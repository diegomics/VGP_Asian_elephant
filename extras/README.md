## Annotation and masking of repeats in the genome
🐘🧬😷🐘🧬😷🐘🧬😷🐘🧬😷🐘🧬😷🐘🧬😷🐘🧬😷🐘🧬😷

## Requirements:
* [Conda](https://docs.conda.io)

## Run the pipeline:

1) Edit `1.repeat_variables.cnf` file with the respective paths, values and parameters.

2) Install needed software with: `bash 2.install_repeat_dependencies.sh`

3) Choose one running mode:

. Mode A: using _Slurm_ with: `bash 3a.Run_RepeatM_slurm.sh`

. Mode B: on a single machine (no _Slurm_) with: `nohup bash 3b.Run_RepeatM.sh 2>&1 &`

\*) Both modes use up to 12 cpus and 48 Gb of RAM

\**) For the Asian elephant genome, it takes ~40 h to finish RepeatModeler. The complete pipeline takes ~50 h.

## Output:
```
<output_folder>
├── 01_modeler
│   └── ..
├── 02_libraries
│   └── ..
└── 03_masker
    ├── ..
    ├── <..>.html    
    ├── <..>.out
    ├── <..>.tbl
    ├── <..>.bed
    └── <..>.masked.fa
```
