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
		}
%>
<script>
alert('<%=msg%>');
location.href="stRead.jsp?stunum=<%=stunum%>";
</script>