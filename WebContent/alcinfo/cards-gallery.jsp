<!-- 메인 화면 -->
<%@page import="alcinfo.LessonBean"%>
<%@page import="alcinfo.AcademyBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="Amgr" class="alcinfo.AcademyMgr"></jsp:useBean>
<jsp:useBean id="Lmgr" class="alcinfo.LessonMgr"></jsp:useBean>
<jsp:setProperty property="*" name="mpbean"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
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
	<br><br>
		<div class="container">
			<div class="heading">
				<h2>학원 BEST</h2>
			</div>
			<br>  
			<div class="row">  
				<%
			
	        	Vector<AcademyBean> Avlist=Amgr.getBestBoard("top","star");
	        	//int listsize=vlist.size();
	        	for(int i=0;i<6;i++){
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
							(<%=count%>)
						</div>
					</div>
				</div>
				<%} %>
				<div>
					<a href="../Academy/AcademyMain.jsp?pageValue=top">학원 더 알아보기</a>
				</div>
			</div>
		</div>
		<br>
		<hr>
		<br>
		<div class="container">
			<div class="heading">
				<h2>과외 BEST</h2>
			</div>
			<br>
			<div class="row">
				<%
	              Vector<LessonBean> Lvlist=Lmgr.getBestBoard("top","star");
	        	//int listsize=vlist.size();
	        	for(int i=0;i<Lvlist.size();i++){
	        		LessonBean Lbean=Lvlist.get(i);
	        		//le.num,tea.name,tea.class,tea.area,le.star,le.count
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
						<a class="lightbox" href="../Lesson/leRead.jsp?num=<%=num %>&id=<%=id%>"> <img
							src="../img/no_image.jpg" alt="Card Image" class="card-img-top">
						</a>
						<div class="card-body">
							<h6>
								<a href="../Lesson/leRead.jsp?num=<%=num%>&id=<%=id%>"><%=name %></a>
							</h6>
							<p class="text-muted card-text"><%=leclass %><br>
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
			<div>
				<a href="../Lesson/LessonMain.jsp">과외 더 알아보기</a>
			</div>
		</div>
	</section>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js"></script>
	<script>
		baguetteBox.run('.cards-gallery', {
			animation : 'slideIn'
		});
	</script>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>