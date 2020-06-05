<%@page import="alcinfo.MemberBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="lebean" class="alcinfo.LessonBean" />
<jsp:useBean id="Mmgr" class="alcinfo.MemberMgr" />
<jsp:useBean id="mgr" class="alcinfo.LessonMgr" />

<jsp:setProperty property="*" name="lebean"/>

<%
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		int num=UtilMgr.parseInt(request,"num");
		String msg="취소에 실패하였습니다.";
		String stuid=(String)session.getAttribute("idKey");
		MemberBean ebean=Mmgr.getId(stuid);
		ebean.setId(stuid);
		if(!mgr.getStudent(ebean,id)){
			msg="신청 이력이 없는 과외입니다.";
		}
		else if(mgr.deleteStudent(lebean, ebean)){
			msg="취소하였습니다.";
		}
%>
<script>
alert('<%=msg%>');
location.href="leRead.jsp?num=<%=num%>&id=<%=id%>";
</script>