$(function(){
		$(".page-left").each(function(){
			var $window = $(window); // window객체를 jQuery로 저장
			var $header = $(this); // header객체를 jQuery로 저장
			var headerOffsetTop = $header.offset().top; // header객체의 위쪽 좌표값을 headerOffsetTop변수에 저장
	
			$window.on("scroll", function(){ // window객체에 'scroll'이벤트가 발생하면
				if ($window.scrollTop() > headerOffsetTop)	{ 
				// 스크롤이 일어난 위쪽 좌표값이 header객체의 위쪽 좌표값보다 크면
				// header가 화면에서 사라져야 하는 상황이면
					$header.addClass("sticky"); 
					// header객체에 'sticky'라는 클래스를 추가
					// 'sticky'클래스에 지정된 CSS가 동작하여 화면 상단에 고정시켜 줌 
				} else {
				// 스크롤이 일어난 위쪽 좌표값이 header객체의 위쪽 좌표값보다 작거나 같으면
				// header가 화면에 원래 위치에 존재해야 하면
					$header.removeClass("sticky");
					// header객체에 'sticky'라는 클래스를 삭제
					// 'sticky'클래스에 지정된 CSS가 동작되지 않음
				}
			});
	
			$window.trigger("scroll"); 
			// window객체에 'scroll'이벤트가 일어났다고 알려주는 명령문
			// 초기 header의 위치를 잡기위해 인위적으로 scroll이벤트를 발생시킴
		});
	});
	//right탭
	$(function(){
		$(".page-right").each(function(){
			var $window = $(window); // window객체를 jQuery로 저장
			var $header = $(this); // header객체를 jQuery로 저장
			var headerOffsetTop = $header.offset().top; // header객체의 위쪽 좌표값을 headerOffsetTop변수에 저장
	
			$window.on("scroll", function(){ // window객체에 'scroll'이벤트가 발생하면
				if ($window.scrollTop() > headerOffsetTop)	{ 
				// 스크롤이 일어난 위쪽 좌표값이 header객체의 위쪽 좌표값보다 크면
				// header가 화면에서 사라져야 하는 상황이면
					$header.addClass("sticky"); 
					// header객체에 'sticky'라는 클래스를 추가
					// 'sticky'클래스에 지정된 CSS가 동작하여 화면 상단에 고정시켜 줌 
				} else {
				// 스크롤이 일어난 위쪽 좌표값이 header객체의 위쪽 좌표값보다 작거나 같으면
				// header가 화면에 원래 위치에 존재해야 하면
					$header.removeClass("sticky");
					// header객체에 'sticky'라는 클래스를 삭제
					// 'sticky'클래스에 지정된 CSS가 동작되지 않음
				}
			});
	
			$window.trigger("scroll"); 
			// window객체에 'scroll'이벤트가 일어났다고 알려주는 명령문
			// 초기 header의 위치를 잡기위해 인위적으로 scroll이벤트를 발생시킴
		});
	});
	
	
	$(function() {	// left-tab메뉴
		var $aside = $(".left-tab");
		$("#man").on("click", function() {
			$aside.toggleClass("open1");
			if ($aside.hasClass("open1")) {
				$("#manScata").slideDown(300);
			} else {
				$("#manScata").slideUp(300);
			}
		});
		
		$("#woman").on("click", function() {
			$aside.toggleClass("open2");
			if ($aside.hasClass("open2")) {
				$("#womanScata").slideDown(300);
			} else {
				$("#womanScata").slideUp(300);
			}
		});
		
		$("#codi").on("click", function() {
			$aside.toggleClass("open3");
			if ($aside.hasClass("open3")) {
				$("#codiScata").slideDown(300);
			} else {
				$("#codiScata").slideUp(300);
			}
		});
	});
	
	$(function() {	// right-tab메뉴
		var $aside = $(".right-tab");
		$("#member").on("click", function() {
			$aside.toggleClass("open4");
			if ($aside.hasClass("open4")) {
				$("#memberScata").slideDown(300);
			} else {
				$("#memberScata").slideUp(300);
			}
		});
	});

	
	$(function() {
		$(".slideshow").each(function() {
			var $container = $(this); //슬라이드쇼에 필요한 모든 요소들의 집합
			var $slideGroup = $container.find(".slideshow-slides"); //슬라이드쇼
			var $slides = $slideGroup.find(".slide"); //슬라이드쇼에 필요한 이미지들
			var $nav = $container.find(".slideshow-nav"); //내비게이션 객체
			var $indicator = $container.find(".slideshow-indicator"); //인디케이터 객체
			var slideCount = $slides.length; //슬라이드쇼를 할 이미지 개수
			var indicatorHTML = ""; //인디케이터에 보여줄 내용을 저장할 변수
			var currentIndex = 0; //현재 보여지고 있는 이미지 인덱스 번호
			var duration = 500; //애니메이트에 걸리는 시간
			var interval = 2000; //슬라이드 넘어가는 시간
			var timer;

			$slides.each(function(i) {
			// $slides내의 요소들로 루프를 돌면서 작업
			// i : $slides내의 요소들의 개수만큼 0부터 1씩 증가시켜 들어감
				$(this).css({ left:100 * i + "%" });
				// $slides내의 요소들(링크걸린 이미지들)을 가로로 배치
				// 각 이미지가 겹치지 않게 x좌표값을 이미지의 넓이로 지정
				indicatorHTML += "<a href='#'>" + (i + 1) + "</a>";
				//indicatorHTML에 보일 링크 문자열 생성
				//슬라이드쇼를 할 이미지의 개수가 일정하지 않으므로 직접 입력하지 않고, 문자열로 생성하여 추가
			});
		
			$indicator.html(indicatorHTML);
			//$indicator의 위치에 indicatorHTML의 문자열 삽입
			//인디케이터용 링크(이미지 바로가기 점)추가

			//특정 슬라이드로 이동시키는 함수
			function goToSlide(index) {
				$slideGroup.animate({ left:-100 * index + "%" }, duration);
				//$slideGroup(전체이미지)의 위치를 받아온 index만큼 이동(animate())시킴
				currentIndex = index;
				//현재 보이는 이미지의 인덱스번호를 새로운 인덱스로 변경
				updateNav();
				//좌우 버튼과 인디케이터의 점표식을 업데이트 시킴
			}
			//좌우 버튼과 인디케이터의 점표식의 표시 여부
			function updateNav() {
				var $navPrev = $nav.find(".prev");
				var $navNext = $nav.find(".next");

				//왼쪽버튼의 표시여부
				//$nav안에 있는 좌우버튼의 객체를 $navPrev와 $navNext변수에 담음
				if (currentIndex == 0)	$navPrev.addClass("disabled");
				//현재 보이는 이미지가 1번째 이미지이면 "disabled"라는 클래스를 추가시킴
				//"disabled"클래스가 추가되면 CSS에 의해 버튼이 숨겨짐 - display:none;
				else					$navPrev.removeClass("disabled");
				//현재이미지가 1번째가 아니면 "disabled"메소드를 삭제시킴
				//"disabled"클래스가 삭제되면 CSS에 의해 버튼이 보여짐 - display:block;	
				
				//오른쪽버튼의 표시여부
				if (currentIndex == slideCount - 1)	$navNext.addClass("disabled");
				//현재 보이는 이미지가 마지막 이미지이면 "disabled"클래스를 추가시킴
				//"disabled"클래스가 추가되면 CSS에 의해 버튼이 숨겨짐 - display:none;
				else								$navNext.removeClass("disabled");
				//현재 보이는 이미지가 마지막 이미지아니면 "disabled"클래스를 삭제시킴
				//"disabled"클래스가 삭제되면 CSS에 의해 버튼이 보여짐 - display:block;
				
				$indicator.find("a").removeClass("active").eq(currentIndex).addClass("active");
				//$indicator내의 모든"a"요소에서 "active"클래스를 삭제
				//새롭게 보이는 이미지의 "a"요소에 "active"클래스를 추가
			}
			//자동으로 이미지가 슬라이딩 되도록 시간을 지정하는 함수
			function startTimer() {
				timer = setInterval(function() {
				//setInterval(기능, 시간) : 특정 시간에 맞춰 반복적으로 동작하게 하는 함수
					var nextIndex = (currentIndex + 1) % slideCount;
					//다음에 보여줄 이미지의 인덱스번호 계산
					//단, 마지막 이미지일 경우 첫번째 이미지의 인덱스번호가 저장됨
					goToSlide(nextIndex);
					//계산된 인덱스에 해당하는 이미지를 보여주기 위해 goToSlide()함수 호출
				}, interval);
				//interval에 저장된 밀리초의 간격에 맞춰 무한 호출
			}

			//자동으로 슬라이딩되는 이미지를 일시멈춤 시키는 함수
			function stopTimer() {
				clearInterval(timer);
				//setInterval()로 지정된 timer를 멈춤(해체시켜 버림)
			}
			
			//$nav객체(좌우버튼)의 'a'태그를 클릭하면
			$nav.on("click", "a", function(event) {
				event.preventDefault();
				//이벤트가 일어난 "a"태그에 아무런 동작이 되지않게 막음
				//즉, "a"태그의 링크에 따라 이동하지 않는다는 의미

				if ($(this).hasClass("prev"))	goToSlide(currentIndex - 1);
				//이벤트가 일어난 객체가 "prev"클래스를 가지고 있으면
				//좌측이동 버튼을 클릭했으면 현재 이미지의 이전 이미지 인덱스를 가지고 goToSlide()함수를 호출
				else							goToSlide(currentIndex + 1);
				//우측이동 버튼을 클릭했으면 현재 이미지의 다음 이미지 인덱스를 가지고 goToSlide()함수를 호출
			});
			
			//$indicator객체(점버튼)의 'a'태그를 클릭하면
			$indicator.on("click", "a", function(event) {
					event.preventDefault();
					if (!$(this).hasClass("active"))	goToSlide($(this).index());
					//이벤트를 일으킨 객체의 "active"클래스가 없으면 객체의 인덱스를 가지고 goToSlide()함수를 호출
					//객체의 "active"가 있다는 것은 현재 보이는 이미지가 this인 경우로 새로운 이미지를 보여줄 수 없음으로 아무일도 하지 않음 
			});
			
			//슬라이드쇼 전체에 마우스가 over또는 out일 경우
			$container.on({mouseenter:stopTimer, mouseleave:startTimer});
			//마우스 오버시(mouseenter) stopTimer함수를 호출하여 동작을 멈춤
			//마우스 아웃시(mouseleave) startTimer함수를 호출하여 동작을 진행

			goToSlide(currentIndex);
			//보여줘야 할 인덱스번호(currentIndex)의 생성이 끝났으면 goToSlide함수를 호출

			startTimer();
			//마우스 오버나 페이지 이동때 까지 무한 호출
				
		});
	});