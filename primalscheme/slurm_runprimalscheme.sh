#!/bin/bash
#SBATCH --account=PAS1755
#SBATCH --time=30
#SBATCH --output=slurm-runprimalscheme-%j.out
set -e -u -o pipefail

# execution takes about 15 min for the 103 genes

# move to directory
cd /fs/scratch/PAS1755/drw_wd/Primal-to-Fluidigm/primalscheme

# open correct python env
module load python/3.7-2019.10
source /fs/scratch/PAS1755/drw_wd/primalscheme/venv/bin/activate

date                              # Report date+time to time script
echo "Starting runprimalscheme.sh script..."  # Report what script is being run
echo -e "---------\n\n"           # Separate from program output

# move to directory
cd /fs/scratch/PAS1755/drw_wd/Primal-to-Fluidigm/primalscheme

# execute primalscheme here...
# bash runprimalscheme.sh
bash runprimalscheme2.sh

echo -e "\n---------\nAll done!"  # Separate from program output
date                              # Report date+time to time script

# exit environment
deactivate
