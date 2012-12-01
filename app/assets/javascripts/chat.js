
$(document).ready(function()
{

	Pusher.channel_auth_endpoint = '/api/authenticate?user_id=' + user_id;
	var socket = new Pusher(PUSHER_KEY);
	
	// Global variable "channel" is set in the view
	var presenceChannel = socket.subscribe('presence-' + channel);

	// Deal with incoming messages!
	presenceChannel.bind('send_message', function(message) {
		
		var you = '';
		if(user_id == message.user.id) {
			you = 'you ';
			$('#message-overlay').fadeOut(150);
		} else {

			// Do some alerting of the user
			if(!hasFocus) {

				// TODO: Update the page title
				document.title = "New Message! - Helpr";

			}
			
		}
		
		$('#messages').append('<li class="' + you + 'just_added_id_' + message.id + '" style="display:none;"><strong>' + message.user.first_name + '</strong> said:<br />' + replaceURLWithHTMLLinks(message.message) + '</li>');
		$('#messages li.just_added_id_' + message.id).fadeIn();
		scrollToTheTop();
	});
	
	$('#loading').fadeOut();
	$('#message').removeAttr("disabled");
	scrollToTheTop();
	
	// Enter key to send message
	$('#message').keydown(function(e)
	{
		if (e.keyCode == 13) { send_message(); return false; }
	});

	var text = 'Type your message here and hit enter...';
	$('#message').focus(function() {
		if($(this).val() == text) { $(this).val(""); }
	}).blur(function() {
		if($(this).val() == "") { $(this).val(text); }
	});

    //file uploader
    presenceChannel.bind('uploaded_file', function(result) {
        alert("Link to shared file: "+result.shared_file);
        $('#messages').append('<li class="note" >File Uploaded: <a href=\''+result.shared_file+'\'>'+result.shared_file+'</a></li>');
    });

});