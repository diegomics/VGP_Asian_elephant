echo
echo "* building singularity container in '/VGP_Asian_elephant/extras/'..."
echo
module load singularity
singularity pull docker://dfam/tetools:latest
