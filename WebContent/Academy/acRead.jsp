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
	String id=(String) session.getAttribute("idKey"); //로그인 여부 확인
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
			window.open(url, "Ac_QnA", "width=900, height=500, top=200, left=400");
			
		}
		function goReport() {
			url = "../Report/reportReceiptAInf.jsp?stopid=<%=num%>";
			window.open(url, "GoReport", "width=400, height=350, top=200, left=300");
		}
</script>
</head>
<body>
	<%@ include file="../alcinfo/headerSearch.jsp"%>
	<br>
	<br>
		<table width="70%" align="center">
			<tr>
				<td align="center">
					<table width="100%" style="font-size: 20; background: rgb(250, 248, 235);">
						<tr>
							<td width="25%" align="center">
							<img src="../img/banner1.jpg" width="100%" height="250">
							</td>
							<td width="60%" height="100%">
								<table width="100%" style="font-size: 20;">
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
											style="font-size: 20;" onclick="goReport();"></td>
											
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
		<table width="70%" height="300" align="center" >
			<tr>
			
				<td width="30%" align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px">
					<jsp:include page="mapJsp.jsp">
					<jsp:param value="<%=bean.getAc_address()%>" name="address" />
					</jsp:include>
				</div>
					</td>
				<td width="70%"  align="center">
				<div style="border:10px solid #36ada9; border-radius:15px; padding:20px">
					<jsp:include page="academyAskList.jsp"></jsp:include>
					</div>
				</td>
			</tr>
		</table>
		<br>

</body>
<%@ include file="../alcinfo/footer.jsp"%>
</html>
<%
	}
%>