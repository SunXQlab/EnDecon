# EnDecon

## Introduction

EnDecon is an R package developed to deconvolute spatial transcriptome (ST) data. EnDecon is an ensemble learing model by intergrating top-performing methods (i.e., cell2location, RCTD, and spatialDWLS) using linear weighted model. EnDecon provides an alternative and more effective method for ST deconvolution. EnDecon can benchmark different deconvolution methods by calculating the root-mean-square error (RMSE), Pearson correlation coefficient (PCC), and Jensen-Shannon divergence (JSD) between the predicted cell type compositions and the known compositions.

# Installation

## 1. Preparation
the cell2location, RCTD, and spatialDWLS packages should be installed before using EnDecon method.
* For the detailed installation process of cell2location, please refer to https://github.com/BayraktarLab/cell2location#Installation
* The installation process of RCTD can refer to https://github.com/dmcable/spacexr
* The installation process of spatialDWLS can refer to https://rubd.github.io/Giotto_site/articles/tut0_giotto_environment.html

## 2. Installation 
Install EnDecon package from github:<br> 
```
install.package("devtools")
library(devtools)
devtools::install_github("SunXQlab/EnDecon")
library(EnDecon)
```
or install scMLnet module from the source code:
```
install.packages("path/to/download/EnDecon_0.1.0.tar.gz", repos = NULL, type = "source")
library(EnDecon)
```
## 3. Example

### Required packages
We start by loading all required packages. `readr` package is used to read data; `Seurat` package is used to read and process data; `dplyr` and `tibble` are used to implement operations in the code; `pryr` is  used to calculate the memory consumed by the algorithm running; `reticulate` is  used to invoke python in R environment; `philentropy` is used to calculate Jensen-Shannon divergence (JSD).
```
library(Seurat)
library(readr)
library(dplyr)
library(tibble)
library(EnDecon)
library(pryr)
library(reticulate)
library(philentropy)
```
### Input data
We then read the scRNA-seq data with behavioral genes, columns as cells and ST data with behavioral genes, columns as spots, requiring scRNA-seq data and ST data as seurat objects. For scRNA-seq data, the cell type annotation in meta.data needs to be named Cell_class and count.data needs to be integer. For ST data, the seurat object needs to contain the coordinate information of each spot.
```
# read scRNA-seq data
sc_data <- readRDS("./MERFISH_singlecell_dataset.rds")

# read ST data
st_data <- readRDS("./MERFISH_spatialspot_dataset.rds")
```
### Run EnDecon
Before running EnDecon function, we need to source the `cell2location_main.py` function.
```
source_python('./EnDecon/cell2location_main.py)
result <- EnDecon_main(sc_data = sc_data ,st_data = st_data,python_path = "D:/Anaconda3/envs/cell2loc_env")
```
The EnDecon `result` includes the deconvolution results of four methods, namely cell2location, RCTD, spatialDWLS, and EnDecon.
