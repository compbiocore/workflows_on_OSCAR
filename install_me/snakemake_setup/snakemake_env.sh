#!/bin/bash

env_var_snake="snakemake_env_${USER}"
env_dir="$HOME/$env_var_snake"

cd "$HOME"

module load python/3.9.23s-gwnt

if [ ! -x "$env_dir/bin/snakemake" ]; then
    echo "Setting up and installing Snakemake..."

    rm -rf "$env_dir"

    python3.9 -m venv "$env_dir"
    source "$env_dir/bin/activate"

    python -m pip install --upgrade pip setuptools wheel
    python -m pip install "snakemake==7.32.4" "pulp==2.7.0"

    mkdir -p ~/.config/snakemake
    mkdir -p ~/snakemake_folders/snake_error_log
    mkdir -p ~/snakemake_folders/snake_output
    mkdir -p ~/snakemake_folders/singularities

    cp -r ~/snakemake_setup/oscar ~/.config/snakemake/oscar

    echo "Snakemake software installed, initializing configuration..."
else
    echo "Snakemake executable detected, initializing configuration..."
    source "$env_dir/bin/activate"
fi

if [ ! -f "$HOME/.snakemake_specific_aliases" ]; then
    touch "$HOME/.snakemake_specific_aliases"
fi

grep -qxF 'snakemake_start () { module load python/3.9.23s-gwnt && source ~/snakemake_env_${USER}/bin/activate; }' "$HOME/.snakemake_specific_aliases" || \
echo 'snakemake_start () { module load python/3.9.23s-gwnt && source ~/snakemake_env_${USER}/bin/activate; }' >> "$HOME/.snakemake_specific_aliases"

grep -qxF 'snakemake_remove () { rm -rf ~/snakemake_env_${USER} ~/snakemake_setup ~/.snakemake_specific_aliases ~/.config/snakemake ~/snakemake_folders; unset -f snakemake_start; unset -f snakemake_remove; }' "$HOME/.snakemake_specific_aliases" || \
echo 'snakemake_remove () { rm -rf ~/snakemake_env_${USER} ~/snakemake_setup ~/.snakemake_specific_aliases ~/.config/snakemake ~/snakemake_folders; unset -f snakemake_start; unset -f snakemake_remove; }' >> "$HOME/.snakemake_specific_aliases"

grep -qxF 'export -f snakemake_start' "$HOME/.snakemake_specific_aliases" || \
echo 'export -f snakemake_start' >> "$HOME/.snakemake_specific_aliases"

grep -qxF 'export -f snakemake_remove' "$HOME/.snakemake_specific_aliases" || \
echo 'export -f snakemake_remove' >> "$HOME/.snakemake_specific_aliases"

grep -qxF 'if [ -e $HOME/.snakemake_specific_aliases ]; then source $HOME/.snakemake_specific_aliases; fi' ~/.bashrc || \
echo 'if [ -e $HOME/.snakemake_specific_aliases ]; then source $HOME/.snakemake_specific_aliases; fi' >> ~/.bashrc
