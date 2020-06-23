'use strict';

$(function() {

	
	var width = 1600; 
	var height = 400; 
	var animationSpeed = 1000; 
	var pause = 5000; 
	var totalSlides = 7;

	var currentSlide = 2; 
	var interval;
	var action;
	var dotNum;
	var dMinusC;

	//cache DOM elements
	var $slideCon = $('#slider');
	var $slideUl = $('.slides');
	var $slides = $('.slide');
	var $dots = $('.slider-nav-dot');
	var $sliderNavPrv = $('#slider-nav-prv');
	var $sliderNavNxt = $('#slider-nav-nxt');

	function initSlider(){
		$slideCon.css('width',width);
		$slideCon.css('height',height);
		$slideUl.css('margin-left',-width);
		$slideUl.css('width',totalSlides*width);
		$slides.css('width',width);
		$slides.css('height',height);
	}

	function startSlider(action, dotNum) {

		if(action == 'prv'){
			$slideUl.animate({'margin-left': '+='+width}, animationSpeed, function() {
				if (--currentSlide === 1) {
					currentSlide = $slides.length-1;
					$slideUl.css('margin-left', -($slides.length-2)*width);
				}else{}

				for(var i=0; i<$dots.length; i++){$dots[i].style.background = "";}
				$dots[currentSlide-2].style.background = "white";
			});
		} else if(action == 'nxt') {
			$slideUl.animate({'margin-left': '-='+width}, animationSpeed, function() {
				if (++currentSlide === $slides.length) {
					currentSlide = 2;
					$slideUl.css('margin-left', -width);
				}else{}

				for(var i=0; i<$dots.length; i++){$dots[i].style.background = "";}
				$dots[currentSlide-2].style.background = "white";
			});
		} else if(action == 'dot') {
			dMinusC = dotNum-currentSlide;
			currentSlide = dotNum;

			for(var i=0; i<$dots.length; i++){$dots[i].style.background = "";}
			$dots[currentSlide-2].style.background = "white";

			$slideUl.animate({'margin-left': '-='+(dMinusC*width)}, animationSpeed);

		} else {
			
			interval = setInterval(function() {

				//.animate( CSS properties [, duration ] [, complete ] )
				$slideUl.animate({'margin-left': '-='+width}, animationSpeed, function() {
					if (++currentSlide === $slides.length) { // $slides.length == 7
						currentSlide = 2;
						$slideUl.css('margin-left', -width);
					}

					for(var i=0; i<$dots.length; i++){$dots[i].style.background = "";}
					$dots[currentSlide-2].style.background = "white";
				});	

			}, pause);
		}

	}


	function pauseSlider() {
		clearInterval(interval);
	}

	function prvSlide(){
		startSlider('prv');
	}

	function nxtSlide(){
		startSlider('nxt');
	}

	function dotSelected(){
		dotNum = $(this).attr('id');
		dotNum = parseInt(dotNum.substring(7))+1;
		startSlider('dot', dotNum);
	}


	$slideUl
		.on('mouseenter', pauseSlider)
		.on('mouseleave', startSlider);

	$sliderNavPrv
		.on('click',prvSlide)
		.on('mouseenter', pauseSlider)
		.on('mouseleave', startSlider);

	$sliderNavNxt
		.on('click',nxtSlide)
		.on('mouseenter', pauseSlider)
		.on('mouseleave', startSlider);

	$dots
		.on('click', dotSelected)
		.on('mouseenter', pauseSlider)
		.on('mouseleave', startSlider);		

	
	initSlider();
	startSlider();

});