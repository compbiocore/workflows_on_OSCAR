#!bin/bash

# Back up .bashrc, just in case 
cp ~/.bashrc ~/.bashrc.bak
# Load needed modules 
module load python/3.9.0
module load java/jdk-11.0.11
# Move setup folders to HOME directory 
cp -r ~/workflows_on_OSCAR/install_me/nextflow_setup ~/nextflow_setup
# Run Python script 
runEverything () {
python3 $HOME/workflows_on_OSCAR/workflows.py 
source ~/.bashrc
}

runEverything
