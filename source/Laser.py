from embed import embed_sentences
import numpy as np


class LASER:
    def __init__(self):
        self.model_dir = "/home/treparme/PycharmProjects/laser-fork/LASER"

    def embed(self, input_file):
        embed_sentences(input_file,
                        "./output.bin",
                        encoder_path=f"{self.model_dir}/laser2.pt",
                        spm_model=f"{self.model_dir}/laser2.spm",
                        verbose=True)
        dim = 1024
        X = np.fromfile("output.bin", dtype=np.float32, count=-1)
        X.resize(X.shape[0] // dim, dim)
        return X


if __name__ == "__main__":
    laser = LASER()
    laser.embed("./test.txt")
