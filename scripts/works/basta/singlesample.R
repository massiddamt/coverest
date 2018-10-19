#!/usr/bin/env Rcript
source("/home/matteo/Scrivania/crs4_pipelines/coverest/scripts/functions.R")
bbmap_coverage_singlesample(snakemake@input[[1]],snakemake@params[[1]],snakemake@output[[1]])