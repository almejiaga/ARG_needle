# ARG_needle
This is a set of scripts for preparing input files and running arg_needle software

#   1) Prepare your data for the analysis

## 1.1) genotype data

If you have phased vcf files, split the data into chromosomes, and for each of the chromosomes, extract the corresponding genetic map file using this bash script. This script excludes multiallelic snps and INDELs from the vcfs and generates a binary plink file: 

bash processingscript.sh

Note: this script recognizes vcfs files that end in .vcf.gz

## 1.2) plink_maps

You will need genetic map files with genetic distance in cM in order to run the ARG_needle. In this repository, you can find a map for each chromosome in the plink_maps folder, you can replace these files with the ones that you want to use for your analysis.

#   2) Generate your genetic map file in increasing genetic distance for ARG_needle
for this section, we will use the .bim file created in the last step. the R script is designed to work automatically. The script access to the map and plink_maps folder in order to perform a 
interpolation of genetic distances for the SNPs in your genotype data that are not present in the genetic map file.
## 2.1) map folder
This folder stores the .bim files for each chromosome

## 2.2) plink_maps folder
This folder stores the genetic map files for each chromosome in plink format. This files can be found in different resources, such as: put the link here. 

## 2.3) Generate a list of excluded variants from the analysis
Now that we have our files in the respective folders, we just have to run the script in this way in linux:

Rscript geneticmapfilepreparation.R

After this, you will get a list of variants that are going to be excluded from the analysis only for the fact that the genetic distance between them is to small that ARG_needle is not able to differenciate that you have the variants in increasing number. 

# 3) excluding the variants from your vcf to be able to run ARG_needle
Run the script:

bash filteringagain.sh

With this script you will create a folder named "ARG_files" and the .haps and .samples files will be stored there.

Note: if your vcf genotypes are not phased, plink will get an error. 

# 4) running ARG_needle

After excluding a few sites and generating .haps and .samples files, you can run arg_needle using the following script

bash ARG_needlefinal.sh

This will generate a .argn file, which can be converted to a .trees tree sequence file that is compatible with tskit.

#   5) converting to tskit .trees format

This step is separated from the last one due to the amount of memory required, you can convert your arg_needle output using the following command:

arg2tskit --arg_path ${arg_path} --ts_path {path_for_output}
