<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html charset=utf-8");
%>
<jsp:useBean id="mgr" class="alcinfo.ReportMgr" />
<jsp:useBean id="bean" class="alcinfo.ReportBean" />
<jsp:setProperty property="*" name="bean" />
<%
	boolean result = mgr.updateMgm(bean);

	if (result) {
%>
<script>
	alert("수정하였습니다.");
	location.href = "MGMemberControl.jsp";
</script>
<%
	} else {
%>
<script>
	alert("수정에 실패하였습니다.");
	history.back();
</script>
<%
	}
%>