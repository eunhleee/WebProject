<!-- cs_Update.jsp -->
<%@page import="alcinfo.CSBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	String cust_page = request.getParameter("cust_page");
	CSBean bean = (CSBean)session.getAttribute("bean");
	String title = bean.getCc_title();
	String content = bean.getCc_content();
	String secret = bean.getCc_secret();
	//scRead.jsp에서 session에 빈즈 단위로 저장 했기 때문에 파일명도 가져 올 수 있다.
	String filename = bean.getCc_filename();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-고객센터</title>
<style>
#list td {
	border-bottom: 1px solid lightgray;
}

#title td {
	color: white;
	background-color: #36ada9;
}

a {
	text-decoration: none;
	color: black;
}

a:hover {
	color: gray;
}
</style>
</head>
<body>

	<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>

	<div style="display: flex; margin-left: 15%; margin-right: 15%">
		<!-- 카테고리 부분 -->

		<div
			style="width: 50px; text-align: left; flex: 1; border: 1px solid black; margin-right: 10%; padding: 40px 40px;">
			<h3>고객센터</h3>
			<a href="custCenter.jsp?cust_page=ccBestBoard">&#149; 자주 묻는 질문</a>
			<br>
			<br> 
			<a href="custCenter.jsp?cust_page=ccQuery">&#149; 질문하기</a>
		</div>

<!-- 고객센터 글수정 Start -->
		<div style="width: 800px; flex: 2; border: 1px solid black; padding: 20px 20px;">
			
			<table width="600" cellpadding="3">
				<tr>
					<td height="25" align="center">글쓰기</td>
				</tr>
			</table>
			<br/>
			<form name="cspostFrm" method="post" action="csUpdate?cust_page=<%=cust_page%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>"
			enctype="multipart/form-data">
			<table width="600" cellpadding="3" align="center" border="1">
				<tr>
					<td align=center>
					<table align="center">
						<tr>
							<td>제 목</td>
							<td>
							<input name="cctitle" size="50" maxlength="30" value="<%=title %>"></td>
						</tr>
						<tr>
							<td>내 용</td>
							<td><textarea name="cccontent" rows="10" cols="50"><%=content %></textarea></td>
						</tr>
						<tr>
						 <tr>
			     			<td>파일찾기</td> 
			     			<td>
								<%=filename!=null?"첨부된 파일 : "+filename:"첨부된 파일이 없습니다."%>
			     				<input type="file" name="ccfilename" size="50" maxlength="50"
			     				style="border:1px;">
			     			</td>
			    		</tr>
			    		<tr>
			    			<td align="right">
			    			비밀글<input type="checkbox" name="ccsecret" <%if(secret!=null) {%>checked<%} %>>
							</td>
			    		</tr>
						<tr>
							<td colspan="2"><hr/></td>
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
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="ccip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="cust_page" value="<%=cust_page%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
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
<!-- 고객센터 글수정 End -->

	</div>
	<jsp:include page="../alcinfo/footer.jsp"></jsp:include>
</body>
</html>