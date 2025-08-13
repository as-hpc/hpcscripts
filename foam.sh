#!/bin/bash

module purge
## Set programming environment

module load intel-oneapi-2025/2025.2.0.592
export CC=icx
export CXX=icpx
export FC=ifx
export F77=ifx
export F90=ifx
export I_MPI_CC=icx
export I_MPI_CXX=icpx
export I_MPI_FC=ifx
export MPICC=mpiicx
export MPICXX=mpiicpx
export MPIFC=mpiifx
## Clone the OpenFOAM 8 repo
git clone https://github.com/OpenFOAM/OpenFOAM-8.git
git clone https://github.com/OpenFOAM/ThirdParty-8.git

## Go to where OpenFOAM should be installed
cd OpenFOAM-8

## Source the bashrc file
source etc/bashrc

## Compile with 16 processors or more
./Allwmake -j40
