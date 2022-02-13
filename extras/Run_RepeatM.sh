source repeat_variables.cnf
sbatch --output=${OUT_DIR}/%x.%j.out --error=${OUT_DIR}/%x.%j.err ReSeq.index.job
