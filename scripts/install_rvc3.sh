# Run this script to install mamba envoriment manager and RVC3 on your system
# It will create a folder rvc3_ws in the current directory and will modify .bashrc 
# to allow the execution of mamba commands
,
!/bin/bash

curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh
bash Miniforge3-$(uname)-$(uname -m).sh

source ~/.bashrc

mamba create -n rvc3 python=3.10
mamba activate rvc3
pip install rvc3python
pip install ipympl 

mkdir rvc3_ws
cd rvc3_ws
git clone https://github.com/petercorke/RVC3-python.git

echo "Run 'rvctool -n -a -c' to start the RVC3 tool" 


