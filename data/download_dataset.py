import subprocess
import os

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
