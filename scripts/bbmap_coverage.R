#!/usr/bin/env Rscript
suppressWarnings(library(stringr))


file_path <- snakemake@input[[1]]
out_folder <- "cov/plots/"
file_list=dir(file_path, pattern = ".bincov.txt")
coverage_df=data.frame(matrix(nrow = length(file_list), ncol = 2))
rownames(coverage_df)=(str_split_fixed(file_list,"\\.",2))[,1]
column_names=c("sample_id","mean")
names(coverage_df)=column_names
for(sample in file_list){
  b=read.table(paste(file_path,sample,sep = ""), nrows = 1,header = F, comment.char = "")
  line_index=grep(str_split_fixed(sample,"\\.",2)[,1],rownames(coverage_df))
  coverage_df[line_index,1]=str_split_fixed(sample,"\\.",2)[,1]
  coverage_df[line_index,2]=b[,2]
}
write.table(coverage_df,file = paste(out_folder,"summary/","bbmap_coverage_summary.tsv",sep = ""), sep = "\t", quote = F,row.names = F)
my_max=round(max(coverage_df$mean))+1
png(filename = paste(out_folder,"bbmap_coverage.png",sep = ""), width = 650, height = 650, units = 'px', res = NA, type = "cairo")
par(mar=c(10.1, 4.1, 4.1, 2.1))
barplot(coverage_df$mean,ylab = "MEAN COVERAGE", las=2, names.arg = coverage_df$sample_id, cex.names = c(0.8), ylim = c(0,round(my_max+1)),axes = F)
axis(side = 2, at = c(seq(0,round(my_max+1),5)), las=1) #, seq(10, 50, 5)))
abline(a=30,b=0, col="red")
abline(a=10,b=0, col="red")
dev.off()
#####################