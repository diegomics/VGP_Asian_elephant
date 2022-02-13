# Proceedings related to mEleMax1 genome
:construction: Under construction! :construction:

## Runnning the annotation and masking of repeats that are present in the genome:
1) Set singularity container:
```bash
cd ~/VGP_Asian_elephant/extras
bash install_repeat_dependencies.sh
```
2) Edit `repeat_variables.cnf` file with the respective paths, values and parameters.
3) Run the pipeline:
```bash
bash Run_RepeatM.sh
```
