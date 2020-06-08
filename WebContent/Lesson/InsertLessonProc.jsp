<%@page import="alcinfo.UtilMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="lebean" class="alcinfo.LessonBean"></jsp:useBean>
<jsp:useBean id="mbean" class="alcinfo.MemberBean"></jsp:useBean>
<jsp:useBean id="mgr" class="alcinfo.LessonMgr" />
<jsp:setProperty property="*" name="lebean"/>
<jsp:setProperty property="*" name="mbean"/>
<%
		request.setCharacterEncoding("utf-8");
		String msg="신청에 실패를 하였습니다.";
		int num=UtilMgr.parseInt(request,"num");
		boolean flag=mgr.insertStudent(lebean, mbean);
		if(flag)
		{		
			msg="신청하였습니다.";
		}
		
%>
<script>
alert('<%=msg%>');
location.href="leRean.jsp?num=<%=num%>";
</script>