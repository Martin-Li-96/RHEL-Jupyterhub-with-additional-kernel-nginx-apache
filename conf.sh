gnome-terminal --window --title="CONF_STEP1" -- bash -c "sudo wget -P /opt https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh;sudo sh /opt/Anaconda3-2022.05-Linux-x86_64.sh;gnome-terminal --window --title='CONF_STEP2' -- bash -c 'sudo su - <<EOF
echo config-step 2 start
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
yum install nodejs -y
yum install gcc-* -y



conda create -n jp --clone base
conda activate jp
pip install jupyterhub jupyterlab
npm install -g configurable-http-proxy
jupyter labextension install @jupyterlab/hub-extension
pip install jupyter-server-proxy
pip install jupyter-vscode-proxy
pip install jupyter-rsession-proxy


conda create -n C -y
conda activate C
conda install conda -y
pip install ipykernel 



EOF';" 
