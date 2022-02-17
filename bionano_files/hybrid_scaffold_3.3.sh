#!/bin/bash

name=$1
ENZYME=$2
BMAP=$ENZYME.cmap # DLE1.cmap
ASM=asm.fasta	# ln -s to the asm.fasta
CONFIG=$3
RefAligner=$tools/bionano/Solve3.6.1_11162020/RefAligner/11442.11643rel/avx/RefAligner

#module load python
#### Python 2.7.15 :: Anaconda custom (64-bit)
#module load perl
#### Loading Perl 5.18.2  ... 
#module load R
#### Loading gcc  7.2.0  ... 
#### Loading GSL 2.4 for GCC 7.2.0 ... 
#### Loading openmpi 3.0.0  for GCC 7.2.0 
#### Loading R 3.5.0_build2

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

perl $tools/bionano/Solve3.6.1_11162020/HybridScaffold/11162020/hybridScaffold.pl \
-n $ASM \
-b $BMAP \
-c $CONFIG \
-r $RefAligner \
-B 2 \
-N 2 \
-f \
-o $PWD/$name
