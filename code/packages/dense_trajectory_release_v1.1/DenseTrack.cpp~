#include "DenseTrack.h"
#include "Descriptors.h"
#include "Initialize.h"

IplImageWrapper image, prev_image, grey, prev_grey;
IplImagePyramid grey_pyramid, prev_grey_pyramid, eig_pyramid;

CvCapture* capture = 0;
float* fscales = 0; // float scale values
int show_track = 0; // set show_track = 1, if you want to visualize the trajectories

int main( int argc, char** argv )
{
	int frameNum = 0;
	TrackerInfo tracker;
	DescInfo hogInfo;
	DescInfo hofInfo;
	DescInfo mbhInfo;

	char* video = argv[1];
	arg_parse(argc, argv);

//	std::cerr << "start_frame: " << start_frame << " end_frame: " << end_frame << " track_length: " << track_length << std::endl;
//	std::cerr << "min_distance: " << min_distance << " patch_size: " << patch_size << " nxy_cell: " << nxy_cell << " nt_cell: " << nt_cell << std::endl;

	InitTrackerInfo(&tracker, track_length, init_gap);
	InitDescInfo(&hogInfo, 8, 0, 1, patch_size, nxy_cell, nt_cell);
	InitDescInfo(&hofInfo, 9, 1, 1, patch_size, nxy_cell, nt_cell);
	InitDescInfo(&mbhInfo, 8, 0, 1, patch_size, nxy_cell, nt_cell);

	capture = cvCreateFileCapture(video);

	if( !capture ) { 
		printf( "Could not initialize capturing..\n" );
		return -1;
	}

	if( show_track == 1 )
		cvNamedWindow( "DenseTrack", 0 );

	std::vector<std::list<Track> > xyScaleTracks;
	int init_counter = 0; // indicate when to detect new feature points
	while( true ) {
		IplImage* frame = 0;
		int i, j, c;

		// get a new frame
		frame = cvQueryFrame( capture );
		if( !frame ) {
			//printf("break");
			break;
		}
		if( frameNum >= start_frame && frameNum <= end_frame ) {
		if( !image ) {
			// initailize all the buffers
			image = IplImageWrapper( cvGetSize(frame), 8, 3 );
			image->origin = frame->origin;
			prev_image= IplImageWrapper( cvGetSize(frame), 8, 3 );
			prev_image->origin = frame->origin;
			grey = IplImageWrapper( cvGetSize(frame), 8, 1 );
			grey_pyramid = IplImagePyramid( cvGetSize(frame), 8, 1, scale_stride );
			prev_grey = IplImageWrapper( cvGetSize(frame), 8, 1 );
			prev_grey_pyramid = IplImagePyramid( cvGetSize(frame), 8, 1, scale_stride );
			eig_pyramid = IplImagePyramid( cvGetSize(frame), 32, 1, scale_stride );

			cvCopy( frame, image, 0 );
			cvCvtColor( image, grey, CV_BGR2GRAY );
			grey_pyramid.rebuild( grey );

			// how many scale we can have
			scale_num = std::min<std::size_t>(scale_num, grey_pyramid.numOfLevels());
			fscales = (float*)cvAlloc(scale_num*sizeof(float));
			xyScaleTracks.resize(scale_num);

			for( int ixyScale = 0; ixyScale < scale_num; ++ixyScale ) {
				std::list<Track>& tracks = xyScaleTracks[ixyScale];
				fscales[ixyScale] = pow(scale_stride, ixyScale);

				// find good features at each scale separately
				IplImage *grey_temp = 0, *eig_temp = 0;
				std::size_t temp_level = (std::size_t)ixyScale;
				grey_temp = cvCloneImage(grey_pyramid.getImage(temp_level));
				eig_temp = cvCloneImage(eig_pyramid.getImage(temp_level));
				std::vector<CvPoint2D32f> points(0);
				cvDenseSample(grey_temp, eig_temp, points, quality, min_distance);

				// save the feature points
				for( i = 0; i < points.size(); i++ ) {
					Track track(tracker.trackLength);
					PointDesc point(hogInfo, hofInfo, mbhInfo, points[i]);
					track.addPointDesc(point);
					tracks.push_back(track);
				}

				cvReleaseImage( &grey_temp );
				cvReleaseImage( &eig_temp );
			}
		}

		// build the image pyramid for the current frame
		cvCopy( frame, image, 0 );
		cvCvtColor( image, grey, CV_BGR2GRAY );
		grey_pyramid.rebuild(grey);

		if( frameNum > 0 ) {
		init_counter++;
		for( int ixyScale = 0; ixyScale < scale_num; ++ixyScale ) {
			// track feature points in each scale separately
			std::vector<CvPoint2D32f> points_in(0);
			std::list<Track>& tracks = xyScaleTracks[ixyScale];
			for (std::list<Track>::iterator iTrack = tracks.begin(); iTrack != tracks.end(); ++iTrack) {
				CvPoint2D32f point = iTrack->pointDescs.back().point;
				points_in.push_back(point); // collect all the feature points
			}
			int count = points_in.size();
			IplImage *prev_grey_temp = 0, *grey_temp = 0;
			std::size_t temp_level = ixyScale;
			prev_grey_temp = cvCloneImage(prev_grey_pyramid.getImage(temp_level));
			grey_temp = cvCloneImage(grey_pyramid.getImage(temp_level));

			cv::Mat prev_grey_mat = cv::cvarrToMat(prev_grey_temp);
			cv::Mat grey_mat = cv::cvarrToMat(grey_temp);

			std::vector<int> status(count);
			std::vector<CvPoint2D32f> points_out(count);

			// compute the optical flow
			IplImage* flow = cvCreateImage(cvGetSize(grey_temp), IPL_DEPTH_32F, 2);
			cv::Mat flow_mat = cv::cvarrToMat(flow);
			cv::calcOpticalFlowFarneback( prev_grey_mat, grey_mat, flow_mat,
							sqrt(2)/2.0, 5, 10, 2, 7, 1.5, cv::OPTFLOW_FARNEBACK_GAUSSIAN );
			// track feature points by median filtering
			OpticalFlowTracker(flow, points_in, points_out, status);

			int width = grey_temp->width;
			int height = grey_temp->height;
			// compute the integral histograms
			DescMat* hogMat = InitDescMat(height, width, hogInfo.nBins);
			HogComp(prev_grey_temp, hogMat, hogInfo);

			DescMat* hofMat = InitDescMat(height, width, hofInfo.nBins);
			HofComp(flow, hofMat, hofInfo);

			DescMat* mbhMatX = InitDescMat(height, width, mbhInfo.nBins);
			DescMat* mbhMatY = InitDescMat(height, width, mbhInfo.nBins);
			MbhComp(flow, mbhMatX, mbhMatY, mbhInfo);

			i = 0;
			for (std::list<Track>::iterator iTrack = tracks.begin(); iTrack != tracks.end(); ++i) {
			if( status[i] == 1 ) { // if the feature point is successfully tracked
				PointDesc& pointDesc = iTrack->pointDescs.back();
				CvPoint2D32f prev_point = points_in[i];
				// get the descriptors for the feature point
				CvScalar rect = getRect(prev_point, cvSize(width, height), hogInfo);
				pointDesc.hog = getDesc(hogMat, rect, hogInfo);
				pointDesc.hof = getDesc(hofMat, rect, hofInfo);
				pointDesc.mbhX = getDesc(mbhMatX, rect, mbhInfo);
				pointDesc.mbhY = getDesc(mbhMatY, rect, mbhInfo);

				PointDesc point(hogInfo, hofInfo, mbhInfo, points_out[i]);
				iTrack->addPointDesc(point);

				// draw this track
				if( show_track == 1 ) {
					std::list<PointDesc>& descs = iTrack->pointDescs;
					std::list<PointDesc>::iterator iDesc = descs.begin();
					float length = descs.size();
					CvPoint2D32f point0 = iDesc->point;
					point0.x *= fscales[ixyScale]; // map the point to first scale
					point0.y *= fscales[ixyScale];

					float j = 0;
					for (iDesc++; iDesc != descs.end(); ++iDesc, ++j) {
						CvPoint2D32f point1 = iDesc->point;
						point1.x *= fscales[ixyScale];
						point1.y *= fscales[ixyScale];

						cvLine(image, cvPointFrom32f(point0), cvPointFrom32f(point1),
							   CV_RGB(0,cvFloor(255.0*(j+1.0)/length),0), 2, 8,0);
						point0 = point1;
					}
					cvCircle(image, cvPointFrom32f(point0), 2, CV_RGB(255,0,0), -1, 8,0);
				}
				++iTrack;
			}
			else // remove the track, if we lose feature point
				iTrack = tracks.erase(iTrack);
			}
			ReleDescMat(hogMat);
			ReleDescMat(hofMat);
			ReleDescMat(mbhMatX);
			ReleDescMat(mbhMatY);
			cvReleaseImage( &prev_grey_temp );
			cvReleaseImage( &grey_temp );
			cvReleaseImage( &flow );
		}

		for( int ixyScale = 0; ixyScale < scale_num; ++ixyScale ) {
		std::list<Track>& tracks = xyScaleTracks[ixyScale]; // output the features for each scale
		for( std::list<Track>::iterator iTrack = tracks.begin(); iTrack != tracks.end(); ) {
			if( iTrack->pointDescs.size() >= tracker.trackLength+1 ) { // if the trajectory achieves the length we want
				std::vector<CvPoint2D32f> trajectory(tracker.trackLength+1);
				std::list<PointDesc>& descs = iTrack->pointDescs;
				std::list<PointDesc>::iterator iDesc = descs.begin();

				for (int count = 0; count <= tracker.trackLength; ++iDesc, ++count) {
					trajectory[count].x = iDesc->point.x*fscales[ixyScale];
					trajectory[count].y = iDesc->point.y*fscales[ixyScale];
				}
				float mean_x(0), mean_y(0), var_x(0), var_y(0), length(0);
				if( isValid(trajectory, mean_x, mean_y, var_x, var_y, length) == 1 ) {
					printf("%d\t", frameNum);
					printf("%f\t%f\t", mean_x, mean_y);
					printf("%f\t%f\t", var_x, var_y);
					printf("%f\t", length);
					printf("%f\t", fscales[ixyScale]);

					for (int count = 0; count < tracker.trackLength; ++count)
						printf("%f\t%f\t", trajectory[count].x,trajectory[count].y );

					iDesc = descs.begin();
					int t_stride = cvFloor(tracker.trackLength/hogInfo.ntCells);
					for( int n = 0; n < hogInfo.ntCells; n++ ) {
						std::vector<float> vec(hogInfo.dim);
						for( int t = 0; t < t_stride; t++, iDesc++ )
							for( int m = 0; m < hogInfo.dim; m++ )
								vec[m] += iDesc->hog[m];
						for( int m = 0; m < hogInfo.dim; m++ )
							printf("%f\t", vec[m]/float(t_stride));
					}

					iDesc = descs.begin();
					t_stride = cvFloor(tracker.trackLength/hofInfo.ntCells);
					for( int n = 0; n < hofInfo.ntCells; n++ ) {
						std::vector<float> vec(hofInfo.dim);
						for( int t = 0; t < t_stride; t++, iDesc++ )
							for( int m = 0; m < hofInfo.dim; m++ )
								vec[m] += iDesc->hof[m];
						for( int m = 0; m < hofInfo.dim; m++ )
							printf("%f\t", vec[m]/float(t_stride));
					}

					iDesc = descs.begin();
					t_stride = cvFloor(tracker.trackLength/mbhInfo.ntCells);
					for( int n = 0; n < mbhInfo.ntCells; n++ ) {
						std::vector<float> vec(mbhInfo.dim);
						for( int t = 0; t < t_stride; t++, iDesc++ )
							for( int m = 0; m < mbhInfo.dim; m++ )
								vec[m] += iDesc->mbhX[m];
						for( int m = 0; m < mbhInfo.dim; m++ )
							printf("%f\t", vec[m]/float(t_stride));
					}

					iDesc = descs.begin();
					t_stride = cvFloor(tracker.trackLength/mbhInfo.ntCells);
					for( int n = 0; n < mbhInfo.ntCells; n++ ) {
						std::vector<float> vec(mbhInfo.dim);
						for( int t = 0; t < t_stride; t++, iDesc++ )
							for( int m = 0; m < mbhInfo.dim; m++ )
								vec[m] += iDesc->mbhY[m];
						for( int m = 0; m < mbhInfo.dim; m++ )
							printf("%f\t", vec[m]/float(t_stride));
					}

					printf("\n");
				}
				iTrack = tracks.erase(iTrack);
			}
			else
				iTrack++;
		}
		}

		if( init_counter == tracker.initGap ) { // detect new feature points every initGap frames
		init_counter = 0;
		for (int ixyScale = 0; ixyScale < scale_num; ++ixyScale) {
			std::list<Track>& tracks = xyScaleTracks[ixyScale];
			std::vector<CvPoint2D32f> points_in(0);
			std::vector<CvPoint2D32f> points_out(0);
			for(std::list<Track>::iterator iTrack = tracks.begin(); iTrack != tracks.end(); iTrack++, i++) {
				std::list<PointDesc>& descs = iTrack->pointDescs;
				CvPoint2D32f point = descs.back().point; // the last point in the track
				points_in.push_back(point);
			}

			IplImage *grey_temp = 0, *eig_temp = 0;
			std::size_t temp_level = (std::size_t)ixyScale;
			grey_temp = cvCloneImage(grey_pyramid.getImage(temp_level));
			eig_temp = cvCloneImage(eig_pyramid.getImage(temp_level));

			cvDenseSample(grey_temp, eig_temp, points_in, points_out, quality, min_distance);
			// save the new feature points
			for( i = 0; i < points_out.size(); i++) {
				Track track(tracker.trackLength);
				PointDesc point(hogInfo, hofInfo, mbhInfo, points_out[i]);
				track.addPointDesc(point);
				tracks.push_back(track);
			}
			cvReleaseImage( &grey_temp );
			cvReleaseImage( &eig_temp );
		}
		}
		}

		cvCopy( frame, prev_image, 0 );
		cvCvtColor( prev_image, prev_grey, CV_BGR2GRAY );
		prev_grey_pyramid.rebuild(prev_grey);
		}

		if( show_track == 1 ) {
			cvShowImage( "DenseTrack", image);
			c = cvWaitKey(3);
			if((char)c == 27) break;
		}
		// get the next frame
		frameNum++;

	}

	if( show_track == 1 )
		cvDestroyWindow("DenseTrack");

	return 0;
}
