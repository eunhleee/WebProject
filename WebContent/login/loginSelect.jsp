<!-- loginSelect.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<script>

function openloginSelect() {
	document.getElementById("loginSelect").style.display = 'block';
}
function closeloginSelect() {
	document.getElementById("loginSelect").style.display = 'none';
}

</script>
<link href="idpwdstyle.css" rel="stylesheet" type="text/css">
<div id="loginSelect" class="loginSelect">
	<button onclick="closeloginSelect();">close</button>
	<form class="idpwd-content">
		<table>
			<tr>
				<td>
					<div class="loginleft">
						<p align="center">일반 회원이신가요?</p>
						<hr class="idpwdhr">
						<input type="button" value="로그인" class="loginb" 
						onclick="closeloginSelect(); openloginMain();">
					</div>
				</td>
				<td>
					<div class="vline"></div>
				</td>
				<td>
					<div class="loginright">
						<p align="center">선생님이신가요?</p>
						<hr class="idpwdhr">
						<input type="button" value="로그인" class="loginb"
						onclick="closeloginSelect(); openloginMain();">
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>