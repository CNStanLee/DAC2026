import os
import onnx
import torch
from brevitas.nn import QuantLinear, QuantReLU
import torch.nn as nn
from brevitas.nn import QuantIdentity
# Setting seeds for reproducibility
torch.manual_seed(0)

def get_model(model_name, w, a):
    if model_name == "unsw_nb15":
        return model_unsw_nb15(w, a)
    if model_name == "unsw_nb15_padded":
        return model_unsw_nb15_padded(w, a)
    else:
        raise ValueError("Unknown model name")

def model_unsw_nb15(w, a):
    input_size = 593      
    hidden1 = 64      
    hidden2 = 64
    hidden3 = 64
    weight_bit_width = w
    act_bit_width = a
    num_classes = 1    

    model = nn.Sequential(
        QuantLinear(input_size, hidden1, bias=True, weight_bit_width=weight_bit_width),
        nn.BatchNorm1d(hidden1),
        nn.Dropout(0.5),
        QuantReLU(bit_width=act_bit_width),
        QuantLinear(hidden1, hidden2, bias=True, weight_bit_width=weight_bit_width),
        nn.BatchNorm1d(hidden2),
        nn.Dropout(0.5),
        QuantReLU(bit_width=act_bit_width),
        QuantLinear(hidden2, hidden3, bias=True, weight_bit_width=weight_bit_width),
        nn.BatchNorm1d(hidden3),
        nn.Dropout(0.5),
        QuantReLU(bit_width=act_bit_width),
        QuantLinear(hidden3, num_classes, bias=True, weight_bit_width=weight_bit_width)
    )
    return model


def model_unsw_nb15_padded(w, a):
    input_size = 600      
    hidden1 = 64
    hidden2 = 64
    hidden3 = 64
    weight_bit_width = w
    act_bit_width = a
    num_classes = 1

    model = nn.Sequential(
        QuantLinear(input_size, hidden1, bias=True, weight_bit_width=weight_bit_width),
        nn.BatchNorm1d(hidden1),
        nn.Dropout(0.5),
        QuantReLU(bit_width=act_bit_width),
        QuantLinear(hidden1, hidden2, bias=True, weight_bit_width=weight_bit_width),
        nn.BatchNorm1d(hidden2),
        nn.Dropout(0.5),
        QuantReLU(bit_width=act_bit_width),
        QuantLinear(hidden2, hidden3, bias=True, weight_bit_width=weight_bit_width),
        nn.BatchNorm1d(hidden3),
        nn.Dropout(0.5),
        QuantReLU(bit_width=act_bit_width),
        QuantLinear(hidden3, num_classes, bias=True, weight_bit_width=weight_bit_width)
    )
    return model


class CybSecMLPForExport(nn.Module):
    def __init__(self, my_pretrained_model):
        super(CybSecMLPForExport, self).__init__()
        self.pretrained = my_pretrained_model
        self.qnt_output = QuantIdentity(
            quant_type='binary', 
            scaling_impl_type='const',
            bit_width=1, min_val=-1.0, max_val=1.0)
    
    def forward(self, x):
        x = (x + torch.tensor([1.0]).to(x.device)) / 2.0  
        out_original = self.pretrained(x)
        out_final = self.qnt_output(out_original)       
        return out_final