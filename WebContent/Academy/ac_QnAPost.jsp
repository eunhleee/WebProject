<!-- ac_QnAPost.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	String acqid = (String)session.getAttribute("idKey");
	int ac_num=UtilMgr.parseInt(request,"ac_num");
	String prevurl = request.getHeader("referer");
%>
<html>
<head>
<style>
#inputdiv{
	margin:10px;
	width:400px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#inputdiv input{
	width:350px;
	border:none;
	font-size:15px;
}
#textareadiv{
	margin:10px;
	width:400px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#textareadiv textarea{
	border:none;
	font-size:15px;
	width:390px;
}
</style>
</head>

<body>
<div style="padding:15px; border:8px solid #F88C65; border-radius: 10px;">
	<h2>문의 하기</h2>		
			<form name="scpostFrm" method="post" action="ac_QnAPostProc.jsp">
			<table width="800" cellpadding="3" >
				<tr>
					<td >
					<table >
						<tr>
							<td>제 목</td>
							<td>
							<div id="inputdiv">
							<input name="acqtitle" size="50" maxlength="30"></div>
							</td>
						</tr>
						<tr>
							<td>과 목</td>
							<td>
							<div id="inputdiv">
							<input name="acqsubject" size="50" maxlength="30">
							</div></td>
						</tr>
						<tr>
							<td>내 용</td>
							<td>
							<div id="textareadiv">
							<textarea name="acqcontent" rows="10" cols="52"></textarea>
							</div></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
						
								 <input type="submit" value="확인">
								 <input type="reset" value="다시쓰기">
								 <input type="button" value="취소"
								 onClick="javascript:location.href='<%=prevurl%>'">
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="acqid" value="<%=acqid%>">
			<input type="hidden" name="acqip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="acnum" value="<%=ac_num%>">
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