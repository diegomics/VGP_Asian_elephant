## Annotation and masking of repeats in the genome:
1) Set singularity container:
```bash
cd ~/VGP_Asian_elephant/extras
bash 1.install_repeat_dependencies.sh
```
2) Edit `2.repeat_variables.cnf` file with the respective paths, values and parameters.
3) Run the pipeline.
Option A: using slurm with: `bash 3.Run_RepeatM_slurm.sh`
Option B: in a single machine (no slurm): `bash 3.Run_RepeatM.sh`
