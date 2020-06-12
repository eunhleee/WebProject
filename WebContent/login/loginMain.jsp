<!-- loginMain.jsp -->
<%@ page language="java" 
    pageEncoding="UTF-8"%>
<%
		request.setCharacterEncoding("UTF-8");
%>
<script>
	function openloginMain() {
		document.getElementById("loginMain").style.display = 'block';
	}
	function closeloginMain() {
		document.getElementById("loginMain").style.display = 'none';
	}
	function openidpwdSearch() {
		document.getElementById("idpwdSearch").style.display = 'block';
	}
	window.onclick = function (event) {
	  if (event.target == loginMain) {
		  document.getElementById("loginMain").style.display = "none";
	  }
	}
	function loginCheck() {
		if (document.loginFrm.lid.value.trim() == "") {
			alert("아이디를 입력해 주세요.");
			document.loginFrm.lid.focus();
			return;
		}
		if (document.loginFrm.lpwd.value == "") {
			alert("비밀번호를 입력해 주세요.");
			document.loginFrm.lpwd.focus();
			return;
		}
		document.loginFrm.submit();
	}
</script>
<link href="../login/idpwdstyle.css" rel="stylesheet">
<div id="loginMain" class="loginMain1">
	<button onclick="closeloginMain();">close</button>
	<form class="idpwd-content" name="loginFrm" method="post" action="../login/loginProc.jsp">
		<table>
			<tr>
				<td><p style="margin-bottom:10px;">로그인</p></td>
			</tr>
			<tr>
				<td colspan="3">
					<table border="1" width="400px">
						<tr style="height:30px;">
							<td align="center">아이디</td>
							<td width="173px">
								<input type="text" class="idpwdtext" style="height:30px;"
								name="lid">
							</td>
							<td rowspan="2" align="center">
								<a onclick="loginCheck();">로그인</a>
							</td>
						</tr>
						<tr style="height:30px;">
							<td align="center">비밀번호</td>
							<td width="173px">
								<input type="password" class="idpwdtext" style="height:30px;"
								name="lpwd">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="130px"><input type="button" 
				onclick="closeloginMain(); openidpwdSearch();" value="ID/PW찾기"></td>
				<td><p style="margin-top:15px;">아직 회원이 아니신가요?</p></td>
				<td><a onclick="closeloginMain(); openmemberSelect();" class="im"><b>회원가입</b></a></td>
			</tr>
		</table>
	</form>
</div>