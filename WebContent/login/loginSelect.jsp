<!-- loginSelect.jsp -->
<%@ page language="java" 
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
<style>
@font-face { 
font-family: 'Godo'; font-style: normal;
font-weight: 400;
src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff2') format('woff2'), 
	url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff') format('woff'); }
@font-face {
	font-family: 'Godo'; font-style: normal;
	font-weight: 700; 
 	src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff2') format('woff2'),
url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff') format('woff'); } 
 	.godo * { font-family: 'Godo', sans-serif; }
 body{
 	font-family:'Godo';}
.loginb{
	border:none;
	background-color:#56C8D3;
	border-radius:6px;
	color:white;
}
</style>
<link href="idpwdstyle.css" rel="stylesheet" type="text/css">
<div id="loginSelect" class="loginSelect">
	<button onclick="closeloginSelect();" id="btnExit"><img src="../img/exit.png" width="25" height="25"></button>
	
	<form class="idpwd-content">
		<table >
			<tr>
				<td colspan="3">
					<h3 style="margin-bottom:10px; color: #56C8D3;">LOGIN</h3>
					<hr style="border:3px solid ligtgray;width:400px;">
				</td>
			</tr>
			<tr>
				<td >
					<div class="loginleft">
						<p align="center">일반 회원이신가요?</p>
						<input type="button" value="로그인" class="loginb" 
						onclick="closeloginSelect(); openloginMain();">
					</div>
				</td>
				<td>
					<div class="vline" style="border:0.5px solid lightgray;"></div>
				</td> 
				<td>
					<div class="loginright">
						<p align="center">선생님이신가요?</p>
						<input type="button" value="로그인" class="loginb"
						onclick="closeloginSelect(); openloginMain();">
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>