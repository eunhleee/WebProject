<!-- ac_ReviewUpdate.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.AcademyBean"%>
<%@page import="alcinfo.AcreviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="acmgr" class="alcinfo.AcademyMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	String loginid = (String)session.getAttribute("idKey");
	int acrnum = UtilMgr.parseInt(request, "acrnum");
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	
	AcreviewBean acrbean = (AcreviewBean)session.getAttribute("bean");
	String title = acrbean.getAc_title();
	Double star = acrbean.getAc_star();
	String star1 = Double.toString(star);
	String nick = acrbean.getAc_nickname(); 
	String content = acrbean.getAc_content();
	
	int num = UtilMgr.parseInt(request, "num");
	AcademyBean bean = acmgr.getAcademy(num);
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
		function goReport() {
			url = "../Report/reportReceiptAInf.jsp?stopid="+<%=num%>;
			window.open(url, "GoReport", "width=360, height=300, top=200, left=300");
		}
</script>
</head>
<body>
	
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
				
<!---- 글수정 Start ---->

					<div style="border:10px solid #36ada9; border-radius:15px; padding:20px">
										
						<table width="600" cellpadding="3">
							<tr>
								<td height="25" align="center">글 수정</td>
							</tr>
						</table>
						<br/>
						<form name="acrupdateFrm" method="post" action="ac_ReviewUpdateProc.jsp">
						<table width="600" cellpadding="3" align="center" border="1">
							<tr>
								<td align=center>
								<table align="center">
									<tr>
										<td>제 목</td>
										<td>
											<input name="acrtitle" size="50" maxlength="30" value="<%=title%>">
										</td>
									</tr>
									<tr>
										<td>평 점</td>
										<td>
											<select name="acrstar">
												<option value="5" 
												<% if(star1.equals("5.0")) { %> selected <% } %>
												>5점</option>
												<option value="4.5" 
												<% if(star1.equals("4.5")) { %> selected<% } %>
												>4.5점</option>
												<option value="4" 
												<% if(star1.equals("4.0")) { %> selected <% } %>
												>4점</option>
												<option value="3.5" 
												<% if(star1.equals("3.5")) { %> selected <% } %>
												>3.5점</option>
												<option value="3" 
												<% if(star1.equals("3.0")) { %> selected <% } %>
												>3점</option>
												<option value="2.5" 
												<% if(star1.equals("2.5")) { %> selected <% } %>
												>2.5점</option>
												<option value="2" 
												<% if(star1.equals("2.0")) { %> selected <% } %>
												>2점</option>
												<option value="1.5" 
												<% if(star1.equals("1.5")) { %> selected <% } %>
												>1.5점</option>
												<option value="1" 
												<% if(star1.equals("1.0")) { %> selected <% } %>
												>1점</option>
												<option value="0.5" 
												<% if(star1.equals("0.5")) { %> selected <% } %>
												>0.5점</option>
												<option value="0" 
												<% if(star1.equals("0.0")) { %> selected <% } %>
												>0점</option>
											</select>
										</td>
									</tr>
									<tr>
										<td>내 용</td>
										<td>
											<textarea name="acrcontent" rows="10" cols="50"><%=content%></textarea>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											 <input type="submit" value="확인">
											 <input type="reset" value="다시쓰기">
											 <input type="button" value="취소"
											 onClick="javascript:location.href='<%=request.getHeader("referer")%>'">
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						 <input type="hidden" name="acrnick" value="<%=nick%>">
						 <input type="hidden" name="acrip" value="<%=request.getRemoteAddr()%>">
						 <input type="hidden" name="nowPage" value="<%=nowPage %>">
						 <input type="hidden" name="num" value="<%=num%>">
						 <input type='hidden' name="acrnum" value="<%=acrnum%>">
						 <input type='hidden' name="numPerPage" value="<%=numPerPage%>">
						 <%
					  	 	if(!(keyWord==null||keyWord.equals(""))){
					     %>
					     <input type="hidden" name="keyField" value="<%=keyField%>">
					     <input type="hidden" name="keyWord" value="<%=keyWord%>">
					 	 <%
							}
						 %>
						</form>
					

					</div>
					
<!---- 글수정 End ---->

				</td>
			</tr>
		</table>
		<br>

</body>
<%@ include file="../alcinfo/footer.jsp"%>
</html>