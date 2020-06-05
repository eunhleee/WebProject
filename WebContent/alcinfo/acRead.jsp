<!-- acRead.jsp -->
<!-- 학원 정보창 -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.AcademyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.AcademyMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	int num = 0;
	String url = "AcademyMain.jsp";
	AcademyBean bean = null;
	if (request.getParameter("num") == null) {
		response.sendRedirect(url);
	} else if (!UtilMgr.isNumeric(request.getParameter("num"))) {
		response.sendRedirect(url);
	} else {
		num = Integer.parseInt(request.getParameter("num"));
		bean = mgr.getAcademy(num);
		session.setAttribute("bean", bean);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team Read</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
		function moveQnA(){
			url = "ac_QnA.jsp?ac_num="+<%=num%>;
			window.open(url, "Ac_QnA", "width=800, height=500, top=200, left=400");
			
		}
</script>
</head>
<body>
	<%@ include file="headerSearch.jsp"%>
	<br>
	<br>
	<form method="post" action="reportReceipt.jsp">
		<table width="70%" align="center">
			<tr>
				<td align="center">
					<table width="100%" border="1"
						style="font-size: 20; background: rgb(250, 248, 235);">
						<tr>
							<td width="25%" align="center"><img src="img/banner1.jpg"
								width="100%" height="250"></td>
							<td width="60%" height="100%">
								<table width="100%" border="1" style="font-size: 20;">
									<tr height="50">
										<td width="30%">학원명</td>
										<td width="70%"><%=bean.getAc_name()%></td>
									</tr>
									<tr height="50">
										<td width="30%">교습계열</td>
										<td width="70%"><%=bean.getGroup1()%></td>
									</tr>
									<tr height="50">
										<td width="30%">교습과정</td>
										<td width="70%"><%=bean.getGroup2()%></td>
									</tr>
									<tr height="50">
										<td width="30%">학원주소</td>
										<td width="100%"><a href=""
											style="color: black; text-decoration: none;"><%=bean.getAc_address()%></a></td>
									</tr>
									<tr height="50">
										<td width="30%">전화번호</td>
										<td width="70%"><%=bean.getAc_tel()%></td>
									</tr>
								</table>
							</td>
							<td width="15%" align="center">
								<table>
									<tr>
										<td><input type="button" value="문의하기"
											style="font-size: 20;" onclick="moveQnA();"></td>
									</tr>
									<tr>
										<td><input type="submit" value="잘못된정보 신고하기"
											style="font-size: 20;"></td>
											
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		<br>
		<table width="70%" height="300" align="center" border="1">
			<tr>
				<td width="30%" align="center"><jsp:include page="mapJsp.jsp">
						<jsp:param value="<%=bean.getAc_address()%>" name="address" />
					</jsp:include></td>
				<td width="70%" align="center">
					<jsp:include page="academyAskList.jsp"></jsp:include>
				</td>
			</tr>
		</table>
		<br>
	</form>
</body>
<%@ include file="footer.jsp"%>
</html>
<%
	}
%>