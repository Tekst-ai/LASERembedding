from embed import embed_sentences


class LASER:
    def __init__(self):
        self.model_dir = "/home/treparme/PycharmProjects/laser-fork/LASER"

    def embed(self, input_file):
        embedding = embed_sentences(input_file,
                        "./output.bin",
                        encoder_path=f"{self.model_dir}/laser2.pt",
                        spm_model=f"{self.model_dir}/laser2.spm",
                        verbose=True)
        print(embedding)
        return embedding


if __name__ == "__main__":
    laser = LASER()
    laser.embed("This is a sentence we need to embed.")
