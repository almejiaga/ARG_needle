#!/bin/bash
#SBATCH --account=def-sgravel
#SBATCH --time=0-23:5
#SBATCH --cpus-per-task=30
#SBATCH --mem-per-cpu=30G
module load python/3.11.2
source /home/mejia/ENV/bin/activate
arg_needle --hap_gz chr21_corrected.haps --map chr21_corrected.map --out resultsforchr21
