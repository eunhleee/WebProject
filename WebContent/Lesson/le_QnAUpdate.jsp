<!-- le_QnAUpdate.jsp -->
<%@page import="alcinfo.LequeryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String leqid = (String)session.getAttribute("idKey");
	int num = Integer.parseInt(request.getParameter("num"));
	int lq_lnum = Integer.parseInt(request.getParameter("lq_lnum"));
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	LequeryBean bean = (LequeryBean)session.getAttribute("bean");
	String title = bean.getLq_title();
	String subject = bean.getLq_subject();
	String id = bean.getLq_id(); 
	String content = bean.getLq_content();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-학원 문의 게시판</title>
<script>
	function cancel() {
		location.href = "<%=request.getHeader("referer")%>";
	}
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
	<div style="margin-left: 15%; margin-right: 15%">

		<div align="center">
			<br/>
			<table width="600" cellpadding="3">
				<tr>
					<td height="25" align="center">글 수정</td>
				</tr>
			</table>
			<br/>
			<form name="lequpdateFrm" method="post"
			action="le_QnAUpdateProc.jsp">
			<table width="600" cellpadding="3" align="center" border="1">
				<tr>
					<td align=center>
					<table align="center">
						<tr>
							<td>제 목</td>
							<td>
								<input name="leqtitle" size="50" maxlength="30" value="<%=title%>">
							</td>
						</tr>
						<tr>
							<td>과 목</td>
							<td>
								<input name="leqsubject" size="50" maxlength="30" value="<%=subject%>">
							</td>
						</tr>
						<tr>
							<td>내 용</td>
							<td>
								<textarea name="leqcontent" rows="10" cols="50"><%=content%></textarea>
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
								 onClick="javascript:cancel()">
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			 <input type="hidden" name="leqid" value="<%=leqid%>">
			 <input type="hidden" name="leqip" value="<%=request.getRemoteAddr()%>">
			 <input type="hidden" name="nowPage" value="<%=nowPage %>">
			 <input type="hidden" name="num" value="<%=num%>">
			 <input type="hidden" name="lq_lnum" value="<%=lq_lnum%>">
			 <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			</form>
		</div>
	</div>

</body>
</html>