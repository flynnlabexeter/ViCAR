#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --mem 48G
#SBATCH -t 36:00:00
#SBATCH -o ViCAR_Pairtools.out
#SBATCH -e ViCAR_Pairtools.err

# Activate the Conda environment
conda activate my_conda

# Set paths to necessary files
FASTQ_DIR="/path/to/fastqs"
GENOME="/path/to/genomes/hg38.fa"
# Ensure HiChIP directory is installed https://hichip.readthedocs.io/en/latest/before_you_begin.html
HICHIP_DIR="/path/to/HiChiP"
JUICETOOLS_JAR="${HICHIP_DIR}/juicertools.jar"
FASTQ_R1="${FASTQ_DIR}/myrun.r_1.fq.gz"
FASTQ_R2="${FASTQ_DIR}/myrun.r_2.fq.gz"

# Perform BWA MEM alignment
bwa mem -t 16 ${GENOME} ${FASTQ_R1} ${FASTQ_R2} > myrun.sam

# Parse the SAM file with pairtools
pairtools parse --min-mapq 30 --walks-policy 5unique --max-inter-align-gap 30 --nproc-in 8 --nproc-out 8 --chroms-path ${GENOME} myrun.sam > myrun.pairsam

# Sort the pairsam file
# Make sure you have created temp directory
pairtools sort --nproc 16 --tmpdir=/path/to/temp myrun.pairsam > myrun.sorted.pairsam

# Deduplicate the sorted pairsam file
pairtools dedup --nproc-in 8 --nproc-out 8 --mark-dups --output-stats myrun_stats.txt --output myrun_dedup.pairsam myrun.sorted.pairsam

# Split the deduplicated pairsam file into pairs and a BAM file
pairtools split --nproc-in 8 --nproc-out 8 --output-pairs myrun_mapped.pairs --output-sam myrun_unsorted.bam myrun_dedup.pairsam

# Sort the BAM file with samtools
#samtools sort -@16 -T /path/to/temp/temp.bam -o myrun_4_mapped.PT.bam myrun_unsorted.bam

# Index the sorted BAM file
samtools index myrun_mapped.PT.bam

# Run the get_qc.py script for QC
python3 ${HICHIP_DIR}/get_qc.py -p myrun_stats.txt

# Generate the contact map using juicertools
path/to/java -Xmx48000m -Djava.awt.headless=true -jar ${JUICETOOLS_JAR} pre --threads 16 myrun_mapped.pairs myrun_contact_map.hic ${GENOME}
