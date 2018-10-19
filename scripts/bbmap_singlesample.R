#!/usr/bin/env Rscript
suppressWarnings(library(stringr))


file_path <- snakemake@input[[1]]
out_folder <- "cov/plots/"
numb_chrom <- snakemake@params[[1]]

file_list=dir(file_path, pattern = ".covstats.txt")

for(sample in file_list){
  sample_name=str_split_fixed(sample,"\\.",2)[,1]
  chrom_coverage_df=read.table(paste(file_path,sample,sep = ""), nrows = numb_chrom,header = T, comment.char = "")
  write.table(chrom_coverage_df,file = paste(out_folder,"summary/singlesamples/",sample_name,".coverage_bbmap_chromosome.tsv",sep = ""), sep = "\t", quote = F,row.names = F)
  pdf(file = paste(out_folder,"singlesamples/",sample_name,".coverage_bbmap_CHROMOSOME.pdf",sep = ""), width = 15, height = 10)
  par(mar=c(10.1, 4.1, 4.1, 2.1))
  barplot(chrom_coverage_df$Avg_fold,ylab = "COVERAGE",xlab = "CHROMOSOME",main = paste(sample_name,"\nMEAN COVERAGE ACROSS CHROMOSOMES",sep = ""), las=2, names.arg = chrom_coverage_df$X.ID, cex.names = c(0.8))
  abline(a=30,b=0, col="red")
  dev.off()
}
