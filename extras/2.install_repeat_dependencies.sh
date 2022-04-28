source 1.repeat_variables.cnf
echo ""
echo "* creating conda environment..."
echo ""
export PATH="${CONDA_BIN_DIR}:${PATH}"
conda env create -f repeat_env.yml
source activate REPEAT_env
echo ""
echo "* building singularity container in ${PWD}..."
echo ""
singularity pull docker://dfam/tetools:latest
