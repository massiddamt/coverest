#!/usr/bin/env Rscript
suppressWarnings(library(stringr))


file_path <- snakemake@input[[1]]
out_folder <- "cov/plots/"

numb_chrom=snakemake@params[[1]]

file_list=dir(file_path, pattern = ".covstats.txt")

coverage_df=data.frame(matrix(nrow = length(file_list), ncol = 2))
rownames(coverage_df)=(str_split_fixed(file_list,"\\.",2))[,1]
column_names=c("sample_id","mean")
names(coverage_df)=column_names
for(sample in file_list){
  b=read.table(paste(file_path,sample,sep = ""), nrows = numb_chrom,header = T, comment.char = "")
  line_index=grep(str_split_fixed(sample,"\\.",2)[,1],rownames(coverage_df))
  coverage_df[line_index,1]=str_split_fixed(sample,"\\.",2)[,1]
  coverage_df[line_index,2]=mean(b$Avg_fold)
}
write.table(coverage_df,file = paste(out_folder,"summary/","mean_coverage_bbmap_summary_from_covstats.tsv",sep = ""), sep = "\t", quote = F,row.names = F)
pdf(file = paste(out_folder,"mean_coverage_bbmap_from_covstats.pdf",sep = ""), width = 15, height = 10)
par(mar=c(10.1, 4.1, 4.1, 2.1))
barplot(coverage_df$mean,ylab = "MEAN COVERAGE", las=2, names.arg = coverage_df$sample_id, cex.names = c(0.8))
abline(a=30,b=0, col="red")
dev.off()
