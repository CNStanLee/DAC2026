import os
from datetime import datetime

class Logger:
    def __init__(self, filename="log.txt", log_dir="logs"):
        """初始化日志类
        
        参数:
            filename (str): 日志文件名
            log_dir (str): 日志保存目录
        """
        os.makedirs(log_dir, exist_ok=True)
        self.log_path = os.path.join(log_dir, filename)
        
        # 打开文件（追加模式）
        self.file = open(self.log_path, "a", encoding="utf-8")
        
        # 写入启动信息
        self._write_line("==== log started ====")

    def _write_line(self, message):
        """写入文件（带时间戳）"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        self.file.write(f"[{timestamp}] {message}\n")
        self.file.flush()  # 立即写入磁盘

    def log(self, message, to_console=True):
        """记录日志
        
        参数:
            message (str): 要记录的内容
            to_console (bool): 是否在终端打印（默认 True）
        """
        self._write_line(message)
        if to_console:
            print(message)

    def close(self):
        """关闭日志文件"""
        self.file.close()
