<!-- ac_QnAUpdate.jsp -->
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="alcinfo.AcqueryBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String acqid = (String)session.getAttribute("idKey");
	int num = Integer.parseInt(request.getParameter("num"));
	int acnum = Integer.parseInt(request.getParameter("ac_num"));
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar today = Calendar.getInstance();
 	String strToday = sdf.format(today.getTime());
 	
	AcqueryBean bean = (AcqueryBean)session.getAttribute("bean");
	String title = bean.getAc_title();
	String subject = bean.getAc_subject();
	String id = bean.getAc_id(); 
	String content = bean.getAc_content();
	String secret = bean.getAc_secret();
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
			<form name="anqupdateFrm" method="post" action="ac_QnAUpdateProc.jsp">
			<table width="800" cellpadding="3">
				<tr>
					<td align=center>
					<table align="center">
					<tr>
						<td>작성자</td>
						<td>
						<div id="inputdiv1">
						<input size="50" maxlength="30" disabled="disabled"
						value="<%=acqid%>">
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
							<td colspan="3"><div id="inputdiv1">
								<input name="acqtitle" size="50" maxlength="30" value="<%=title%>">
							</div></td>
						</tr>
						<tr>
							<td>과 목</td>
							<td colspan="3"><div id="inputdiv1">
								<input name="acqsubject" size="50" maxlength="30" value="<%=subject%>">
							</div></td>
						</tr>
						<tr>
							<td>내 용</td>
							<td colspan="3"><div id="textareadiv">
								<textarea name="acqcontent" rows="10" cols="50"><%=content%></textarea>
							</div></td>
						</tr>
						<tr>
			    			<td colspan="1">
			    			비밀글
							</td>
							<td colspan="3"><input type="checkbox" name="acqsecret" 
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
			 <input type="hidden" name="acqid" value="<%=acqid%>">
			 <input type="hidden" name="acqip" value="<%=request.getRemoteAddr()%>">
			 <input type="hidden" name="num" value="<%=num%>">
			 <input type="hidden" name="ac_num" value="<%=acnum%>">
			 <input type="hidden" name="nowPage" value="<%=nowPage%>">
			 <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			 <%if(!(keyWord==null||keyWord.equals(""))){%>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}%>
		</form>
	</div>

</body>
</html>