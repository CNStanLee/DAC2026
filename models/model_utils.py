import torch
from sklearn.metrics import accuracy_score
from .models import get_model
import numpy as np
def test_unsw(model, test_loader, device):    
    # ensure model is in eval mode
    model.eval() 
    y_true = []
    y_pred = []
   
    with torch.no_grad():
        for data in test_loader:
            inputs, target = data
            inputs, target = inputs.to(device), target.to(device)
            output_orig = model(inputs.float())
            # run the output through sigmoid
            output = torch.sigmoid(output_orig)  
            # compare against a threshold of 0.5 to generate 0/1
            pred = (output.detach().cpu().numpy() > 0.5) * 1
            target = target.cpu().float()
            y_true.extend(target.tolist()) 
            y_pred.extend(pred.reshape(-1).tolist())
        
    return accuracy_score(y_true, y_pred)

def test_unsw_padded_bipolar(model, test_loader, device):    
    # ensure model is in eval mode
    model.eval() 
    y_true = []
    y_pred = []
   
    with torch.no_grad():
        for data in test_loader:
            inputs, target = data
            inputs, target = inputs.to(device), target.to(device)
            # pad inputs to 600 elements
            input_padded = torch.nn.functional.pad(inputs, (0,7,0,0))
            # convert inputs to {-1,+1}
            input_scaled = 2 * input_padded - 1
            # run the model
            output = model(input_scaled.float())
            y_pred.extend(list(output.flatten().cpu().numpy()))
            # make targets bipolar {-1,+1}
            expected = 2 * target.float() - 1
            expected = expected.cpu().numpy()
            y_true.extend(list(expected.flatten()))
        
    return accuracy_score(y_true, y_pred)

def save_padded_unsw_model(old_ckpt_path, new_ckpt_path, w=2, a=2):
    # 1) 加载旧模型 + state_dict（含参数+buffers）
    old_model = get_model("unsw_nb15", w, a).cpu()
    old_sd = torch.load(old_ckpt_path, weights_only=False)["models_state_dict"][0]
    old_model.load_state_dict(old_sd, strict=True)

    # 2) 基于旧 state_dict 复制出一个新 state_dict
    new_sd = {k: v.clone() for k, v in old_model.state_dict().items()}

    # 3) 用 np.pad 精确复刻你之前的权重填充（列方向 +7）
    W_orig = new_sd["0.weight"].detach().cpu().numpy()            # [64, 593]
    W_new  = np.pad(W_orig, [(0, 0), (0, 7)], mode="constant")    # [64, 600]
    new_sd["0.weight"] = torch.from_numpy(W_new).to(dtype=new_sd["0.weight"].dtype)

    # 注意：bias 不需要改形状；BN 与量化相关 buffers 全都保留在 new_sd 里

    # 4) 构建新模型（输入 600）
    new_model = get_model("unsw_nb15_padded", w, a).cpu()

    # 5) 一次性严格加载（确保没有遗漏任何 key）
    new_model.load_state_dict(new_sd, strict=True)

    # 6) 保存
    torch.save({"models_state_dict": [new_model.state_dict()]}, new_ckpt_path)
    print(f"new padded model saved to: {new_ckpt_path}")
