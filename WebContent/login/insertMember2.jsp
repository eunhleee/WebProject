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
</script>
</head>
<body>
<%@ include file="../alcinfo/mainHeader.jsp"%>
<div id="insertMember" class="insertMember1" align="center">
	<form name="imFrm" class="im-content" method="post" action="../login/memberProc2.jsp">
		<table style="margin-left:10px;">
			<tr>
				<td><p style="margin-bottom:10px;">선생님 회원가입</p></td>
			</tr>
			<tr>
				<td>
					<table border="1" class="insertMt">
						<tr>
							<td width="100px">&nbsp;아이디</td>
							<td width="230px">
								<input type="text" style="width:185px; height:30px;"
								maxlength="15" name="imid">
								<input type="button" style="width:70px; height:30px;"
								value="중복체크" onclick="idCheck();">
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;이름</td>
							<td width="260px">
								<input type="text" style="width:260px; height:30px;"
								name="imname">
							</td>
						</tr>
						<tr height="33px">
							<td width="100px">&nbsp;성별</td>
							<td width="260px">
								<input type="radio" name="imgender" value="남자" checked
								style="margin-left:5px;">남자
								<input type="radio" name="imgender" value="여자"
								style="margin-left:5px;">여자
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;비밀번호</td>
							<td width="260px">
								<input type="password" style="width:260px; height:30px;"
								maxlength="15" name="impwd">
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;비밀번호확인</td>
							<td width="260px">
								<input type="password" style="width:260px; height:30px;"
								maxlength="15" name="imrepwd">
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;닉네임</td>
							<td width="230px">
								<input type="text" style="width:185px; height:30px;"
								name="imnickname">
								<input type="button" style="width:70px; height:30px;" 
								value="중복체크" onclick="nickCheck();">
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;생년월일</td>
							<td width="260px">
								<input type="text" style="width:85px; height:32px;"
									placeholder="년(4자)" name="imbirthy" maxlength="4">
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
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;휴대폰번호</td>
							<td width="260px">
								<input type="text" style="width:260px; height:30px;"
								placeholder=" '-' 빼고 입력" maxlength="11" name="imphone">
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;이메일</td>
							<td width="260px">
								<input type="text" style="width:260px; height:30px;"
								name="imemail">
							</td>
						</tr>
						<tr>
							<td width="100px" height="66px">&nbsp;주소</td>
							<td width="260px">
								<input type="text" id="address" name="imaddress1"
								style="width:185px; height:30px;" readonly>
								<input type="button" style="width:70px; height:30px;"
								onClick="openDaumZipAddress();" value="주소찾기">
								<input type="text" style="width:260px; height:30px; margin-top:2px;"
								placeholder="기타 주소" name="imaddress2">
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;학교 구분</td>
							<td width="260px">
								<select name="imschoolgrade" style="width:260px; height:30px">
									<option value="학력 구분">학력 구분</option>
									<option value="재학중">재학중</option>
									<option value="졸업예정">졸업예정</option>
									<option value="졸업">졸업</option>
								</select>
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;학교 이름</td>
							<td width="260px">
								<input type="text" style="width:260px; height:30px;"
								name="imschoolname">
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;수업가능한 지역</td>
							<td width="260px">
								<input type="text" style="width:260px; height:30px;"
								name="imarea" placeholder="과외선생님만 입력해 주세요.">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><input type="button" value="가입신청" class="loginb"
				style="width:120px;" onclick="inputCheck();"></td>
			</tr>
		</table>
	</form>
</div>
<%@ include file="../alcinfo/footer.jsp"%>
</body>
</html>