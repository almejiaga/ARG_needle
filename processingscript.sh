#!/bin/bash
#SBATCH --account=def-sgravel
#SBATCH --time=0-23:5
#SBATCH --cpus-per-task=30
#SBATCH --mem-per-cpu=30G
module load plink/2.00a3.6
module load bcftools/1.11
for files in *_filtered.vcf.gz
do
(
filename=${files%_filtered.vcf.gz}
echo $filename
bcftools norm -m + $files > ${filename}_biallelic.vcf.gz
plink2 --vcf ${filename}_biallelic.vcf.gz --max-alleles 2 --snps-only --make-bed --out maps/${filename}
) &
done

