<!-- 신고접수 메인 화면 -->
<%@page contentType="text/html; charset=EUC-KR"%>
<%
	request.setCharacterEncoding("euc-kr");
	String re_page=request.getParameter("re_page");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>신고 접수</title>

</head>
<body>

	<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>

	<div style="display: flex; margin-left: 15%; margin-right: 15%">
		<!-- 카테고리 부분 -->

		<div
			style="width: 50px; text-align: left; flex: 1; border: 1px solid black; margin-right: 10%; padding: 40px 40px;">
			<h3>카테고리</h3>
			<a href="report.jsp?re_page=NewReport.jsp">&#149; 최근 신고글</a><br>
			<br> <a href="report.jsp?re_page=EndReport.jsp">&#149; 신고
				완료글</a><br>
			<br>
		</div>

		<!-- 리스트 부분 -->
		<div
			style="width: 800px; flex: 2; border: 1px solid black; padding: 20px 20px;">
			<jsp:include page="<%=re_page %>"></jsp:include>
		</div>
	</div>
	<jsp:include page="../alcinfo/footer.jsp"></jsp:include>
</body>
</html>