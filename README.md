Four scripts are provided for processing ViCAR data.

Script 1 (demultiplex.sh) uses demuxFQ to demultiplex fastqs. 

Script 2a (Read1.sh) generates bigWig files for Read1 fastqs. Adapted from https://github.com/flynnlabexeter/CUT-Tag
Script 2b (Read2.sh) generates bigWig files for Read2 fastqs. Adapted from https://github.com/flynnlabexeter/CUT-Tag

Script 3 (pairtools_hic.sh) generates hi-c statistics, and .pairs .hic files. **Adapted from Dovetail Genomics HiChIP documentation https://hichip.readthedocs.io/en/latest/**

Script 4 (FitHiChIP.sh) uses FitHiChIP to call loops in 3D data. **See FitHiChIP documentation https://ay-lab.github.io/FitHiChIP/html/index.html**

Consider citing tools involved, including:
1. Open2C; Abdennur N, Fudenberg G, Flyamer IM, Galitsyna AA, Goloborodko A, Imakaev M, Venev SV. Pairtools: From sequencing data to chromosome contacts. PLoS Comput Biol. 2024 May 29;20(5):e1012164. doi: 10.1371/journal.pcbi.1012164.
2. Bhattacharyya S, Chandra V, Vijayanand P, Ay F. Identification of significant chromatin contacts from HiChIP data by FitHiChIP. Nat Commun. 2019 Sep 17;10(1):4221. doi: 10.1038/s41467-019-11950-y.

**Dependencies**

Ensure the following software is installed

For script 1
demuxFQ

For script 2
cutadapt bwa samtools bedtools bamCoverage (from deepTools)

These can be installed using conda install -c bioconda cutadapt bwa samtools bedtools deeptools

For script 3
BWA 
Pairtools (https://pairtools.readthedocs.io/en/latest/)
Samtools 
Python 
Juicer Tools
 
For script 4
FitHiChIP 

