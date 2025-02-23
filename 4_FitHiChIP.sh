#!/bin/bash
#SBATCH --job-name=FitHiChIP_HiC
#SBATCH --output=FitHiChIP_HiC_%j.out
#SBATCH --error=FitHiChIP_HiC_%j.err
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G

# Load conda environment
conda activate my_fithichip_conda_env

# Modify configfile_BiasCorrection_CoverageBias. See: https://ay-lab.github.io/FitHiChIP/html/usage/configuration.html and https://hichip.readthedocs.io/en/latest/loops.html
# Run FitHiChIP 
bash FitHiChIP_HiCPro_conda.sh -C /path/to/FitHiChIP/configfile_BiasCorrection_CoverageBias
