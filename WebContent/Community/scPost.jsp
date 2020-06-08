<!-- 커뮤니티의 자유게시판 리스트 출력 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String scid = (String)session.getAttribute("idKey");
	String group=request.getParameter("pageValue");
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-자유게시판 글쓰기</title>
<script>

</script>
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

		<div
			style="width: 50px; text-align: left; flex: 1; border: 1px solid black; margin-right: 10%; padding: 40px 40px;">
			<h3>커뮤니티</h3>
			<a href="communityList.jsp?pageValue=free">&#149; 자유게시판</a><br>
			<a href="communityList.jsp?pageValue=academy">&#149; 학원 Q&A</a><br>
			<a href="communityList.jsp?pageValue=lesson">&#149; 과외 Q&A</a><br>
			<br>

		</div>
		<div align="center" style="flex:4;">
			<br/>
			<table width="600" cellpadding="3">
				<tr>
					<td height="25" align="center">글쓰기</td>
				</tr>
			</table>
			<br/>
			<form name="scpostFrm" method="post" action="scPost?pageValue=<%=group%>"
			enctype="multipart/form-data">
			<table width="600" cellpadding="3" align="center" border="1">
				<tr>
					<td align=center>
					<table align="center">
						<tr>
							<td>제 목</td>
							<td>
							<input name="sctitle" size="50" maxlength="30"></td>
						</tr>
						<tr>
							<td>내 용</td>
							<td><textarea name="sccontent" rows="10" cols="50"></textarea></td>
						</tr>
						<tr>
						 <tr>
			     			<td>파일찾기</td> 
			     			<td><input type="file" name="scfilename" size="50" maxlength="50"></td>
			    		</tr>
						<tr>
							<td colspan="2"><hr/></td>
						</tr>
						<tr>
							<td colspan="2">
						
								 <input type="submit" value="확인">
								 <input type="reset" value="다시쓰기">
								 <input type="button" value="취소"
								 onClick="javascript:location.href='../alcinfo/communityList.jsp'">
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="scid" value="<%=scid%>">
			<input type="hidden" name="scip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="pageValue" value="<%=group %>">
			</form>
		</div>
		
	</div>
	<jsp:include page="../alcinfo/footer.jsp" />

</body>

</html>

