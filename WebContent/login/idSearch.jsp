<!-- idSearch.jsp -->
<%@ page language="java" 
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<script>
	function closeidSearch() {
		document.getElementById("idSearch").style.display = 'none';
	}
	
	function idSearch(isname, isphone) {
		if(isname=="") {
			alert("이름을 입력하세요.");
			document.isfrm.isname.focus();
			return;
		}
		if(isphone=="") {
			alert("휴대폰 번호를 입력하세요.");
			document.isfrm.isphone.focus();
			return;
		}
		url = "../login/idSearchProc.jsp?isname="+isname+"&isphone="+isphone;
		window.open(url, "idSearchProc", "width=300, height=150, top=200, left=400");
	}
</script>

<link href="../login/idpwdstyle.css" rel="stylesheet" type="text/css">
<div id="idSearch" class="idSearch">
	<button onclick="closeidSearch();" id="btnExit"><img src="../img/exit.png" width="25" height="25"></button>
	<form class="idpwd-content" name="isfrm">
		<table width="400">
			<tr>
				<td colspan="3">
					<h3 style="margin-bottom:10px; color: #56C8D3;">Search ID</h3>
					<hr style="border:3px solid ligtgray;width:400px;">
				</td>
			</tr>
			<tr>
				<td>
					<table width="400px">
						<tr>
							<td width="140px" align="center">이름</td>
							<td >
								<div id="inputdiv" style="width:200px;">
								<input type="text" name="isname" style="width:180px;">
								</div>
							</td>
						</tr>
						<tr>
							<td width="140px" align="center">휴대폰 번호</td>
							<td >
								<div id="inputdiv" style="width:200px;">
								<input type="text" name="isphone" maxlength="11" style="width:180px;">
								</div>
							</td>
						</tr>
						<tr align="right" >
							<td colspan="2">
								<input type="button" value="로그인" class="loginb" style="margin-top:10px; width:100px;"
								onclick="closeidSearch(); openloginMain();">
	
								<input type="button" value="찾기" class="loginb" style="margin-top:10px; margin-right:47px; width:100px;" 
								onclick="idSearch(this.form.isname.value, this.form.isphone.value);">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			
		</table>
	</form>
</div>