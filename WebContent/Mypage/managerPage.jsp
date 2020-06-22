<%@ page contentType="text/html; charset=utf-8"%>
<%
		request.setCharacterEncoding("utf-8");
		String pageValue=request.getParameter("pageValue");
%>
<html>
<head>
<style>

#nav_table tr {
	border:5px solid #56C8D3;
}

#nav_td {
	text-align: center;
	width:330px;
	height: 100px;
	border: none;
	
}

#nav_td a {
	color: black;
	text-decoration: none;
}

#nav_td a:hover {
	color: white;
	font-weight: bold;
}

#nav_td:hover {
	background-color: #56C8D3;
}
</style>
</head>
<body>
<jsp:include page="../alcinfo/headerSearch.jsp" />
	<div id="frame">
		<div id="container">
			<div id="total" align="center">
				<table id="nav_table">
					<tr>
						<td id="nav_td"><a href="../Mypage/managerPage.jsp?pageValue=salesList">매출 현황</a></td>
						<td id="nav_td"><a href="../Mypage/managerPage.jsp?pageValue=memberChart">회원 현황</a></td>
						<td id="nav_td"><a href="../Mypage/managerPage.jsp?pageValue=reportList">신고 접수건</a></td>
						<td id="nav_td"><a href="../Mypage/managerPage.jsp?pageValue=memberControl">회원 관리</a></td>
					</tr>
				</table>
			</div>
			<!--nav-->
			<div>
				<% if(pageValue.equals("salseList")){ %>
					<jsp:include page="../Mypage/salesList.jsp"></jsp:include>
				<%} else if(pageValue.equals("memberChart")){%>
					<%-- <jsp:include page="../Mypage/memberChart.jsp"></jsp:include> --%>
				<%} else if(pageValue.equals("reportList")){%>
					<jsp:include page="../Report/MGMemberControl.jsp"></jsp:include>
				<%} else if(pageValue.equals("memberControl")){%>
					<jsp:include page="../Report/StateManagement.jsp"></jsp:include>
				<%} %>
			</div>
		</div>
	</div>
</body>
</html>