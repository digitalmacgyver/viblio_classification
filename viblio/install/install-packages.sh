echo "Adding debian package urls to the /etc/apt/sources.list"
echo "deb http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ precise multiverse" >> /etc/apt/sources.list
echo "deb-src http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ precise multiverse" >> /etc/apt/sources.list
echo "deb http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ precise-updates multiverse" >> /etc/apt/sources.list
echo "deb-src http://eu-west-1.ec2.archive.ubuntu.com/ubuntu/ precise-updates multiverse" >> /etc/apt/sources.list

mkdir OpenCV
cd OpenCV
echo "essential updates"

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install build-essential
sudo apt-get install make
sudo apt-get -y install python-setuptools
sudo apt-get -y install subversion
sudo apt-get -y install swig
sudo apt-get -y install python-software-properties
sudo apt-get -y update
sudo apt-get -y install ec2-api-tools
sudo apt-get -y install s3cmd
sudo apt-get -y install cmake
sudo apt-get -y install python-sphinx
#sudo apt-add-repository ppa:awstools-dev/awstools

echo "Removing any pre-installed ffmpeg and x264"
sudo apt-get -y remove ffmpeg x264 libx264-dev
echo "Installing Dependenices"
sudo apt-get -y install libopencv-dev
sudo apt-get -y install build-essential checkinstall cmake pkg-config yasm
sudo apt-get -y install libtiff4-dev libjpeg-dev libjasper-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev
sudo apt-get -y install python-dev python-numpy
sudo apt-get -y install libtbb-dev
sudo apt-get -y install libqt4-dev libgtk2.0-dev

#prerequisite of ffmpeg
echo "Installing ffmpeg dependencies"
sudo apt-get -y install yasm
sudo apt-get -y install libfaac-dev
sudo apt-get -y install libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt-get -y install libtheora-dev
sudo apt-get -y install  libvorbis-dev
sudo apt-get -y install x264 libx264-dev
sudo apt-get -y install libxvidcore-dev

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

echo "Downloading ffmpeg"
wget http://ffmpeg.org/releases/ffmpeg-0.11.1.tar.bz2
echo "Installing ffmpeg"
tar -xvf ffmpeg-0.11.1.tar.bz2
cd ffmpeg-0.11.1/

./configure --enable-gpl --enable-libfaac --enable-libmp3lame --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libxvid --enable-nonfree --enable-postproc --enable-version3 --enable-x11grab --enable-shared

make -j8
sudo make install
cd ..
echo "Downloading v4l"
wget http://www.linuxtv.org/downloads/v4l-utils/v4l-utils-0.8.8.tar.bz2
echo "Installing v4l"
tar -xvf v4l-utils-0.8.8.tar.bz2
cd v4l-utils-0.8.8/
make -j8
sudo make install
cd ..

sudo apt-get -y install python-scipy python-numpy

echo "Downloading OpenCV 2.4.2"
wget -O OpenCV-2.4.2.tar.bz2 http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.2/OpenCV-2.4.2.tar.bz2/download
echo "Installing OpenCV 2.4.2"
tar -xvf OpenCV-2.4.2.tar.bz2
cd OpenCV-2.4.2
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE ..
make -j8
sudo make install
sudo echo “/usr/local/lib” >> /etc/ld.so.conf
sudo ldconfig
echo "OpenCV 2.4.2 ready to be used"
cd ..

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
sudo apt-get install youtube-dl

sudo apt-get install ipython
sudo apt-get install python-gdata
sudo apt-get install python-beautifulsoup
sudo easy_install selenium




