<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,alcinfo.*"%>
<jsp:useBean id="leMgr" class="alcinfo.LeteaMgr" />
<%	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	LeteaBean leBean = leMgr.getLetea(id);
	int grade = leBean.getGrade();
	if(id==null){
%>
	<script>
		alert("로그인을 해주세요.");
		history.back();
	</script>
<%	} else {
		if(grade != 2) {
%>
<script>
	alert("선생님만 이용 가능합니다.");
	history.back();
</script>
<%
	}
}
%>
<script type="text/javascript">
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
	function leregister() {
	 	if(document.leForm.lestudent.value=="") {
			alert("과외중인 학생 수를 입력해 주세요.");
			document.leForm.lestudent.focus();
			return;
		}
		if(document.leForm.leetc.value=="") {
			alert("비고란을 입력해 주세요.");
			document.leForm.leetc.focus();
			return;
		}
		document.leForm.submit();
	}
	
</script>

<html>
<head>
<title>선생님 등록하기</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="script.js"></script>
</head>
<%@ include file="../alcinfo/headerSearch.jsp" %>
<body>
<br>
	<form name="leForm" method="post" action="leInsertProc.jsp">
		<table width="70%" align="center">
	<tr> 
	<td align="center">
		<table width="100%" border="1" style="font-size:20; background: rgb(250,248,235);"> 
		<tr> 
		<td width="25%" align="center">
		<img src="img/<%=leBean.getImgname() %>" width="250" height="250">
		</td>
		<td width="60%" height="100%">
			<table width="100%" border="1" >
				<tr height="40">
					<td width="30%">선생님명 / 성별</td>
					<td width="70%"><%=leBean.getName()%> / <%=leBean.getGender() %></td>
				</tr>
				<tr height="40">
					<td width="30%">과외가능지역</td>
					<td width="70%"><%=leBean.getAddress() %></td>
				</tr>
				<tr height="40">
					<td width="30%">전화번호</td>
					<td width="70%"><%=leBean.getPhone() %></td>
				</tr>
					<tr height="35">
					<td width="30%">과외 가능한 과목</td>
					<td width="70%"><%=leBean.getLeclass() %></td>
				</tr>
				<tr height="35">
					<td width="30%">과외중인 학생 수</td>
					<td width="70%"><input name="lestudent" type="text" onKeyPress="return checkNum(event)" placeholder="과외중인 학생 수를 입력하시오.(없으면 0명)" style="width:300; height:30;"></td>
				</tr>
				<tr height="40">
					<td width="30%">재학(졸업)중인 학교</td>
					<td width="70%"><%=leBean.getSchool_name() %></td>
				</tr>
				<tr height="40">
					<td width="30%">비고</td>
					<td width="70%"><input name="leetc" type="text" placeholder="비고란을 입력하시오." style="width:300; height:30;"></td>
				</tr>
			</table>
		</td>
		<td width="15%" align="center">
			<table>			
			<tr>
			<td>
				<input type="button" value="등록하기" onclick="javacript:leregister()">
			</td>
			</tr>
			</table>				
		</td>
		</tr>
		</table>
	</td>
	</tr>
</table>
<br>
<input type="hidden" name="id" value="<%=id%>">

</form>
</body>
<%@ include file="../alcinfo/footer.jsp" %>
</html>
