#! /bin/bash

#Data Retrieval and Environment Setup
tmux
#(tmux -new was used initially)

cp /tmp/FinalProjectData -r ~

source activate qiime2-amplicon-2024.5


qiime tools import \
 --type 'SampleData[PairedEndSequencesWithQuality]' \
 --input-path fq-manifest.tsv \
 --output-path demux.qza \
 --input-format PairedEndFastqManifestPhred33V2

#A demux.qza file was produced.
