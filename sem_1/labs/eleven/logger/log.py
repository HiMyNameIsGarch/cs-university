from datetime import datetime
from logger.log_levels import Log_levels

class Logger:
    def __init__(self, log_file):
        self.__base_path = "/var/log/"
        self.log_file = self.__base_path + log_file

    @property
    def time(self):
        return datetime.now().strftime("%d/%m/%Y %H:%M:%S")

    def log(self, message:str, level:Log_levels = Log_levels.INFO):
        text_to_write = f"[ {level.name} ]: {self.time} ] {message}"
        with open(self.log_file, 'a') as f:
            f.write(text_to_write + '\n')
