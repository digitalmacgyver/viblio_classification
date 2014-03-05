gcc -fPIC -std=c99 -c ../src/rawHOG2DFeatures.c
gcc -shared -o ../bin/hog2D_library.so rawHOG2DFeatures.o

cd ./vl_feat/vlfeat-0.9.16
make clean
make
cd ../..
pwd
gcc -fPIC -std=c99 -c ./vl_feat/expand_feature.c -I./vl_feat/vlfeat-0.9.16/ -L./vl_feat/vlfeat-0.9.16/bin/glnxa64 -lvl -lm
gcc -shared -o ../bin/expansion_library.so expand_feature.o -I./vl_feat/vlfeat-0.9.16/ -L./vl_feat/vlfeat-0.9.16/bin/glnxa64 -lvl


