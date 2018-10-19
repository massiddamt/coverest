library(ggplot2)
library(stringr)
library(gridExtra)

#file_path="/home/matteo/Scrivania/coverest_plots/bbmap/"
file_path=snakemake@input[[1]]
file_list=dir(file_path, pattern = ".sample_summary")
column_names=c("sample_id","total","mean","granular_third_quartile","granular_median","granular_first_quartile","%_bases_above_15","%_bases_above_20","%_bases_above_30")

coverage_df=data.frame(matrix(nrow = length(file_list), ncol = length(column_names)))
rownames(coverage_df)=(str_split_fixed(file_list,"\\.",2))[,1]
names(coverage_df)=column_names

for(sample in file_list){
  b=read.table(paste(file_path,sample,sep = ""), nrows = 1,header = T)
  line_index=grep(b$sample_id,rownames(coverage_df))
  coverage_df[line_index,1:9]=b[1,1:9]
}

coverage_df$sample_id=rownames(coverage_df)
write.table(coverage_df,file = snakemake@output[[1]], sep = "\t", quote = F,row.names = F)

par(mar=c(10.1, 4.1, 4.1, 2.1))
pdf(file = snakemake@output[[2]], width = 15, height = 10)
par(mar=c(10.1, 4.1, 4.1, 2.1))
barplot(coverage_df$mean,ylab = "MEAN COVERAGE", las=2, names.arg = coverage_df$sample_id, cex.names = c(0.8))
abline(a=30,b=0, col="red")
dev.off()
