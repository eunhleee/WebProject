<!-- idpwdSearch.jsp -->
<%@ page language="java" 
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<script>
	function closeidpwdSearch() {
		document.getElementById("idpwdSearch").style.display = 'none';
	}
	function openidSearch() {
		document.getElementById("idSearch").style.display = 'block';
	}
	function openpwdSearch() {
		document.getElementById("pwdSearch").style.display = 'block';
	}
	window.onclick = function (event) {
	  if (event.target == idpwdSearch) {
		  document.getElementById("idpwdSearch").style.display = "none";
	  }
	}
</script>
<link href="../login/idpwdstyle.css" rel="stylesheet" type="text/css">
<div id="idpwdSearch" class="idpwdSearch">
	<button onclick="closeidpwdSearch();">close</button>
	<form class="idpwd-content">
		<table>
			<tr>
				<td>
					<div class="loginleft">
						<p align="center">아이디 찾기</p>
						<hr class="idpwdhr">
						<input type="button" value="찾기" class="loginb" 
						onclick="closeidpwdSearch(); openidSearch();">
					</div>
				</td>
				<td>
					<div class="vline"></div>
				</td>
				<td>
					<div class="loginright">
						<p align="center">비밀번호 찾기</p>
						<hr class="idpwdhr">
						<input type="button" value="찾기" class="loginb"
						 onclick="closeidpwdSearch(); openpwdSearch();">
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>