from utilsfile import set_logger

LOGGER = set_logger("crypto_class_logger")


class Loader:

    def __init__(self):
        pass

    @staticmethod
    def load(filename=None):
        """
        Load function for sql files that perform batch ingestion/Transformation to the Database/Data Warehouse
        @param  filename
        @return
        """
        try:
            sql = open(filename, encoding='utf-8').read()
            return sql
        except Exception as e:
            LOGGER.info(f"Exception: {e}")
            return None


