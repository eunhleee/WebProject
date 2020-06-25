<!-- 학생 메인 창 -->
<%@page import="alcinfo.StudentBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
 	request.setCharacterEncoding("utf-8");
	String pageValue=request.getParameter("pageValue");
	String id = (String) session.getAttribute("idKey");
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>우리학원 어디?-학생</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css" />
<link rel="stylesheet" href="../alcinfo/cards-gallery.css">
<script>
 	function insertStudent(){
 		location.href="stInsert.jsp?id=<%=id%>"; // 등록할 페이지	
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
#total {
	width: 100%;
	background-color: #FAF8EB;
	margin-bottom: 50px;
}

#table {
	width: 70%;
}

#td {
	text-align: center;
	width: 150px;
	height: 100px;
	background-color: #FAF8EB;
	border: none;
}

#insert {
	text-align: center;
	width: 150px;
	height: 100px;
	background-color: #56C8D3;
	border: none;
}

#td a {
	color: black;
}

#insert a {
	color: white;
}

#td a:hover {
	color: white;
	font-weight: bold;
}

#insert a:hover {
	color: white;
	font-weight: bold;
}

#td:hover {
	background-color: #FCBC7E;
}

#insert:hover {
	background-color: #36ada9;
}
</style>
</head>
<body>
	<jsp:include page="../alcinfo/mainHeader.jsp"></jsp:include>

	<div id="total" align="center">
		<table id="table">
			<tr>
				<td id="td"><a href="StudentMain.jsp?pageValue=count">조회순</a></td>
				<td id="td"><a href="StudentMain.jsp?pageValue=국어">국어</a></td>
				<td id="td"><a href="StudentMain.jsp?pageValue=수학">수학</a></td>
				<td id="td"><a href="StudentMain.jsp?pageValue=사회">사회</a></td>
				<td id="td"><a href="StudentMain.jsp?pageValue=과학">과학</a></td>
				<td id="td"><a href="StudentMain.jsp?pageValue=영어">영어</a></td>
				<%if(id!=null) {%>
				<td id="insert"><a href="javascript:insertStudent();">등록</a></td>
				<%} %>
			</tr>
		</table>
	</div>
 
	<jsp:include page="StudentList.jsp?pageValue=<%=pageValue %>"></jsp:include>

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