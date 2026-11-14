# SpatialTranscriptomicsPractice

Práctico de **Spatial Transcriptomics** · Magíster en Informática Médica.

Analizamos un corte de corteza prefrontal dorsolateral humana medido con **10x Visium**
(muestra 151673 de Maynard et al., 2021, *Nature Neuroscience* 24:425–436), que trae las capas
corticales anotadas por expertos. Las usamos para evaluar qué tan bien distintos métodos recuperan
la anatomía del tejido.

## Contenido

| Archivo | Qué hace | Tiempo aprox. |
|---|---|---|
| `00_descargar_datos.Rmd` | Descarga los datos (~20 MB) desde las fuentes oficiales y crea `data/` | < 1 min |
| `01_practico_I.Rmd` | QC sobre el tejido, clustering, genes con patrón espacial (Moran's I), comparación con las capas (ARI) | ~1 min |
| `02_practico_II.Rmd` | Dominios espaciales con BayesSpace y comparación con el clustering clásico | ~3–4 min |
| `environment.yml` · `setup_extra.R` | Entorno de R con todos los paquetes | — |

Los Rmd se corren **en orden**: cada uno usa lo que deja el anterior.

## 1. Clonar el repositorio

```bash
git clone https://github.com/GabrielCabas/SpatialTranscriptomicsPractice.git
cd SpatialTranscriptomicsPractice
```

## 2. Instalar el entorno

### Opción A: Linux o macOS con conda / mamba / micromamba (recomendada)

```bash
micromamba create -f environment.yml -y          # o: conda env create -f environment.yml
micromamba run -n spatial-r Rscript setup_extra.R
```

Para trabajar en RStudio con este entorno, actívalo y abre RStudio **desde la misma terminal**:

```bash
micromamba activate spatial-r
rstudio &
```

Comprueba en la consola de RStudio que `library(BayesSpace)` carga sin error.

### Opción B: Windows (o sin conda)

Los paquetes de Bioconductor en conda no existen para Windows. Instala R ≥ 4.5 y RStudio, y en la
consola de R corre:

```r
install.packages(c("Seurat", "tidyverse", "patchwork", "hdf5r", "mclust", "Rfast2",
                   "rmarkdown", "BiocManager"))
BiocManager::install(c("SingleCellExperiment", "BayesSpace"))
```

## 3. Correr el práctico

1. Abre el proyecto en RStudio: la carpeta del repositorio debe ser el directorio de trabajo.
2. Corre `00_descargar_datos.Rmd` (chunk por chunk, o con **Knit**).
3. Sigue con `01_practico_I.Rmd` y después `02_practico_II.Rmd`.

Las carpetas `data/` y `output/` se crean solas y no se suben al repositorio.

## Problemas frecuentes

**¿RStudio está usando el R correcto?** En la consola de RStudio, `R.home()` debe apuntar a la carpeta del
entorno (por ejemplo `.../envs/spatial-r/lib/R`). Si dice `/usr/lib/R` o similar, RStudio está usando el R
del sistema, que no tiene los paquetes: ciérralo y ábrelo **desde una terminal con el entorno activado**
(`micromamba activate spatial-r` y luego `rstudio &`). Si lo abres desde el menú de aplicaciones, no pasa
por el entorno.

**`package 'Biobase' could not be loaded`** (u otro paquete de Bioconductor) **después de instalar o
actualizar el entorno:** la sesión de RStudio quedó abierta con la versión anterior de R en memoria.
Cierra RStudio por completo y vuelve a abrirlo desde la terminal con el entorno activado.

**No instales RStudio con conda.** El paquete `rstudio-desktop` de conda-forge es antiguo y exige R 4.3:
instalarlo baja la versión de R del entorno y rompe BayesSpace. Usa el RStudio normal de tu sistema.

**Aviso `package '...' was built under R version 4.5.x`:** es inofensivo. El paquete se compiló con una
versión menor de R un poco distinta y funciona igual.

**Moran's I tarda varios minutos:** falta `Rfast2`. Instálalo con `micromamba run -n spatial-r Rscript setup_extra.R`.

**No encuentra `data/dlpfc_151673`:** el directorio de trabajo no es la carpeta del repositorio, o no
corriste `00_descargar_datos.Rmd`. Revisa con `getwd()`.

## Fuente de los datos

- Maynard KR, Collado-Torres L, et al. (2021). Transcriptome-scale spatial gene expression in the human
  dorsolateral prefrontal cortex. *Nature Neuroscience* 24:425–436.
- Datos públicos de [spatialLIBD](http://research.libd.org/spatialLIBD/) (Lieber Institute for Brain Development).
