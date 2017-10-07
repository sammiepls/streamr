


function deleteChild(){
  $('.message').first().remove();
}


document.addEventListener('DOMContentLoaded', function() {
var cats = new Date(document.getElementById('cat').innerText);
console.log(cats);
var date = new Date(new Date().toISOString());
console.log(date);
var Milliseconds = date.getTime() - cats.getTime();
console.log(Milliseconds);
var Seconds = Milliseconds / 1000;
var begin = 60 - Seconds;
console.log(Seconds);
console.log(begin);
var fff = Math.ceil(begin);
console.log(fff);

time = fff
var timer = {
  timerFunction: setInterval(function(){
    time -= 1;
    document.getElementById("timer").innerHTML =  "<p>Count<br>Down</br></p> "+time;
  }, 1000)
};

}, false);
// function getTime() {
//   var created = document.getElementById('cat').innerHTML;
//
//
// }
// var myDate2 = new Date(created)

$(document).ready(function(){
  console.log();
  $('#messages').animate({
  scrollTop: $('#messages').get(0).scrollHeight}, 1000);
    $("#user_button").on('click', function(e){
    e.preventDefault();
    name = $("#username").val();
    $('#chat-username').hide();
    $('#chat-input').show();
    });
debugger
      $("#messages").bind("DOMSubtreeModified",function(){
        length = $('.message').length
        if(length > 28){
          deleteChild()
        };
      $('#messages').animate({
      scrollTop: $('#messages').get(0).scrollHeight}, 1000);
      });

});
