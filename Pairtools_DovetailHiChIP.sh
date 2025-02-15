#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --mem 48G
#SBATCH -t 36:00:00
#SBATCH -o Pairtools_DovetailHiChIP.out
#SBATCH -e Pairtools_DovetailHiChIP.err

/path/to/bwa/bwa-0.7.17/bwa mem -t 16 /path/to/genomes/hg38/fasta/hsa.hg38.fa /path/to/fastqs/demult/sample1.r1.fq.gz  /path/to/fastqs/demult/sample1.r2.fq.gz > /path/to/fastqs/demult/sample1.sam

/home/flynn02/.local/bin/pairtools parse --min-mapq 30 --walks-policy 5unique --max-inter-align-gap 30 --nproc-in 8 --nproc-out 8 --chroms-path /path/to/genomes/hg38/fasta/hsa.hg38.fa /path/to/fastqs/demult/sample1.sam > /path/to/fastqs/demult/sample1.pairsam

pairtools sort --nproc 16 --tmpdir=/set/path/to/temp sample1.pairsam > sample1.sorted.pairsam

pairtools dedup --nproc-in 8 --nproc-out 8 --mark-dups --output-stats sample1_stats.txt --output sample1_dedup.pairsam sample1.sorted.pairsam

pairtools split --nproc-in 8 --nproc-out 8 --output-pairs sample1_mapped.pairs --output-sam sample1_unsorted.bam sample1_dedup.pairsam

samtools sort -@16 -T path/to/temp/temp.bam -o sample1_mapped.PT.bam sample1_unsorted.bam

samtools index sample1_mapped.PT.bam

path/to/python/python-3.8.7/bin/python3 /path/to/HiChiP/get_qc.py -p sample1_stats.txt

path/to/java/jdk1.8.0_192/bin/java -Xmx48000m -Djava.awt.headless=true -jar /path/to/HiChiP/juicertools.jar pre --threads 16 sample1_mapped.pairs sample1_contact_map.hic /path/to/genomes/hg38/fasta/hg38.genome
