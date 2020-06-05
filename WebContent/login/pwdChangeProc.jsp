<!-- pwdChangeProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="pcmgr1" class="member.MemberMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String pcid = request.getParameter("pcid");
	String pcpwd = request.getParameter("pcpwd");
	String pcmsg = "비밀번호 변경에 실패하였습니다.";
	boolean result = pcmgr1.pwdChange(pcid, pcpwd);
	if(result) {
		pcmsg = "비밀번호가 변경되었습니다.";
	}
%>
<script>
	alert("<%=pcmsg%>");
	location.href = "../alcinfo/cards-gallery.jsp";
</script>