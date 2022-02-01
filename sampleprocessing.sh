#! /bin/bash

## This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International$
## Author: Juan Ernesto Perez, Santiago Padilla y Miriam Valdayo
## Date: November 2021
## Email: miriamvaldayo99@gmail.com

SAMPLEDIR=$1
i=$2
NUMSAMPLES=$3
PAIRED=$4
DISTANCE=$5

##Access sample folder

cd $SAMPLEDIR

## Sample quality control and read mapping to reference genome

if [ "$PAIRED" == "TRUE" ]
then
   fastqc chip${i}_1.fq.gz
   fastqc chip${i}_2.fq.gz

   bowtie2 -x ../../genome/index -1 chip${i}_1.fq.gz -2 chip${i}_2.fq.gz -S chip${i}.sam

   samtools sort -o chip${i}.bam chip${i}.sam
   rm chip${i}.sam
   samtools index chip${i}.bam

   fastqc input${i}_1.fq.gz
   fastqc input${i}_2.fq.gz

   bowtie2 -x ../../genome/index -1 input${i}_1.fq.gz -2 input${i}_2.fq.gz -S input${i}.sam

   samtools sort -o input${i}.bam input${i}.sam
   rm input${i}.sam
   samtools index input${i}.bam
else
   fastqc chip${i}.fq.gz

   bowtie2 -x ../../genome/index -U chip${i}.fq.gz -S chip${i}.sam

   samtools sort -o chip${i}.bam chip${i}.sam
   rm chip${i}.sam
   samtools index chip${i}.bam

   fastqc input${i}.fq.gz

   bowtie2 -x ../../genome/index -U input${i}.fq.gz -S input${i}.sam

   samtools sort -o input${i}.bam input${i}.sam
   rm input${i}.sam
   samtools index input${i}.bam
fi

## Peak calling

cd ../../results
macs2 callpeak -t $SAMPLEDIR/chip${i}.bam -c $SAMPLEDIR/input${i}.bam -f BAM --outdir . -n sample${i}

## Motif analysis with HOMER

findMotifsGenome.pl sample${i}_summits.bed ../genome/genome.fa homer_sample${i}/ -size 200 -len 8

## Determining target genes

Rscript $PLOTWIST/target_genes.R sample${i}_peaks.narrowPeak $DISTANCE $i

## escribir en el blackboard
echo "sample ${i} processed" >> ../logs/blackboard_samples

## reading from blackboard
NSAMDONE=$(wc -l ../logs/blackboard_samples | awk '{print $1}')
echo "Number of done samples: $NSAMDONE"
echo ""

## Check if last sample
if [ $NSAMDONE -eq $NUMSAMPLES ]
then
   echo "         ___                       "
   echo "       _(((,|    What's DNA??         "
   echo "      /  _-\\                       "
   echo "     / C o\o \                     "
   echo "   _/_    __\ \     __ __     __ __     __ __     __"
   echo "  /   \ \___/  )   /--X--\   /--X--\   /--X--\   /--"
   echo "  |    |\_|\  /   /--/ \--\ /--/ \--\ /--/ \--\ /--/"
   echo "  |    |#  #|/          \__X__/   \__X__/   \__X__/ "
   echo "  (   /     | "
   echo "   |  |#  # | "
   echo "   |  |    #|                      "
   echo "   |  | #___n_,_                  "
   echo ",-/   7-' .     `\                 "
   echo "`-\...\-_   -  o /                 "
   echo "   |#  # `---U--'                  "
   echo "   `-v-^-'\/                       "
   echo "     \  |_|_ Wny                  "
   echo "     (___mnnm"
   echo ""
   echo "All samples have been processed"
fi
