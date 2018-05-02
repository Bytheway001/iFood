$(document).on('turbolinks:load',function(){
	$('.res-thumbnail').click(function(){
		location.href=$(this).find('.res-button').attr('href')
	})

})