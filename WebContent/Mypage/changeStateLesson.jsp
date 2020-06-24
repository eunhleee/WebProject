<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="mgr" class="alcinfo.StinsertMgr"></jsp:useBean>
<%
		request.setCharacterEncoding("utf-8");
		String teaid=request.getParameter("teaid");
		String msg="상태 변경을 실패하였습니다.";
		if(mgr.changeState(teaid)){
			msg="상태 변경을 하였습니다.";
		}
		
%>
<script>
alert('<%=msg%>');
location.href="../Mypage/myReceiveLesson.jsp";
</script>