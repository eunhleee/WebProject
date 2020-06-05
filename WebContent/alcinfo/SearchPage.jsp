<%@page import="alcinfo.StudentBean"%>
<%@page import="alcinfo.LessonBean"%>
<%@page import="alcinfo.AcademyBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="Amgr" class="alcinfo.AcademyMgr"></jsp:useBean>
<jsp:useBean id="Lmgr" class="alcinfo.LessonMgr"></jsp:useBean>
<jsp:useBean id="Smgr" class="alcinfo.StudentMgr"></jsp:useBean>
<%
		request.setCharacterEncoding("utf-8");
		String keyWord=request.getParameter("keyWord");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>우리학원 어디?</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css" />
<link rel="stylesheet" href="cards-gallery.css">
</head>
<body>

	<%@ include file="mainHeader.jsp"%>

	<section class="gallery-block cards-gallery">

	<div class="container">
		<div class="heading">
			<h2>학원</h2>
		</div>
		<br>
		<div class="row">
			<%
	        	Vector<AcademyBean> Avlist=Amgr.getSearchList(keyWord);
	        	//int listsize=vlist.size();
	        	for(int i=0;i<Avlist.size();i++){
	        		
	        		AcademyBean Abean=Avlist.get(i);
	        		//imgname, ac_name,group2, ac_tel,star,count
	        		int num=Abean.getNum();
	        		String img=Abean.getImgname();
	        		String name=Abean.getAc_name();
	        		String group2=Abean.getGroup2();
	        		String tel=Abean.getAc_tel();
	        		float star=Abean.getStar();
	        		int count=Abean.getCount();
	        		if(tel.equals("")) tel="번호 정보가 없습니다.";
	        %>
			<div class="col-md-6 col-lg-4">
				<div class="card border-0 transform-on-hover">
					<a class="lightbox" href="acRead.jsp?num=<%=num%>"> <img
						src="img/no_image.jpg" alt="Card Image" class="card-img-top">
					</a>
					<div class="card-body">
						<h6>
							<a href="acRead.jsp?num=<%=num%>"><%=name %></a>
						</h6>
						<p class="text-muted card-text"><%=group2 %>
							<br>
							<%=tel %></p>
					</div>
					<div align="right" style="margin-right: 20px;">
						<img src="img/star.png" width="15" height="15"><%=star %>
						(<%=count %>)
					</div>
				</div>
			</div>
			<%} %>

		</div>
	</div>
	<br>
	<hr>
	<br>
	<div class="container">
		<div class="heading">
			<h2>과외</h2>
		</div>
		<br>
		<div class="row">
			<%
	        Vector<LessonBean> Lvlist=Lmgr.getSearchList(keyWord);
	        	int listsize=Lvlist.size();
	        	for(int i=0;i<listsize;i++){
	        		LessonBean Lbean=Lvlist.get(i);
	        		  int num=Lbean.getNum(); 
	        		  String id=Lbean.getId();
					  String name=Lbean.getName(); 
					  String leclass=Lbean.getLeclass();
					   String area=Lbean.getArea();
					   float star=Lbean.getStar(); 
					   int count=Lbean.getCount();
	        %>
			<div class="col-md-6 col-lg-4">
				<div class="card border-0 transform-on-hover">
					<a class="lightbox" href="leRead.jsp?id=<%=id%>"> <img
						src="img/no_image.jpg" alt="Card Image" class="card-img-top">
					</a>
					<div class="card-body">
						<h6>
							<a href="leRead.jsp?id=<%=id%>"><%=name %></a>
						</h6>
						<p class="text-muted card-text"><%=leclass %>
							<br>
							<%=area %></p>
					</div>
					<div align="right" style="margin-right: 20px;">
						<img src="img/star.png" width="15" height="15"><%=star %>
						(<%=count %>)
					</div>
				</div>
			</div>
			<%} %>

		</div>
	</div>
	<br>
	<hr>
	<br>
	<div class="container">
		<div class="heading">
			<h2>학생</h2>
		</div>
		<br>
		<div class="row">
			<%
	        	Vector<StudentBean> Svlist=Smgr.getSearchList(keyWord);
	        	//int listsize=vlist.size();
	        	for(int i=0;i<Svlist.size();i++){
	        		StudentBean Sbean=Svlist.get(i);
	        		//imgname, ac_name,group2, ac_tel,star,count
	        		int num=Sbean.getNum();
	        		String img=Sbean.getImgname();
	        		String name=Sbean.getName();
	        		String stclass=Sbean.getStclass();
	        		String school_name=Sbean.getSchool_name();
	        		String school_grade=Sbean.getSchool_grade();
	        		int count=Sbean.getCount();
	        		
	        %>
			<div class="col-md-6 col-lg-4">
				<div class="card border-0 transform-on-hover">
					<a class="lightbox" href="stRead.jsp?num=<%=num%>"> <img
						src="img/no_image.jpg" alt="Card Image" class="card-img-top">
					</a>
					<div class="card-body">
						<h6>
							<a href="stRead.jsp?num=<%=num%>"><%=name %></a>
						</h6>
						<p class="text-muted card-text"><%=school_name %>
							&nbsp;
							<%=school_grade %></p>
					</div>
					<div align="right" style="margin-right: 20px;">
						(<%=count %>)
					</div>
				</div>
			</div>
			<%} %>
		</div>

	</div>
	</section>


</body>
</html>
