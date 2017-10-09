function deleteChild(){
  $('.message').first().remove();
}


document.addEventListener('DOMContentLoaded', function() {
  ////////////////// Method that calculates the video remaining time on page load /////////////////////////////////
  var cats = new Date(document.getElementById('cat').innerText);
  var date = new Date(new Date().toISOString());
  var Milliseconds = date.getTime() - cats.getTime();
  var Seconds = Milliseconds / 1000;
  var begin = 60 - Seconds;
  var fff = Math.ceil(begin);

    time = fff;
/////////////////// Method that counts down clock on countdowm timer ///////////////////////////
      var timer = {
        timerFunction: setInterval(function(){
          if(time > 0){
            time -= 1
            document.getElementById("timer").innerHTML =  "<p>Countdown</p> "+time;
          } else {
            document.getElementById("timer").innerHTML =  "<p>Please wait</p> ";
            }
          }, 1000)
      };
}, false);

$(document).ready(function(){
  ////////////////// Method that autoscrolls the chat room on page load ////////////////////////
  $('#messages').animate({
  scrollTop: $('#messages').get(0).scrollHeight}, 1000);
  ////////////////// Method that adds user name to chat and show message send button ////////////
    $("#user_button").on('click', function(e){
    e.preventDefault();
    name = $("#username").val();
    $('#chat-username').hide();
    $('#chat-input').show();
    });
///////////////////// Method that removes first child when the message count gets to high /////////
      $("#messages").bind("DOMSubtreeModified",function(){
        length = $('.message').length
        if(length > 28){
        deleteChild()};
  ///////////////////// Method that scrolls down after a message has be posted ////////////////////
        $('#messages').animate({
          scrollTop: $('#messages').get(0).scrollHeight}, 1000);
        });
});
