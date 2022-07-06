gnome-terminal --window --title="CONF_STEP1" -- bash -c "sudo wget -P /opt https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh;sudo sh /opt/Anaconda3-2022.05-Linux-x86_64.sh;gnome-terminal --window --title='CONF_STEP2' -- bash -c 'sudo su - <<EOF
echo config-step 2 start
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
yum install nodejs -y
yum install gcc-* -y


conda update conda -y
conda create -n jp --clone base
conda activate jp
pip install jupyterhub jupyterlab
npm install -g configurable-http-proxy
jupyter labextension install @jupyterlab/hub-extension
pip install jupyter-server-proxy
pip install jupyter-vscode-proxy
pip install jupyter-rsession-proxy
pip install jupyter-c-kernel
install_c_kernel


conda create -n C++ -y
conda activate C++
conda install conda -y
pip install ipykernel
conda install xeus-cling -c conda-forge -y
cp -r /opt/anaconda3/envs/C++/share/jupyter/kernels/xcpp11 /opt/anaconda3/envs/jp/share/jupyter/kernels/xcpp11
cp -r /opt/anaconda3/envs/C++/share/jupyter/kernels/xcpp14 /opt/anaconda3/envs/jp/share/jupyter/kernels/xcpp14
cp -r /opt/anaconda3/envs/C++/share/jupyter/kernels/xcpp17 /opt/anaconda3/envs/jp/share/jupyter/kernels/xcpp17

conda create -n fortran -y
conda activate fortran 
conda install conda -y
pip install ipykernel
conda install lfortran -c conda-forge -y
cp -r /opt/anaconda3/envs/fortran/share/jupyter/kernels/fortran /opt/anaconda3/envs/jp/share/jupyter/kernels/fortran


wget -P /opt https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.3-linux-x86_64.tar.gz
tar -zvxf /opt/julia-1.7.3-linux-x86_64.tar.gz
cat <<EOF_in >/etc/profile
export PATH=$PATH:/opt/julia-1.7.3/bin
EOF_in




EOF';" 
