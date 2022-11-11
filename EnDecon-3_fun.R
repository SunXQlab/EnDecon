#############
## library ##
#############

library(philentropy)
library(readr)
library(pryr)
library(Seurat)
rm(list=ls())
gc()

setwd("D:/AA-luluyan-phd/code/test")
## code

source(file = "D:/AA-luluyan-phd/code/benchmark_github/benchmarking.R")

## load data
ptm <- proc.time()

# load merfish

sc_data <- readRDS("D:/AA-luluyan-phd/code/benchmark_github/synthetic_st_dataset/MERFISH_singlecell_dataset.rds")
st_data <- readRDS("D:/AA-luluyan-phd/code/benchmark_github/synthetic_st_dataset/MERFISH_spatialspot_dataset.rds")

# load human heart 

# sc_data <- readRDS("~/benchmark_github/real_st_dataset/human_heart_singlecell_data.rds")
# st_data <- readRDS("~/benchmark_github/real_st_dataset/human_heart_spatialspot_data.rds")

Methods.R <- c("RCTD","spatialDWLS")

DeconResults <- list()
for (m in Methods.R){
  
  deconresult <- benchmark(sc_data,st_data,number_ct = 9, methods = m, 
                           ground_truth = as.matrix(st_data@meta.data[,7:15]))

  DeconResults[[m]] <- deconresult
  
}

# run cell2location
library(reticulate)

use_python("D:/Anaconda3/envs/cell2loc_env")
source_python("D:/AA-luluyan-phd/code/STDeconMethod/EnDecon/MERFISH/cell2location_main.py")

st_cnt_path = "D:/AA-luluyan-phd/code/STDeconMethod/EnDecon/MERFISH/merfish_spatial_countdata.csv"
sc_cnt_path = "D:/AA-luluyan-phd/code/STDeconMethod/EnDecon/MERFISH/merfish_cell_countdata.csv"
sc_mta_path = "D:/AA-luluyan-phd/code/STDeconMethod/EnDecon/MERFISH/merfish_cell_metadata.csv"

WorkDir <- paste0("./deconvolution_results/decon_", "cell2location")
dir.create(WorkDir, recursive = TRUE, showWarnings = F)
cat(paste0("WorkDir: ", WorkDir, "\n"))
means_cell_abun <- cell2location_main(sc_cnt_dir = sc_cnt_path,
                                   sc_mta_dir = sc_mta_path,
                                   st_cnt_dir = st_cnt_path)

means_cell_abun <- column_to_rownames(means_cell_abun,var="X")
means_cell_abun <- as.matrix(means_cell_abun)
#rownames(means_cell_abun) <- rownames(ground_truth)
colnames(means_cell_abun) <- gsub("meanscell_abundance_w_sf_","",colnames(means_cell_abun))
decon_result <- t(apply(means_cell_abun,1,as.numeric))
colnames(decon_result) <- colnames(means_cell_abun)

write.table(decon_result, 
            paste0(WorkDir, '/decon_result.csv'),
            row.names = TRUE, col.names = TRUE, sep=",")

runtime <- (proc.time() - ptm)/60
memory <- mem_used()

cat(paste0("Ensemble running time is:", round(runtime[3],3), "min"),
    paste0("Ensemble memory usage is:", round(memory/1024/1024/1024,3), "GB"),
    sep = "\n")
