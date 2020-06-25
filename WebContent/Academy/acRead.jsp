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
		mgr.upAcCount(num);
		session.setAttribute("bean", bean);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>우리 학원 어디?-학원 리뷰</title>

<link href="style.css" rel="stylesheet" type="text/css">
<script>
		function moveQnA(){
			url = "ac_QnA.jsp?ac_num="+<%=num%>;
			window.open(url, "Ac_QnA", "width=900, height=560, top=200, left=400");
			
		}
		function goReport() {
			url = "../Report/reportReceiptAInf.jsp?stopid=<%=num%>";
			window.open(url, "GoReport", "width=900, height=560, top=200, left=300");
		}
		function goErr(){
			alert("로그인을 해주세요");

		}
</script>
<style>

.totalFrame{
	background-color:#FAF8EB;
	margin-top:-40px;
	padding:40px 0px;
}
.subFrame{
	width:70%;
	border:1px solid gray;
	background-color:white;
	padding:30px 30px;
	margin-bottom:40px;
}
.tdBorder{
	border-right:3px solid #F88C65;
}

</style>
</head>
<body >
	<%@ include file="../alcinfo/headerSearch.jsp"%>
	<br>
	<br>
	<div class="totalFrame" align="center">
	<div class="subFrame">
		<table width="100%" >
			<tr>
				<td >
					<table  style="font-size: 20;" >
						<tr>
						<td width="95%"><h1><%=bean.getAc_name()%></h1>
						</td>
						
						<td><input type="button" value="문의하기" 	style="font-size: 20;" onclick="moveQnA();"></td>
						<%	if(session.getAttribute("idKey")==null||session.getAttribute("idKey").equals("")){ %>
							<td ><input type="button" value="잘못된정보 신고하기" style="font-size: 20;" onclick="goErr();"></td>
						<%}else{%>
							<td><input type="submit" value="잘못된정보 신고하기" style="font-size: 20;" onclick="goReport();"></td><%} %>
						
						</tr>
						<tr>
						<td width="70%">
						<table width="80%" style="font-size: 17px;"  >
									
									<tr height="20">
										<td class="tdBorder" width="8%">계열</td>
										<td width="15%">&nbsp;<%=bean.getGroup1()%></td>
										<td class="tdBorder" width="8%">과정</td>
										<td width="15%">&nbsp;<%=bean.getGroup2()%></td>
										<td class="tdBorder" width="8%">번호</td>
										<td  colspan="3">&nbsp;<%=bean.getAc_tel()%></td>
									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder">주소</td>
										<td colspan="5">&nbsp;<%=bean.getAc_address()%></td>	
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
			<td>
				<div style="padding:20px">
						<img src="../img/banner1.jpg" width="350" height="250">
				</div>
			</td>
			<td  align="center" rowspan="2" >
				<div style="border:10px solid #36ada9; border-radius:15px; padding:20px; height:100%;">
					<jsp:include page="academyAskList.jsp"></jsp:include>
					</div>
				</td>
			<tr>
			
				<td align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px">
					<jsp:include page="mapJsp.jsp">
					<jsp:param value="<%=bean.getAc_address()%>" name="address" />
					</jsp:include>
				</div>
				</td>
				
			</tr>
		</table>
		<br>
		</div>
		<%@ include file="../alcinfo/footer.jsp"%>
</div>
</body>

</html>
<%
	}
%>