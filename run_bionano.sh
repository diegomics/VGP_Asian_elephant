#!/bin/bash

# === STEP 0/: Get variables & create folders  ======================
source bionano.cnf

mkdir -p "${OUT_DIR}/${ASSEMBLY_NAME}/std_logs"
cd "${OUT_DIR}/${ASSEMBLY_NAME}"
cp ${BIONANO_DIR}/hybrid* .
chmod +x hybrid*
ln -s $ASSEMBLY asm.fasta
ln -s $CMAP_FILE DL1.cmap

source ~/.bashrc
conda activate bionano

# === STEP 1/:  ======================
BIONANO_JOB
sbatch --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --cpus-per-task=${CPUS} --mem=${MEM} --time=${MAX_TIME} --output=${OUT_DIR}/${ASSEMBLY_NAME}/std_logs/%x.%j.out --error=${OUT_DIR}/${ASSEMBLY_NAME}/std_logs/%x.%j.err "${BIONANO_DIR}/hybrid_scaffold_3.3.sh" ${ASSEMBLY_NAME} DLE1 "${BIONANO_DIR}/hybridScaffold_DLE1_config_3.3.xml"
BIONANO_JOB_ID=$(echo $BIONANO_JOB | cut -d ' ' -f4)

# === STEP 2/:  ======================
sbatch --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/${ASSEMBLY_NAME}/std_logs/%x.%j.out --error=${OUT_DIR}/${ASSEMBLY_NAME}/std_logs/%x.%j.err trimNs.job

