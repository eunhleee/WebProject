<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="mgr" class="alcinfo.LeinsertMgr"></jsp:useBean>
<%
		request.setCharacterEncoding("utf-8");
		String stid=request.getParameter("stid");
		String msg="상태 변경을 실패하였습니다.";
		if(mgr.changeState(stid)){
			msg="상태 변경을 하였습니다.";
		}
		
%>
<script>
alert('<%=msg%>');
location.href="../Mypage/myReceiveStudent.jsp";
</script>