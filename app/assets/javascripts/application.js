// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery_ujs
//= require materialize-sprockets
//= require turbolinks
//= require jquery.slick
//= require materialize/extras/nouislider
//= require_tree .

function initializeSlider(range, rangeInputs){
	// JS for noUiSlider

	noUiSlider.create(range, {
		start: [ parseInt(rangeInputs[0].attr('value')), parseInt(rangeInputs[1].attr('value')) ], // Handle start position
		step: 100, // Slider moves in increments of '10'
		margin: 100, // Handles must be more than '20' apart
		connect: true, // Display a colored bar between the handles
		direction: 'ltr', // Put '0' at the bottom of the slider
		behaviour: 'tap-drag', // Move handle on tap, bar is draggable
		range: { // Slider can select '0' to '100'
			'min': 0,
			'max': 2000
		},
		format: wNumb({ decimals: 0 })
	});
}


var ready = function() {
	$(".button-collapse").sideNav();
	$(".dropdown-button").dropdown({
		hover: false,
		belowOrigin: true,
		constrain_width: false
	});      

	$('.product-images-slider').slick({
		dots: true,
		infinite: true,
		arrows: true
	});
	$('.collapsible').collapsible();

	if($('.noUi-target').length == 0 && $('div#range').length > 0){
		var range = document.getElementById('range');

		var rangeInputs = [
			$('input#range_min'),
			$('input#range_max')
		];

		initializeSlider(range, rangeInputs);

		range.noUiSlider.on('update', function( values, handle ) {
			rangeInputs[handle].val(values[handle]);
		});
	}

	$('.auto-submit-input').on('change', function(){
		$('form#filter_form').submit();
	});

	$.post('/cart/show_without_layout.html', function(data, status){
		$('#cart-dropdown').html(data);
	});


	$('.datepicker').pickadate({
		selectMonths: false, // Creates a dropdown to control month
		selectYears: 1 // Creates a dropdown of 15 years to control year
	});
        
}

$(document).ready(function(){
	ready();
	$('select').material_select();
});
$(document).on('turbolinks:load', function(){
	ready();
	$('select').material_select();
	// TODO: Fix the multiple select input on back press bug
	// var select_length =  $('select').length;
	// for(var i = 0; $('.select-wrapper').length > select_length; i = i ++){
	// 	$('.select-wrapper:eq(' + i + ')').replaceWith($('.select-wrapper:eq(' + (i + 1) + ')'));
	// }
});