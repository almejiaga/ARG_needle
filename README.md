# ARG_needle
This is a set of scripts for preparing input files and running arg_needle
# prepare input files
For this task we need to have genetic map files with distance in cM in a plink format, which might be available here:
We also need map/bim plink files from the genetic data we are going to use for reconstructing the ARG. If you have your date in a vcf format, you can generate a bin file using plink2:
plink2 --vcf file.vcf --make-bed --out file
