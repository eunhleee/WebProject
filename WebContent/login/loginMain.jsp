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
<style>
#btnExit{
	border:none;
	background-color:white;
}

#inputdiv{
	margin:10px;
	width:150px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#inputdiv input{
	width:140px;
	border:none;
	font-size:15px;
}
#btnLogin{
  background:#56C8D3;
  color:#fff;
  border:none;
  position:relative;
  width:90px;
  height:70px;
  font-size:17px;
  line-height:70px;
  cursor:pointer;
  transition:800ms ease all;
  outline:none;
  border-radius: 6px;
}
#btnLogin:hover{
  background:#fff;
  color:#56C8D3;
}
#btnLogin:before,#btnLogin:after{
  content:'';
  position:absolute;
  top:0;
  right:0;
  height:2px;
  width:0;
  background: #56C8D3;
  transition:400ms ease all;
}
#btnLogin:after{
  right:inherit;
  top:inherit;
  left:0;
  bottom:0;
}
#btnLogin:hover:before,#btnLogin:hover:after{
  width:100%;
  transition:800ms ease all;
}
#btnSearch{
	border:none;
	background-color:white;
}
#btnSearch:hover{
	border-radius:6px;
	background-color:#36ada9;
	color:white;
}
.im:hover{
	
	border-radius:6px;
	background-color:#36ada9;
}
.im b:hover{
	color:white;
	font-weight:normal;
	text-decoration: none;
}
​

</style>
<link href="../login/idpwdstyle.css" rel="stylesheet">
<div id="loginMain" class="loginMain1">
	<button onclick="closeloginMain();" id="btnExit"><img src="../img/exit.png" width="25" height="25"></button>
	<form class="idpwd-content" name="loginFrm" method="post" action="../login/loginProc.jsp">
		<h3 style="margin-bottom:10px; color: #56C8D3;">LOGIN</h3>
			<hr>
		<table>	
			<tr>
				<td colspan="3">
					<table  width="400px">
						<tr style="height:30px;">
							<td align="center">아이디</td>
							<td width="173px">
							<div id="inputdiv">
								<input type="text" name="lid">
							</div>
							</td>
							<td rowspan="2" align="center">
								<button type="button" id="btnLogin" onclick="loginCheck();">로그인</button>
							</td>
						</tr>
						<tr style="height:30px;">
							<td align="center">비밀번호</td>
							<td width="173px">
							<div id="inputdiv">
								<input type="password" name="lpwd">
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><td><br></td></tr>
			<tr>
				<td width="130px"><input type="button" id="btnSearch"
				onclick="closeloginMain(); openidpwdSearch();" value="ID/PW찾기"></td>
				<td colspan="3" align="right"><span style="margin-top:15px; font-size:13px;">아직 회원이 아니신가요?</span>
				<a onclick="closeloginMain(); openmemberSelect();" class="im"><b>&nbsp;회원가입 &nbsp;</b></a></td>
			</tr>
		</table>
	</form>
</div>