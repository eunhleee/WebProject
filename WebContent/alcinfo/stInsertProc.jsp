<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="mMgr" class="alcinfo.MemberMgr" />
<jsp:useBean id="mBean" class="alcinfo.MemberBean" />
<jsp:setProperty name="mBean" property="*" />
<%
	String id = request.getParameter("id");
	String stclass = request.getParameter("stclass");
	String stetc = request.getParameter("stetc");
	boolean flag = mMgr.insertStudent(id, stclass, stetc);
	if(flag){%>
<script>
		alert("등록되었습니다.");
		location.href="StudentMain.jsp?pageValue=count";
</script>
<%}else{%>
	<script>
		alert("등록에 실패하였습니다.");
		history.back();
	</script>
<%}%>
