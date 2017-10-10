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
//= require jquery3
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require popper
//= require bootstrap
//= require ahoy
//= require chardinjs
//= require_tree .
//
document.addEventListener('DOMContentLoaded', function() {
	setInterval(function(e){
	// make if statement, if the video is different then ajax and change the video. every 5 seconds the js will check
	var old_id = document.getElementsByClassName('video_id');
	  $.ajax({
	    type:'GET',
	    url:'/update',
	    dataType: 'json',
	    success: function(data){
	    	// console.log("ran");
	    	// debugger
				$('#current-viewers').text(data.data[4])
				$('#current-keeps').remove()
				$('.btn-keep-wrapper').append("\
					<input type='hidden' id='current-keeps' name='vid_id' type='hidden' value='"+ data.data[5] +"'>")
					var totalKeeps = parseInt($('#current-keeps').val())
					var totalVisits = parseInt($('#current-viewers').html())
					var val = (Math.round((totalKeeps / totalVisits) * 100 ))  + '%';
					$('.progress-bar').width(val)
					$('.progress-bar span').text(val)


	    	if (old_id[0].value != data.data[0]) {
	    	   console.log("success");
	    	   		 // var a = false; 
					 time = 60;
				 	 timer['timerFunction'];

	    	   $('.video').remove()
	    	   $('.video_id').remove()
	    	   $('.stream-container').append("\
	    	   	<input class='video_id' name='vid_id' type='hidden' value="+ data.data[0] +">\
	    	   <iframe class='video' id= "+ data.data[0] +" width='700' \
	    	   height='500' src='https://www.youtube.com/embed/"+ data.data[0] +"?autoplay=1&start="+ data.data[1]+"'></iframe> ")
					 $("#vid-title").text(data.data[6].vid_title)
					 $("#vid-username").text(data.data[6].channel_title)
					 $("#btn-keep").removeClass("disabled");
					 $(".coin").css("animation-duration","3s");
					 $(".coin").fadeIn( 1000, function() {
		 		 	});
		 			$("#coin small").text("Continue Stream?");
	    	}

	    	if (data.data[7] == 'prev' && time == 0 ) {
	    		debugger
	    		clearInterval(timer); 
	    		// var a = true ;
	    		console.log('timer');
	    		document.getElementById("timer").innerHTML =  "<p>Video Kept</p>";
	    	}
	    },
	  });
}, 3000);

});

document.addEventListener("turbolinks:load", function() {

	$('#btn-keep').click(function(event) {
		if($("#btn-keep").hasClass('disabled')){
			event.preventDefault();
		}
		else {
			ahoy.track("Press keep button","Keep playing");
			$("#btn-keep").addClass("disabled");
			$(".coin").css("animation-duration",".2s");
			$(".coin").fadeOut( 1000, function() {
		 	});
			$("#coin small").text("Thanks!");


			$.ajax({
				type:'GET',
				url:'/voting',
				dataType: 'json',
				success: function(data){
					$('#current-keeps').remove()
					$('.btn-keep-wrapper').append("\
					<input type='hidden' id='current-keeps' name='vid_id' type='hidden' value='"+ data.data +"'>")
					var totalKeeps = parseInt($('#current-keeps').val())
					var totalVisits = parseInt($('#current-viewers').html())
					var val = (Math.round((totalKeeps / totalVisits) * 100 ))  + '%';
					$('.progress-bar').width(val)
					$('.progress-bar span').text(val)
				}
			}) //end ajax
		} //end if else statement
	});

});


// Buttons
document.addEventListener("turbolinks:load", function() {
	$('.btn-subscribe').prepend('<div class="hover"><span></span><span></span><span></span><span></span><span></span></div>');
});

document.addEventListener("turbolinks:load", function() {
	$('#open-tour').click(function() {
		$('body').chardinJs('start')
		if($('.navbar-item').hasClass('login')) {
			$( ".chardinjs-helper-layer" ).first().addClass("login-show");
			$( ".chardinjs-tooltip" ).first().css("top","-10px");
			$( ".chardinjs-tooltip.chardinjs-left").first().css("margin-left","-224px");
		}
		else {
			$( ".chardinjs-helper-layer" ).first().addClass("queue-show");
			$( ".chardinjs-tooltip" ).first().css("top","-10px");
		}
	});
});
