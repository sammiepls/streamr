
time = 20
var timer = {
  timerFunction: setInterval(function(){
    time -= 1;
    document.getElementById("timer").innerHTML =  "<p>Count<br>Down</br></p> "+time;
  }, 1000)
};



function deleteChild(){
  $('.message').first().remove();
}


$(document).ready(function(){
  $('#messages').animate({
  scrollTop: $('#messages').get(0).scrollHeight}, 1000);
    $("#user_button").on('click', function(e){
    e.preventDefault();
    name = $("#username").val();
    $('#chat-username').hide();
    $('#chat-input').show();
    });

      $("#messages").bind("DOMSubtreeModified",function(){
        length = $('.message').length
        if(length > 28){
          deleteChild()
        };
      $('#messages').animate({
      scrollTop: $('#messages').get(0).scrollHeight}, 1000);
      });
});
