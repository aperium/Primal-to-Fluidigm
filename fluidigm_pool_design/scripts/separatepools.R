reqpacks <- c("tidyverse","stringr","magrittr","fs")
packstoinstall <- setdiff(reqpacks,installed.packages()[,1])
if(length(packstoinstall) > 0) install.packages(packstoinstall)

library(tidyverse)
library(stringr)
library(magrittr)
library(fs)

# set working directory
# getwd()
#setwd("/fs/scratch/PAS1755/drw_wd/reduced_primal_by_clustal/clustal_on_primers/")
setwd("/Users/aperium/Dropbox/Projects/OSU HCS/T. kok-saghyz/Harnessing VLHSV/reduced_primal_by_clustal/clustal_on_primers")

outpath <- path("pools")

# get arguments
args = commandArgs(trailingOnly = TRUE)
if (length(args) == 0) infile <- path("allprimers.tsv") else infile <- args[1]

# read tsv file
data <- infile %>%
  read_tsv(col_names = TRUE)

# produce a unique csv and fasta file for each pool
dir_create(outpath)
for (i in unique(data$pool)) {
  tmp_pool <- data %>%
    filter(pool == i)
  
  # make csv files
  tmp_pool %>% write_csv(paste0(outpath,"/pool",i,".csv"))
  
  # make fasta files
  fastapath <- path(paste0(outpath,"/pool",i,".fasta"))
  #file.remove(fastapath)
  file_create(fastapath)
  #printer <- file(fastapath,"w")
  output <- paste0(">",tmp_pool$gene,"|",tmp_pool$name,"|pool_",tmp_pool$pool,"|size_",tmp_pool$size,"|%gc_",tmp_pool$`%gc`,"|tm_",tmp_pool$`tm (use 65)`,"\n",tmp_pool$seq)
  #write_lines(output, printer, sep = "\n")
  readr::write_lines(x = output, file = path(fastapath), sep = "\n")
  #close(printer)
  
}


