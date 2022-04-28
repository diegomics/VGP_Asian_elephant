source 1.repeat_variables.cnf

export PATH="${CONDA_BIN_DIR}:${PATH}"
source activate REPEAT_env

export ASSEMBLY_NAME=$(basename $ASSEMBLY .${ASSEMBLY##*.})


echo "=== 1/5. Indexing genome for RepeatModeler...  ======================================="

mkdir -p "${OUT_DIR}/01_modeler"
cd "${OUT_DIR}/01_modeler"
ln -s $ASSEMBLY ${ASSEMBLY_NAME}.fa

singularity exec --bind ${BIND_DIR}:${BIND_DIR} "${INSTALLATION_DIR}/tetools_latest.sif" \
BuildDatabase -name ${ASSEMBLY_NAME} ${ASSEMBLY_NAME}.fa


echo "=== 2/5. Starting RepeatModeler...  =================================================="

singularity exec --bind ${BIND_DIR}:${BIND_DIR} "${INSTALLATION_DIR}/tetools_latest.sif" \
RepeatModeler -database ${ASSEMBLY_NAME} -pa ${SLURM_CPUS_PER_TASK} -LTRStruct


echo "=== 3/5. Combining repeats libraries...  =============================================="

mkdir -p "${OUT_DIR}/02_libraries"
cd "${OUT_DIR}/02_libraries"

#extract a species-specific FASTA library from the installed libraries
singularity exec --bind ${BIND_DIR}:${BIND_DIR} --pwd /opt/RepeatMasker/Libraries/ "${INSTALLATION_DIR}/tetools_latest.sif" \
famdb.py -i RepeatMaskerLib.h5 families --format fasta_name --include-class-in-name --ancestors --descendants "${SPECIES_NAME}" > ${ASSEMBLY_NAME}-rm.fa

#combine libraries
cat ${ASSEMBLY_NAME}-rm.fa "${OUT_DIR}/01_modeler/${ASSEMBLY_NAME}-families.fa" > "${ASSEMBLY_NAME}_combined.fa"


echo "=== 4/5. Starting RepeatMasker...  ==================================================="

mkdir -p "${OUT_DIR}/03_masker"
cd "${OUT_DIR}/03_masker"
ln -s $ASSEMBLY ${ASSEMBLY_NAME}

singularity exec --bind ${BIND_DIR}:${BIND_DIR} "${INSTALLATION_DIR}/tetools_latest.sif" \
RepeatMasker -pa ${SLURM_CPUS_PER_TASK} -a -s -gccalc -xsmall -lib "${OUT_DIR}/02_libraries/${ASSEMBLY_NAME}_combined.fa" ${ASSEMBLY_NAME}

mv ${ASSEMBLY_NAME}.masked ${ASSEMBLY_NAME}.masked.fa

# generate a bed files useful for masking
rmsk2bed --max-mem 48G < ${ASSEMBLY_NAME}.out > ${ASSEMBLY_NAME}.bed
cut -f1,2,3 ${ASSEMBLY_NAME}.bed > ${ASSEMBLY_NAME}.3cols.bed

echo "=== 5/5. Plotting results...  ========================================================"

singularity exec --bind ${BIND_DIR}:${BIND_DIR} "${INSTALLATION_DIR}/tetools_latest.sif" \
calcDivergenceFromAlign.pl -s ${ASSEMBLY_NAME}.align.divsum -a ${ASSEMBLY_NAME}.align_with_div ${ASSEMBLY_NAME}.align

VAR="$(grep -n total ${ASSEMBLY_NAME}.tbl | cut -f1 -d:)"
SIZE="$(sed -n $VAR\p ${ASSEMBLY_NAME}.tbl | sed -e 's/ /\t/g' | cut -f3)"

singularity exec --bind ${BIND_DIR}:${BIND_DIR} "${INSTALLATION_DIR}/tetools_latest.sif" \
createRepeatLandscape.pl -div ${ASSEMBLY_NAME}.align.divsum -g ${SIZE} > ${ASSEMBLY_NAME}.align.divsum.html
