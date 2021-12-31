# ¿Qué es Plot-Twist?

Plot-Twist es un programa diseñado para automatizar el proceso de análisis de datos de ChIP-seq. 
Plot-Twist procesa archivos fastq y genera una lista de loci en el genoma.

# ¿Cómo instalarlo?

Plot-Twist requiere las siguientes dependencias que necesitan ser instaladas previamente:

- FASTQC: [Una herramienta de control de calidad para datos de secuenciación de alto rendimiento](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- [Bowtie 2: Una herramienta ultrarrápida y eficiente para el alineamiento de lecturas de secuenciación a secuencias de referencia largas](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
- [Samtools: Lectura/escritura/edición/indexación/inspección de formato SAM/BAM/CRAM](http://www.htslib.org/)
- MACS2: [Análisis basado en modelos para ChIP-Seq](https://pypi.org/project/MACS2/)

Para instalar Plot-Twist no son necesarios permisos de administrador/sudo, simplemente sigue los siguientes pasos:

1. Descarga el código de Github, por ejemplo, a tu carpeta opt (asegúrate de que tienes dicha carpeta o creala con mkdir opt en tu carpeta home):
 ```
cd
mkdir opt
cd opt
git clone https://github.com/SantiPadR/Plot-Twist.git
```
2. Añade a tu variable PATH definida en tu .bashrc la ruta a la carpeta de scripts para que los scripts de Plot-Twist puedan ser ejecutados desde la línea de comandos:
```
cd
echo "PATH=$PATH:$HOME/opt/plotwist/scripts" >> .bashrc
source .bashrc
```
3. Añade a tu .bashrc una nueva variable plotwist indicando la ruta a la carpeta de Plot-Twist:

```
echo "export plotwist=$HOME/opt/plotwist/" .bashrc
source .bashrc
```
