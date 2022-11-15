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
