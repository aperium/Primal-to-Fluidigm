# Readme

Run the scripts in this order:

2. `runprimalscheme.sh`
3. `grepcoverage.sh`
4. `formatcoverage.R`
5. `analyzecoverage.R`

## 1. Prepare fasta files

Clustered by tree using Clustal$\Omega$.

## 2. Run primal scheme

```{shell}
cd /fs/scratch/PAS1755/drw_wd/reduced_primal_by_clustal/primalscheme/
mkdir overlap_70 overlap_65 overlap_60 overlap_55 overlap_50


module load singularity
singularity shell /fs/scratch/PAS1755/Containers/Primal_1.3.2/Primal.sif
source /home/python3env/bin/activate
#sh runprimalscheme_onlyclusters.sh

# This fastas named in the list with specified overlaps
LIST=( 1_FEH_TK 1_FFT_TK 1_SST_TK 2cMDE4PCT1_TK 4C5DP2CMDEK1_TK 4H3M2EDPR2_TK CPT2_TK DOG_1_TK ETR1_TK FDPS1_TK FDPS2_TK FTC_TK FT_TK GDPS1_TK IPPK_TK PMEI_TK PPO_TK REF_TK e4H3M2EDPS1_TK cluster_4H3M2EDPR_TK cluster_CPT_TK cluster_GGDPS_TK)
OVERLAPS=( 50 55 60 65 70 )
for OVERLAP in ${OVERLAPS[@]}; do for GENE in ${LIST[@]}; do primalscheme multiplex -a 180 -a 200 -n $GENE -t $OVERLAP -o overlap_$OVERLAP/$GENE -f fastas/$GENE.fasta; done; done

exit

```



## 3. Copy over existing primal output for genes run separately (if needed)

```{shell}
cd /fs/scratch/PAS1755/drw_wd/reduced_primal_by_clustal/primalscheme/

# ls /fs/scratch/PAS1755/drw_wd/reduced_primal_by_clustal/primalscheme/fastas | awk 'BEGIN {FS = ".fasta"}{OFS = "\t"} {print $1}'

LIST=( 1_FEH_TK 1_FFT_TK 1_SST_TK 2cMDE4PCT1_TK 4C5DP2CMDEK1_TK 4H3M2EDPR2_TK CPT2_TK DOG_1_TK ETR1_TK FDPS1_TK FDPS2_TK FTC_TK FT_TK GDPS1_TK IPPK_TK PMEI_TK PPO_TK REF_TK e4H3M2EDPS1_TK)
OVERLAPS=( 50 55 60 65 70 )

for OVERLAP in ${OVERLAPS[@]}; do for GENE in ${LIST[@]}; do cp -pruv /fs/scratch/PAS1755/drw_wd/103_separate_genes/primalscheme/overlap_$OVERLAP/$GENE overlap_$OVERLAP; done; done


for OVERLAP in ${OVERLAPS[@]}; do for GENE in ${LIST[@]}; do primalscheme multiplex -a 180 -a 200 -n $GENE -t 50 -o overlap_$OVERLAP/$GENE -f fastas/$GENE.fasta; done; done
```



## 4. Extract and prepare the coverage log summary and produce visusuals

```{shell}
cd /fs/scratch/PAS1755/drw_wd/reduced_primal_by_clustal/primalscheme/
sh grepcoverage.sh

cd ~
module purge
module load R
Rscript /fs/scratch/PAS1755/drw_wd/reduced_primal_by_clustal/primalscheme/formatcoverage.R
Rscript /fs/scratch/PAS1755/drw_wd/reduced_primal_by_clustal/primalscheme/analyzecoverage.R

cd /fs/scratch/PAS1755/drw_wd/reduced_primal_by_clustal/primalscheme/

```

