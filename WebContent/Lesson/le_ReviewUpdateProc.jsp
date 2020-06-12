<!-- le_ReviewUpdateProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mgr" class="alcinfo.LereviewMgr"/>
<jsp:useBean id="bean" class="alcinfo.LereviewBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String id = request.getParameter("id");
	int lernum = Integer.parseInt(request.getParameter("lernum"));
	
	bean.setNum(lernum);
	bean.setLr_title(request.getParameter("lertitle"));
	bean.setLr_star(Double.parseDouble(request.getParameter("lerstar")));
	bean.setLr_content(request.getParameter("lercontent"));
	mgr.updateLer(bean);
%>
<script>
	alert("수정되었습니다.");
	location.href = "le_ReviewRead.jsp?num=<%=num%>&id=<%=id%>&lernum=<%=lernum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
</script>