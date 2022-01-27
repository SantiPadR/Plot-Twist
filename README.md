# ¿Qué es Plot-Twist?

Plot-Twist es un programa diseñado para automatizar el proceso de análisis de datos de ChIP-seq de *Arabidopsis thaliana*. 
Plot-Twist procesa archivos fastq y genera una lista de loci en el genoma.

# ¿Cómo instalarlo?

**Plot-Twist** requiere las siguientes dependencias que necesitan ser instaladas previamente:

- [FASTQC: Una herramienta de control de calidad para datos de secuenciación de alto rendimiento](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)

- [Bowtie 2: Una herramienta ultrarrápida y eficiente para el alineamiento de lecturas de secuenciación a secuencias de referencia largas](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)

- [Samtools: Lectura/escritura/edición/indexación/inspección de formato SAM/BAM/CRAM](http://www.htslib.org/)

- [MACS2: Análisis basado en modelos para ChIP-Seq](https://pypi.org/project/MACS2/)

- [SLURM: Sistema de programación de trabajos y administración de clústeres de código abierto](https://slurm.schedmd.com/documentation.html)

- [HOMER: Software para descubrimiento de motivos y análisis de secuenciación de última generación](http://homer.ucsd.edu/homer/introduction/install.html)


Para instalar **Plot-Twist** no son necesarios permisos de administrador/sudo, simplemente sigue los siguientes pasos:

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
echo "PATH=$PATH:$HOME/opt/Plot-Twist" >> .bashrc
source .bashrc
```
3. Añade a tu .bashrc una nueva variable PLOTWIST indicando la ruta a la carpeta de Plot-Twist:
```
echo "export PLOTWIST=$HOME/opt/Plot-Twist/" >> .bashrc
source .bashrc
```
# ¿Cómo se usa?
Para ejecutar **Plot-Twist** primero debes crear el archivo de parámetros. Puedes encontrar ejemplos de estos archivos en las carpetas test y examples.
Para el procesamiento de los datos usa el ejecutable plotwist con una única entrada consistiendo en el archivo de parámetros

```
plotwist <archivo de parámetros>
```
[Click aquí para un ejemplo del archivo de parámetros usado para Plot-Twist](https://github.com/SantiPadR/Plot-Twist/blob/main/example/param_file_test.txt)

Los parámetros que necesitan ser especificados en el archivo de parámetros son los siguientes:

- **working_directory:** Este parámetro especifica el directorio donde se generará la carpeta que contendrá los datos de salida del análisis. Por ejemplo /home/usuario/investigacion/
- **folder_name:** Este parámetro especifica el nombre de la carpeta donde se guardarán los resultados del análisis. 
- **genome:** Este parámetro especifica la ruta del archivo fasta del genoma.
- **annotation:** Este parámetro especifica la ruta de la anotación del genoma. 
- **number_samples:** Este parámetro especifica el número de muestras de cada tipo (ChIP y control) del estudio. 
- **paired_end:** Este parámetro especifica si los datos son single-end (tomará el valor de FALSE) o paired-end (tomará el valor de TRUE). 
- **promoter_distance:** Distancia desde el sitio de inicio de transcripción que se tiene en cuenta como sitio donde hay promotor.  
- **chipN:** Para datos single-end, este parámetro especifica la ruta de cada una de las muestras de ChIP. 
- **inputN:** Para datos single-end, este parámetro especifica la ruta de cada una de las muestras control.
- **chipN_1:** Para datos paired-end, este parámetro especifica la ruta de las lecturas izquierdas de cada una de las muestras de ChIP.
- **chipN_2:** Para datos paired-end, este parámetro especifica la ruta de las lecturas derechas cada una de las muestras de ChIP.
- **inputN_1:** Para datos paired-end, este parámetro especifica la ruta de las lecturas izquierdas de cada una de las muestras control.
- **inputN_2:** Para datos paired-end, este parámetro especifica la ruta de las lecturas derechas de cada una de las muestras control.
# Resultados generados por Plot-Twist
 Los resultados y archivos intermediarios generados durante la ejecución del programa serán guardados en la carpeta especificada en el parámetro **folder_name**. 
# Datos de ejemplo
Plot-Twist incluye datos de ejemplo para comprobar que se ha instalado correctamente. Para ello, ejecuta la siguiente instrucción:
```
plotwist $PLOTWIST/example/param_file_test.txt
```
