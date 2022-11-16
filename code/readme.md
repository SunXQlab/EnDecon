# EnDecon

## Introduction

EnDecon is an R package developed to deconvolute spatial transcriptome (ST) data. EnDecon is an ensemble learing model by intergrating top-performing methods (i.e., cell2location, RCTD, and spatialDWLS) using linear weighted model. EnDecon provides an alternative and more effective method for ST deconvolution. EnDecon can benchmark different deconvolution methods by calculating the root-mean-square error (RMSE), Pearson correlation coefficient (PCC), and Jensen-Shannon divergence (JSD) between the predicted cell type compositions and the known compositions.

## Example
### Required packages
We start by loading all required packages. `readr` package is used to read data; `Seurat` package is used to read and process data; `dplyr` and `tibble` are used to implement operations in the code; `pryr` is  used to calculate the memory consumed by the algorithm running; `reticulate` is  used to invoke python in R environment; `philentropy` is used to calculate Jensen-Shannon divergence (JSD).
```
library(Seurat)
library(readr)
library(dplyr)
library(tibble)
library(pryr)
library(reticulate)
library(philentropy)
```
### Source code
We source the scripts needed to run EnDecon.
```
source("./code/EnDecon_main.R")
source("./code/cell2loc_process.R")
source("./code/RCTD_pipeline.R")
source("./code/spatialDWLS_pipeline.R")
source_python("./code/cell2location_main.py")
```
### Input data
We then read the scRNA-seq data with rows as genes and columns as cells and ST data with raws as genes and columns as spots, requiring scRNA-seq data and ST data as seurat objects. For scRNA-seq data, the cell type annotation in meta.data needs to be named Cell_class. For ST data, the seurat object needs to contain the coordinate information of each spot.

#### Example dataset
You can download the scRNA-seq data here:<br>
https://www.dropbox.com/s/ruseq3necn176c7/brain_sc.rds?dl=0<br>
You can download the ST data here:<br>
https://www.dropbox.com/s/azjysbt7lbpmbew/brain_st_cortex.rds?dl=0

```
# read scRNA-seq data
sc_data <- readRDS("./brain_sc.rds")
sc_data@meta.data$Cell_class <- gsub("/",".",sc_data@meta.data$subclass)
#sc_data@assays$RNA@counts <- round(sc_data@assays$RNA@counts)

# read ST data
st_data <- readRDS("./brain_st_cortex.rds") 
st_data@images$coordinates = data.frame(x=st_data@images$anterior1@coordinates$row,
                                        y=st_data@images$anterior1@coordinates$col)
```
### Run EnDecon
```
result <- EnDecon_main(sc_data = sc_data ,st_data = st_data,python_path = "D:/Anaconda3/envs/cell2loc_env")
```
The EnDecon `result` includes the deconvolution results of four methods, namely cell2location, RCTD, spatialDWLS, and EnDecon.

