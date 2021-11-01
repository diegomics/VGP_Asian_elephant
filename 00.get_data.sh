# create folder structure and get PacBio HiFi data	
mkdir -p Elephant_project/mEleMax1/genomic_data/pacbio
cd Elephant_project/mEleMax1/genomic_data/pacbio
aws s3 cp s3://genomeark/species/Elephas_maximus/mEleMax1/genomic_data/pacbio/ . --recursive --no-sign-request
cd -

# create folder structure and get Bionano data
mkdir -p Elephant_project/mEleMax1/genomic_data/bionano
cd Elephant_project/mEleMax1/genomic_data/bionano
aws s3 cp s3://genomeark/species/Elephas_maximus/mEleMax1/genomic_data/bionano/ . --recursive --no-sign-request
cd -

# create folder structure and get HiC data

# create folder structure
mkdir -p Elephant_project/mEleMax1/evaluation
mkdir -p Elephant_project/mEleMax1/intermediates
