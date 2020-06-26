<!-- insertMember.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<link href="../login/idpwdstyle.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../login/script.js"></script>
<script type="text/JavaScript" src="http://code.jquery.com/jquery-1.7.min.js"></script>
<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	function openDaumZipAddress() {
		new daum.Postcode({
			oncomplete:function(data) {
				jQuery("#postcode1").val(data.postcode1);
				jQuery("#postcode2").val(data.postcode2);
				jQuery("#zonecode").val(data.zonecode);
				jQuery("#address").val(data.address);
				jQuery("#address_etc").focus();
				console.log(data);
			}
		}).open();
	}
	function idCheck() {
		if(document.imFrm.imid.value.trim()=="") {
			alert("아이디를 입력하세요.");
			document.imFrm.imid.focus();
			return;
		}
		url = "../login/idCheck.jsp?imid="+document.imFrm.imid.value;
		window.open(url, "IDCheck", "width=300, height=150, top=200, left=400");
	}
	function nickCheck() {
		if(document.imFrm.imnickname.value.trim()=="") {
			alert("닉네임을 입력하세요.");
			document.imFrm.imnickname.focus();
			return;
		}
		url = "../login/nickCheck.jsp?imnick="+document.imFrm.imnickname.value;
		window.open(url, "NICKCheck", "width=300, height=150, top=200, left=400");
	}
	function checkNum(e) {
	    var keyVal = event.keyCode;
    	if(((keyVal >= 48) && (keyVal <= 57))){
        	return true;
    	}
   		else{
        	alert("숫자만 입력가능합니다");
        return false;
    	}
	}
</script>
<style>
@font-face { 
font-family: 'Godo'; font-style: normal;
font-weight: 400;
src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff2') format('woff2'), 
	url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff') format('woff'); }
@font-face {
	font-family: 'Godo'; font-style: normal;
	font-weight: 700; 
 	src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff2') format('woff2'),
url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff') format('woff'); } 
 	.godo * { font-family: 'Godo', sans-serif; }
 body{
 	font-family:'Godo';}
#insertMember{
	background-color:#FAF8EB;
	width:100%;
	height:100%;
	padding:30px;
}
#inputdiv{
	background-color:white;
}
#btnJoin{
  background:#FCBC7E;
  color:#fff;
  border:none;
  position:relative;
  width:90px;
  height:50px;
  font-size:17px;
  line-height:50px;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  border-radius: 6px;
}
#btnJoin:hover{
  background:#fff;
  color:#FCBC7E;
}
#btnJoin:before,#btnJoin:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background:#FCBC7E;
  transition:400ms ease all;
}
#btnJoin:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
#btnJoin:hover:before,#btnJoin:hover:after{
  width:100%;
  transition:800ms ease all;
}


</style>
</head>
<body>
<%@ include file="../alcinfo/headerSearch.jsp"%>
<div id="insertMember" class="insertMember1" align="center">
	<form name="imFrm" class="im-content" method="post" action="../login/memberProc.jsp">
		<table style="margin-left:10px;">
			<tr>
				<td colspan="3">
					<h2 style="margin-bottom:10px;">회원가입</h2>
				</td>
			</tr>
			<tr>
				<td>
					<table  class="insertMt">
						<tr>
							<td width="100px">&nbsp;아이디</td>
							<td width="270px">
								<div id="inputdiv" style="width:270px;">
								<input type="text" style="width:180px; height:30px;"
								maxlength="15" name="imid">
								<input type="button" style="width:70px; height:30px;"
								value="중복체크" onclick="idCheck();">
								</div>
							</td>
						<tr>
							<td >&nbsp;이름</td>
							<td >
								<div id="inputdiv" style="width:270px;">
								<input type="text" style="width:260px; height:30px;" name="imname">
								</div>
							</td>
						</tr>
						<tr height="33px">
							<td >&nbsp;성별</td>
							<td >
								<input type="radio" name="imgender" value="남자" checked style="margin-left:5px;">남자
								<input type="radio" name="imgender" value="여자"	style="margin-left:5px;">여자
							</td>
						</tr>
						<tr>
							<td >&nbsp;비밀번호</td>
							<td >
								<div id="inputdiv" style="width:270px;">
									<input type="password" style="width:260px; height:30px;" maxlength="15" name="impwd">
								</div>
							</td>
						</tr>
						<tr>
							<td >&nbsp;비밀번호확인</td>
							<td >
								<div id="inputdiv" style="width:270px;">
									<input type="password" style="width:260px; height:30px;" maxlength="15" name="imrepwd">
								</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;닉네임</td>
							<td >
								<div id="inputdiv" style="width:270px;">
									<input type="text" style="width:185px; height:30px;" name="imnickname">
									<input type="button" style="width:70px; height:30px;" value="중복체크" onclick="nickCheck();">
								</div>
							</td>
						</tr>
						<tr>
							<td >&nbsp;생년월일</td>
							<td >
							<div id="inputdiv" style="width:270px;">
								<input type="text" style="width:85px; height:32px;" placeholder="년(4자)" name="imbirthy" maxlength="4">
								<select name="imbirthm" style="width:82px; height:32px">
									<option value="월" selected>월</option>
									<% for(int i=1; i<13; i++) { 
										if(i>0 && i<10) {
									%>
										<option value="0<%=i%>"><%=i%></option>
									<%	
										} else {
									%>
										<option value="<%=i%>"><%=i%></option>
									<%  } %>
										
									<% } %>
								</select>
								<select name="imbirthd" style="width:82px; height:32px">
									<option value="일" selected>일</option>
									<% for(int i=1; i<32; i++) { 
										if(i>0 && i<10) {
									%>
										<option value="0<%=i%>"><%=i%></option>
									<%	
										} else {
									%>
										<option value="<%=i%>"><%=i%></option>
									<%  } %>
										
									<% } %>
								</select>
								</div>
							</td>
						</tr>
						<tr>
							<td >&nbsp;휴대폰번호</td>
							<td >
								<div id="inputdiv" style="width:270px;">
									<input type="text" style="width:260px; height:30px;" onKeyPress="return checkNum(event)" placeholder=" '-' 빼고 입력" maxlength="11" name="imphone">
								</div>
							</td>
						</tr>
						<tr>
							<td>&nbsp;이메일</td>
							<td>
								<div id="inputdiv" style="width:270px;">
									<input type="text" style="width:260px; height:30px;" name="imemail">
								</div>
							</td>
						</tr>
						<tr>
							<td height="66px">&nbsp;주소</td>
							<td>
								<div id="inputdiv" style="width:270px;">
									<input type="text" id="address" name="imaddress1" style="width:185px; height:30px;" readonly>
									<input type="button" style="width:70px; height:30px;" onClick="openDaumZipAddress();" value="주소찾기">
								</div>
								<div id="inputdiv" style="width:270px;">
									<input type="text" style="width:260px; height:30px; margin-top:2px;" placeholder="기타 주소" name="imaddress2">
								</div>
							</td>
						</tr>
						<tr>
							<td >&nbsp;학교 구분</td>
							<td >
								<div id="inputdiv" style="width:270px;">
								<select name="imschoolgrade" style="width:260px; height:30px; border:none;">
									<option value="학교 구분">학교 구분</option>
									<option value="초등학생">초등학생</option>
									<option value="중학생">중학생</option>
									<option value="고등학생">고등학생</option>
									<option value="기타">기타</option>
								</select>
								</div>
							</td>
						</tr>
						<tr>
							<td >&nbsp;학교 이름</td>
							<td >
								<div id="inputdiv" style="width:270px;">
									<input type="text" style="width:260px; height:30px;" name="imschoolname">
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><button type="button" id="btnJoin"  onclick="inputCheck();">가입 신청</button></td>
			</tr>
		</table>
	</form>
</div>
<%@ include file="../alcinfo/footer.jsp"%>
</body>
</html>