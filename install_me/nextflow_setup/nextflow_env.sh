#!/bin/bash


env_var="nextflow_env_${USER}"
cd $HOME
if [ ! -d "$HOME/$env_var" ]; then
    echo "Setting up and installing Nextflow.." 
    # Create virutal environment for user 
    python -m venv $env_var
    source $HOME/$env_var/bin/activate 
    wget -qO- https://get.nextflow.io | bash
    # Make nextflow executable and move to path 
    chmod +x nextflow
    mv nextflow $HOME/$env_var/bin
    deactivate
    echo "Nextflow software installed, initializing configuration..." 
else 
    echo "Nextflow software detected, initializing configuration..."
fi 

# change .bashrc to make it more user-friendly 
if [ ! -f "$HOME/.nextflow_specific_aliases" ]; then touch ~/.nextflow_specific_aliases; fi 
echo 'nextflow_start () { module load openjdk/11.0.23_9-7cjq && source ~/nextflow_env_${USER}/bin/activate; }' >> $HOME/.nextflow_specific_aliases 
echo 'remove_nexflow () { rm -rf ~/nextflow_env_${USER} ~/.nextflow ~/nextflow_setup ~/.nextflow_specific_aliases; unset -f nextflow_start; unset -f remove_nextflow; }' >> $HOME/.nextflow_specific_aliases 
echo 'export -f nextflow_start' >> $HOME/.nextflow_specific_aliases 
echo 'export -f remove_nexflow' >> $HOME/.nextflow_specific_aliases 
grep -qxF 'if [ -e $HOME/.nextflow_specific_aliases ]; then source $HOME/.nextflow_specific_aliases; fi' ~/.bashrc || echo 'if [ -e $HOME/.nextflow_specific_aliases ]; then source $HOME/.nextflow_specific_aliases; fi' >> ~/.bashrc


