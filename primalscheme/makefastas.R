reqpacks <- c("tidyverse","stringr","magrittr","openxlsx","fs")
packstoinstall <- setdiff(reqpacks,installed.packages()[,1])
if(length(packstoinstall) > 0) install.packages(packstoinstall)

library("tidyverse")
library("stringr")
library("magrittr")
library("openxlsx")
library("fs")

# set working directory
# getwd()
setwd("/fs/scratch/PAS1755/drw_wd/")

# set primal scheme parameters
args = commandArgs(trailingOnly = TRUE)
if (length(args) == 0) {
  ampmin <- 180
  ampmax <- 200
  overlap <- 70 
} else {
    ampmin <- args[1]
    ampmax <- args[2]
    overlap <- args[3]
}

# read xlsx file
seqs <- path("TK_Amplicons_090319.xlsx") %>%
  read.xlsx(sheet = 4) %>%
  select(Short.name, seq)

# pull sequence short_name and sequence from file
# write unique fastas for each short_name and sequence
# and prepare shell file for execution of each file with named output
shellpath <- "runprimalscheme.sh" # name of shell script
dir_create(paste0("overlap_",overlap))

command <- paste0("primalscheme multiplex -a ", ampmin, " -a ", ampmax, " -n Gene1 -t ", overlap)
if(file_exists(path = shellpath)) file_delete(path = shellpath)
for (i in 1:length(seqs$Short.name)) {
  fastapath <- path(paste0("fastas/",seqs$Short.name[i],".fasta"))
  outpath <- path(paste0("overlap_",overlap,"/",seqs$Short.name[i]))
  
  # make fastas
  file_create(fastapath)
  paste0(">",seqs$Short.name[i],"\n",seqs$seq[i]) %>% write_file(path = fastapath)
  
  # make/append shell file
  paste(command, "-o", outpath, "-f", fastapath, "\n") %>%
    write_file(path = shellpath, append = TRUE)
}
