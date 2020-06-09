<!-- ac_QnAUpdateProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.AcqueryMgr"/>
<jsp:useBean id="bean" class="alcinfo.AcqueryBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int num = Integer.parseInt(request.getParameter("num"));
	int acqnum = Integer.parseInt(request.getParameter("ac_num"));
	bean.setAc_num(num);
	bean.setAc_title(request.getParameter("acqtitle"));
	bean.setAc_subject(request.getParameter("acqsubject"));
	bean.setAc_content(request.getParameter("acqcontent"));
	bean.setAc_id(request.getParameter("acqid"));
	bean.setAc_ip(request.getParameter("acqip"));
	mgr.updateAnQ(bean);
%>
<script>
	alert("수정되었습니다.");
	location.href = "ac_QnARead.jsp?num=<%=num%>&ac_num=<%=acqnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
</script>