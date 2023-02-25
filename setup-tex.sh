#!/bin/sh

sudo apt update
sudo apt upgrade -y

sudo apt-get install 
# curl -sSL https://install.python-poetry.org | python3 - --version 1.1.15
# export PATH="/home/harukitosa/.local/bin:$PATH"

# pyenvの準備
sudo apt install -y \
python3-distutils \
build-essential \
libffi-dev \
libssl-dev \
zlib1g-dev \
liblzma-dev \
libbz2-dev \
libreadline-dev \
libsqlite3-dev \
libopencv-dev \
tk-dev \
git

sudo apt-get install libncurses-dev

git clone https://github.com/pyenv/pyenv.git ~/.pyenv

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
source ~/.bashrc


pyenv install 3.10.0
pyenv global 3.10.0
pyenv --version

# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-keyring_1.0-1_all.deb
# sudo dpkg -i cuda-keyring_1.0-1_all.deb
# sudo apt-get update
# sudo apt-get -y install cuda
sudo apt-get install -y wget
wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda_11.8.0_520.61.05_linux.run
sudo sh cuda_11.8.0_520.61.05_linux.run

echo 'export PATH="/usr/local/cuda/bin:$PATH"'  >> ~/.bashrc
echo 'export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"' >> ~/.bashrc
source ~/.bashrc

nvcc -V


sudo dpkg -i libcudnn8_8.8.0.121-1+cuda11.8_amd64.deb
sudo dpkg -i  libcudnn8-dev_8.8.0.121-1+cuda11.8_amd64.deb
sudo dpkg -i libcudnn8-samples_8.8.0.121-1+cuda11.8_amd64.deb


pip install --upgrade pip
pip install --upgrade "jax[cuda]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html

# sudo apt install ./cudnn-local-repo-ubuntu1804-8.8.0.121_1.0-1_amd64.deb

# gcloud compute scp --zone "asia-east1-a" --project "quanterm" /Users/harukitosa/cudnn-local-repo-ubuntu1804-8.8.0.121_1.0-1_amd64.deb quantum-1:.

# gcloud compute scp --zone "us-central1-f" --project "quanterm" /Users/harukitosa/cudnn-local-repo-ubuntu1804-8.8.0.121_1.0-1_amd64.deb instance-1:.
# CUDAのバージョンのリンクを貼る
# sudo ln -s /path/to/cuda /usr/local/cuda-X.X

# export PATH="/usr/local/cuda/bin:$PATH"
# export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

# nvidiaのuninstall ubuntu
# sudo apt-get purge nvidia*
# sudo apt-get autoremove



# pip install -r requirements.txt