gcc -fPIC -std=c99 -c rawHOG2DFeatures.c
gcc -shared -o hog2D_library.so rawHOG2DFeatures.o