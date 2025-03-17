#!/bin/bash
#PBS -l walltime=12:00:00         
#PBS -l select=1:ncpus=1:mem=1gb  
#PBS -J 1-3  

module load anaconda3/personal   

echo "R is about to run"


cp $HOME/Yaxin_Liu_HPC_2024_neutral_cluster.R $TMPDIR
cp $HOME/Yaxin_Liu_HPC_2024_main.R $TMPDIR

cd $TMPDIR


Rscript Yaxin_Liu_HPC_2024_neutral_cluster.R


echo "Checking TMPDIR contents..."
ls -lh $TMPDIR  


mv $TMPDIR/q23_simulation_result_* $HOME/output_files/

echo "R has finished running"

