<!--  고객센터 메인 화면 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String cust_page = request.getParameter("cust_page");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-고객센터</title>
<style>
#insertMember{
	float: right;
	margin-right:350px;
  	width: 800px;
  	border: 10px solid #F88C65; 
	border-radius:10px;
	padding:20px 40px;
	margin-top:50px;
}
#categoryframe{
	margin-left:280px;
	margin-right:80px;
	margin-top:50px;
	float:left;
	border:10px solid #FCBC7E;
	border-radius:15px;
	background-color:white;
	width:250px;
	height:300px;
	padding:30px 0px;
	background-color:#FAF8EB;
}
 
#list td {
	border-bottom: 1px solid lightgray;
	height:30px;
	
}

#title td {
	color: white;
	background-color: #F88C65;
}

a {
	text-decoration: none;
	color: black;
}

a:hover {
	color: gray;
}


 #atag {
 	margin-left:50px;
 	height:40px;
 	line-height:40px;
 	width:170px;
 	display: block;
 }
 
 
 #atag:hover{
 	background-color:white;
 	border-radius: 10px;
 }
</style>
</head>
<body>

	<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>

	<table width="70%" align="center">
		<tr>
		<!-- 카테고리 부분 -->
		<td style="vertical-align:top">
		<div id="categoryframe">
			<h3 style="margin-left:50px;">고객센터</h3>
			<div id="atag">
			<a href="custCenter.jsp?cust_page=ccBestBoard">&#149; 자주 묻는 질문</a>
			</div>
			<br> 
			<div id="atag">
			<a href="custCenter.jsp?cust_page=ccQuery">&#149; 질문하기</a>
			</div>
		</div>
		</td>

		<!-- 리스트 부분 -->
		<td>
		<div id="insertMember">
			<jsp:include page="ccBestBoard.jsp"></jsp:include>
		</div>
		</td>
		</tr>
	</table>
	<jsp:include page="../alcinfo/footer.jsp"></jsp:include>
</body>
</html>