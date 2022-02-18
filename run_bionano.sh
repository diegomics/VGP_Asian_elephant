#!/bin/bash

source bionano.cnf

ASSEMBLY_NAME=$(basename $ASSEMBLY .${ASSEMBLY##*.})

mkdir -p "${OUT_DIR}/${ASSEMBLY_NAME}/std_logs"
cd "${OUT_DIR}/${ASSEMBLY_NAME}"
cp "${BIONANO_DIR}/*hybrid*" .
ln -s $ASSEMBLY "${ASSEMBLY_NAME}.fasta"
ln -s $CMAP_FILE "DL1.cmap"

bash submit_hybrid_scaffold_dle1_3.3.sh $NAME



source ~/.bashrc
conda activate bionano


cpus=48
mem=960g

name=$1
script="/scratch/ddepanis/Software/bionano/hybrid_scaffold_3.3.sh"
#args="$1 DLE1 $VGP_PIPELINE/bionano/hybridScaffold_DLE1_HiC_config_3.3.xml"
args="$1 DLE1 /scratch/ddepanis/Software/bionano/hybridScaffold_DLE1_config_3.3.xml"
walltime=7-00:00:00

mkdir -p logs
log=$PWD/logs/$name.%A_%a.log


$script $args

sbatch --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --cpus-per-task=${CPUS} --mem=${MEM} --time=${MAX_TIME} --output=${OUT_DIR}/${ASSEMBLY_NAME}/std_logs/%x.%j.out --error=${OUT_DIR}/${ASSEMBLY_NAME}/std_logs/%x.%j.err


slurm/arima.index1.job)
