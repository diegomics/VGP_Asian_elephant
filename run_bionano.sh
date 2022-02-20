#!/bin/bash

source bionano.cnf

mkdir -p "${OUT_DIR}/${ASSEMBLY_NAME}/std_logs"
cd "${OUT_DIR}/${ASSEMBLY_NAME}"
cp ${BIONANO_DIR}/* .
chmod +x hybrid*
ln -s $ASSEMBLY asm.fasta
ln -s $CMAP_FILE DL1.cmap

source ~/.bashrc
conda activate bionano

sbatch --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --cpus-per-task=${CPUS} --mem=${MEM} --time=${MAX_TIME} --output=${OUT_DIR}/${ASSEMBLY_NAME}/std_logs/%x.%j.out --error=${OUT_DIR}/${ASSEMBLY_NAME}/std_logs/%x.%j.err "${BIONANO_DIR}/hybrid_scaffold_3.3.sh" ${ASSEMBLY_NAME} DLE1 "${BIONANO_DIR}/hybridScaffold_DLE1_config_3.3.xml"
