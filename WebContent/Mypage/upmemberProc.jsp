<!-- memberProc.jsp -->
<%@page import="alcinfo.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mpmgr" class="alcinfo.MemberMgr"/>
<jsp:useBean id="mpbean" class="alcinfo.MemberBean"/>
<jsp:setProperty property="*" name="mpbean"/>
<%
	String id=request.getParameter("imid");


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
	mpbean.setImgname(request.getParameter("image"));
	MemberBean gBean =mpmgr.getGrade(id);
	
	boolean imresult = mpmgr.upMember(mpbean,gBean.getGrade());
	String mpmsg = "회원정보 수정을 실패 하였습니다.";
	String mpurl = "../Mypage/upMember.jsp";
	if(imresult) {
		mpmsg = "회원정보 수정을 성공 하였습니다.";
		mpurl = "../Mypage/upMember.jsp";

	}
%>
<script>
	alert("<%=mpmsg%>");
	location.href = "<%=mpurl%>";
</script>