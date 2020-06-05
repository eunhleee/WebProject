<!-- idSearch.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<script>
	function closeidSearch() {
		document.getElementById("idSearch").style.display = 'none';
	}
	window.onclick = function (event) {
	  if (event.target == idSearch) {
		  document.getElementById("idSearch").style.display = "none";
	  }
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
	<button onclick="closeidSearch();">close</button>
	<form class="idpwd-content" name="isfrm">
		<table>
			<tr>
				<td><p style="margin-bottom:10px;">아이디 찾기</p></td>
			</tr>
			<tr>
				<td>
					<table border="1" width="400px">
						<tr>
							<td width="140px" align="center">이름</td>
							<td width="260px">
								<input type="text" style="width:260px; height:30px;"
								name="isname">
							</td>
						</tr>
						<tr>
							<td width="140px" align="center">휴대폰 번호</td>
							<td width="260px">
								<input type="text" style="width:260px; height:30px;"
								name="isphone" maxlength="11">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<input type="button" value="로그인" class="loginb" style="margin-top:10px; width:100px;"
					onclick="closeidSearch(); openloginMain();">
					<input type="button" value="찾기" class="loginb" style="margin-top:10px; margin-left:194px; width:100px;" 
					onclick="idSearch(this.form.isname.value, this.form.isphone.value);">
				</td>
			</tr>
		</table>
	</form>
</div>