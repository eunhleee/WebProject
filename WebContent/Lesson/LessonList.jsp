<!-- 과외의 과목별 리스트 창 -->
<%@page import="alcinfo.LessonBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="Lmgr" class="alcinfo.LessonMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	String pageValue = request.getParameter("pageValue");
	String sort = request.getParameter("sort");
	Vector<LessonBean> Lvlist = new Vector<LessonBean>();
%>
<html>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css" />
<link rel="stylesheet" href="../alcinfo/cards-gallery.css">
<head>
<style>
.main {
	align: center;
	max-width: 70%;
	padding: 50px;
	margin: 0 auto;
	background: #ffffff;
}

section {
	display: none;
	padding: 20px 0 0;
	border-top: 1px solid #ddd;
}

/*라디오버튼 숨김*/
#tab1, #tab2{
	display: none;
}

label {
	display: inline-block;
	margin: 0 0 -1px;
	padding: 15px 25px;
	font-weight: 600;
	text-align: center;
	color: #bbb;
	border: 1px solid transparent;
}

label:hover {
	color: #F88C65;
	cursor: pointer;
}

/*input 클릭시, label 스타일*/
input:checked+label {
	color: #555;
	border: 1px solid #ddd;
	border-top: 2px solid #F88C65;
	border-bottom: 1px solid #ffffff;
}

#tab1:checked ~ #content1, #tab2:checked ~ #content2 {
	display: block;
}
</style>
</head>
<body>
	<div class="main">
		<input id="tab1" type="radio" name="tabs" checked>
		<!--디폴트 메뉴-->
		<label for="tab1">평점순</label>
		 <input id="tab2" type="radio" name="tabs"> 
		 <label for="tab2">조회순</label> 
		

		<section class="gallery-block cards-gallery" id="content1">
			<div class="container">
				<div class="heading">
					<h2>List</h2>
				</div>
				<br>
				<div class="row">
					<%
						Lvlist = Lmgr.getBestBoard(pageValue, "le.star");
						int listsize = Lvlist.size();
						for (int i = 0; i < listsize; i++) {
							LessonBean Lbean = Lvlist.get(i);
							int num = Lbean.getNum();
							String id = Lbean.getId();
							String name = Lbean.getName();
							String leclass = Lbean.getLeclass();
							String area = Lbean.getArea();
							float star = Lbean.getStar();
							int count = Lbean.getCount();
					%>
					<div class="col-md-6 col-lg-4">
						<div class="card border-0 transform-on-hover">
							<a class="lightbox" href="leRead.jsp?num=<%=num %>&id=<%=id%>"> <img
								src="../img/no_image.jpg" alt="Card Image" class="card-img-top">
							</a>
							<div class="card-body">
								<h6>
									<a href="leRead.jsp?num=<%=num %>&id=<%=id%>"><%=name%></a>
								</h6>
								<p class="text-muted card-text"><%=leclass%>
									<br>
									<%=area%></p>
							</div>
							<div align="right" style="margin-right: 20px;">
								<img src="../img/star.png" width="15" height="15"><%=star%>
								(<%=count%>)
							</div>
						</div>
					</div>
					<%
						}
					%>

				</div>
			</div>
			
		</section>

		<section class="gallery-block cards-gallery" id="content2">
			<div class="container">
				<div class="heading">
					<h2>List</h2>
				</div>
				<br>
				<div class="row">
					<%
						Lvlist = Lmgr.getBestBoard(pageValue,"le.count");

						for (int i = 0; i < Lvlist.size(); i++) {
							LessonBean Lbean = Lvlist.get(i);
							//imgname, ac_name,group2, ac_tel,star,count

							int num = Lbean.getNum();
							String img = Lbean.getImgname();
							String id = Lbean.getId();
							String name = Lbean.getName();
							String leclass = Lbean.getLeclass();
							String area = Lbean.getArea();
							float star = Lbean.getStar();
							int count = Lbean.getCount();
					%>
					<div class="col-md-6 col-lg-4">
						<div class="card border-0 transform-on-hover">
							<a class="lightbox" href="leRead.jsp?num=<%=num %>&id=<%=id%>"> <img
								src="../TeacherImg/<%=img %>" width="350" height="200" alt="Card Image" class="card-img-top">
							</a>
							<div class="card-body">
								<h6>
									<a href="leRead.jsp?num=<%=num %>&id=<%=id%>"><%=name%></a>
								</h6>
								<p class="text-muted card-text"><%=leclass%>
									<br>
									<%=area%></p>
							</div>
							<div align="right" style="margin-right: 20px;">
								<img src="../img/star.png" width="15" height="15"><%=star%>
								(<%=count%>)
							</div>
						</div>
					</div>
					<%
						}
					%>

				</div>
			</div>
			
		</section>

	
	</div>
</body>
</html>