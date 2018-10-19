library(ggplot2)
library(stringr)
library(gridExtra)


#file_path="Desktop/agris/coverage/cov/"
file_path="/home/matteo/Scrivania/coverest_plots/bbmap/"
file_list=dir(file_path, pattern = ".bincov.txt")


coverage_df=data.frame(matrix(nrow = length(file_list), ncol = 2))
rownames(coverage_df)=(str_split_fixed(file_list,"\\.",2))[,1]
#coverage_df=data.frame(row.names = (str_split_fixed(file_list,"\\.",2))[,1])
column_names=c("sample_id","mean")
names(coverage_df)=column_names

for(sample in file_list){
  print(sample)
  b=read.table(paste(file_path,sample,sep = ""), nrows = 1,header = F, comment.char = "")
  line_index=grep(str_split_fixed(sample,"\\.",2)[,1],rownames(coverage_df))
  coverage_df[line_index,1]=str_split_fixed(sample,"\\.",2)[,1]
  coverage_df[line_index,2]=b[,2]
}
coverage_df

summary(coverage_df$mean)
write.table(coverage_df,file = paste(file_path,"coverage_bbmap_summary.tsv",sep = ""), sep = "\t", quote = F,row.names = F)

grid.table(coverage_df, rows=NULL)
par(mar=c(10.1, 4.1, 4.1, 2.1))
pdf(file = paste(file_path,"coverage_bbmap_hist.pdf",sep = ""), width = 15, height = 10)
par(mar=c(10.1, 4.1, 4.1, 2.1))
barplot(coverage_df$mean,ylab = "MEAN COVERAGE", las=2, names.arg = coverage_df$sample_id, cex.names = c(0.8))
abline(a=30,b=0, col="red")
dev.off()

####################################################################
########## single sample coverage across chromosomes ###############
####################################################################
file_list=dir(file_path, pattern = ".covstats.txt")
numb_chrom=28

for(sample in file_list){
  print(sample)
  sample_name=str_split_fixed(sample,"\\.",2)[,1]
  chrom_coverage_df=read.table(paste(file_path,sample,sep = ""), nrows = numb_chrom,header = T, comment.char = "")
  write.table(chrom_coverage_df,file = paste(file_path,"SUMMARY/",sample_name,".coverage_bbmap_chromosome.tsv",sep = ""), sep = "\t", quote = F,row.names = F)
  par(mar=c(10.1, 4.1, 4.1, 2.1))
  pdf(file = paste(file_path,"PLOTS/",sample_name,".coverage_bbmap_CHROMOSOME.pdf",sep = ""), width = 15, height = 10)
  par(mar=c(10.1, 4.1, 4.1, 2.1))
  barplot(chrom_coverage_df$Avg_fold,ylab = "COVERAGE",xlab = "CHROMOSOME",main = paste(sample_name,"\nMEAN COVERAGE ACROSS CHROMOSOMES",sep = ""), las=2, names.arg = chrom_coverage_df$X.ID, cex.names = c(0.8))
  abline(a=30,b=0, col="red")
  dev.off()
}

########################################################
### sul file .covstats calcola il coverage medio sui cromosmomi ##
########################################################
file_list=dir(file_path, pattern = ".covstats.txt")
numb_chrom=28

coverage_df=data.frame(matrix(nrow = length(file_list), ncol = 2))
rownames(coverage_df)=(str_split_fixed(file_list,"\\.",2))[,1]
column_names=c("sample_id","mean")
names(coverage_df)=column_names

for(sample in file_list){
  print(sample)
  b=read.table(paste(file_path,sample,sep = ""), nrows = numb_chrom,header = T, comment.char = "")
  line_index=grep(str_split_fixed(sample,"\\.",2)[,1],rownames(coverage_df))
  coverage_df[line_index,1]=str_split_fixed(sample,"\\.",2)[,1]
  coverage_df[line_index,2]=mean(b$Avg_fold)
}
coverage_df

summary(coverage_df$mean)
write.table(coverage_df,file = paste(file_path,"mean_coverage_bbmap_summary_from_covstats.tsv",sep = ""), sep = "\t", quote = F,row.names = F)

grid.table(coverage_df, rows=NULL)
par(mar=c(10.1, 4.1, 4.1, 2.1))
pdf(file = paste(file_path,"mean_coverage_bbmap_from_covstats.pdf",sep = ""), width = 15, height = 10)
par(mar=c(10.1, 4.1, 4.1, 2.1))
barplot(coverage_df$mean,ylab = "MEAN COVERAGE", las=2, names.arg = coverage_df$sample_id, cex.names = c(0.8))
abline(a=30,b=0, col="red")
dev.off()


