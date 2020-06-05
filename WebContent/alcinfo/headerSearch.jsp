<!-- 헤더1 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
 	int random=(int)(Math.random()*10+1);
  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<link href="headerStyle.css" rel="stylesheet">
<script>
function btnmouseUp(){
	var button=document.getElementById("button");
	button.style.color="rgb(240,240,240)";
}
function btnmouseOut(){
	var button=document.getElementById("button");
	button.style.color="white";
}
function check() {
	if(document.searchFrm.keyWord.value==""){
		alert("검색어를 입력하세요.");
		document.searchFrm.keyWord.focus();
		location.href="SearchPage.jsp";
		return;
	}
	document.searchFrm.submit();
}
function openlogoutProc(){
	location.href="../login/logoutProc.jsp";
}

</script>
</head>
<body style="margin: 0px;">
<%@ include file="../login/loginSelect.jsp" %>
<%@ include file="../login/loginMain.jsp" %>
<%@ include file="../login/memberSelect.jsp" %>
<%@ include file="../login/idpwdSearch.jsp" %>
<%@ include file="../login/idSearch.jsp" %>
<%@ include file="../login/pwdSearch.jsp" %>
<%@ include file="../login/pwdChange.jsp" %>


	<div id="top" align="center">
		<span> ※과도한 사교육은 안좋아아아아아아아앙.&nbsp;&nbsp; <a
			href="custCenter.jsp?cust_page=ccBestBoard.jsp">고객센터</a>
		</span>

	</div>
	<div align="center">
		<form name="searchFrm" action="SearchPage.jsp">
			<table style="margin-top: 70px;">
				<tr>
					<td>
						<div>
							<a href="cards-gallery.jsp"><img src="img/home.png"
								width="80px" style="margin-right: 30px"></a>
						</div>
					</td>
					<td>
						<div id="searchTotal">
							<input id="search" type="text" name="keyWord"> <input
								id="button" type="submit" value="검색" onmouseover="btnmouseUp();"
								onmouseout="btnmouseOut();" onClick="javascript:check()">
						</div>
					</td>
				</tr>
			</table>
		</form>



		<div class="catagory" align="center"
			style="background-color: rgb(034, 200, 211);">
			<a href="AcademyMain.jsp?pageValue=top">학원</a> 
			<a	href="LessonMain.jsp?pageValue=top">과외선생님</a> 
			<a	href="StudentMain.jsp?pageValue=count">학생</a> 
			<a	href="communityList.jsp?pageValue=free">커뮤니티</a> 
			<% if(session.getAttribute("idKey")==null){%>
			<input type="button" onclick="openloginSelect();" class="openlm" value="로그인">
			<%}else{ %>
			<input type="button" onclick="openlogoutProc();" class="openlm" value="로그아웃">
			<a href="">마이페이지</a>
			<%} %>
		</div>
	</div>

	<div class="banner" align="center"
		style="width: 100%; background-color: rgb(240, 240, 240); box-shadow: 0px 0px 10px #c0c0c0;">
		<a href=""><img src="img/banner<%=random %>.jpg"
			style="width: 70%; height: 300px"></a>
	</div>
</body>
</html>