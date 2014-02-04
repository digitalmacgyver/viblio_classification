import argparse
import glob
import os

#usage: python txtfile_from_imagefolder.py -i /home/rgolla/Desktop/mona_vids -c soccer -o soccer.txt -l -1
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', action='store', dest='info_folder', help='Folder with images')
    parser.add_argument('-l', action='store', dest='label', help='Label to be attached with the images')
    parser.add_argument('-c',action='store',dest='category',help='category of images eg:soccer')
    parser.add_argument('-o',action='store',dest='output_filename',help='output filename')
    results = parser.parse_args()

    #file types to search in the info_folder
    types=('*.png','*.jpg','*.bmp','*.jpeg')
    total_files=[]
    for extensions in types:
        path=os.path.join(results.info_folder,extensions)
        total_files.extend((glob.glob(path)))
    output_filepath=results.info_folder+'/'+results.output_filename
    filepointer=open(output_filepath,'w')    
    for filename in total_files:
        #fetching just the filename from the whole path
        #filepath yields image001.png
        filepath= os.path.basename(filename)
        #filename yields image001
        filename=filepath.split('.')[0]
        filepointer.write('%s %s %s %s\n'%(filename,filepath,results.category,results.label))

    filepointer.close()
    print 'output file stored at '+output_filepath
    # output textfile format : file_2_images00001 file_2_images00001.png soccer -1
