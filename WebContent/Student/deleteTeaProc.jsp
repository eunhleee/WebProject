<%@page import="alcinfo.Smssend"%>
<%@page import="alcinfo.LeteaBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="sbean" class="alcinfo.StudentBean" />
<jsp:useBean id="lemgr" class="alcinfo.LeteaMgr" />
<jsp:useBean id="smgr" class="alcinfo.StudentMgr" />
<jsp:useBean id="mgr" class="alcinfo.StinsertMgr" />


<%
		request.setCharacterEncoding("utf-8");
		int stunum=UtilMgr.parseInt(request,"stunum");
		String phone=request.getParameter("phone");

		String msg="취소에 실패하였습니다.";
		String teaid=(String)session.getAttribute("idKey");
		LeteaBean lbean=lemgr.getId(teaid);
		lbean.setId(teaid);
		sbean=smgr.getStudent(stunum);
		if(!mgr.getTea(teaid,stunum)){
			msg="신청 이력이 없는 과외입니다.";
		}
		else if(mgr.deleteTea(sbean, lbean)){
			msg="취소하였습니다.";
			Smssend.send("[우리학원어디]\n"+teaid+"님이 취소를 하셨습니다.",phone);
		}
%>
<script>
alert('<%=msg%>');
location.href="stRead.jsp?stunum=<%=stunum%>";
</script>