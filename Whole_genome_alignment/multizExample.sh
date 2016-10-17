#!/bin/bash

##############################################################################
# This is template batch script for calling multiz to make multiple gene/genome
# alignments on ASU's Saguaro Cluster. 
#
# Requires the Whole_Genome_ALignment scripts from the Avian Genome Project.
# git clone https://github.com/WilsonSayresLab/Useful_code.git
#
# Replace anything inside <> before use.
##############################################################################

#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 4-0:0
#SBATCH --job-name=<job name>
#SBATCH -A mwilsons
#SBATCH -o slurm.%j.out
#SBATCH -e slurm.%j.err  
#SBATCH --mail-type=END,FAIL 
#SBATCH --mail-user=<user's e-mail>

# Make working directory and copy alignments to it

mkdir /alignments/multiz/
cd /alignments/multiz/

# The next commands assumes that the target directory only cantains alignments you want to use.
# If not, you can use cp to copy individual files.
cp <path to alignments>/*.maf ./

# Add path to lastz scripts

export PATH=$PATH:<path to Whole_genome_alignment/multiple/bin/>
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:<path to /Whole_genome_alignment/multiple/bin/>

# Invoke multiz pipeline:
roast T=<path to lastz/multiz2> E=<name of reference species> "<phylogenic tree using species names as they appear in the pairwise alignments" *.maf <output file name>.maf
