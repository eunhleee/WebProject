<%@page import="alcinfo.Smssend"%>
<%@page import="alcinfo.LessonBean"%>

<%@page import="alcinfo.UtilMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="lebean" class="alcinfo.LeteaBean" />
<jsp:useBean id="stbean" class="alcinfo.StudentBean" />

<jsp:useBean id="mgr" class="alcinfo.StudentMgr" />
<jsp:useBean id="lmgr" class="alcinfo.LessonMgr" />

<jsp:setProperty property="*" name="lebean"/>
<jsp:setProperty property="*" name="stbean"/>

<%
		request.setCharacterEncoding("utf-8");
		int stunum=UtilMgr.parseInt(request,"stunum");
		String phone=request.getParameter("phone");

		String msg="신청에 실패하였습니다.";
		String teaid=(String)session.getAttribute("idKey");
		LessonBean lbean=lmgr.getId(teaid);
		stbean = mgr.getStudent(stunum);
		stbean.setNum(stunum); 
		if(lbean.getName()==null){
			msg="신청 권한이 없습니다.";
		}
		else if(mgr.getTea(lbean.getId(),stunum)){
			msg="이미 신청된 학생입니다.";
		}
		else if(mgr.insertTea(stbean, lbean)){
			msg="신청하였습니다.";
			Smssend.send("[우리학원어디]\n"+teaid+"님이 신청을 하셨습니다.",phone);

		}
%>
<script>
alert('<%=msg%>');
location.href="stRead.jsp?stunum=<%=stunum%>";
</script>