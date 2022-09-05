import os
from os.path import exists
from lib.constants import langs, version

from embed import embed_sentences


class LASER:
    def __init__(self):
        self.model_dir = os.path.join(os.path.dirname(os.path.realpath(__file__)),
                                      'models')

    def embed(self, input_file, lang=None, model_dir=None):
        model_dir = self.model_dir if model_dir is None else model_dir

        # default to laser2
        model_file = f"{model_dir}/laser2.pt"
        spm = f"{model_dir}/laser2.spm"

        if lang:
            if not (lang in langs):
                raise Exception(f"lang {lang} not found, does it exist?")
            model_file = f"{model_dir}/laser3-{lang}.{version}.pt"
            lang_specific_spm = f"{model_dir}/laser3-{lang}.{version}.spm"

            if exists(lang_specific_spm):
                spm = lang_specific_spm

        embedding = embed_sentences(input_file,
                                    "./output.bin",
                                    encoder_path=model_file,
                                    spm_model=spm,
                                    verbose=True)
        return embedding


if __name__ == "__main__":
    laser = LASER()
    embedding_result = laser.embed("This is a sentence we need to embed.", lang="ace_Latn")
    print(embedding_result)