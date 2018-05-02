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
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require_tree .
//= require cocoon
//= require selectize
//= require bootstrap-sprockets

// Para los Input File
function readURL(input,selector) {
	console.log(input);
	var url = $(input).val();
	var ext = url.substring(url.lastIndexOf('.') + 1).toLowerCase();
	if (input.files && input.files[0]&& (ext == "gif" || ext == "png" || ext == "jpeg" || ext == "jpg")) {
		
		var reader = new FileReader();
		reader.onload = function (e) {
			$(selector).attr('src', e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
	else{
		$(selector).attr('src', '/assets/no_preview.png');
	}
}

// ****************************Funciones de google maps****************************

function initMap() {
	var map = new google.maps.Map(document.getElementById('map'), {
		center: {lat: -8.761160499999999, lng:-63.90043029999998},
		zoom: 13
	});

	var geocoder = new google.maps.Geocoder();
	$('#search').click(function() {
		geocodeAddress(geocoder, map);
	});

	var input=document.getElementById('gmaps-direccion')

	var autocomplete = new google.maps.places.Autocomplete(input);
	autocomplete.bindTo('bounds', map);
}

function geocodeAddress(geocoder, resultsMap) {
	var address = $('#gmaps-direccion').val();
	geocoder.geocode({'address': address}, function(results, status) {
		if (status === 'OK') {
			console.log(results)
			resultsMap.setCenter(results[0].geometry.location);
			var marker = new google.maps.Marker({map: resultsMap,position: results[0].geometry.location})
			$('#lat').val(results[0].geometry.location.lat())
			$('#long').val(results[0].geometry.location.lng())
		}
		else{
			alert('Geocode was not successful for the following reason: ' + status);
		}
	})

}

// ****************************Funciones de google maps****************************