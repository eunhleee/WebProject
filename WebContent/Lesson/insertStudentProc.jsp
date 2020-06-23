<%@page import="alcinfo.Smssend"%>
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
		String phone=request.getParameter("phone");
		System.out.println(phone);
		int num=UtilMgr.parseInt(request,"num");
		String msg="신청에 실패하였습니다.";
		String stuid=(String)session.getAttribute("idKey");
		MemberBean ebean=Mmgr.getId(stuid);
		ebean.setId(stuid);
		if(ebean.getName()==null){
			msg="신청 권한이 없습니다.";
		}
		else if(mgr.getStudent(ebean,stuid)){
			msg="이미 신청된 과외입니다.";
		}
		else if(mgr.insertStudent(lebean, ebean)){
			msg="신청하였습니다.";
			Smssend.send("[우리학원어디]\n"+stuid+"님이 과외 신청을 하셨습니다.",phone);
		}
%>
<script>
alert('<%=msg%>');
location.href="leRead.jsp?num=<%=num%>&id=<%=id%>";
</script>