# Asian elephant VGP genome (mEleMax1)

🐘 🧬 🐘 🧬 🐘 🧬 🐘 🧬 🐘 🧬 🐘 🧬 🐘 🧬 🐘 🧬 🐘 🧬 🐘 🧬 🐘 🧬

#### Pipeline for running the VGP assembly pipeline 2.0+
:construction: Under construction! :construction:

## Requirements:
* [Slurm](https://slurm.schedmd.com)
* [Singularity](https://sylabs.io)
* [Conda](https://docs.conda.io)

## Installation:
```bash
git clone https://github.com/diegomics/VGP_Asian_elephant
cd VGP_Asian_elephant
```

### _Hifiasm_

### _purge_dups workflow_

### _bionano worflow_ :construction:

### _[Arima_mapping](https://github.com/ArimaGenomics/mapping_pipeline) workflow_
The Arima workflow uses up to 24 CPUs and 192 GB in certain steps

. `bash install_arima_dependencies.sh`

. Edit the file `arima.cnf` with required data

. Run the workflow with `bash run_arima_pipeline.sh`

\*) For the Asian elephant genome, it takes <30 h to produce the final sorted BAM (needed for pretextMap) and ~44 h to produce the final sorted BED (needed for salsa2 or yahs). Comment the code for steps 13 and 14 in `run_arima_pipeline.sh` if BED files are not needed.

### _Salsa2 workflow_
