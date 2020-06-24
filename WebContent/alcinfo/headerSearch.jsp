<!-- 헤더1 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="HeaderMmgr" class="member.MemberMgr"></jsp:useBean>
<%
	
 	int random=(int)(Math.random()*10+1);
	String loginid=(String)session.getAttribute("idKey");

	String loginNickname=HeaderMmgr.getInfo(loginid).getNickname();
	
	
  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="../alcinfo/banner.js"></script>
<link href="../alcinfo/headerStyle.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
		<span> ※과도한 사교육은 올바른 교육이 아닙니다.&nbsp;&nbsp; <a
			href="../CS/custCenter.jsp?cust_page=ccBestBoard">고객센터</a>
		</span>

	</div>
	<div align="center">
		<form name="searchFrm" action="../alcinfo/SearchPage.jsp">
			<table style="margin-top: 70px;">
				<tr>
					<td>
						<div>
							<a href="../alcinfo/cards-gallery.jsp"><img src="../img/home.png"
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
		style="background-color: rgb(034, 200, 211); border-radius: 0px; box-shadow: 0px 0px 10px #c0c0c0; height:75px;
			line-height:75px; text-align: center; margin-top:35px;">
			<a href="../Academy/AcademyMain.jsp?pageValue=top">학원</a> 
			<a	href="../Lesson/LessonMain.jsp?pageValue=top">과외선생님</a> 
			<a	href="../Student/StudentMain.jsp?pageValue=count">학생</a> 
			<a	href="../Community/communityList.jsp?pageValue=free">커뮤니티</a> 
			<a	href="../Payment/buyPoint.jsp" style="color:yellow;"><img src="../img/won.png" width="20" height="20">포인트</a>
			<% if(loginid==null){%>
			<input type="button" onclick="openloginMain();" class="openlm" value="로그인">
			<%}else{ %>
			<input type="button" onclick="openlogoutProc();" class="openlm" value="로그아웃">

			<% if((Integer)session.getAttribute("idgrade")==0){%>
			<a href="../Mypage/managerPage.jsp?pageValue=salesList">관리자페이지</a>
			<%}else{
			if((Integer)session.getAttribute("idgrade")==1){%>
			<a href="../Mypage/upMember.jsp">마이페이지</a>
			<%}else if((Integer)session.getAttribute("idgrade")==2||(Integer)session.getAttribute("idgrade")==3){ %>
			<a href="../Mypage/upTeacher.jsp">마이페이지</a>
			<%		}
				}
			} %>
		</div>
	</div>

	<div id="slider">
	
		<ul class="slides">
			<li class="slide slide5"><img src="../img/banner5.jpg"></li>
			<li class="slide slide1"><img src="../img/banner1.jpg"></li>
			<li class="slide slide2"><img src="../img/banner2.jpg"></li>
			<li class="slide slide3"><img src="../img/banner3.jpg"></li>
			<li class="slide slide4"><img src="../img/banner4.jpg"></li>
			<li class="slide slide5"><img src="../img/banner5.jpg"></li>
			<li class="slide slide1"><img src="../img/banner1.jpg"></li>
		</ul>
	
		<div id="slider-nav">
			<div id="slider-nav-prv">&#10094;</div>
			<div id="slider-nav-nxt">&#10095;</div>
			<div id="slider-nav-dot-con">
				<span class="slider-nav-dot" style="background:white" id="nav-dot1"></span>
				<span class="slider-nav-dot" id="nav-dot2"></span>
				<span class="slider-nav-dot" id="nav-dot3"></span>
				<span class="slider-nav-dot" id="nav-dot4"></span>
				<span class="slider-nav-dot" id="nav-dot5"></span>
			</div>
		</div>
	
	</div>
	
</body>
</html>