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
devtools::install_github("SunLab/EnDecon")
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
sc_data <- readRDS("D:/AA-luluyan-phd/code/benchmark_github/synthetic_st_dataset/MERFISH_singlecell_dataset.rds")
st_data <- readRDS("D:/AA-luluyan-phd/code/benchmark_github/synthetic_st_dataset/MERFISH_spatialspot_dataset.rds")


