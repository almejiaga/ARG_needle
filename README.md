# ARG_needle
This is a set of scripts for preparing input files and running arg_needle
#   1) Prepare your data for the analysis

If you have phased vcf files, split the data into chromosomes, and for each of the chromosomes, extract the corresponding genetic map file using this bash script that merge again multiallelic variants that were split and also excludes multiallelic snps and INDELs from the vcfs and generates a binary plink file: 

bash processingscript.sh

Note: this script recognizes vcfs files that end in .vcf.gz

---
#   2) Generate your genetic map file in increasing genetic distance for ARG_needle
for this section, we will use the .bim file created in the last step. the R script is designed to work automatically but we need to create two folders in order to the script to work properly

## 2.1) map folder
We have to create a map folder that will store the .bim files for each chromosome

## 2.2) plink_maps folder
We have to create a vcf folder that stores the genetic map files for each chromosome in plink format. This files can be found in different resources, such as: put the link here. 

## 2.3) Generate a list of excluded variants from the analysis
Now that we have our files in the respective folders, we just have to run the script in this way in linux:

Rscript geneticmapfilepreparation.R

After this, you will get a list of variants that are going to be excluded from the analysis only for the fact that the genetic distance between them is to small that ARG_needle is not able to say that you have the variants in an increasing number. 

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
