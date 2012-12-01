// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require twitter/bootstrap


$(document).ready(function(){
	
	//hides or shows chat history based on filter
    $('#search_chat').keypress(function() {
        console.log('keypress');

        var filter = $(this).val();

        $(".chat_in_history").each(function(){
            // If the list item does not contain the text phrase fade it out
            if ($(this).html().search(new RegExp(filter, "i")) < 0) {
                $(this).fadeOut();

                // Show the list item if the phrase matches and increase the count by 1
            } else {
                $(this).show();
            }
        });

    });
});


$(function() {
    $('.alert').fadeIn('normal', function() {
        $(this).delay(3700).fadeOut();
    });
});
