#!/bin/bash

##############################################################################
# This is template batch script for calling lastz to make pairwise gene/genome
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

# Make working directory and copy genomes to it

mkdir alignments/lastz/
cd alignments/lastz/

cp <path to fasta file> ./
cp <path to fasta file> ./

# Add path to lastz scripts

export PATH=$PATH:<path to Whole_genome_alignment/pairwise/bin/>
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:<path to Whole_genome_alignment/pairwise/bin/>

# Invoke lastz pipeline (may need to change the numbe rof cuts if the program finishes without producing output or times out):
lastz_CNM.pl <name of fasta file 1> <name of fasta file --run multi --cuts 100 --cpu 16 --hspthresh 2200 --inner 2000 --ydrop 3400 --gappedthresh 10000 --scores HoxD55 --chain --linearGap loose

# Change name and inline species identifiers of output maf file:
mv all.maf <species_names>.maf
sed -i 's/query/<species_1>/g' <species_names>.maf
sed -i 's/target/<species_2>/g' <species_names>.maf
