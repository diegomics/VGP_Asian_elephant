source 2.repeat_variables.cnf
sbatch --mail-user=${USER_MAIL} --partition=${PARTITION} --qos=${QUEUE} --output=${OUT_DIR}/%x.%j.out --error=${OUT_DIR}/%x.%j.err slurm/RepeatM.job
