<!-- memberSelect.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<script>

function openmemberSelect() {
	document.getElementById("memberSelect").style.display = 'block';
}
function closememberSelect() {
	document.getElementById("memberSelect").style.display = 'none';
}
function mhref1() {
	document.getElementById("memberSelect").style.display = 'none';
	location.href="../login/insertMember1.jsp";
}
function mhref2() {
	document.getElementById("memberSelect").style.display = 'none';
	location.href="../login/insertMember2.jsp";
}

</script>
<link href="idpwdstyle.css" rel="stylesheet" type="text/css">
<div id="memberSelect" class="memberSelect">
	<button onclick="closememberSelect();">close</button>
	<form class="idpwd-content">
		<table>
			<tr>
				<td>
					<div class="loginleft">
						<p align="center">학생 회원가입</p>
						<hr class="idpwdhr">
						<input type="button" value="회원가입" class="loginb"
						onclick="javascript:mhref1()">
					</div>
				</td>
				<td>
					<div class="vline"></div>
				</td>
				<td>
					<div class="loginright">
						<p align="center">선생님 회원가입</p>
						<hr class="idpwdhr">
						<input type="button" value="회원가입" class="loginb"
						onclick="javascript:mhref2()">
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>