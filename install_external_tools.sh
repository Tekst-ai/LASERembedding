#!/bin/bash
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
#-------------------------------------------------------
#
# This bash script installs third party software 
#

if [ -z ${LASER} ] ; then 
  echo "Please set the environment variable 'LASER'"
  exit
fi

###################################################################
#
# Generic helper functions
#
###################################################################

MKDIR () {
  dname=$1
  if [ ! -d ${dname} ] ; then
    echo " - creating directory ${dname}"
    mkdir -p ${dname}
  fi
}


bdir="${LASER}"
tools_ext="${bdir}/tools-external"
MKDIR $tools_ext

###################################################################
#
# Tokenization tools from Moses
# It is important to use the official release V4 and not the current one
# to obtain the same results than the published ones.
# (the behavior of the tokenizer for end-of-sentence abbreviations has changed)
#
###################################################################

###################################################################
#
# SENTENCEPIECE 
#
###################################################################

InstallSentencePiece () {
  cd ${tools_ext}
  if [ ! -d sentencepiece-master ] ; then
    echo " - download sentencepiece from github"
    wget https://github.com/google/sentencepiece/archive/master.zip
    unzip master.zip
    /bin/rm master.zip
    if [ ! -s /usr/local/bin/spm_encode ] ; then
      echo " - building code "
      cd sentencepiece-master
      mkdir build
      cd build
      cmake ..
      make -j 10
    fi
  fi
}


###################################################################
#
# Install Japanese tokenizer Mecab
# We do not use automatic installation with "pip" but directly add the soruce directory
#
###################################################################



###################################################################
#
# main
#
###################################################################

echo "Installing external tools"

InstallMosesTools
InstallSentencePiece

