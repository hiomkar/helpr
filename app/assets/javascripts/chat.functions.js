/* == PusherChat Functions == */

// Define some variables
var hasFocus = true;

// Attach some functions to track when the window gains and looses focus
window.onblur = function () {hasFocus = false; }
window.onfocus = function () {hasFocus = true; document.title = "Helpr"; }


// Post a message to the server to be sent through Pusher
function send_message() { 
	
	// Validate Field
	if($('#message').val() == '') {
		alert('Please enter a message...');
		$('#message').focus();
		return false;
	}
	
	//validates chat message
	var escaped_message = $('#message').val().replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;");
	$('#message').val(escaped_message);
	
	// Reset the validation stuff
	$('#message').css({ color: '#000000' });
	
	// Set some vars
	var message = $('#message').val();
	var username = $('#username').val();
	
	// Start the "loading" UI
	$('#loading').fadeIn();
	$('#message-overlay').fadeIn(200);
	$('#message').blur();
	
	// Post off to the server with the message and some vars!
	$.post('/api/post_message', { "chat_id": chat_id, "message":message }, function(response) {
		// When the response comes back, do some stuff to remove the "loading" UI
		$('#message').val("");
		$('#message-overlay').fadeOut(150);
		$('#message').focus();
		$('#loading').fadeOut();
	});
	
}

function scrollToTheTop() {
	$("#messages").scrollTop(20000000); 
}

function replaceURLWithHTMLLinks(text) {
     var exp = /^(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
     return text.replace(exp,"<a href='$1' target='_blank'>$1</a>"); 
}

function addPhrase(phrase) {
	$('#message').val(phrase);
	send_message();
}

function endChat(user, role) {
    $('#message').val(user+" has left the conversation.");

	if (role == "agent") {
		if (confirm("Want to end this chat session?")) {
	        location.href = '/agents';
	    }
	}
	else {
	    if (confirm("Want to end this chat session?")) {
	        send_message();
	        $('#chat_interface').html('<h2>Chat ended. Thank you!</h2>');
	    }
   	}
}
