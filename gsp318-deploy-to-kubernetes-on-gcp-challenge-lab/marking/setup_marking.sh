#!/bin/bash
mkdir ~/marking
cd ~/marking
gsutil cp gs://cloud-training/gsp318/marking/step*.sh .
chmod +x *.sh
echo "export PATH=$PATH:$HOME/marking" >> ~/.bashrc
export PATH=$PATH:$HOME/marking
