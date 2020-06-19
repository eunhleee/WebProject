<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,alcinfo.*"%>
<jsp:useBean id="mMgr" class="alcinfo.MemberMgr" />
<%	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
	MemberBean mBean = mMgr.getMember(id);
	int grade = mBean.getGrade();
	if(id == null) {
%>
	<script>
		alert("로그인 후 이용 가능합니다.");
		history.back();
	</script>
<%	} else {
		if(grade != 1) {
%>
<script>
	alert("학생만 이용 가능합니다.");
	history.back();
</script>
<%		}
	}
%>
<script type="text/javascript">
	function stregister() {
		if(document.stForm.stclass.value==""){
			alert("원하는 과목을 입력해 주세요.");
			document.stForm.stclass.focus();
			return;
		}
		if(document.stForm.stetc.value==""){
			alert("비고란을 입력해 주세요.");
			document.stForm.stetc.focus();
			return;
		}
		document.stForm.submit();
	}
</script>
<html>
<head>
<title>학생 등록하기</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="script.js"></script>
</head>
<body>
<br>
	<form name="stForm" method="post" action="stInsertProc.jsp">
		<table width="70%" align="center">
	<tr> 
	<td align="center">
		<table width="100%" border="1" style="font-size:20; background: rgb(250,248,235);"> 
		<tr> 
		<td width="25%" align="center">
		<img src="img/<%=mBean.getImgname() %>" width="250" height="250">
		</td>
		<td width="60%" height="100%">
			<table width="100%" border="1" >
				<tr height="40">
					<td width="30%">학생명 / 성별</td>
					<td width="70%"><%=mBean.getName()%> / <%=mBean.getGender() %></td>
				</tr>
				<tr height="40">
					<td width="30%">원하는지역</td>
					<td width="70%"><%=mBean.getAddress() %></td>
				</tr>
				<tr height="40">
					<td width="30%">전화번호</td>
					<td width="70%"><%=mBean.getPhone() %></td>
				</tr>
				<tr height="35">
					<td width="30%">원하는과목</td>
					<td width="70%"><input name="stclass" type="text" placeholder="원하는과목을 입력하시오." style="width:300; height:30;"></td>
				</tr>
				<tr height="40">
					<td width="30%">재학중인 학교 / 학년</td>
					<td width="70%"><%=mBean.getSchool_name() %> / <%=mBean.getSchool_grade() %></td>
				</tr>
				<tr height="40">
					<td width="30%">비고</td>
					<td width="70%"><input name="stetc" type="text" placeholder="비고란을 입력하시오." style="width:300; height:30;"></td>
				</tr>
				
			</table>
		</td>
		<td width="15%" align="center">
			<table>			
			<tr>
			<td>
				<input type="button" value="등록하기" onclick="javacript:stregister()">
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
