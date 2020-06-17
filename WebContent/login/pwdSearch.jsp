<!-- pwdSearch.jsp -->
<%@ page language="java"
    pageEncoding="UTF-8"%>
<jsp:useBean id="psmgr" class="member.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String pscheck = "", psid = "", psname = "", psphone = "";
%>
<script>
	function closepwdSearch() {
		document.getElementById("pwdSearch").style.display = 'none';
	}
	
	function pwdSearch() {
		if(document.psfrm1.psid.value.trim()=="") {
			alert("아이디를 입력하세요.");
			document.psfrm1.psid.focus();
			return;
		}
		if(document.psfrm1.psname.value.trim()=="") {
			alert("이름을 입력하세요.");
			document.psfrm1.psname.focus();
			return;
		}
		if(document.psfrm1.psphone.value.trim()=="") {
			alert("휴대폰 번호를 입력하세요.");
			document.psfrm1.psphone.focus();
			return;
		} else {
			document.psfrm2.pscheck.value="1";
			document.psfrm2.psid.value=document.psfrm1.psid.value;
			document.psfrm2.psname.value=document.psfrm1.psname.value;
			document.psfrm2.psphone.value=document.psfrm1.psphone.value;
			document.psfrm2.submit();
		}
	}
	function openpwdSearch1() {
		<% if(request.getParameter("pscheck")!=null) {
				psid = request.getParameter("psid");
				psname = request.getParameter("psname");
				psphone = request.getParameter("psphone");
				boolean result3 = psmgr.pwdSearch(psid, psname, psphone);
				if(result3) {
			%>
				alert("새로운 비밀번호로 변경하세요.");
				document.getElementById("pwdChange").style.display = 'block';
			<%  } else { %>
				alert("정보와 일치하지 않습니다.");
				document.getElementById("pwdSearch").style.display = 'block';
			<%  } %>
		<% } %>
	}
</script>
<link href="../login/idpwdstyle.css" rel="stylesheet" type="text/css">
<body onload="javascript:openpwdSearch1()">
<div id="pwdSearch" class="pwdSearch">
	<button onclick="closepwdSearch();" id="btnExit"><img src="../img/exit.png" width="25" height="25"></button>
	<form class="idpwd-content" name="psfrm1">
		<table>
			<tr>
				<td colspan="3">
					<h3 style="margin-bottom:10px; color: #56C8D3;">Search Password</h3>
					<hr style="border:3px solid ligtgray;width:400px;">
				</td>
			</tr>
			<tr>
				<td>
					<table width="400px">
						<tr>
							<td width="140px" align="center">아이디</td>
							<td >
							<div id="inputdiv" style="width:200px;">
								<input type="text" style="width:180px;" name="psid">
								</div>
							</td>
						</tr>
						<tr>
							<td width="140px" align="center">이름</td>
							<td >
							<div id="inputdiv" style="width:200px;">
								<input type="text" style="width:180px;" name="psname">
								</div>
							</td>
						</tr>
						<tr>
							<td width="140px" align="center">휴대폰 번호</td>
							<td width="260px">
							<div id="inputdiv" style="width:200px;">
								<input type="text" style="width:180px;"
								name="psphone">
								</div>
							</td>
						</tr>
						<tr  align="right">
							<td colspan="2"><input type="button" value="찾기" class="loginb" 
								style="margin-top:10px; margin-right:47px; width:100px;" onclick="pwdSearch();">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			
		</table>
	</form>
	<form name="psfrm2" method="post">
		<input type="hidden" name="pscheck" value="<%=pscheck%>">
		<input type="hidden" name="psid" value="<%=psid%>">
		<input type="hidden" name="psname" value="<%=psname%>">
		<input type="hidden" name="psphone" value="<%=psphone%>">
	</form>
</div>
</body>