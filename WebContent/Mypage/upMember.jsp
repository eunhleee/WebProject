<!-- upMember.jsp -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="alcinfo.MemberBean"%>
<jsp:useBean id="mpmgr" class="alcinfo.MemberMgr"/>
<jsp:useBean id="mpbean" class="alcinfo.LeteaBean"/>
<jsp:setProperty property="*" name="mpbean"/>
<jsp:useBean id="mgr" class="alcinfo.MemberMgr"/>
    
<%
if(session.getAttribute("idKey")==null||session.getAttribute("idKey").equals("")){
	response.sendRedirect("cards-gallery.jsp");
	}
	else{
	String id=(String)session.getAttribute("idKey");
	MemberBean bean=mgr.getUpMember(id);

	int to=Integer.parseInt(bean.getBirth().substring(4,6)); 
	int to2=Integer.parseInt(bean.getBirth().substring(6,8));
	
	System.out.println("pic"+bean.getImgname());
%>
<html>
<head>
<link href="../login/idpwdstyle.css" rel="stylesheet" type="text/css">
<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
function inputCheck(){
	
	if(document.imFrm.imname.value==""){
		alert("이름을 입력하세요");
		document.imFrm.imname.focus();
		return;
	}
	if(document.imFrm.imgender.value==""){
		alert("성별을 입력하세요");
		document.imFrm.imgender.focus();
		return;
	}
	if(document.imFrm.impwd.value==""){
		alert("비밀번호를 입력하세요");
		document.imFrm.impwd.focus();
		return;
	}
	if(document.imFrm.imrepwd.value==""){
		alert("비밀번호를 한 번 더 입력해주세요");
		document.imFrm.imrepwd.focus();
		return;
	}
	if(document.imFrm.impwd.value != document.imFrm.imrepwd.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.imFrm.imrepwd.focus();
		return;
	}
	if(document.imFrm.imnickname.value==""){
		alert("닉네임을 입력하세요");
		document.imFrm.imnickname.focus();
		return;
	}
	if(document.imFrm.imbirthy.value==""){
		alert("태어난 년도를 입력하세요");
		document.imFrm.imbirthy.focus();
		return;
	}
	if(document.imFrm.imbirthm.value=="월"){
		alert("태어난 월을 선택하세요");
		document.imFrm.imbirthm.focus();
		return;
	}
	if(document.imFrm.imbirthd.value=="일"){
		alert("태어난 일을 선택하세요");
		document.imFrm.imbirthd.focus();
		return;
	}
	if(document.imFrm.imphone.value==""){
		alert("휴대폰 번호를 입력하세요");
		document.imFrm.imphone.focus();
		return;
	}
	if(document.imFrm.imemail.value==""){
		alert("이메일을 입력하세요");
		document.imFrm.imemail.focus();
		return;
	}	
	 var str=document.imFrm.imemail.value;
	 var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
     if(!reg_email.test(str)) { 
         alert('E-mail주소 형식을 잘 못 입력하셨습니다. 다시 입력하세요.');
          return;         
     }                            
      

    if(document.imFrm.imaddress1.value==""){
		alert("주소를 입력하세요");
		return;
	}
	if(document.imFrm.imschoolgrade.value=="학교 구분"){
		alert("학교 구분을 선택하세요.");
		document.imFrm.imschoolgrade.focus();
		return;
	}
	if(document.imFrm.imschoolname.value==""){
		alert("학교 이름을 선택하세요.");
		document.imFrm.imschoolname.focus();
		return;
	}
		document.imFrm.submit();		
}
function win_close(){
	self.close();
}

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

	function nickCheck() {
		if(document.imFrm.imnickname.value.trim()=="") {
			alert("닉네임을 입력하세요.");
			document.imFrm.imnickname.focus();
			return;
		}
		url = "../alcinfo/nickCheck.jsp?imnick="+document.imFrm.imnickname.value;
		window.open(url, "NICKCheck", "width=300, height=150, top=200, left=400");
	}

	function imgcheck(){
		url = "../alcinfo/ImgProc.jsp";
		window.open(url, "imggo", "width=500, height=500, top=200, left=200");
	}
</script>
</head>
<body>
<%@ include file="../alcinfo/mainHeader.jsp"%>
<div id="insertMember" class="insertMember1" align="center">
	<form name="imFrm" class="im-content" method="post" action="../alcinfo/upmemberProc.jsp">
		<table style="margin-left:10px;">
			<tr>
				<td><p style="margin-bottom:10px;">학생 정보수정</p></td>
			</tr>
		
			<tr>
				<td>
					<table border="1" class="insertMt">
						<tr>
				<td><img src="../img/<%=bean.getImgname()%>" width="380" height="300" margin-bottom="5px"><br/>
				<input type="button" onclick="imgcheck();" value="이미지수정"></td>
			</tr>
						<tr>
							<td width="100px">&nbsp;아이디</td>
							<td width="260px">
								<input type="text" style="width:260px; height:30px;"
								maxlength="15" name="imid" value="<%=bean.getId()%>" readonly>
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;이름</td>
							<td width="260px">
								<input type="text" style="width:260px; height:30px;"
								name="imname" value="<%=bean.getName()%>">
							</td>
						</tr>
						<tr height="33px">
							<td width="100px">&nbsp;성별</td>
							<td width="260px">
								<input type="radio" name="imgender" value="남자" 
								<%=bean.getGender().equals("남자")?"checked":""%> 
								style="margin-left:5px;">남자
								<input type="radio" name="imgender" value="여자"
								<%=bean.getGender().equals("여자")?"checked":""%> 
								style="margin-left:5px;">여자
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;비밀번호</td>
							<td width="260px">
								<input type="password" style="width:260px; height:30px;"
								maxlength="15" name="impwd" value="<%=bean.getPasswd()%>">
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
								name="imnickname" value="<%=bean.getNickname()%>">
								<input type="button" style="width:70px; height:30px;" 
								value="중복체크" onclick="nickCheck();">
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;생년월일</td>
							<td width="260px">
							
								<input type="text" style="width:85px; height:32px;"
									placeholder="년(4자)" name="imbirthy" maxlength="4" 
									value="<%=bean.getBirth().substring(0,4)%>">
							  
								<select name="imbirthm" style="width:82px; height:32px">
									<option value="월">월</option>									
									<% for(int i=1; i<=12; i++) { 
										if(i==to){
											%>
											<option value="<%=i%>" selected><%=i%></option>
										<%	
										i++;
										}
										if( i<10) {
									%>	
										<option value="0<%=i%>"><%=i%></option>
									<%	
										} else {
									%>
										<option value="<%=i%>"><%=i%></option>
									<% 	} %>	
									<% } %>
								</select>
								<select name="imbirthd" style="width:82px; height:32px">
									<option value="일" selected>일</option>
									<% for(int i=1; i<32; i++) { 
										if(i==to2){
											%>
											<option value="<%=i%>" selected><%=i%></option>
										<%	
										i++;
										}
										if(i<10) {
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
								placeholder="  숫자만 입력해주세요" maxlength="11" name="imphone"
								value="<%=bean.getPhone()%>">
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;이메일</td>
							<td width="260px">
								<input type="text" style="width:260px; height:30px;"
								name="imemail" value="<%=bean.getEmail()%>">
							</td>
						</tr>
						<tr>
							<td width="100px" height="66px">&nbsp;주소</td>
							<td width="260px">
								<input type="text" id="address" name="imaddress1"
								value="<%=bean.getAddress()%>"
								style="width:185px; height:30px;" readonly >
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
									<option value="학교 구분">학교 구분</option>
									<option value="초등학생" 
									<%=bean.getSchool_grade().equals("초등학생")?"selected":""%>>초등학생</option>
									<option value="중학생" 
									<%=bean.getSchool_grade().equals("중학생")?"selected":""%>>중학생</option>
									<option value="고등학생" 
									<%=bean.getSchool_grade().equals("고등학생")?"selected":""%>>고등학생</option>
									<option value="기타" 
									<%=bean.getSchool_grade().equals("기타")?"selected":""%>>기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<td width="100px">&nbsp;학교 이름</td>
							<td width="260px">
								<input type="text" style="width:260px; height:30px;"
								name="imschoolname" value="<%=bean.getSchool_name()%>">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right"><input type=button value="회원수정" class="loginb"
				style="width:120px;" onclick="inputCheck();"></td>
			</tr>
		</table>
	</form>
	<%} %>
</div>

<%@ include file="../alcinfo/footer.jsp"%>
</body>
</html>