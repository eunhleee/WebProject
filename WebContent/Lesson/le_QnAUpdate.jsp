<!-- le_QnAUpdate.jsp -->
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar today = Calendar.getInstance();
 	String strToday = sdf.format(today.getTime());
	
	LequeryBean bean = (LequeryBean)session.getAttribute("bean");
	String title = bean.getLq_title();
	String subject = bean.getLq_subject();
	String id = bean.getLq_id(); 
	String content = bean.getLq_content();
	String secret = bean.getLq_secret();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-과외 문의 게시판</title>
<script>
	function cancel() {
		location.href = "<%=request.getHeader("referer")%>";
	}
</script>
<style>
@font-face { 
font-family: 'Godo'; font-style: normal;
font-weight: 400;
src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff2') format('woff2'), 
	url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff') format('woff'); }
@font-face {
	font-family: 'Godo'; font-style: normal;
	font-weight: 700; 
 	src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff2') format('woff2'),
url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff') format('woff'); } 
 	.godo * { font-family: 'Godo', sans-serif; }
 body{
 	font-family:'Godo';}
#inputdiv{
	margin:10px;
	width:490px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#inputdiv input{
	width:480px;
	border:none;
	font-size:15px;
}

#inputdiv1{
	margin:10px;
	width:200px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}

#inputdiv1 input{
	width:180px;
	border:none;
	font-size:15px;
	
}

#textareadiv{
	margin:10px;
	width:490px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#textareadiv textarea{
	border:none;
	font-size:15px;
	width:480px;
}
#checkbox {
	border:1px solid gray;
	border-radius: 6px;
}
</style>
</head>
<body>
	<div style="padding:10px; border:8px solid #F88C65; border-radius: 10px;">
		<h2><img src="../img/questionmark.png" width="40" height="40">&nbsp;문의 하기</h2>
		<hr style="border:1px solid #F88C65;">
		<form name="lequpdateFrm" method="post" action="le_QnAUpdateProc.jsp">
		<table width="600" cellpadding="3" align="center">
			<tr>
				<td align=center>
				<table align="center">
					<tr>
						<td>작성자</td>
						<td>
						<div id="inputdiv1">
						<input size="50" maxlength="30" disabled="disabled"
						value="<%=leqid%>">
						</div>
						</td>
						<td>작성일</td>
						<td>
						<div id="inputdiv1">
						<input size="50" maxlength="30" disabled="disabled"
						value="<%=strToday%>">
						</div>
						</td>
					</tr>
					<tr>
						<td>제 목</td>
						<td colspan="3"><div id="inputdiv">
							<input name="leqtitle" size="50" maxlength="30" value="<%=title%>">
						</div></td>
					</tr>
					<tr>
						<td>과 목</td>
						<td colspan="3"><div id="inputdiv">
							<input name="leqsubject" size="50" maxlength="30" value="<%=subject%>">
						</div></td>
					</tr>
					<tr>
						<td>내 용</td>
						<td colspan="3"><div id="textareadiv">
							<textarea name="leqcontent" rows="10" cols="50"><%=content%></textarea>
						</div></td>
					</tr>
					<tr>
		    			<td colspan="1">
		    			비밀글
						</td>
						<td colspan="3"><input type="checkbox" name="leqsecret" 
						id="checkbox" <% if(secret!=null) {%>checked<%} %>></td>
		    		</tr>
					<tr>
						<td colspan="4" align="center">
							 <input type="submit" value="수정">
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

</body>
</html>