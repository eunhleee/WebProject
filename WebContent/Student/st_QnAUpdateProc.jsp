<!-- st_QnAUpdateProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mgr" class="alcinfo.StinqueryMgr"/>
<jsp:useBean id="bean" class="alcinfo.StinqueryBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int num = Integer.parseInt(request.getParameter("num"));
	int stunum = Integer.parseInt(request.getParameter("stunum"));
	bean.setNum(num);
	bean.setTitle(request.getParameter("stqtitle"));
	bean.setContent(request.getParameter("stqcontent"));
	bean.setSt_secret(request.getParameter("stqsecret"));
	mgr.updateStQ(bean);
%>
<script>
	alert("수정되었습니다.");
	location.href = "st_QnARead.jsp?num=<%=num%>&stunum=<%=stunum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
</script>