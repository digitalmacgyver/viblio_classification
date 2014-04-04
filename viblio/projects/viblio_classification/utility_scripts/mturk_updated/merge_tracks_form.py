
from configobj import ConfigObj


form_front = '''
  <form name='mturk_form' method='post' id='mturk_form' action='https://www.mturk.com/mturk/externalSubmit'>
'''

form_back = '''
  <input type='hidden' value='' name='assignmentId' id='assignmentId'/>
  <p><input type='submit' id='submitButton' value='Submit' /></p>
  </form>
'''

html_front = '''<HTMLQuestion xmlns="http://mechanicalturk.amazonaws.com/AWSMechanicalTurkDataSchemas/2011-11-11/HTMLQuestion.xsd">
  <HTMLContent><![CDATA[
<!DOCTYPE html>
<html>
 <head>
  <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
  <script type='text/javascript' src='https://s3.amazonaws.com/mturk-public/externalHIT_v1.js'></script>
  <title>Classify Images</title>
 </head>
 <body>
 '''



html_back = '''
  <script language='Javascript'>turkSetAssignmentID();</script>
 </body>
</html>
]]>
  </HTMLContent>
  <FrameHeight>%d</FrameHeight>
</HTMLQuestion>
'''

def _get_contact_row_html( contacts,start_idx,cell_count):

    

    contact_count = len( contacts )

    html = "<tr>"
    for i in range( contact_count ):
        contact = contacts[i]
        #contact_uuid = contact.uuid
        
        html += '<td><img src="%s" height="200" width="200" alt="Img. %s" /></td>' % ( contact, start_idx + i )

    for i in range( contact_count, cell_count ):
        html += '<td></td>'

    html += '</tr>'
    html += '<tr>'

    for i in range( contact_count ):
        contact = contacts[i]
        #contact_uuid = contact.uuid
        html += '<td><input type="checkbox" name="answer_%s" value="%s" /></td>' % (start_idx+i,contact)
        
    for i in range( contact_count, cell_count ):
        html += '<td></td>'

    html += '</tr>'

    return html

def get_example_images(example_imagelist):
    html='<table>'
    html= html+ '''
      <tr>
    <th>Positive example</th>
    <th>Negative example</th>
  </tr>
  '''
    html = html+"<tr>"
    for i in range( len(example_imagelist) ):
        contact = example_imagelist[i]
        #contact_uuid = contact.uuid

        html += '<td><img src="%s" height="200" width="200" alt="Img. %s" /></td>' % ( contact,i )

    html += '</tr>'
    html += '</table>'
    return html

def get_question(tracks,ex_images):
    desc = ConfigObj( 'boto.config' )['mturk_description']
    html = html_front
    html= html+'<p>'+desc['description']+'</p>'
    html = html+get_example_images(ex_images)
    #server = config.ImageServer
    """
    # Create a table of the person we're recognizing
    html += '<table><tr>'
    for face in person_tracks[0]['faces']:
        html += '<td><img src="%s%s" height="128" width="128" alt="An Image" /></td>' % ( server, face['s3_key'] )
    html += '</tr></table>'
    """
    html += form_front
    html += '<h3> Check mark the following images according to the instructions given above </h3>'
    #html += '<input type="hidden" name="recognize_id" value="%s" />' % ( recognize_id )

    html += '<table border="1">'

    """
    if guess:
        html += '<tr>'
        html += '<td><input type="checkbox" name="answer" value="machine_recognized_%s" /></td>' % ( guess['uuid'] )
        html += '<td>The person  is the same as this person: <img src="%s" height="128" width="128" alt="Img. %s" /></td>' % ( guess['face_url'], 'guess' )
        html += '</tr>'

    html += '<tr>'
    html += '<td></td>'
    html += '<td>The person is one of these people:</td>'
    html += '</tr>'
    """
    html += '<tr>'
    html += '<td></td>'
    html += '<td>'

    html += '<table>'
    col_faces = 5

    for idx in range( 0, len( tracks ), col_faces ):
        html += _get_contact_row_html( tracks[idx:idx+col_faces],idx,col_faces)
        
    html += '</table>'

    html += '</td>'
    html += '</tr>'
    """
    html += '<tr>'
    html += '<td><input type="radio" name="answer" value="new_face" /></td>'
    html += '<td>The person was none of the above people.</td>'
    html += '</tr>'
    """
    html += '</table>'
    html += form_back
    # Parenthesis because of integer division not being associative.
    html += html_back % ( 180*( 1+len( tracks )/col_faces ) + 400 ) 
    
    return html
