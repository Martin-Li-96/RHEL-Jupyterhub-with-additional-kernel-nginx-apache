#!/bin/bash
set -e

gnome-terminal --window --title="CONF_STEP1" -- bash -c "sudo wget -P /opt/config https://repo.anaconda.com/archive/Anaconda3-2022.05-Linux-x86_64.sh;sudo sh /opt/config/Anaconda3-2022.05-Linux-x86_64.sh;gnome-terminal --window --title='CONF_STEP2' -- bash -c 'sudo su - <<'EOF'
echo config-step 2 start

subscription-manager repos --enable codeready-builder-for-rhel-8-$(arch)-rpms
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
sudo yum install -y  https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm
sudo yum install -y http://rpmfind.net/linux/centos/8-stream/PowerTools/x86_64/os/Packages/SDL2-2.0.10-2.el8.x86_64.rpm
sudo yum install -y ffmpeg*
wget -P /opt/config https://github.com/Martin-Li-96/RHEL-Jupyterhub-with-additional-kernel-nginx-apache/releases/download/beta2/profile.py
python /opt/config/profile.py
source /etc/profile
yum update -y
yum install gnome-* -y
yum install R -y
curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
yum install nodejs -y
yum install gcc-* -y
wget -P /opt/config https://download2.rstudio.org/server/rhel8/x86_64/rstudio-server-rhel-2022.02.3-492-x86_64.rpm
yum install /opt/config/rstudio-server-rhel-2022.02.3-492-x86_64.rpm -y
rstudio-server start
curl -fsSL https://code-server.dev/install.sh | sh
conda update conda -y
conda create -n jp --clone base
conda activate jp
pip install jupyterhub jupyterlab
npm install -g configurable-http-proxy
pip install ipywidgets
yum install octave -y
jupyter labextension install @jupyterlab/hub-extension
pip install jupyter-server-proxy
pip install jupyter-vscode-proxy
pip install jupyter-rsession-proxy
pip install jupyter-c-kernel
install_c_kernel
cp -r /root/.local/share/jupyter/kernels/c /opt/anaconda3/envs/jp/share/jupyter/kernels/c
conda install octave_kernel -c conda-forge -y
conda install texinfo -y
python -m octave_kernel install
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
wget -P /opt/config https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.3-linux-x86_64.tar.gz
tar -zvxf /opt/config/julia-1.7.3-linux-x86_64.tar.gz -C /opt

source /etc/profile
mkdir /opt/config/julia
cat <<'EOF_in' >/opt/config/julia/Jconf.jl
using Pkg
Pkg.add('IJulia')
EOF_in
julia /opt/config/julia/Jconf.jl
wget -P /opt https://download.oracle.com/java/18/latest/jdk-18_linux-x64_bin.rpm
process=`rpm -qa | grep java`
for i in $process
do
  rpm -e --nodeps $i
done
rpm -ivh /opt/jdk-18_linux-x64_bin.rpm

conda create -n java -y
conda activate java
conda install conda -y 
pip install ipykernel
wget -P /opt https://github.com/SpencerPark/IJava/releases/download/v1.3.0/ijava-1.3.0.zip
unzip /opt/ijava-1.3.0.zip -d /opt
python3 /opt/install.py --sys-prefix
cp -r /opt/anaconda3/envs/java/share/jupyter/kernels/java /opt/anaconda3/envs/jp/share/jupyter/kernels/java
npm install -g ijavascript
ijsinstall
cp -r /root/.local/share/jupyter/kernels/javascript /opt/anaconda3/envs/jp/share/jupyter/kernels/javascript
conda create -n ssh -y
conda activate ssh
conda install conda -y
pip install ipykernel
pip install -U sshkernel
python -m sshkernel install --sys-prefix
cp -r /opt/anaconda3/envs/ssh/share/jupyter/kernels/ssh /opt/anaconda3/envs/jp/share/jupyter/kernels/ssh
cat <<'EOF_in' > /opt/Rconfig.r
install.packages('IRkernel',repos='https://cran.r-project.org')
IRkernel::installspec()
IRkernel::installspec(user = FALSE)
EOF_in
Rscript /opt/Rconfig.r
cp -r /root/.local/share/jupyter/kernels/ir /opt/anaconda3/envs/jp/share/jupyter/kernels/ir
#conda create -n ruby -y
#conda activate ruby
#conda install conda -y
#pip install ipykernel
#\curl -sSL https://get.rvm.io | bash
#source /etc/profile.d/rvm.sh
#rvm install ruby-3.2
#gem install ffi
#yum install ruby-devel -y
#yum install zeromq -y
#dnf -y install rubygem-ffi
#yum install zeromq-devel -y
#yum install czmq-dev* -y
#cd ~
#gem install iruby
#iruby register --force
#gem install --user-install executable-hooks
#rvm all-gemsets do gem update bundler
#source /etc/profile
conda create -n bash -y
conda activate bash
conda install conda -y
pip install ipykernel
pip install bash_kernel
python -m bash_kernel.install
conda create -n tensorflow python=3.9 -y
conda activate tensorflow
conda install conda -y
pip install ipykernel
conda install tensorflow -y
conda install tensorflow-gpu -y
conda install pandas -y
conda install keras -y
conda install numba -y
conda install matplotlib -y
pip install sklearn
python3 -m ipykernel install --name tensorflow
conda create -n pytorch -y
conda activate pytorch 
conda install conda -y
pip install ipykernel
conda install pytorch torchvision torchaudio cudatoolkit=11.6 -c pytorch -c conda-forge -y
python3 -m ipykernel install --name pytorch
conda install pandas -y
conda install keras -y
conda install numba -y
conda install matplotlib -y
pip install sklearn
yum install nginx -y
cp -r /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
wget -P /opt/Jetbrain https://download.jetbrains.com/cpp/CLion-2021.1.3.tar.gz
wget -P /opt/Jetbrain https://download.jetbrains.com/datagrip/datagrip-2021.1.3.tar.gz
wget -P /opt/Jetbrain https://download.jetbrains.com/go/goland-2021.1.3.tar.gz
wget -P /opt/Jetbrain https://download.jetbrains.com/idea/ideaIU-2021.1.3.tar.gz
wget -P /opt/Jetbrain https://download.jetbrains.com/webide/PhpStorm-2021.1.3.tar.gz
wget -P /opt/Jetbrain https://download.jetbrains.com/python/pycharm-professional-2021.1.3.tar.gz
wget -P /opt/Jetbrain https://download.jetbrains.com/ruby/RubyMine-2021.1.3.tar.gz
wget -P /opt/Jetbrain https://download.jetbrains.com/webstorm/WebStorm-2021.1.3.tar.gz
wget -P /opt/Jetbrain https://github.com/Martin-Li-96/RHEL-Jupyterhub-with-additional-kernel-nginx-apache/releases/download/beta/ide-eval-resetter-2.1.9.zip
cd /opt/jetbrain
tar -zvxf /opt/Jetbrain/CLion-2021.1.3.tar.gz
tar -zvxf /opt/Jetbrain/datagrip-2021.1.3.tar.gz
tar -zvxf /opt/Jetbrain/goland-2021.1.3.tar.gz
tar -zvxf /opt/Jetbrain/ideaIU-2021.1.3.tar.gz
tar -zvxf /opt/Jetbrain/PhpStorm-2021.1.3.tar.gz
tar -zvxf /opt/Jetbrain/pycharm-professional-2021.1.3.tar.gz
tar -zvxf /opt/Jetbrain/RubyMine-2021.1.3.tar.gz
tar -zvxf /opt/Jetbrain/WebStorm-2021.1.3.tar.gz
rm -rf *.tar.gz

rm -rf /opt/config


yum install -y libnsl*
wget -P /opt https://downloadsapachefriends.global.ssl.fastly.net/8.1.6/xampp-linux-x64-8.1.6-0-installer.run
chmod 777 /opt/xampp-linux-x64-8.1.6-0-installer.run
/opt/xampp-linux-x64-8.1.6-0-installer.run --mode text
EOF';gnome-terminal --window --title='CONF_STEP2' -- bash -c 'cat <<'EOF_in' >~/Jconf.jl
using Pkg
Pkg.add('IJulia')
EOF_in;source /etc/profile;julia ~/Jconf.jl;'" 
