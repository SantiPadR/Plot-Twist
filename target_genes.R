## Script para determinar los genes dianas de un factor de transcripcion
## a partir del fichero narrowPeak generado por MaCS2.

## Autor: PLOT-TWIST team 2022
## Fecha: Enero 2022

args <- commandArgs(trailingOnly = TRUE)

peak.file <- args[1]
distance <- as.numeric(args[2])
sample.num <- as.numeric(args[3])

library(ChIPseeker)
library(TxDb.Athaliana.BioMart.plantsmart28)
txdb <- TxDb.Athaliana.BioMart.plantsmart28

## Leer fichero de picos
peaks <- readPeakFile(peak.file,header=FALSE)

## Definir la region que se considera promotor entorno al TSS
promoter <- getPromoters(TxDb=txdb, 
                         upstream=distance, 
                         downstream=distance)

## Anotacion de los picos
peakAnno <- annotatePeak(peak = peaks, 
                             tssRegion=c(-distance, distance),
                             TxDb=txdb)

plotAnnoPie(peakAnno)
plotDistToTSS(peakAnno,
              title="Distribution of genomic loci relative to TSS",
              ylab = "Genomic Loci (%) (5' -> 3')")

## Convertir la anotacion a data frame
annotation <- as.data.frame(peakAnno)
head(annotation)

target.genes <- annotation$geneId[annotation$annotation == "Promoter"]

write(x = target.genes,file = paste0("target_genes_sample_",sample.num,".txt"))
