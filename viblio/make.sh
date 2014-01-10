gcc -fPIC -std=c99 -c src/rawHOG2DFeatures.c
gcc -shared -o bin/hog2D_library.so rawHOG2DFeatures.o
