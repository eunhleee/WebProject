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
	
</script>
<link href="../login/idpwdstyle.css" rel="stylesheet" type="text/css">
<div id="idpwdSearch" class="idpwdSearch">
	<button onclick="closeidpwdSearch()" id="btnExit"><img src="../img/exit.png" width="25" height="25"></button>	
	<form class="idpwd-content">
		<table>
			<tr>
				<td colspan="3">
					<h3 style="margin-bottom:10px; color: #56C8D3;">Search</h3>
					<hr style="border:3px solid ligtgray;width:400px;">
				</td>
			</tr>
			<tr>
				<td>
					<div class="loginleft">
						<p align="center">아이디 찾기</p>
						<input type="button" value="찾기" class="loginb" 
						onclick="closeidpwdSearch(); openidSearch();">
					</div>
				</td>
				<td>
					<div class="vline" style="border:0.5px solid lightgray;"></div>
				</td>
				<td>
					<div class="loginright">
						<p align="center">비밀번호 찾기</p>
						<input type="button" value="찾기" class="loginb"
						 onclick="closeidpwdSearch(); openpwdSearch();">
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>