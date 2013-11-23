import unittest
import datetime
from sqlalchemy import *
import sys

class SchemaTest( unittest.TestCase ):

    verbose = False

    username = 'test'
    password = 'isidelontmos'
    database = 'test'

    engine = create_engine( 'mysql+mysqldb://'
                            +username+':'+password
                            +'@testpub.c9azfz8yt9lz.us-west-2.rds.amazonaws.com:3306/'
                            +database, echo=verbose )

    meta = None
    conn = None

    detector = None
    image = None
    image_label = None
    video = None
    video_label = None

    
    @classmethod
    def setUpClass( self ):
        try:
            print "Getting database connection."
            self.meta = MetaData()
            self.meta.reflect( bind=self.engine )
            self.conn = self.engine.connect()
        except:
            print "Failed to get database connection, aborting tests."
            raise

        try:
            print "Validating metadata import"
            self.detector = self.meta.tables['detector']
            self.image = self.meta.tables['image']
            self.image_label = self.meta.tables['image_label']
            self.video = self.meta.tables['video']
            self.video_label = self.meta.tables['video_label']

            print "Cleaning up any stale rows from prior tests."
            self.delete_test_rows()
        except:
            print "Something went wrong getting the database schema, aborting tests."
            raise


    @classmethod
    def tearDownClass( self ):
        try: 
            print "Testing delete of rows from the database."
            self.delete_test_rows()
        except:
            print "Something went wrong cleaning up test data - test data may be resident in the database."
            raise
        
        try:
            self.conn.close()
            self.engine.dispose()
        except:
            print "Something went wrong closing down database connection."
            raise


    @classmethod
    def delete_test_rows( self ):
        self.conn.execute( 
            self.image_label.delete()
            .where( self.image_label.c.label == 'unit_test_insert' ) )
        self.conn.execute( 
            self.video_label.delete()
            .where( self.video_label.c.label == 'unit_test_insert' ) )
        self.conn.execute( 
            self.detector.delete()
            .where( self.detector.c.name == 'unit_test_insert' ) )
        self.conn.execute( 
            self.image.delete()
            .where( self.image.c.s3image_url == 'unit_test_insert' ) )
        self.conn.execute( 
            self.video.delete()
            .where( self.video.c.title == 'unit_test_insert' ) )


    def test_metadata( self ):
        def test_table( table_name ):
            self.assertIn( table_name, self.meta.tables, msg=table_name+' table not found in database' )

        try:
            print "Validating metadata."
            test_table( 'detector' )
            test_table( 'image' )
            test_table( 'image_label' )
            test_table( 'video' )
            test_table( 'video_label' )
        except:
            print "ERROR during metadata validation."
            raise

    def insert_detector_rows( self ):
        self.conn.execute( self.detector.insert(),
                           id=None,
                           name='unit_test_insert',
                           run_status='running',
                           description='ABC Detector',
                           created_date=datetime.datetime.now(),
                           last_updated=datetime.datetime.now() )            


    def test_detector_insert( self ):
        trans = self.conn.begin()
        try:
            # Add a detector.
            print "Testing insertion to detector table"
            self.insert_detector_rows()

            # Run a select and get back the right number of rows.
            rows = self.conn.execute( select( [ func.count() ] ).where( self.detector.c.name == 'unit_test_insert' ) ).fetchone()[0]
            self.assertEquals( rows, 1, msg="There should have been 1 matching rows in video, instead there were "+str( rows ) )
        except:
            print "Something went wrong testing inserts to detector."
            raise
        finally:
            trans.rollback()

    def insert_video_rows( self ):
        ins = self.video.insert()
        # id of None because of auto sequencing of the ID.
        self.conn.execute( ins, 
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
        self.conn.execute( self.video.insert(), [
                { 'title' : 'unit_test_insert' },
                { 'title' : 'unit_test_insert' },
                ] )


    def test_video_insert( self ):
        trans = self.conn.begin()
        try:
            print "Testing insertion to video table."
            self.insert_video_rows()

            # Run a select and get back the right number of rows.
            rows = self.conn.execute( select( [ func.count() ] ).where( self.video.c.title == 'unit_test_insert' ) ).fetchone()[0]
            self.assertEquals( rows, 3, msg="There should have been 3 matching rows in video, instead there were "+str( rows ) )

        except:
            print "Something went wrong testing inserts to video."
            raise
        finally:
            trans.rollback()

    def insert_video_label_rows( self ):
        for result in self.conn.execute( select( [self.video.c.id] ).where( self.video.c.title == 'unit_test_insert' ) ):
            self.conn.execute( self.video_label.insert(),
                               id=None,
                               video_id=result[0],
                               label='unit_test_insert',
                               detector_name=None, # Detector names can be null.
                               type='action',
                               confidence=0.99,
                               created_date=datetime.datetime.now(),
                               last_updated=datetime.datetime.now() )


    def test_video_label_insert( self ):
        trans = self.conn.begin()
        try:
            print "Testing insertion into video_label table."
            # Add a few video labels.
            self.insert_detector_rows()
            self.insert_video_rows()
            self.insert_video_label_rows()

            # Run a select and get back the right number of rows.
            rows = self.conn.execute( select( [ func.count() ] ).where( self.video_label.c.label == 'unit_test_insert' ) ).fetchone()[0]
            self.assertEquals( rows, 3, msg="There should have been 3 matching rows in video_label, instead there were "+str( rows ) )

        except:
            print "Something went wrong testing inserts to video_label."
            raise
        finally:
            trans.rollback()

    def insert_image_rows( self ):
        for videoId in self.conn.execute( select( [self.video.c.id ] ).where( self.video.c.title == 'unit_test_insert' ) ):
            print "Adding image for video:", videoId[0]
            self.conn.execute( self.image.insert(),
                               id=None,
                               video_id=videoId[0],
                               time_stamp=33.004999,
                               s3image_url='unit_test_insert',
                               format='PNG',
                               width=1024,
                               height=768,
                               created_date=datetime.datetime.now(),
                               last_updated=datetime.datetime.now() )


    def test_image_insert( self ):
        trans = self.conn.begin()
        try:
            print "Testing insertion into image table."
            # Add a few images.
            self.insert_video_rows()
            self.insert_image_rows()

            # Run a select and get back the right number of rows.
            rows = self.conn.execute( select( [ func.count() ] ).where( self.image.c.s3image_url == 'unit_test_insert' ) ).fetchone()[0]
            self.assertEquals( rows, 3, msg="There should have been 3 matching rows in image, instead there were "+str( rows ) )

        except:
            print "Something went wrong testing inserts to image."
            raise
        finally:
            trans.rollback()

    def insert_image_label_rows( self ):
        for result in self.conn.execute( select( [self.image.c.id, self.image.c.video_id ] ).where( self.image.c.s3image_url == 'unit_test_insert' ) ):
            self.conn.execute( self.image_label.insert(),
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

    def test_image_label_insert( self ):
        trans = self.conn.begin()
        try:
            print "Testing insertion into image_label."
            # Add a few image labels.
            self.insert_detector_rows()
            self.insert_video_rows()
            self.insert_image_rows()
            self.insert_image_label_rows()

            # Run a select and get back the right number of rows.
            rows = self.conn.execute( select( [ func.count() ] ).where( self.image_label.c.label == 'unit_test_insert' ) ).fetchone()[0]
            self.assertEquals( rows, 3, msg="There should have been 3 matching rows in image_label, instead there were "+str( rows ) )

        except:
            print "Something went wrong testing inserts to image_label."
            raise
        finally:
            trans.rollback()


if __name__ == '__main__':
    unittest.main()

'''

assertEqual( a, b )

assertRaises( TypeError, a, b )

assertTrue( bool )

'''

