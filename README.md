# GEN711 Final Project
## Qiime2 Pond Microbiome Analysis
Contributors:
-Sophie Welch
-Noelle DiVeglia
-Emily Small 

## Background
-Data was borrowed from a grad student by Kaleb 
- This data is formated in 
  - Illumina Hi Seq 2500
  - Paried end reads
  - 250 bp sequencing reads
- Included in the files are
  - 20 total samples
  -  Two collection methods
      -  one where the duckweed was skimmed  from the top of the pond
     -  one where there was no skimming was used sample was directly taken from the pond
- Each sample had 5 replicates of each treatment
  - A metadata file was used to tell Qiime program which samples are which
  -  A manifest file was used to tell Qiime where the fastq files are located for importing of data and tables               
## Materials and Methods
This project was done using the Qiime2 Amplicon environment through Conda.

 ### Obtaining Data
- Raw reads and metadata found in /tmp/FinalProjectData​
    -This was done in the Qiime2-amplicon-2024.5 conda environment​

### Qiime Tools Import​
- Imported the Qiime toolset for paired end sequences​
- Used to get the demultiplexed sequences into a .qza format

### Demux Summarize​
- Created a visual.qzv of the demultiplexed sequences​
- Visual.qzv contained average reads in each sample and a quality score plot​

### Denoising using DADA2​
- Removed poor quality reads and any sequence errors from samples​
- Used Metadata Tabulate to produce a table with data on what was removed
  
### Feature Table​
- Used summarize-plus to obtain more data on sequences and their frequencies, features, and associated samples​
- Used tabulate-seqs to produce an asv-seqs.qzv to input into the visualization program​

### Filtering​
- Used filter-features to sort table by the features of each sequence​
- Used filter-seqs to create a sorted sequence .qza file to use for taxonomy

### Taxonomy
- Obtained the suboptimal 16S rRNA classifier file using wget​
  - Tool found at: https://gut-to-soil-tutorial.readthedocs.io/en/latest/data/gut-to-soil/suboptimal-16S-rRNA-classifier.qza​
- Used feature-classify classify-sklearn to match taxonomic information to the sequences ​
- Used feature-table tabulate-seqs to create a .qzv file for visualization of taxa

### Boots and Kmer Diversity​
- Used to only keep sequences that have a certain depth​

### Alpha Rarefaction​
- Used to generate a scatter plot on the depth of reads and sequence diversity​

### Taxa Bar Plot​
- Used to generate a bar plot of the taxa in each sample

## Results  

## Citations
  ###Qiime2 and Tutorial
  - Bolyen, E., Rideout, J. R., Dillon, M. R., Bokulich, N. A., Abnet, C. C., Al-Ghalith, G. A., Alexander, H., Alm, E. J., Arumugam, M., Asnicar, F., Bai, Y., Bisanz, J. E., Bittinger, K., Brejnrod, A., Brislawn, C. J., Brown, C. T., Callahan, B. J., Caraballo-Rodríguez, A. M., Chase, J., … Caporaso, J. G. (2019). Reproducible, interactive, scalable and extensible microbiome data science using QIIME 2. Nature Biotechnology, 37(8), 852–857. 10.1038/s41587-019-0209-9
