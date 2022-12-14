#!/usr/bin/python
# Copyright (c) Facebook, Inc. and its affiliates.
# All rights reserved.
#
# This source code is licensed under the BSD-style license found in the
# LICENSE file in the root directory of this source tree.
#
# LASER  Language-Agnostic SEntence Representations
# is a toolkit to calculate multilingual sentence embeddings
# and to use them for document classification, bitext filtering
# and mining
#
# --------------------------------------------------------
#
# Helper functions for tokenization and BPE

import logging
import os
import sys

import numpy as np
import sentencepiece as spm
from sacremoses import MosesTokenizer

logging.basicConfig(
    stream=sys.stdout,
    level=logging.INFO,
    format="%(asctime)s | %(levelname)s | %(name)s | %(message)s",
)
logger = logging.getLogger("preprocess")

# get environment
assert os.environ.get("LASER"), "Please set the enviornment variable LASER"
LASER = os.environ["LASER"]

SPM_DIR = LASER + "/tools-external/sentencepiece-master/build/src/"
SPM = "LD_LIBRARY_PATH=" + SPM_DIR + " " + SPM_DIR + "spm_encode --output_format=piece"


###############################################################################
#
# Apply SPM on a whole file
#
###############################################################################
# todo: romanize


def SPMApply(
    input_text,
    spm_model,
    lang="en",
    lower_case=True,
    descape=False,
    verbose=False,
    over_write=False,
    gzip=False,
):
    assert lower_case, "lower case is needed by all the models"

    if verbose:
        logger.info("SPM processing")

    sp = spm.SentencePieceProcessor(model_file=spm_model)
    transformed = sp.EncodeAsPieces(input_text)
    print(transformed)
    return " ".join(transformed)

    # todo: multiple sentences etc
