<!--  고객센터 메인 화면 -->
<%@page contentType="text/html; charset=utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String cust_page = request.getParameter("cust_page");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-고객센터</title>
</head>
<body>

	<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>

	<div style="display: flex; margin-left: 15%; margin-right: 15%">
		<!-- 카테고리 부분 -->

		<div
			style="width: 50px; text-align: left; flex: 1; border: 1px solid black; margin-right: 10%; padding: 40px 40px;">
			<h3>고객센터</h3>
			<a href="custCenter.jsp?cust_page=ccBestBoard.jsp">&#149; 자주 묻는
				질문</a><br>
			<br> <a href="">&#149; 질문하기</a>
		</div>

		<!-- 리스트 부분 -->
		<div
			style="width: 800px; flex: 2; border: 1px solid black; padding: 20px 20px;">
			<jsp:include page="ccBestBoard.jsp"></jsp:include>
		</div>
	</div>
	<jsp:include page="../alcinfo/footer.jsp"></jsp:include>
</body>
</html>