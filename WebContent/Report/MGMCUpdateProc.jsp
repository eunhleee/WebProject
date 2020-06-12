<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html charset=utf-8");
%>
<jsp:useBean id="mgr" class="alcinfo.ReportMgr" />
<jsp:useBean id="bean" class="alcinfo.ReportBean" />
<jsp:setProperty property="*" name="bean" />
<%
	boolean result = mgr.MGMUpdate(bean);

	if (result) {
%>
<script>
	alert("처리가 완료되었습니다.");
	location.href = "MGMemberControl.jsp";
</script>
<%
	} else {
%>
<script>
	alert("처리에 실패 하셨습니다.");
	history.back();
</script>
<%
	}
%>