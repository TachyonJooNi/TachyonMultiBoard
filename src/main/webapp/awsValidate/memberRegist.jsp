<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
<script>
	$(function(){
		//패스워드 입력란에 입력후 키보드를 땠을때 함수를 실행한다.
		$('#passwd1').keyup(function(){
			//패스워드1에 입력한 내용을 변수로 저장한다.
			var inputVal = $(this).val();
			//콘솔에서 확인하기
			console.log("입력", inputVal);
			
			if(inputVal.length>=8){
				//alert("정상");
				//패스워드가 8자 이상이면 검증처리한다.
				$('#confirm4').css({'color':'red', 'fontSize':'22px', 'fontWeigth':'bold'})
			}
			else{
				//8자 미만이면 초기상태로 스타일을 지정한다.
				$('#confirm4').css('color','gray').css('fontSize','20px')
					.css('fontWeigth','normal');
			}

			//대소문자 및 숫자를 체킹할 수 있는 변수 생성
			var strUpper=false, strLower=false, strNumber=false;
			
			//입력한 패스워드의 길이만큼 반복하여 모든 문자를 검사한다.
			for(var i=0 ; i<inputVal.length ; i++){
				//입력값의 아스키코드를 확인해본다.
				console.log("아스키코드값", inputVal[i].charCodeAt(0));
				
				//입력한 문자열 중에 아래조건에 맞는 문자가 하나라도 존재하면 true로 변경해준다.
				
				//대문자인지 확인
				if(inputVal[i].charCodeAt(0)>=65 && inputVal[i].charCodeAt(0)<=90){
					strUpper = true;	
				}
				//소문자인지 확인
				if(inputVal[i].charCodeAt(0)>=97 && inputVal[i].charCodeAt(0)<=122){
					strLower = true;
				}
				//숫자인지 확인
				if(inputVal[i].charCodeAt(0)>=48 && inputVal[i].charCodeAt(0)<=57){
					strNumber = true;
				}
			}
			
			//조건에 맞는 부분에 빨산색으로 변경해준다.
			//대문자 컨펌
			if(strUpper==true)
				$('#confirm1').css({'color':'red', 'fontSize':'22px', 'fontWeigth':'bold'})
			else
				$('#confirm1').css({'color':'gray', 'fontSize':'20px', 'fontWeigth':'normal'})
		
			//소문자 컨펌
			if(strLower==true)
				$('#confirm2').css({'color':'red', 'fontSize':'22px', 'fontWeigth':'bold'})
			else
				$('#confirm2').css({'color':'gray', 'fontSize':'20px', 'fontWeigth':'normal'})
			//숫자 컨펌
			if(strNumber==true)
				$('#confirm3').css({'color':'red', 'fontSize':'22px', 'fontWeigth':'bold'})
			else
				$('#confirm3').css({'color':'gray', 'fontSize':'20px', 'fontWeigth':'normal'})
		});
		
		//패스워드 확인을 입력한 후 키보드를 땠을때 검증한다.
		$('#passwd2').keyup(function(){
			//패스워드입력과 확인 부분의 입력된값을 가져온다.
			var p1 = $('#passwd1').val();
			var p2 = $(this).val();
			//2개의 값이 일치하는지 확인하여 텍스트를 출력한다.
	        if (p1 == p2) {
	        	$("#passConfirm").html("패스워드가 일치합니다.").css("color", "red");
	        }
	        else {
	            $("#passConfirm").html("패스워드가 다릅니다.").css("color", "black");
	        }
		});
	});
</script>
<style>
.confirmChar{
	color : gray; font-size: 20px; font-weight: normal;
}
</style>
</head>
<body>
	<h2>회원가입</h2>
	<form action="">
		아이디 : <input type="text" name="userid">
		<br>
		비밀번호 입력 : <input type="text" name="passwd1" id="passwd1">
		<div style="padding-left:20px;">
			<span id="confirm1" class="confirmChar">√</span>대문자 <br />
			<span id="confirm2" class="confirmChar">√</span>소문자 <br />
			<span id="confirm3" class="confirmChar">√</span>숫자 <br />
			<span id="confirm4" class="confirmChar">√</span>8자이상
		</div> 
		<br>
		비밀번호 확인 : <input type="text" name="passwd2" id="passwd2">
		<br>
		<div id="passConfirm"></div>
	</form>
</body>
</html>