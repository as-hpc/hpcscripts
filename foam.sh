#!/bin/bash

module purge
## Set programming environment

module load PrgEnv-cray
module load openmpi

## Clone the OpenFOAM 8 repo
git clone https://github.com/OpenFOAM/OpenFOAM-8.git
git clone https://github.com/OpenFOAM/ThirdParty-8.git

## Go to where OpenFOAM should be installed
cd OpenFOAM-8

## Source the bashrc file
source etc/bashrc

## Compile with 16 processors or more
./Allwmake -j40
