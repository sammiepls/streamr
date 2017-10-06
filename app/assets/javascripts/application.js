// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require ahoy
//= require_tree .


setInterval(function(e){

	// make if statement, if the video is different then ajax and change the video. every 5 seconds the js will check
	var old_id = document.getElementsByClassName('video_id');
	  $.ajax({
	    type:'GET',
	    url:'/update',
	    dataType: 'json',
	    success: function(data){
	    	// debugger 
	    	console.log("ran");
	    	// debugger 
	    	if (old_id[0].value != data.data[0]) {
	    	   console.log("sucess");
	    	   // debugger 
	    	   $('.video').remove()
	    	   $('.video_id').remove()
	    	   $('.stream-container').append("\
	    	   	<input class='video_id' name='vid_id' type='hidden' value="+ data.data[0] +">\
	    	   <iframe class='video' id= "+ data.data[0] +" width='700' \
	    	   height='500' src='https://www.youtube.com/embed/"+ data.data[0] +"?autoplay=1&start="+ data.data[1]+"'></iframe> ")
	    	}
	    },
	  });
}, 5000);

// $(document).on("click","#executer-button",callExecuter);

// Get Keep Button Count
document.addEventListener("turbolinks:load", function() {
  document.querySelector("#btn-keep").addEventListener("click",function(e) {
    ahoy.track("Press keep button","Keep playing");
  })
});

document.addEventListener("turbolinks:load", function() {
		var totalKeeps = $('#btn-keep').data('url')
		var totalVisits = $('#current-viewers').html()

		$('#btn-keep').click(function () {
        // var val = Math.floor((Math.random() * 100)) + '%';
        var val = (Math.ceil(totalKeeps / totalVisits)) * 100 + '%';
				debugger
        $('.progress-bar').width(val).text(val)
    })
});
