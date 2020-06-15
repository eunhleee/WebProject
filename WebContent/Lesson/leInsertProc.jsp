<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="leMgr" class="alcinfo.LeteaMgr" />
<jsp:useBean id="leBean" class="alcinfo.LeteaBean" />
<jsp:setProperty name="leBean" property="*" />
<%
	String id = request.getParameter("id");
	String leclass = request.getParameter("leclass");
	int student = Integer.parseInt(request.getParameter("lestudent"));
	String etc = request.getParameter("leetc");
	boolean flag = leMgr.insertLetea(id, leclass, student, etc);
	if(flag){%>
<script>
		alert("등록되었습니다.");
		location.href="LessonMain.jsp?pageValue=top";
</script>
<%}else{%>
	<script>
		alert("등록에 실패하였습니다.");
		history.back();
	</script>
<%}%>