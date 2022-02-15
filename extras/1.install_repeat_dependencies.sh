echo
echo "* building singularity container in '~/Software'..."
echo
mkdir -p ~/Software
cd ~/Software
module load singularity
singularity pull docker://dfam/tetools:latest
