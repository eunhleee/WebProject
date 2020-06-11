<!-- le_QnAUpdateProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.LequeryMgr"/>
<jsp:useBean id="bean" class="alcinfo.LequeryBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int num = Integer.parseInt(request.getParameter("num"));
	int lq_lnum = Integer.parseInt(request.getParameter("lq_lnum"));
	bean.setNum(num);
	bean.setLq_title(request.getParameter("leqtitle"));
	bean.setLq_subject(request.getParameter("leqsubject"));
	bean.setLq_content(request.getParameter("leqcontent"));
	bean.setLq_id(request.getParameter("leqid"));
	bean.setLq_ip(request.getParameter("leqip"));
	mgr.updateLeQ(bean);
%>
<script>
	alert("수정되었습니다.");
	location.href = "le_QnARead.jsp?num=<%=num%>&lq_lnum=<%=lq_lnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>";
</script>