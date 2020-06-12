<!-- pwdChange.jsp -->
<%@ page language="java" 
    pageEncoding="UTF-8"%>
<jsp:useBean id="pcmgr" class="member.MemberMgr"/>
<%
	request.setCharacterEncoding("EUC-KR");
%>
<script>
	function closepwdChange() {
		document.getElementById("pwdChange").style.display = 'none';
	}
	window.onclick = function (event) {
	  if (event.target == pwdChange) {
		  document.getElementById("pwdChange").style.display = "none";
	  }
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
	<button onclick="closepwdChange();">close</button>
	<form class="idpwd-content" name="pcfrm" method="post" action="../login/pwdChangeProc.jsp">
		<table>
			<tr>
				<td><p style="margin-bottom:10px;">비밀번호 변경</p></td>
			</tr>
			<tr>
				<td>
					<table border="1" width="400px">
						<tr>
							<td width="140px" align="center">새 비밀번호</td>
							<td width="260px">
								<input type="password" style="width:260px; height:30px;"
								name="pcpwd">
							</td>
						</tr>
						<tr>
							<td width="140px" align="center">비밀번호 확인</td>
							<td width="260px">
								<input type="password" style="width:260px; height:30px;"
								name="pcrepwd">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<input type="button" value="저장" class="loginb" onclick="pcpwdCheck();">
				</td>
			</tr>
		</table>
		<input type="hidden" name="pcid" value="<%=request.getParameter("psid")%>">
	</form>
</div>
</body>