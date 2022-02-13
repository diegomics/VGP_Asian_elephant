bash test
sbatch --output=$OUT_DIR/0_idx/%x.%j.out --error=$OUT_DIR/0_idx/%x.%j.err ReSeq.index.job
