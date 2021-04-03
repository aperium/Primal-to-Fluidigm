#!/bin/bash
#SBATCH --account=PAS1755
#SBATCH --time=120
#SBATCH --output=slurm-runprimalscheme-%j.out
set -e -u -o pipefail

# move to directory
cd /fs/scratch/PAS1755/drw_wd/primalscheme/

# open correct python env
module load python/3.7-2019.10
source /fs/scratch/PAS1755/drw_wd/primalscheme/venv/bin/activate

date                              # Report date+time to time script
echo "Starting runprimalscheme.sh script..."  # Report what script is being run
echo -e "---------\n\n"           # Separate from program output

# execute primalscheme here...
runprimalscheme.sh

echo -e "\n---------\nAll done!"  # Separate from program output
date                              # Report date+time to time script

# exit environment
deactivate
