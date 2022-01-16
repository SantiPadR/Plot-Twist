## This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International$
## Author: Juan Ernesto Perez, Santiago Padilla y Miriam Valdayo
## Date: November 2021
## Email: miriamvaldayo99@gmail.com

SAMPLEDIR=$1
i=$2
NUMSAMPLES=$3
PAIRED=$4

##Access sample folder

cd $SAMPLEDIR

## Sample quality control and read mapping to reference genome

if [ "$PAIRED" == "TRUE" ]
then
   fastqc chip${i}_1.fq.gz
   fastqc chip${i}_2.fq.gz

   bowtie2 -x ../../genome/index -1 chip${i}_1.fq.gz -2 chip${i}_2.fq.gz -S chip${i}.sam

   fastqc input${i}_1.fq.gz
   fastqc input${i}_2.fq.gz

   bowtie2 -x ../../genome/index -1 input${i}_1.fq.gz -2 input${i}_2.fq.gz -S input${i}.sam
else
   fastqc chip${i}.fq.gz

   bowtie2 -x ../../genome/index -U chip${i}.fq.gz -S chip${i}.sam

   fastqc input${i}.fq.gz

   bowtie2 -x ../../genome/index -U input${i}.fq.gz -S input${i}.sam
fi

samtools sort -o chip${i}.bam chip${i}.sam
rm chip${i}.sam
samtools index chip${i}.bam

samtools sort -o input${i}.bam input${i}.sam
rm input${i}.sam
samtools index input${i}.bam

## Peak calling

cd ../../results
macs2 callpeak -t $SAMPLEDIR/chip${i}.bam -c $SAMPLEDIR/input${i}.bam -f BAM --outdir . -n sample${i}

## escribir en el blackboard
echo "sample ${i} processed" >> ../../logs/blackboard_samples

## reading from blackboard
NSAMDONE=$(wc -l ../../logs/blackboard_samples | awk '{print $1}')
echo "Number of done samples: $NSAMDONE"
echo ""

## Check if last sample
if [ $NSAMDONE -eq $NUMSAMPLES ]
then
   echo "All samples have been processed"
fi

