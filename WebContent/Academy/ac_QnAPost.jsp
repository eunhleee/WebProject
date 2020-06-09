<!-- ac_QnAPost.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String acqid = (String)session.getAttribute("idKey");
	int ac_num=UtilMgr.parseInt(request,"ac_num");
%>
<div align="center"">
			<br/>
			<table width="600" cellpadding="3">
				<tr>
					<td height="25" align="center">글쓰기</td>
				</tr>
			</table>
			<br/>
			<form name="scpostFrm" method="post" action="ac_QnAPostProc.jsp">
			<table width="600" cellpadding="3" align="center" border="1">
				<tr>
					<td align=center>
					<table align="center">
						<tr>
							<td>제 목</td>
							<td>
							<input name="acqtitle" size="50" maxlength="30"></td>
						</tr>
						<tr>
							<td>과 목</td>
							<td>
							<input name="acqsubject" size="50" maxlength="30"></td>
						</tr>
						<tr>
							<td>내 용</td>
							<td><textarea name="acqcontent" rows="10" cols="50"></textarea></td>
						</tr>
						<tr>
							<td colspan="2">
						
								 <input type="submit" value="확인">
								 <input type="reset" value="다시쓰기">
								 <input type="button" value="취소"
								 onClick="javascript:location.href='../alcinfo/ac_QnA.jsp?ac_num=<%=ac_num%>'">
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="acqid" value="<%=acqid%>">
			<input type="hidden" name="acqip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="acnum" value="<%=ac_num%>">
			</form>
		</div>