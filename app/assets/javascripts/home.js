
$(document).ready(function(){
  $('#messages').animate({
  scrollTop: $('#messages').get(0).scrollHeight}, 1000);
    $("#user_button").on('click', function(e){
      e.preventDefault();
      name = $("#username").val();
      $('#chat-input').show();
      $('#chat-username').hide();
      });
        $("#messages").bind("DOMSubtreeModified",function(){
        $('#messages').animate({
        scrollTop: $('#messages').get(0).scrollHeight}, 1000);
        console.log("hi");
        });
});
//
  //   last_message_container = $(".message").last();
  //   last_message = $(this).children().last().children().html();
  //   colon = last_message.search(/:/);
  //   username = last_message.slice(0,colon);
  //     colon_message = last_message.slice(colon+1, )
  //     debugger
  // });
