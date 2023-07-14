#!/bin/bash
#SBATCH --account=def-sgravel
#SBATCH --time=0-23:5
#SBATCH --cpus-per-task=30
#SBATCH --mem-per-cpu=30G
module load plink/2.00a3.6
module load bcftools/1.11
for files in *_biallelic.vcf.gz
do
(
filename=${files%_biallelic.vcf.gz}
echo $filename
bcftools view -T ^excluded_maps/${filename}_excluded.txt $files > ${filename}_corrected.vcf
plink2 --vcf ${filename}_corrected.vcf --max-alleles 2 --snps-only --export haps --out ARG_files/${filename}_corrected
) &
done



#bcftools view -T ^list_snp_exclude.txt input.vcf > output.vcf

