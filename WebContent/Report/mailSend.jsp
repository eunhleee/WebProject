<%@ page contentType="text/html; charset=EUC-KR" %>
<html>
<head>
<title>JSP Email</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFFFCC">
<div align="center">
<br/><br/>
<table width="400"  cellpadding="3">
	<tr>
		<td bgcolor="#FF3412" height="25" align="center">비밀번호 찾기</td>
	</tr>
</table>
<br/>
<form name="postFrm" method="post" action="mailSendProc.jsp" >
<table width="400" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table align="center">
			<tr>
				<td width="10%">id</td>
				<td width="90%">
				<input name="id" size="10" maxlength="8"></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td>
				<input name="email" size="30" maxlength="30"></td>
			</tr>
			<tr>
				<td colspan="2"><hr/></td>
			</tr>
			<tr>
				<td colspan="2">
					 <input type="submit" value="SEND">
					 <input type="reset" value="다시쓰기">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>