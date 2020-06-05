function inputCheck(){
	if(document.imFrm.imid.value==""){
		alert("아이디를 입력해 주세요.");
		document.imFrm.imid.focus();
		return;
	}
	if(document.imFrm.imname.value==""){
		alert("이름을 입력해 주세요.");
		document.imFrm.imname.focus();
		return;
	}
	if(document.imFrm.imgender.value==""){
		alert("성별을 입력해 주세요.");
		document.imFrm.imgender.focus();
		return;
	}
	if(document.imFrm.impwd.value==""){
		alert("비밀번호를 입력해 주세요.");
		document.imFrm.impwd.focus();
		return;
	}
	if(document.imFrm.imrepwd.value==""){
		alert("비밀번호를 확인해 주세요");
		document.imFrm.imrepwd.focus();
		return;
	}
	if(document.imFrm.impwd.value != document.imFrm.imrepwd.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.imFrm.imrepwd.focus();
		return;
	}
	if(document.imFrm.imnickname.value==""){
		alert("닉네임을 입력해 주세요.");
		document.imFrm.imnickname.focus();
		return;
	}
	if(document.imFrm.imbirthy.value==""){
		alert("태어난 년도를 입력해 주세요.");
		document.imFrm.imbirthy.focus();
		return;
	}
	if(document.imFrm.imbirthm.value=="월"){
		alert("태어난 월을 입력해 주세요.");
		document.imFrm.imbirthm.focus();
		return;
	}
	if(document.imFrm.imbirthd.value=="일"){
		alert("태어난 일을 입력해 주세요.");
		document.imFrm.imbirthd.focus();
		return;
	}
	if(document.imFrm.imphone.value==""){
		alert("휴대폰 번호를 입력해 주세요.");
		document.imFrm.imphone.focus();
		return;
	}
	if(document.imFrm.imemail.value==""){
		alert("이메일을 입력해 주세요.");
		document.imFrm.imemail.focus();
		return;
	}
    var str=document.imFrm.imemail.value;	   
    var atPos = str.indexOf('@');
    var atLastPos = str.lastIndexOf('@');
    var dotPos = str.indexOf('.'); 
    var spacePos = str.indexOf(' ');
    var commaPos = str.indexOf(',');
    var eMailSize = str.length;
    if (atPos > 1 && atPos == atLastPos && 
	   dotPos > 3 && spacePos == -1 && commaPos == -1 
	   && atPos + 1 < dotPos && dotPos + 1 < eMailSize);
    else {
          alert('E-mail주소 형식이 잘못되었습니다.\n\r다시 입력해 주세요!');
	      document.imFrm.imemail.focus();
		  return;
    }
    if(document.imFrm.imaddress1.value==""){
		alert("주소를 검색해 주세요.");
		return;
	}
    if(document.imFrm.imaddress2.value==""){
    	alert("기타 주소를 입력해 주세요.");
    	document.imFrm.imaddress2.focus();
    	return;
    }
	if(document.imFrm.imschoolgrade.value=="학교 구분"){
		alert("학교 구분을 선택해 주세요.");
		document.imFrm.imschoolgrade.focus();
		return;
	}
	if(document.imFrm.imschoolname.value==""){
		alert("학교 이름을 입력해 주세요.");
		document.imFrm.imschoolname.focus();
		return;
	}
//	if(!result1 && !result2) {
//		document.idFrm.check.value="3";
		document.imFrm.submit();		
//	}
}
function win_close(){
	self.close();
}
