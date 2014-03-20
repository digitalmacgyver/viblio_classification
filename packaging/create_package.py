import subprocess
import os
import shutil

directory='classification'
if not os.path.isdir(directory):
    os.makedirs(directory)
else:
    shutil.rmtree(directory)
    os.makedirs(directory)


workdir=os.getcwd()
os.chdir('../viblio/src')
command1='./make.sh'
p = subprocess.Popen(command1, shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
output = p.communicate()[0]
os.chdir(workdir)


filelist=['../viblio/__init__.py','../viblio/bin/expansion_library.so','../viblio/bin/hog2D_library.so','../viblio/common','../viblio/install','../viblio/projects','../viblio/resources/ml','../viblio/resources/features/feature.cfg','../viblio/resources/features/codebooks/centers_4000_hog2x2_patch=18_imageDim=640_whiten=1.mat','../viblio/src/expand_feature.o','../viblio/src/make.sh','../viblio/src/rawHOG2DFeatures.c','../viblio/src/rawHOG2DFeatures.o','../viblio/src/vl_feat/vlfeat-0.9.16/bin']
command='tar -cvzf %s.tar.gz '%(directory)
for file in filelist:
    command=command+file+' '

#print command

   
p = subprocess.Popen(command, shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
output = p.communicate()[0]
command2='tar -zxvf %s.tar.gz'%(directory)
p=subprocess.Popen(command2 , shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
output = p.communicate()[0]

command3='mv viblio/ %s'%(directory)
p=subprocess.Popen(command3,shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
output = p.communicate()[0]
os.remove('%s.tar.gz'%(directory))

command4='tar -cvzf %s.tar.gz %s'%(directory,directory)
p=subprocess.Popen(command4,shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
output = p.communicate()[0]
#print directory


command5='tar -cvzf package.tar.gz %s.tar.gz Makefile'%(directory)
p=subprocess.Popen(command5,shell=True,stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
output = p.communicate()[0]

shutil.rmtree(directory)
os.remove('%s.tar.gz'%(directory))
