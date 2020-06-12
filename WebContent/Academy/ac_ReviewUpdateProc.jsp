<!-- ac_ReviewUpdateProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mgr" class="alcinfo.AcreviewMgr"/>
<jsp:useBean id="bean" class="alcinfo.AcreviewBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int num = Integer.parseInt(request.getParameter("num"));
	int acrnum = Integer.parseInt(request.getParameter("acrnum"));
	bean.setNum(acrnum);
	bean.setAc_title(request.getParameter("acrtitle"));
	bean.setAc_star(Double.parseDouble(request.getParameter("acrstar")));
	bean.setAc_content(request.getParameter("acrcontent"));
	mgr.updateAcr(bean);
%>
<script>
	alert("수정되었습니다.");
	location.href = "ac_ReviewRead.jsp?num=<%=num%>&acrnum=<%=acrnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
</script>