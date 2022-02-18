#!/bin/bash

source ~/.bashrc
conda activate bionano

if [ -z $1 ]; then
	echo "Usage: ./_submit_hybrid_scaffold_dle1.sh <name>"
	echo -e "\t<name>: job name and output dir name"
	echo -e "\tAssumes we have asm.fasta and DLE1.cmap in the same dir"
	exit -1
fi

if [ -e $1 ]; then
	echo "$1 already exists. Remove."
	exit -1
fi

cpus=48
mem=960g
partition=begendiv
name=$1
script="/scratch/ddepanis/Software/bionano/hybrid_scaffold_3.3.sh"
#args="$1 DLE1 $VGP_PIPELINE/bionano/hybridScaffold_DLE1_HiC_config_3.3.xml"
args="$1 DLE1 /scratch/ddepanis/Software/bionano/hybridScaffold_DLE1_config_3.3.xml"
walltime=7-00:00:00

mkdir -p logs
log=$PWD/logs/$name.%A_%a.log

echo "\
sbatch --partition=$partition  --qos=standard --cpus-per-task=$cpus --job-name=$name --mem=$mem --time=$walltime --error=$log --output=$log $script $args"
sbatch --partition=$partition  --qos=standard --cpus-per-task=$cpus --job-name=$name --mem=$mem --time=$walltime --error=$log --output=$log $script $args
