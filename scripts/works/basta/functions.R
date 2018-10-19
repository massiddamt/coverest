

depthofcoverage <- function(path,id,out_folder_path){
  file_path=path
  library(stringr)
  library(ggplot2)
  id=id
  out_folder=out_folder_path
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
  write.table(coverage_df,file = paste(out_folder,id,".gatk_coverage_summary.tsv",sep = ""), sep = "\t", quote = F,row.names = F)
  pdf(file = paste(out_folder,id,".gatk_coverage_hist.pdf",sep = ""), width = 15, height = 10)
  par(mar=c(10.1, 4.1, 4.1, 2.1))
  barplot(coverage_df$mean,ylab = "MEAN COVERAGE", las=2, names.arg = coverage_df$sample_id, cex.names = c(0.8))
  abline(a=30,b=0, col="red")
  dev.off()
}
####################################################################################à
bbmap_coverage<-function(path,id,out_folder_path){
  file_path=path
  library(stringr)
  library(ggplot2)
  id=id
  out_folder=out_folder_path
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
  write.table(coverage_df,file = paste(out_folder,id,".coverage_bbmap_summary.tsv",sep = ""), sep = "\t", quote = F,row.names = F)
  pdf(file = paste(out_folder,id,".coverage_bbmap_hist.pdf",sep = ""), width = 15, height = 10)
  par(mar=c(10.1, 4.1, 4.1, 2.1))
  barplot(coverage_df$mean,ylab = "MEAN COVERAGE", las=2, names.arg = coverage_df$sample_id, cex.names = c(0.8))
  abline(a=30,b=0, col="red")
  dev.off()
}
#####################################################################
bbmap_coverage_singlesample<-function(path,numb_chr,out_folder_path){
  file_path=path
  library(stringr)
  library(ggplot2)
  out_folder=out_folder_path
  file_list=dir(file_path, pattern = ".covstats.txt")
  numb_chrom=numb_chr
  for(sample in file_list){
    sample_name=str_split_fixed(sample,"\\.",2)[,1]
    chrom_coverage_df=read.table(paste(file_path,sample,sep = ""), nrows = numb_chrom,header = T, comment.char = "")
    write.table(chrom_coverage_df,file = paste(out_folder,"summary/",sample_name,".coverage_bbmap_chromosome.tsv",sep = ""), sep = "\t", quote = F,row.names = F)
    pdf(file = paste(out_folder,"plots/",sample_name,".coverage_bbmap_CHROMOSOME.pdf",sep = ""), width = 15, height = 10)
    par(mar=c(10.1, 4.1, 4.1, 2.1))
    barplot(chrom_coverage_df$Avg_fold,ylab = "COVERAGE",xlab = "CHROMOSOME",main = paste(sample_name,"\nMEAN COVERAGE ACROSS CHROMOSOMES",sep = ""), las=2, names.arg = chrom_coverage_df$X.ID, cex.names = c(0.8))
    abline(a=30,b=0, col="red")
    dev.off()
  }
}
###########################################################################
bbmap_coverage_on_chromosomes<-function(path,numb_chr,id,out_folder_path){
  file_path=path
  id=id
  library(stringr)
  library(ggplot2)
  out_folder=out_folder_path
  file_list=dir(file_path, pattern = ".covstats.txt")
  numb_chrom=numb_chr
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
  write.table(coverage_df,file = paste(out_folder,id,".mean_coverage_bbmap_summary_from_covstats.tsv",sep = ""), sep = "\t", quote = F,row.names = F)
  pdf(file = paste(out_folder,id,".mean_coverage_bbmap_from_covstats.pdf",sep = ""), width = 15, height = 10)
  par(mar=c(10.1, 4.1, 4.1, 2.1))
  barplot(coverage_df$mean,ylab = "MEAN COVERAGE", las=2, names.arg = coverage_df$sample_id, cex.names = c(0.8))
  abline(a=30,b=0, col="red")
  dev.off()
}
#################################################################################