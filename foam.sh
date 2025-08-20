#!/bin/bash

## Set programming environment
module purge
module load PrgEnv-cray
module load openmpi



if [ $# -eq 0 ]; then
	echo "Usage: ./foamCompile.sh <integer> <optional_flags>"
	echo "-c|-custom	custom branch flag (OpenFOAM 8 specific)"
        return 1
fi

# Set variable for OpenFoam version
of_ver=$1
custom_ver="$2"

# Parse custom flag version specifically for OpenFOAM 8
if [[ "$custom_ver" == "-c" || "$custom_ver" == "-custom" ]]; then
	custom_flag=1
else
	custom_flag=0
fi

if [[ "$of_ver" -ge 8 && "$of_ver" -le 13 ]]; then

	if [[ "$of_ver" -eq 8 && "custom_flag" -eq 1 ]]; then
		git_of_url="https://github.com/as-hpc/OpenFOAM-$of_ver.git"
		git_tp_url="https://github.com/OpenFOAM/ThirdParty-$of_ver.git"

        	## Clone the repo
        	git clone -b ELAM $git_of_url
        	git clone $git_tp_url

	else
		git_of_url="https://github.com/OpenFOAM/OpenFOAM-$of_ver.git"
		git_tp_url="https://github.com/OpenFOAM/ThirdParty-$of_ver.git"
		
		git clone $git_of_url
		git clone $git_tp_url
	fi

        ## Go to where OpenFOAM should be installed
        cd OpenFOAM-$of_ver

        ## Source the bashrc file
        source etc/bashrc

        ## Compile with 40 processors or more
        ./Allwmake -j40

elif [[ "$of_ver" -gt 1000 && "$of_ver" -lt 3000 ]]; then
        ## Clone the repo
	git clone -b OpenFOAM-v$of_ver https://gitlab.com/openfoam/openfoam.git

        ## Go to where OpenFOAM should be installed
        mv openfoam OpenFOAM-v$of_ver
	cd OpenFOAM-v$of_ver

        ## Source the bashrc file
        source etc/bashrc

        ## Compile with 40 processors or more
        ./Allwmake -j40

else
        echo "Error: Please enter a valid OpenFOAM version to compile."
        return 1
fi
