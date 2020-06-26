<!-- pwdChange.jsp -->
<%@ page language="java" 
    pageEncoding="UTF-8"%>
<jsp:useBean id="pcmgr" class="member.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
%>
<script>
	function closepwdChange() {
		document.getElementById("pwdChange").style.display = 'none';
	}
	
	function pcpwdCheck() {
		if(document.pcfrm.pcpwd.value != document.pcfrm.pcrepwd.value){
			alert("비밀번호가 일치하지 않습니다.");
			document.pcfrm.pcrepwd.value="";
			document.pcfrm.pcrepwd.focus();
			return;
		}
		document.pcfrm.submit();
	}
</script>
<link href="../login/idpwdstyle.css" rel="stylesheet" type="text/css">
<body>
<div id="pwdChange" class="pwdChange">
	<button onclick="closepwdChange();" id="btnExit"><img src="../img/exit.png" width="25" height="25"></button>
	<form class="idpwd-content" name="pcfrm" method="post" action="../login/pwdChangeProc.jsp">
		<table>
			<tr>
				<td colspan="3">
					<h3 style="margin-bottom:10px; color: #56C8D3;">Change Password</h3>
					<hr style="border:3px solid ligtgray;width:400px;">
				</td>
			</tr>
			<tr>
				<td>
					<table width="400px">
						<tr>
							<td width="140px" align="center">새 비밀번호</td>
							<td>
							<div id="inputdiv" style="width:200px;">
								<input type="password" style="width:180px;" name="pcpwd">
								</div>
							</td>
						</tr>
						<tr>
							<td width="140px" align="center">비밀번호 확인</td>
							<td>
							<div id="inputdiv" style="width:200px;">
								<input type="password" style="width:180px;" name="pcrepwd">
							</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr align="right">
				<td colspan="2">
					<input type="button" value="저장" class="loginb" onclick="pcpwdCheck();"
					style="margin-top:10px; margin-right:47px; width:100px;">
				</td>
			</tr>
		</table>
		<input type="hidden" name="pcid" value="<%=request.getParameter("psid")%>">
	</form>
</div>
</body>