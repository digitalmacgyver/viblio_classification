#!/usr/bin/env python

'''Located in separate VIBLIO git repository - check out
viblio/video_processor, and cd into the vib subdirectory and source
setup_env.sh
'''
import vib.utils.vsum as vsum

# Process multiple videos at a time.
source_videos = [ 
    '/wintmp/samples/gopro/surf/test/surf01.mp4',
#    '/wintmp/samples/gopro/surf/test/surf05.mp4',
#    '/wintmp/samples/gopro/surf/test/surf10.mp4',
#    '/wintmp/samples/gopro/surf/test/surf15.mp4',
#    '/wintmp/samples/gopro/surf/test/surf20.mp4',
#    '/wintmp/samples/gopro/surf/test/surf25.mp4',
#    '/wintmp/samples/gopro/surf/test/surf30.mp4',
]

clip_timestamp_files = [
#    '/wintmp/samples/gopro/surf/test02/video0/0_0.4_timestamps.txt',
#    '/wintmp/samples/gopro/surf/test02/video1/0_0.4_timestamps.txt',
#    '/wintmp/samples/gopro/surf/test02/video2/0_0.4_timestamps.txt',
#    '/wintmp/samples/gopro/surf/test02/video3/0_0.4_timestamps.txt',
    '/wintmp/samples/gopro/surf/test02/video4/0_0.4_timestamps.txt',
    '/wintmp/samples/gopro/surf/test02/video5/0_0.4_timestamps.txt',
    '/wintmp/samples/gopro/surf/test02/video6/0_0.4_timestamps.txt',
]

output_videos = [ 
#    '/wintmp/samples/gopro/surf/test02/video0/0_0.4_side_by_side.mp4',
#    '/wintmp/samples/gopro/surf/test02/video1/0_0.4_side_by_side.mp4',
#    '/wintmp/samples/gopro/surf/test02/video2/0_0.4_side_by_side.mp4',
#    '/wintmp/samples/gopro/surf/test02/video3/0_0.4_side_by_side.mp4',
    '/wintmp/samples/gopro/surf/test02/video4/0_0.4_side_by_side.mp4',
    '/wintmp/samples/gopro/surf/test02/video5/0_0.4_side_by_side.mp4',
    '/wintmp/samples/gopro/surf/test02/video6/0_0.4_side_by_side.mp4',
] 

for ( idx, clip_timestamp_file_2 ) in enumerate( clip_timestamp_files ):
    with open( clip_timestamp_file_2 ) as f:
        timestamps2 = [ ( float(x.split()[0])/1000, float(x.split()[1])/1000 ) for x in f ]
        
    v = vsum.Video( source_videos[idx] )

    w0 = vsum.Window( width=640*2, height=360 )

    w1 = vsum.Window( width=640, height=360 )
    w1.clips = [ vsum.Clip( v ) ]
    #w2 = vsum.Window( width=640, height=480, x = 640 )
    #w2 = vsum.Window( width=640, height=480, x = 640*2 )

    #w3 = vsum.Window( width=640, height=480, x = 640*2 )
    w3 = vsum.Window( width=640, height=360, x = 640 )

    last_time = 0.0

    for clip_time in timestamps2:
        clip_start = clip_time[0]
        if clip_start > last_time:
            blank_duration = clip_start - last_time
            blank_vid_file = vsum.get_solid_clip( blank_duration, width=640, height=360 )
            blank_vid = vsum.Video( blank_vid_file )
            w3.clips.append( vsum.Clip( blank_vid ) )
        w3.clips.append( vsum.Clip( v, clip_time[0], clip_time[1] ) )
        last_time = clip_time[1]

    #w0.windows = [ w1, w2, w3 ]
    w0.windows = [ w1, w3 ]
    w0.output_file = output_videos[idx]
    w0.render()

