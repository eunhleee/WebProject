<%@page import="alcinfo.UtilMgr"%>
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
		int maxPage;
		if(request.getParameter("maxPage")==null){
			maxPage=6;
		}
		else{
			maxPage=UtilMgr.parseInt(request,"maxPage");
		}
		
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
<script>
	function morePage(){
		location.href="upPageSearch.jsp?maxPage=<%=maxPage%>&keyWord=<%=keyWord%>";
	}
</script>
<style type="text/css">
@font-face { 
font-family: 'Godo'; font-style: normal;
font-weight: 400;
src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff2') format('woff2'), 
	url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff') format('woff'); }
@font-face {
	font-family: 'Godo'; font-style: normal;
	font-weight: 700; 
 	src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff2') format('woff2'),
url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff') format('woff'); } 
 	.godo * { font-family: 'Godo', sans-serif; }
 body{
 	font-family:'Godo';}
#btnmore{
	border:none;
	background-color:white;
	text-size:20px;
	text-decoration:underline;
}
</style>
</head>
<body>

	<%@ include file="mainHeader.jsp"%>
	
	<section class="gallery-block cards-gallery">
	<br>
	
	<div class="container">
	<h3>"<%=keyWord %>"에 대한 검색 결과 입니다.</h3><br>
		<div class="heading">
			<h2>학원</h2>
		</div>
		<br>
		<div class="row">
			<%
	        	Vector<AcademyBean> Avlist=Amgr.getSearchList(keyWord);
	        	int alistsize=Avlist.size();
	        	if(alistsize>=6){
	        		alistsize=maxPage;
	        	}
	        	for(int i=0;i<alistsize;i++){
	        		
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
					<a class="lightbox" href="../Academy/acRead.jsp?num=<%=num%>"> <img
						src="../img/no_image.jpg" alt="Card Image" class="card-img-top">
					</a>
					<div class="card-body">
						<h6>
							<a href="../Academy/acRead.jsp?num=<%=num%>"><%=name %></a>
						</h6>
						<p class="text-muted card-text"><%=group2 %>
							<br>
							<%=tel %></p>
					</div>
					<div align="right" style="margin-right: 20px;">
						<img src="../img/star.png" width="15" height="15"><%=star %>
						(<%=count %>)
					</div>
				</div>
			</div>
			<%} %>

		</div>
		<input id="btnmore" type="button" onclick="javascript:morePage();" value="검색 결과 더 보기">
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
					<a class="lightbox" href="../Lesson/leRead.jsp?id=<%=id%>&num=<%=num%>"> <img
						src="../img/no_image.jpg" alt="Card Image" class="card-img-top">
					</a>
					<div class="card-body">
						<h6>
							<a href="../Lesson/leRead.jsp?id=<%=id%>&num=<%=num%>"><%=name %></a>
						</h6>
						<p class="text-muted card-text"><%=leclass %>
							<br>
							<%=area %></p>
					</div>
					<div align="right" style="margin-right: 20px;">
						<img src="../img/star.png" width="15" height="15"><%=star %>
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
					<a class="lightbox" href="../Student/stRead.jsp?num=<%=num%>"> <img
						src="../img/no_image.jpg" alt="Card Image" class="card-img-top">
					</a>
					<div class="card-body">
						<h6>
							<a href="../Student/stRead.jsp?num=<%=num%>"><%=name %></a>
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
