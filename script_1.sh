#! /bin/bash

#Data Retrieval and Environment Setup
tmux
# tmux -new was used initially, tmux attach was used sequentially

cp /tmp/FinalProjectData -r ~

source activate qiime2-amplicon-2024.5


qiime tools import \
 --type 'SampleData[PairedEndSequencesWithQuality]' \
 --input-path fq-manifest.tsv \
 --output-path demux.qza \
 --input-format PairedEndFastqManifestPhred33V2

#A demux.qza file was produced.
# Summarizing and Visualizing Data

qiime demux summarize \
--i-data demux.qza \
--o-visualization visual.qzv


#Output is a visual.qzv file that can be put into Qiime2 visualizer online.

 qiime dada2 denoise-paired \
  --i-demultiplexed-seqs demux.qza \
  --p-trim-left-f 0 \
  --p-trunc-len-f 250 \
  --p-trim-left-r 0 \
  --p-trunc-len-r 250 \
  --p-n-threads 0 \
  --o-representative-sequences asv-seqs.qza \
  --o-table asv-table.qza \
  --o-denoising-stats stats.qza

qiime metadata tabulate \
 --m-input-file stats.qza
 --o-visualization visual-stats.qzv

#this produces a visual-stats.qzv file that can be put into the qiime2 visualizer.

#moving to upstream data analysis and feature data

qiime feature-table summarize-plus \
  --i-table asv-table.qza \
  --m-metadata-file qiime2dataset/metadata.tsv \
  --o-summary asv-table.qzv \
  --o-sample-frequencies sample-frequencies.qza \
  --o-feature-frequencies asv-frequencies.qza

qiime feature-table tabulate-seqs \
  --i-data asv-seqs.qza \
  --m-metadata-file asv-frequencies.qza \
  --o-visualization asv-seqs.qzv

qiime feature-table filter-features \
  --i-table asv-table.qza \
  --p-min-samples 2 \
  --o-filtered-table asv-table-ms2.qza

qiime feature-table filter-seqs \
  --i-data asv-seqs.qza \
  --i-table asv-table-ms2.qza \
  --o-filtered-data asv-seqs-ms2.qza
#the output is the asv-seqs-ms2.qza file that is useful for the taoxnomic classification step.

#Moving to Taxonomic Classification

#This first step is grabbing the classifier file itself.

wget -O 'suboptimal-16S-rRNA-classifier.qza'   'https://gut-to-soil-tutorial.readthedocs.io/en/latest/data/gut-to-soil/suboptimal-16S-rRNA-classifier.qza'

#This is using the classifier to find and summarize features in the asv-seqs-ms2.qza file and output it into the taxonomy file.
 qiime feature-classifier classify-sklearn
 --i-classifier suboptimal-16S-rRNA-classifier.qza
 --i-reads asv-seqs-ms2.qza
 --o-classification taxonomy.qza
#output is the taxonomy.qza file that is used for the next feature table tabulate step.

qiime feature-table tabulate-seqs
 --i-data asv-seqs-ms2.qza
 --i-taxonomy taxonomy.qza
 --o-visualization asv-seqs-ms2.qzv
#output is the asv-seqs-ms2.qzv file that can be input into the online Qiime Visualizer
