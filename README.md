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

### _bionano worflow_

### _[Arima_pipeline](https://github.com/ArimaGenomics/mapping_pipeline) workflow_
The arima_pipeline workflow uses up to 24 CPUs and 192 GB in certain steps

. `bash install_arima_dependencies.sh`

. Edit the file `arima.cnf` with required data

. Run the workflow with `bash run_arima_pipeline.sh`

### _Salsa2 workflow_
