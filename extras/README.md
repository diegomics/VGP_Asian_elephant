# Proceedings related to mEleMax1 genome
:construction: Under construction! :construction:

## Runnning the annotation and masking of repeats that are present in the genome:
1) Set singularity container:
```bash
cd ~/VGP_Asian_elephant/extras
bash 1.install_repeat_dependencies.sh
```
2) Edit `2.repeat_variables.cnf` file with the respective paths, values and parameters.
3) Run the pipeline:
```bash
bash 3.Run_RepeatM.sh
```