# === STEP 0/12: Get variables & create folders  ======================

source arima.cnf
export ASSEMBLY_NAME=$(basename $ASSEMBLY .${ASSEMBLY##*.})
mkdir -p "${OUT_DIR}/std_logs"
mkdir -p "${OUT_DIR}/idx"
mkdir -p ${TMPDIR}


# === STEP 1-2/14: Reference index - BWA index  ======================

INDEX1_JOB=$(sbatch --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.index1.job)
INDEX1_JOB_ID=$(echo $INDEX1_JOB | cut -d ' ' -f4)


# === STEP 3/14: Map forward reads ===================================

MAP1_JOB=$(sbatch --dependency=afterok:${INDEX1_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.map1.job)
MAP1_JOB_ID=$(echo $MAP1_JOB | cut -d ' ' -f4)


# === STEP 4/14: Map reverse reads ===================================

MAP2_JOB=$(sbatch --dependency=afterok:${INDEX1_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.map2.job)
MAP2_JOB_ID=$(echo $MAP2_JOB | cut -d ' ' -f4)


# === STEP 5/14: Filter 5' end on forward .bam =======================

FILTER1_JOB=$(sbatch --dependency=afterok:${MAP1_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.filter1.job)
FILTER1_JOB_ID=$(echo $FILTER1_JOB | cut -d ' ' -f4)


# === STEP 6/14: Filter 5' end on reverse .bam =======================

FILTER2_JOB=$(sbatch --dependency=afterok:${MAP2_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.filter2.job)
FILTER2_JOB_ID=$(echo $FILTER2_JOB | cut -d ' ' -f4)


# === STEP 7/14: Pair & sort .bam files ==============================

PAIR_JOB=$(sbatch --dependency=afterok:${FILTER1_JOB_ID}:${FILTER2_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.pair.job)
PAIR_JOB_ID=$(echo $PAIR_JOB | cut -d ' ' -f4)


# === STEP 8/14: Quality filter ======================================

QUALITY_JOB=$(sbatch --dependency=afterok:${PAIR_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.quality.job)
QUALITY_JOB_ID=$(echo $QUALITY_JOB | cut -d ' ' -f4)


# === STEP 9/14: Remove duplicates ===================================

DEDUP_JOB=$(sbatch --dependency=afterok:${QUALITY_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.dedup.job)
DEDUP_JOB_ID=$(echo $DEDUP_JOB | cut -d ' ' -f4)


# === STEP 10/14: Index .bam =========================================

INDEX2_JOB=$(sbatch --dependency=afterok:${DEDUP_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.index2.job)
INDEX2_JOB_ID=$(echo $INDEX2_JOB | cut -d ' ' -f4)


# === STEP 11/14: Make stats =========================================

STATS_JOB=$(sbatch --dependency=afterok:${INDEX2_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.stats.job)
STATS_JOB_ID=$(echo $STATS_JOB | cut -d ' ' -f4)


# === STEP 12/14: Remove intermediate files ==========================

REMOVE_JOB=$(sbatch --dependency=afterok:${INDEX2_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.clean.job)


# === STEP 13/14: Generate .bed from .bam ==========================

BED1_JOB=$(sbatch --dependency=afterok:${INDEX2_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.bed1.job)
BED1_JOB_ID=$(echo $BED1_JOB | cut -d ' ' -f4)


# === STEP 14/14: Sort .bed ==========================

BED2_JOB=$(sbatch --dependency=afterok:${BED1_JOB_ID} --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/std_logs/%x.%j.out --error=${OUT_DIR}/std_logs/%x.%j.err slurm/arima.bed2.job)
