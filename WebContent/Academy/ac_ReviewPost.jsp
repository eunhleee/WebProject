<!-- 학원 리뷰 글쓰기 -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.AcademyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.AcademyMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
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
	<%@ include file="../alcinfo/headerSearch.jsp"%>
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
		
	</form>
		<br>
		<br>
		<table width="70%" height="300" align="center" border="1">
			<tr>
				<td width="30%" align="center"><jsp:include page="mapJsp.jsp">
						<jsp:param value="<%=bean.getAc_address()%>" name="address" />
					</jsp:include></td>
				<td width="70%" align="center">

<!-- 글쓰기 Start -->

		<div align="center">
			<br/>
			<table width="600" cellpadding="3">
				<tr>
					<td height="25" align="center"><%=bean.getAc_name()%> 리뷰</td>
				</tr>
			</table>
			<br/>
			<form name="acrpostFrm" method="post" action="ac_ReviewPostProc.jsp">
			<table width="600" cellpadding="3" align="center" border="1">
				<tr>
					<td align=center>
					<table align="center">
						<tr>
							<td>제 목</td>
							<td>
							<input name="acrtitle" size="50" maxlength="30"></td>
						</tr>
						<tr>
							<td>평 점</td>
							<td>
								<select name="acrstar">
									<option value="5" selected>5점</option>
									<option value="4.5">4.5점</option>
									<option value="4">4점</option>
									<option value="3.5">3.5점</option>
									<option value="3">3점</option>
									<option value="2.5">2.5점</option>
									<option value="2">2점</option>
									<option value="1.5">1.5점</option>
									<option value="1">1점</option>
									<option value="0.5">0.5점</option>
									<option value="0">0점</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>내 용</td>
							<td><textarea name="acrcontent" rows="10" cols="50"></textarea></td>
						</tr>
						<tr>
							<td colspan="2">
						
								 <input type="submit" value="확인">
								 <input type="reset" value="다시쓰기">
								 <input type="button" value="취소"
								 onClick="javascript:location.href='../Academy/acRead.jsp?num=<%=num%>'">
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="acqid" value="<%=id%>">
			<input type="hidden" name="acqip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="acnum" value="<%=num%>">
			</form>
		</div>

<!-- 글쓰기 End -->

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