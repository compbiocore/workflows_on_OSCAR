#!bin/bash

# First time we run install, back up .bashrc, just in case 
if [ ! -f "$HOME/.bashrc.bak" ]; then cp ~/.bashrc ~/.bashrc.bak; fi 
# Create a user-friendly alias to shut off virtual environments 
grep -qxF 'alias quit_workflow="deactivate && bash"' ~/.bashrc || echo 'alias quit_workflow="deactivate && bash"' >> ~/.bashrc; 
# Load needed modules 
module load python/3.9.16s-x3wdtvt openjdk/11.0.23_9-7cjq
# Run Python script 
python3 $HOME/workflows_on_OSCAR/workflows.py 
