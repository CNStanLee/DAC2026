import os
import subprocess
import shutil
import zipfile
from urllib.request import urlretrieve


def download_and_extract_model(dest_dir: str, model_name: str):
    """
    下载并解压模型 ZIP。
    参数:
        dest_dir: 目标保存目录（会在其下创建子目录）
        model_name: 模型名，可带或不带 .zip 后缀
                    例如: "onnx-models-mobilenetv1" 或 "onnx-models-mobilenetv1.zip"
    逻辑:
        - 默认从 https://github.com/Xilinx/finn-examples/releases/download/v0.0.7a/ 下载
        - 若已解压过则跳过
        - 优先用系统的 wget/unzip；若不可用则自动用 Python 标准库下载/解压
        - 解压时使用“扁平化”（等价 unzip -j）：把压缩包里的文件直接放到子目录下
    返回:
        解压后的目录绝对路径
    """
    # -------- 基本设置 --------
    base_url = "https://github.com/Xilinx/finn-examples/releases/download/v0.0.7a/"
    model_zip = model_name if model_name.endswith(".zip") else f"{model_name}.zip"
    model_stem = model_zip[:-4]  # 去掉 .zip
    dest_dir = os.path.abspath(dest_dir)
    model_dir = os.path.join(dest_dir, model_stem)
    zip_path = os.path.join(model_dir, model_zip)

    # 确保目录存在
    os.makedirs(model_dir, exist_ok=True)

    # 如果已经解压（模型目录中存在除ZIP外的文件），则跳过
    already_extracted = any(
        os.path.isfile(os.path.join(model_dir, f)) and not f.endswith(".zip")
        for f in os.listdir(model_dir)
    )
    if already_extracted:
        print(f"Model already extracted at: {model_dir}")
        return model_dir

    # 若 ZIP 已存在则无需再次下载
    if not os.path.exists(zip_path):
        url = base_url + model_zip
        print(f"Downloading: {url}")
        # 优先使用 wget；不可用则用 urllib
        if shutil.which("wget"):
            subprocess.run(["wget", "-O", zip_path, url], check=True)
        else:
            # Python 内置兜底
            urlretrieve(url, zip_path)
        print(f"Downloaded to: {zip_path}")
    else:
        print(f"ZIP already exists at: {zip_path}")

    # 解压（扁平化：等价 unzip -j）
    print(f"Extracting into: {model_dir}")
    if shutil.which("unzip"):
        # -j 扁平化，-o 覆盖同名文件（避免交互）
        subprocess.run(["unzip", "-j", "-o", zip_path, "-d", model_dir], check=True)
    else:
        # Python 内置兜底：手动扁平化到目标目录
        with zipfile.ZipFile(zip_path, "r") as zf:
            for member in zf.infolist():
                if member.is_dir():
                    continue
                # 扁平化：仅保留文件名
                target_path = os.path.join(model_dir, os.path.basename(member.filename))
                with zf.open(member) as src, open(target_path, "wb") as dst:
                    dst.write(src.read())

    print(f"Model extracted at: {model_dir}")
    return model_dir

def download_dataset(dataset_name):
    if dataset_name == "unsw_nb15":
        os.makedirs("data/unsw", exist_ok=True)
        output_path = "data/unsw/unsw_nb15_binarized.npz"

        # 检查文件是否已经存在
        if os.path.exists(output_path):
            print(f"Dataset already exists at: {output_path}")
            return

        # 若不存在则下载
        subprocess.run([
            "wget",
            "-O", output_path,
            "https://zenodo.org/record/4519767/files/unsw_nb15_binarized.npz?download=1"
        ], check=True)

        print(f"Dataset downloaded to: {output_path}")

    else:
        print(f"Dataset '{dataset_name}' not recognized.")