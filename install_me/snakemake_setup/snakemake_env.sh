#!/bin/bash


env_var_snake="snakemake_env_${USER}"
cd $HOME
if [ ! -d "$HOME/$env_var_snake" ]; then
    echo "Setting up and installing Snakemake.." 
    #git clone https://bitbucket.org/snakemake/snakemake.git
    #cd snakemake
    # Create virutal environment for user 
    python3.9 -m venv $env_var_snake --system-site-packages
    source $HOME/$env_var_snake/bin/activate 
    #python3 setup.py install
    pip3 install snakemake
    deactivate
    mkdir -p ~/.config/snakemake
    mkdir -p ~/snakemake_folders/snake_error_log
    mkdir -p ~/snakemake_folders/snake_output
    mkdir -p ~/snakemake_folders/singularities
    cp -r ~/snakemake_setup/oscar ~/.config/snakemake/oscar
    echo "Snakemake software installed, initializing configuration..." 
else 
    echo "Snakemake software detected, initializing configuration..."
fi 

# change .bashrc to make it more user-friendly 
if [ ! -f "$HOME/.snakemake_specific_aliases" ]; then touch ~/.snakemake_specific_aliases; fi 
echo 'snakemake_start () { module load python/3.9.23s-gwnt && source ~/snakemake_env_${USER}/bin/activate; }' >> $HOME/.snakemake_specific_aliases
echo 'snakemake_remove () { rm -rf ~/snakemake_env_${USER} ~/snakemake_setup ~/.snakemake_specific_aliases ~/.config/snakemake ~/snakemake_folders; unset -f snakemake_start; unset -f snakemake_remove; }' >> $HOME/.snakemake_specific_aliases 
echo 'export -f snakemake_start' >> $HOME/.snakemake_specific_aliases 
echo 'export -f snakemake_remove' >> $HOME/.snakemake_specific_aliases
grep -qxF 'if [ -e $HOME/.snakemake_specific_aliases ]; then source $HOME/.snakemake_specific_aliases; fi' ~/.bashrc || echo 'if [ -e $HOME/.snakemake_specific_aliases ]; then source $HOME/.snakemake_specific_aliases; fi' >> ~/.bashrc
