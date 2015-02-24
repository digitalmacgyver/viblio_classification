#!/bin/bash

#other tools
echo "Installing algorithm dependencies"

sudo apt-get -y install  python-configobj
sudo apt-get -y install libzbar0
sudo apt-get -y install libzbar-dev
sudo apt-get -y install python-zbar
sudo apt-get -y zbar-tools
sudo apt-get -y install python-nose
sudo apt-get -y install python-matplotlib
#xlrd
sudo apt-get -y install python-pip python-dev build-essential 
sudo pip install --upgrade pip
sudo pip install xlrd==0.9.0

sudo pip install -U scikit-learn
sudo easy_install xlrd

#install lame
echo "Installing lame"

wget http://downloads.sourceforge.net/project/lame/lame/3.98.4/lame-3.98.4.tar.gz
tar -zxvf lame-3.98.4.tar.gz 
cd lame-3.98.4
./configure
make
sudo make install
cd ..



sudo apt-get -y install python-scipy python-numpy


echo "installing jpegtran"
wget http://www.ijg.org/files/jpegsrc.v9.tar.gz
tar -xzvf jpegsrc.v9.tar.gz
cd jpeg-9
./configure
sudo make
sudo make install 
#echo "export LD_LIBRARY_PATH=/usr/local/lib" >> /root/.bashrc
cd ..


echo "Installing ANN lib"
wget http://www.cs.umd.edu/~mount/ANN/Files/1.1.2/ann_1.1.2.tar.gz
tar xvzf ann_1.1.2.tar.gz
cd ann_1.1.2
make linux-g++
sudo cp -r include/ANN /usr/local/include/ANN
sudo cp -r lib/* /usr/local/lib
ANN_DIR=$PWD
#echo "export ANN_DIR=$ANN_DIR" >> /root/.bashrc
cd ..

## Ramsri need to install tests for the packages below
echo "Installing boto"
sudo pip install -U boto

echo "Installing sqlalchemy"
sudo apt-get -y install python-sqlalchemy

echo "Installing You Tube downloader"
sudo apt-get -y install youtube-dl

sudo apt-get -y install ipython
sudo apt-get -y install python-gdata
sudo apt-get -y install python-beautifulsoup
sudo easy_install selenium

#Installation for PyTables(Hdf5 storage for features)

#Sub dependencies - 1) numexpr
wget http://numexpr.googlecode.com/files/numexpr-2.2.2.tar.gz
tar -xzvf numexpr-2.2.2.tar.gz
cd numexpr-2.2.2/
python setup.py build
sudo python setup.py install
cd ..

#sub dependencies - 2) HDF5
sudo apt-get -y install libhdf5-serial-dev

#sub dependencies - 3) Cython
wget http://www.cython.org/release/Cython-0.20.tar.gz
tar -xzvf Cython-0.20.tar.gz
cd Cython-0.20/
sudo python setup.py install
cd ..

#PyTables
sudo easy_install tables

#h5py to read the stored hdf file
sudo easy_install h5py




