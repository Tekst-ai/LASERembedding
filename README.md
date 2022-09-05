# LASER embeddings v2   
[![CI-LASER](https://github.com/Tekst-ai/LASERembedding/actions/workflows/laser.yml/badge.svg)](https://github.com/Tekst-ai/LASERembedding/actions/workflows/laser.yml)


is a python package that makes the new LASER models of [Facebook Research's NNLB](https://github.com/facebookresearch/LASER/tree/main/nllb) (no language left behind) 
easy installable and ready to use.

The original version had a lot of extra dependencies and is hard to install.

**CURRENT VERSION:**
* We now provide updated LASER models which support over 200 languages. Please see [here](nllb/README.md) for more details including how to download the models and perform inference.

According to our experience, the sentence encoder also supports code-switching, i.e.
the same sentences can contain words in several different languages.

We have also some evidence that the encoder can generalize to other
languages which have not been seen during training, but which are in
a language family which is covered by other languages.

A detailed description of how the multilingual sentence embeddings are trained can
be found in [10], together with an experimental evaluation.

## Installation
* download encoders from Amazon s3 by e.g. `bash download_models.sh` 
  * This downloads all the LASER files to /models folder
* download third party software by `bash ./install_external_tools.sh`
* download the data used in the example tasks (see description for each task)

## Applications

We showcase several applications of multilingual sentence embeddings
with code to reproduce our results (in the directory "tasks").

* [**Cross-lingual document classification**](tasks/mldoc) using the
  [*MLDoc*](https://github.com/facebookresearch/MLDoc) corpus [2,6]
* [**WikiMatrix**](tasks/WikiMatrix)
   Mining 135M Parallel Sentences in 1620 Language Pairs from Wikipedia [7]
* [**Bitext mining**](tasks/bucc) using the
  [*BUCC*](https://comparable.limsi.fr/bucc2018/bucc2018-task.html) corpus [3,5]
* [**Cross-lingual NLI**](tasks/xnli)
  using the [*XNLI*](https://www.nyu.edu/projects/bowman/xnli/) corpus [4,5,6]
* [**Multilingual similarity search**](tasks/similarity) [1,6]
* [**Sentence embedding of text files**](tasks/embed)
  example how to calculate sentence embeddings for arbitrary text files in any of the supported language.

**For all tasks, we use exactly the same multilingual encoder, without any task specific optimization or fine-tuning.**

## License

LASER is BSD-licensed, as found in the [`LICENSE`](LICENSE) file in the root directory of this source tree.

## Supported languages

The original LASER model was trained on the following languages:

Afrikaans, Albanian, Amharic, Arabic, Armenian, Aymara, Azerbaijani, Basque, Belarusian, Bengali,
Berber languages, Bosnian, Breton, Bulgarian, Burmese, Catalan, Central/Kadazan Dusun, Central Khmer,
Chavacano, Chinese, Coastal Kadazan, Cornish, Croatian, Czech, Danish, Dutch, Eastern Mari, English,
Esperanto, Estonian, Finnish, French, Galician, Georgian, German, Greek, Hausa, Hebrew, Hindi,
Hungarian, Icelandic, Ido, Indonesian, Interlingua, Interlingue, Irish, Italian, Japanese, Kabyle,
Kazakh, Korean, Kurdish, Latvian, Latin, Lingua Franca Nova, Lithuanian, Low German/Saxon,
Macedonian, Malagasy, Malay, Malayalam, Maldivian (Divehi), Marathi, Norwegian (Bokmål), Occitan,
Persian (Farsi), Polish, Portuguese, Romanian, Russian, Serbian, Sindhi, Sinhala, Slovak, Slovenian,
Somali, Spanish, Swahili, Swedish, Tagalog, Tajik, Tamil, Tatar, Telugu, Thai, Turkish, Uighur,
Ukrainian, Urdu, Uzbek, Vietnamese, Wu Chinese and Yue Chinese.

We have also observed that the model seems to generalize well to other (minority) languages or dialects, e.g.

Asturian, Egyptian Arabic, Faroese, Kashubian, North Moluccan Malay, Nynorsk Norwegian, Piedmontese, Sorbian, Swabian,
Swiss German or Western Frisian.

### LASER3

Updated LASER models referred to as *[LASER3](nllb/README.md)* supplement the above list with support for 147 languages. The full list of supported languages can be seen [here](nllb/README.md#list-of-available-laser3-encoders).

## References

[1] Holger Schwenk and Matthijs Douze,
    [*Learning Joint Multilingual Sentence Representations with Neural Machine Translation*](https://aclanthology.info/papers/W17-2619/w17-2619),
    ACL workshop on Representation Learning for NLP, 2017

[2] Holger Schwenk and Xian Li,
    [*A Corpus for Multilingual Document Classification in Eight Languages*](http://www.lrec-conf.org/proceedings/lrec2018/pdf/658.pdf),
    LREC, pages 3548-3551, 2018.

[3] Holger Schwenk,
    [*Filtering and Mining Parallel Data in a Joint Multilingual Space*](http://aclweb.org/anthology/P18-2037)
    ACL, July 2018

[4] Alexis Conneau, Guillaume Lample, Ruty Rinott, Adina Williams, Samuel R. Bowman, Holger Schwenk and Veselin Stoyanov,
    [*XNLI: Cross-lingual Sentence Understanding through Inference*](https://aclweb.org/anthology/D18-1269),
    EMNLP, 2018.

[5] Mikel Artetxe and Holger Schwenk,
    [*Margin-based Parallel Corpus Mining with Multilingual Sentence Embeddings*](https://arxiv.org/abs/1811.01136)
    arXiv, Nov 3 2018.

[6] Mikel Artetxe and Holger Schwenk,
    [*Massively Multilingual Sentence Embeddings for Zero-Shot Cross-Lingual Transfer and Beyond*](https://arxiv.org/abs/1812.10464)
    arXiv, Dec 26 2018.

[7] Holger Schwenk, Vishrav Chaudhary, Shuo Sun, Hongyu Gong and Paco Guzman,
    [*WikiMatrix: Mining 135M Parallel Sentences in 1620 Language Pairs from Wikipedia*](https://arxiv.org/abs/1907.05791)
    arXiv, July 11  2019.

[8] Holger Schwenk, Guillaume Wenzek, Sergey Edunov, Edouard Grave and Armand Joulin
    [*CCMatrix: Mining Billions of High-Quality Parallel Sentences on the WEB*](https://arxiv.org/abs/1911.04944)

[9] Paul-Ambroise Duquenne, Hongyu Gong, Holger Schwenk,
    [*Multimodal and Multilingual Embeddings for Large-Scale Speech Mining,*](https://papers.nips.cc/paper/2021/hash/8466f9ace6a9acbe71f75762ffc890f1-Abstract.html), NeurIPS 2021, pages 15748-15761.

[10] Kevin Heffernan, Onur Celebi, and Holger Schwenk,
     [*Bitext Mining Using Distilled Sentence Representations for Low-Resource Languages*](https://arxiv.org/abs/2205.12654)
