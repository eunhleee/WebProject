<!-- memberProc.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mpmgr" class="member.MemberMgr"/>
<jsp:useBean id="mpbean" class="alcinfo.MemberBean"/>
<jsp:setProperty property="*" name="mpbean"/>
<%
	String imbirth = request.getParameter("imbirthy") + request.getParameter("imbirthm") + 
			request.getParameter("imbirthd");
	String imaddress = request.getParameter("imaddress1") + " " + request.getParameter("imaddress2");
	
	mpbean.setId(request.getParameter("imid"));
	mpbean.setName(request.getParameter("imname"));
	mpbean.setGender(request.getParameter("imgender"));
	mpbean.setPasswd(request.getParameter("impwd"));
	mpbean.setNickname(request.getParameter("imnickname"));
	mpbean.setBirth(imbirth);
	mpbean.setPhone(request.getParameter("imphone"));
	mpbean.setEmail(request.getParameter("imemail"));
	mpbean.setAddress(imaddress);
	mpbean.setSchool_grade(request.getParameter("imschoolgrade"));
	mpbean.setSchool_name(request.getParameter("imschoolname"));
	
	
	boolean imresult = mpmgr.insertMember(mpbean);
	String mpmsg = "회원가입에 실패하였습니다.";
	String mpurl = "../login/insertMember1.jsp";
	if(imresult) {
		mpmsg = "회원가입에 성공하였습니다.";
		mpurl = "../alcinfo/cards-gallery.jsp";
// 		session.setAttribute("idKey", mpbean.getId()); // 가입과 동시에 로그인
	}
%>
<script>
	alert("<%=mpmsg%>");
	location.href = "<%=mpurl%>";
</script>