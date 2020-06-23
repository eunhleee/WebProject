'use strict';

$(function() {

	//이 부분을 자신의 상황에 맞게 수정
	var width = 1300; //슬라이드 한 개의 폭
	var height = 400; //슬라이드 높이
	var animationSpeed = 1000; //화면전환 속도
	var pause = 5000; //화면전환 후 일시 정지 속도
	var totalSlides = 7; //복제 슬라이드를 포함한 전체 슬라이드 개수

	var currentSlide = 2; //이 항목은 수정하지 않음
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
			// setInterval(function,milliseconds)
			// 지정한 시간에 한번씩 함수를 실행
			// 3초 마다 $slideUl 의 왼쪽 마진을 -width 함. 에니메이션 속도는 1초.
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