#!/bin/bash
#SBATCH --job-name=spark_job
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=4
#SBATCH --mem=8G
#SBATCH --time=1:00:00
#SBATCH --account=open
#SBATCH --mail-user=eks5748@psu.edu
#SBATCH --mail-type=BEGIN

# Load necessary modules (if required)
module load anaconda3
conda create -y -n eks5748_final python=3.8
source activate eks5748_final
module use /gpfs/group/RISE/sw7/modules
module load spark/3.3.0
pip install sparktorch
export PYSPARK_PYTHON=python3
export PYSPARK_DRIVER_PYTHON=python3

git clone https://github.com/SettiE03/optionalTest.git


git clone https://github.com/dmmiller612/sparktorch.git
cd sparktorch

# Run PySpark
# Record the start time
start_time=$(date +%s)
spark-submit --deploy-mode client examples/simple_cnn.py

#python simple_cnn.py

# Record the end time
end_time=$(date +%s)

# Calculate and print the execution time
execution_time=$((end_time - start_time))
echo "Execution time: $execution_time seconds"