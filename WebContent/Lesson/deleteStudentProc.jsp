<%@page import="alcinfo.Smssend"%>
<%@page import="alcinfo.MemberBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="lebean" class="alcinfo.LessonBean" />
<jsp:useBean id="Mmgr" class="alcinfo.MemberMgr" />
<jsp:useBean id="mgr" class="alcinfo.LeinsertMgr" />

<jsp:setProperty property="*" name="lebean"/>

<%
		request.setCharacterEncoding("utf-8");
		String id=request.getParameter("id");
		int num=UtilMgr.parseInt(request,"num");
		String phone=request.getParameter("phone");

		String msg="취소에 실패하였습니다.";
		String stuid=(String)session.getAttribute("idKey");
		MemberBean ebean=Mmgr.getId(stuid);
		ebean.setId(stuid);
		if(!mgr.getStudent(ebean,id)){
			msg="신청 이력이 없는 과외입니다.";
		}
		else if(mgr.deleteStudent(lebean, ebean)){
			msg="취소하였습니다.";
			Smssend.send("[우리학원어디]\n"+stuid+"님이 과외 신청을 취소 하셨습니다.",phone);

		}
%>
<script>
alert('<%=msg%>');
location.href="leRead.jsp?num=<%=num%>&id=<%=id%>";
</script>