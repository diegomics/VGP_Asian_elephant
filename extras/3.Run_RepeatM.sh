source 2.repeat_variables.cnf
sbatch --output=${OUT_DIR}/%x.%j.out --error=${OUT_DIR}/%x.%j.err slurm/RepeatM.job
