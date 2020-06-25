<!-- 학원 메인 창 -->

<%@page import="alcinfo.AcademyBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="Amgr" class="alcinfo.AcademyMgr"></jsp:useBean>
<jsp:useBean id="Lmgr" class="alcinfo.LessonMgr"></jsp:useBean>
<%
	String pageValue = request.getParameter("pageValue");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>우리학원 어디?-학원</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css" />
<link rel="stylesheet" href="../alcinfo/cards-gallery.css">
<style>
@font-face 
{ font-family: 'Godo'; font-style: normal;
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
 font-family:'Godo';
 }

#total {
	width: 100%;
	background-color: #FAF8EB;
	margin-bottom: 50px;
}

#table {
	width: 70%;
}

#table td {
	text-align: center;
	width: 150px;
	height: 100px;
	background-color: #FAF8EB;
	border: none;
}

td a {
	color: black;
}

td a:hover {
	color: white;
	font-weight: bold;
}

#td:hover {
	background-color: #FCBC7E;
}
</style>

</head>
<body>
	<jsp:include page="../alcinfo/mainHeader.jsp"></jsp:include>
	<div id="total" align="center">
		<table id="table">
			<tr>
				<td id="td"><a href="AcademyMain.jsp?pageValue=top">TOP6</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=예능">예능</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=외국어">외국어</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=국제">국제</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=보통교과">보통 교과</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=종합">종합</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=인문사회">인문 사회</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=컴퓨터">컴퓨터</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=간호보조기술">간호
						보조 기술</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=특수교육">특수 교육</a></td>
			</tr>
			<tr>
				<td id="td"><a href="AcademyMain.jsp?pageValue=문화관광">문화 관광</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=경영.사무관리">경영/사무관리</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=기예">기예</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=기타">기타</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=산업응용기술">산업
						응용 기술</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=산업기반기술">산업
						기반 기술</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=산업서비스">산업
						서비스</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=일반서비스">일반
						서비스</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=진학지도">진학지도</a></td>
				<td id="td"><a href="AcademyMain.jsp?pageValue=독서실">독서실</a></td>
			</tr>
		</table>
	</div>
	<%
		if (pageValue.equals("top")) {
		
	%>
	<jsp:include page="AcademyTopList.jsp" />
	<%
		} else {
	%>
	<jsp:include page="AcademyList.jsp?pageValue=<%=pageValue%>"></jsp:include>
	<%
		}
	%>


	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
	<script>
		baguetteBox.run('.cards-gallery', {
			animation : 'slideIn'
		});
	</script>
	<jsp:include page="../alcinfo/footer.jsp"></jsp:include>
</body>
</html>