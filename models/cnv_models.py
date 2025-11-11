import torch
from torch.nn import BatchNorm1d
from torch.nn import BatchNorm2d
from torch.nn import MaxPool2d, AvgPool2d
from torch.nn import Module
from torch.nn import ModuleList
from brevitas.core.restrict_val import RestrictValueType
from brevitas.nn import QuantConv2d
from brevitas.nn import QuantIdentity
from brevitas.nn import QuantLinear
from brevitas_examples.bnn_pynq.models.common import CommonActQuant
from brevitas_examples.bnn_pynq.models.common import CommonWeightQuant
from brevitas_examples.bnn_pynq.models.tensor_norm import TensorNorm
import os
from brevitas.core.scaling import ScalingImplType
from brevitas.core.quant import QuantType
import brevitas.nn as qnn
import ast
from functools import reduce
from operator import mul
from torch.nn import Dropout
import configparser

DROPOUT = 0.2
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print(f"Using device: {device}")
print(f"Current working directory: {os.getcwd()}")

# LeNet-5
CNV_OUT_CH_POOL = [(6, True), (16, True), (120, False)]  
INTERMEDIATE_FC_FEATURES = [(120, 84)]  
LAST_FC_IN_FEATURES = 84 
LAST_FC_PER_OUT_CH_SCALING = False
POOL_SIZE = 2  
KERNEL_SIZE = 5  

config = configparser.ConfigParser()
config['MODEL'] = {
    'NUM_CLASSES': '10',
    'IN_CHANNELS': '1',
    'DTASET': 'MNIST',
}
config['QUANT'] = {
    'WEIGHT_BIT_WIDTH': '1',
    'ACT_BIT_WIDTH': '1',
    'IN_BIT_WIDTH': '8',
}


class CNV(Module):

    def __init__(self, num_classes, weight_bit_width, act_bit_width, in_bit_width, in_ch):
        super(CNV, self).__init__()

        self.conv_features = ModuleList()
        self.linear_features = ModuleList()

        self.conv_features.append(QuantIdentity( # for Q1.7 input format
            act_quant=CommonActQuant,
            bit_width=in_bit_width,
            min_val=- 1.0,
            max_val=1.0 - 2.0 ** (-7),
            narrow_range=False,
            restrict_scaling_type=RestrictValueType.POWER_OF_TWO))

        for out_ch, is_pool_enabled in CNV_OUT_CH_POOL:
            self.conv_features.append(
                QuantConv2d(
                    kernel_size=KERNEL_SIZE,
                    in_channels=in_ch,
                    out_channels=out_ch,
                    bias=False,
                    weight_quant=CommonWeightQuant,
                    weight_bit_width=weight_bit_width))
            in_ch = out_ch
            self.conv_features.append(BatchNorm2d(in_ch, eps=1e-4))
            self.conv_features.append(
                QuantIdentity(act_quant=CommonActQuant, bit_width=act_bit_width))
            if is_pool_enabled:
                self.conv_features.append(MaxPool2d(kernel_size=2)) # avg pool not supported in finn

        for in_features, out_features in INTERMEDIATE_FC_FEATURES:
            self.linear_features.append(
                QuantLinear(
                    in_features=in_features,
                    out_features=out_features,
                    bias=False,
                    weight_quant=CommonWeightQuant,
                    weight_bit_width=weight_bit_width))
            self.linear_features.append(BatchNorm1d(out_features, eps=1e-4))
            self.linear_features.append(
                QuantIdentity(act_quant=CommonActQuant, bit_width=act_bit_width))

        self.linear_features.append(
            QuantLinear(
                in_features=LAST_FC_IN_FEATURES,
                out_features=num_classes,
                bias=False,
                weight_quant=CommonWeightQuant,
                weight_bit_width=weight_bit_width))
        self.linear_features.append(TensorNorm())

        for m in self.modules():
            if isinstance(m, QuantConv2d) or isinstance(m, QuantLinear):
                torch.nn.init.uniform_(m.weight.data, -1, 1)

    def clip_weights(self, min_val, max_val):
        for mod in self.conv_features:
            if isinstance(mod, QuantConv2d):
                mod.weight.data.clamp_(min_val, max_val)
        for mod in self.linear_features:
            if isinstance(mod, QuantLinear):
                mod.weight.data.clamp_(min_val, max_val)

    def forward(self, x):
        x = 2.0 * x - torch.tensor([1.0], device=x.device)
        for mod in self.conv_features:
            x = mod(x)
        x = x.view(x.shape[0], -1)
        for mod in self.linear_features:
            x = mod(x)
        return x 
    
class CNV_RELU(Module):

    def __init__(self, num_classes, weight_bit_width, act_bit_width, in_bit_width, in_ch):
        super(CNV_RELU, self).__init__()

        self.conv_features = ModuleList()
        self.linear_features = ModuleList()

        self.conv_features.append(QuantIdentity( # for Q1.7 input format
            act_quant=CommonActQuant,
            bit_width=in_bit_width,
            min_val=- 1.0,
            max_val=1.0 - 2.0 ** (-7),
            narrow_range=False,
            restrict_scaling_type=RestrictValueType.POWER_OF_TWO))

        for out_ch, is_pool_enabled in CNV_OUT_CH_POOL:
            self.conv_features.append(
                QuantConv2d(
                    kernel_size=KERNEL_SIZE,
                    in_channels=in_ch,
                    out_channels=out_ch,
                    bias=False,
                    weight_quant=CommonWeightQuant,
                    weight_bit_width=weight_bit_width))
            in_ch = out_ch
            self.conv_features.append(BatchNorm2d(in_ch, eps=1e-4))
            if act_bit_width == 1:
                self.conv_features.append(
                    QuantIdentity(act_quant=CommonActQuant, bit_width=act_bit_width))
            else:
                self.conv_features.append(
                      qnn.QuantReLU(
                        bit_width=act_bit_width, return_quant_tensor=True))
            if is_pool_enabled:
                self.conv_features.append(MaxPool2d(kernel_size=2)) # avg pool not supported in finn

        for in_features, out_features in INTERMEDIATE_FC_FEATURES:
            self.linear_features.append(
                QuantLinear(
                    in_features=in_features,
                    out_features=out_features,
                    bias=False,
                    weight_quant=CommonWeightQuant,
                    weight_bit_width=weight_bit_width))
            self.linear_features.append(BatchNorm1d(out_features, eps=1e-4))
            if act_bit_width == 1:
                self.linear_features.append(
                    QuantIdentity(act_quant=CommonActQuant, bit_width=act_bit_width))
            else:
                self.linear_features.append(
                      qnn.QuantReLU(
                        bit_width=act_bit_width, return_quant_tensor=True))

        self.linear_features.append(
            QuantLinear(
                in_features=LAST_FC_IN_FEATURES,
                out_features=num_classes,
                bias=False,
                weight_quant=CommonWeightQuant,
                weight_bit_width=weight_bit_width))
        self.linear_features.append(TensorNorm())

        for m in self.modules():
            if isinstance(m, QuantConv2d) or isinstance(m, QuantLinear):
                torch.nn.init.uniform_(m.weight.data, -1, 1)

    def clip_weights(self, min_val, max_val):
        for mod in self.conv_features:
            if isinstance(mod, QuantConv2d):
                mod.weight.data.clamp_(min_val, max_val)
        for mod in self.linear_features:
            if isinstance(mod, QuantLinear):
                mod.weight.data.clamp_(min_val, max_val)

    def forward(self, x):
        x = 2.0 * x - torch.tensor([1.0], device=x.device)
        for mod in self.conv_features:
            x = mod(x)
        x = x.view(x.shape[0], -1)
        for mod in self.linear_features:
            x = mod(x)
        return x 
    
def letnet5_model(w, a):
    net = CNV_RELU(
        weight_bit_width=w,
        act_bit_width=a,
        in_bit_width=8,
        num_classes=10,
        in_ch=1)
    return net