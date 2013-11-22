import datetime
from sqlalchemy import *

verbose = True

username = 'unit_test'
password = 'unit_test'
database = 'unit_test'

engine = create_engine( 'mysql+mysqldb://'
                        +username+':'+password
                        +'@classifier.c9azfz8yt9lz.us-west-2.rds.amazonaws.com:3306/'
                        +database, echo=verbose )

meta = MetaData()
meta.reflect( bind=engine )

for table in meta.tables:
    print "Found table:", table

video = meta.tables['video']
video_label = meta.tables['video_label']

image = meta.tables['image']
image_label = meta.tables['image_label']

detector = meta.tables['detector']

conn = engine.connect()

ins = video.insert()
# id of None because of auto sequencing of the ID.
conn.execute( ins, 
              id=None,
              title='unit_test_insert',
              s3video_url='http://viblio-data.s3...',
              s3images_url='http://viblio-data.s3...',
              source_url='http://test.com/video.mp3',
              encoding='mp3',
              width=100,
              height=100,
              length=60.001,
              created_date=datetime.datetime.now(),
              last_updated=datetime.datetime.now() )
              
# Bulk insert a few more rows.
conn.execute( video.insert(), [
        { 'title' : 'unit_test_insert' },
        { 'title' : 'unit_test_insert' },
        ] )

# Add a detector.
conn.execute( detector.insert(),
              id=None,
              name='unit_test_insert',
              run_status='running',
              description='ABC Detector',
              created_date=datetime.datetime.now(),
              last_updated=datetime.datetime.now() )

# Add a few images.
for videoId in conn.execute( select( [video.c.id ] ).where( video.c.title == 'unit_test_insert' ) ):
    conn.execute( image.insert(),
                  id=None,
                  video_id=videoId[0],
                  time_stamp=33.004999,
                  s3image_url='unit_test_insert',
                  format='PNG',
                  width=1024,
                  height=768,
                  created_date=datetime.datetime.now(),
                  last_updated=datetime.datetime.now() )

# Add a few image labels.
for result in conn.execute( select( [image.c.id, image.c.video_id ] ).where( image.c.s3image_url == 'unit_test_insert' ) ):
    conn.execute( image_label.insert(),
                  id=None,
                  image_id=result[0],
                  image_video_id=result[1],
                  label='unit_test_insert',
                  detector_name='unit_test_insert', # Must match FK of name in detector
                  type='object',
                  x1=99.44,
                  y1=0,
                  x2=100,
                  y2=11.33,
                  created_date=datetime.datetime.now(),
                  last_updated=datetime.datetime.now() )

# Add a few video labels.
for result in conn.execute( select( [video.c.id] ).where( video.c.title == 'unit_test_insert' ) ):
    conn.execute( video_label.insert(),
                  id=None,
                  video_id=result[0],
                  label='unit_test_insert',
                  detector_name=None, # Detector names can be null.
                  type='action',
                  confidence=0.99,
                  created_date=datetime.datetime.now(),
                  last_updated=datetime.datetime.now() )

# Clean up our results.
conn.execute( image_label.delete().where( image_label.c.label == 'unit_test_insert' ) )
conn.execute( video_label.delete().where( video_label.c.label == 'unit_test_insert' ) )
conn.execute( detector.delete().where( detector.c.name == 'unit_test_insert' ) )
conn.execute( image.delete().where( image.c.s3image_url == 'unit_test_insert' ) )
conn.execute( video.delete().where( video.c.title == 'unit_test_insert' ) )

# Close our connections.
conn.close()
engine.dispose()
