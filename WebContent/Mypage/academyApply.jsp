<!-- academyApply.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="aMgr" class="alcinfo.AcademyMgr"/>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function setChildValue(name,num){
    document.getElementById("num").value = num;
    document.getElementById("name").value = name;
}

function goAclist() {
	url = "../Mypage/acSearch.jsp";
	window.open(url, "GoReport", "width=580, height=460, top=200, left=300");
}
</script>
<meta charset="UTF-8">
<title>학원장 신청(권한변경)</title>
</head>
<body>
<form method="post" action="acApplyProc.jsp?flag=insert" enctype="multipart/form-data">
<table>
	<tr>
		<td colspan="3"><h3>권한변경</h3></td>
	</tr>	
	<tr>
		<td>학원검색</td>
		<td><input type="text" name="num" id="num" readonly="readonly"></td>
		<td><input type="text" name="name" id="name" readonly="readonly"></td>
		<td><input type="button" onclick="goAclist();" value="검색"></td>
	</tr>
	<tr> 
		<td align="center">신분증</td>
		<td><input type="file" name="identity"></td>
	</tr>
	<tr> 
		<td align="center">사업자 파일</td>
		<td><input type="file" name="business"></td>
	</tr>
	<tr>
		<td colspan="3" align="right">
		<input type="submit" value="접수" onclick="send()">
		</td>ㅈ
	</tr>
</table>
</form>
</body>
</html>