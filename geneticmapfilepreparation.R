#loading packages first
library(dplyr)
#defining the paths for the bim files
pathTobed <- "map/"
#getting the name of the files
bamFiles <- paste0(pathTobed, dir(pathTobed, "bim$"))
#extracting only the names without extension nor full path
nombres <- sapply(strsplit(dir(pathTobed, "bim$"), "[/\\.]"), function(x){x[length(x)-1]}) # sample identifiers
#defining the path to the genetic map files in plink format
pathTovcf <- "vcf/"
#getting the name of the files
vcfFiles <- paste0(pathTovcf, dir(pathTovcf, "GRCh38.map$"))
#extracting only the names without extension nor full path
nombresvcf <- sapply(strsplit(dir(pathTovcf, "GRCh38.map$"), "[/\\.]"), function(x){x[length(x)-1]}) # sample identifiers
#defining the suffix of the output files
identificacion <- "_corrected.map"
txt <- "_excluded.txt"
valor=1
repeat
{
  mybed <- read.table(bamFiles[valor], header = FALSE, sep= "")
  myvcf <- read.table(vcfFiles[valor], header = FALSE, sep= "")
  elnombre <- paste(nombres[valor], identificacion, sep="")
  elnombre2 <- paste(pathTobed, elnombre, sep="")
  elnombre3 <- paste(nombres[valor], txt, sep="")
  predictionintend <- approx(myvcf$V4, myvcf$V3, xout=mybed$V4, method = "linear", ties = mean, rule = 2)
  predictedcartagene <- as.data.frame(predictionintend)
  updatedmap <- cbind(mybed, predictedcartagene)
  updatedmap$y <- format(round(updatedmap$y, 4), nsmall = 4)
  finalmap <-updatedmap[, c("V1", "V2", "y", "V4")]
  finalmap$V4 <- as.numeric(finalmap$V4)
  finalmap2 <- finalmap[order(finalmap$V4),]
  duplicatedvalues <- subset(finalmap2,duplicated(y))
  finallistoexclude <- duplicatedvalues[, c("V1", "V4")]
  finallistoexclude$V1 <- paste0("chr", finallistoexclude$V1)
    finalmap3 <- finalmap2 %>%  filter(!row_number() %in% rownames(finallistoexclude))
  finalmap3 <- finalmap3[order(finalmap3$V4),]
  write.table(finallistoexclude, elnombre3, sep="\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
  write.table(finalmap3, elnombre2, sep="\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
    #write.table(bedmodificado2, file = elnombre2, sep = "\t", quote = FALSE, row.names = F, col.names = FALSE)
  duplicatedvalues <- subset(finalmap3,duplicated(y))
  
  valor = valor + 1
  if(valor > length(nombres))
  {
    valor=1
    break
  }
}
#ways to verify
#which(sapply(myvcf$V3, function(x) any(diff(x) <= 0)))
#unname(which(sapply(finalmap2$V4, function(x) any(diff(x) <= 0))))
#duplicated(finalmap2$y)
#chr21biallelic <- as.data.frame(chr21biallelic)
#subset(finalmap3,duplicated(y2))
#otroejemplo <- round(finalmap2$y,10),nsmall=10)
#finalmap2$y2 <- otroejemplo
#which(sapply(as.numeric(finalmap3$y), function(x) any(diff(x) < 0)))
#duplicados <- as.data.frame(duplicated(finalmap3$y))
#View(duplicados)
#all(diff(as.numeric(finalmap2$V4)>0))
#subset(finalmap3,duplicated(V4))
#vectornuevo <- as.data.frame(diff(as.numeric(finalmap2$V4)))        
#max(finalmap2$V4)                  
#is.ordered(myvcf$V4)
#is.unsorted(myvcf$V4)
#finalmap4 <- finalmap3[order(as.numeric(finalmap3$y)),]
#finalmap4$y <- as.numeric(finalmap4$y)
#is.unsorted(finalmap4$y)
#duplicados <- as.data.frame(duplicated(finalmap4$y))
