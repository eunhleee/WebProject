<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="mgr" class="alcinfo.LoginMgr"></jsp:useBean>
<%
		request.setCharacterEncoding("utf-8");
		String id=session.getAttribute("idKey").toString();
		String url="";
		if(mgr.deleteLogin(id)){
			session.removeAttribute("idKey");	
			session.removeAttribute("idgrade");	

			url=request.getHeader("referer");
		}
%>
<script>
alert("로그아웃 하였습니다.");
location.href="<%=url%>";
</script>