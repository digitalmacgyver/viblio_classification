-include .build_release/DenseTrack.d
-include .build_release/opencv/IplImageWrapper.d
-include .build_release/opencv/IplImagePyramid.d

.build_release/DenseTrack.l: \
	.build_release/DenseTrack.d \
	.build_release/opencv/IplImageWrapper.d \
	.build_release/opencv/IplImagePyramid.d \

release/DenseTrack: .build_release/DenseTrack.l \
	.build_release/DenseTrack.o \
	.build_release/opencv/IplImageWrapper.o \
	.build_release/opencv/IplImagePyramid.o \

