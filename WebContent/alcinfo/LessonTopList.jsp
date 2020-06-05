<!-- 과외의 평점별/조회수별 리스트 6개씩만 나타내는 창 -->
<%@page import="alcinfo.LessonBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=utf-8"%>

<jsp:useBean id="Lmgr" class="alcinfo.LessonMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	String sort = request.getParameter("sort");
%>

<section class="gallery-block cards-gallery">
	<div class="container">
		<div class="heading">
			<h2>평점 TOP6</h2>
		</div>
		<br>
		<div class="row">
			<%
				Vector<LessonBean> Lvlist = Lmgr.getBestBoard("top", "star");
				//int listsize=vlist.size();
				for (int i = 0; i < Lvlist.size(); i++) {
					LessonBean Lbean = Lvlist.get(i);
					//imgname, ac_name,group2, ac_tel,star,count

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
						src="img/no_image.jpg" alt="Card Image" class="card-img-top">
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
						<img src="img/star.png" width="15" height="15"><%=star%>
						(<%=count%>)
					</div>
				</div>
			</div>
			<%
				}
			%>

		</div>
	</div>
	<br>
	<hr>
	<br>
	<div class="container">
		<div class="heading">
			<h2>조회수 TOP6</h2>
		</div>
		<br>
		<div class="row">
			<%
				Lvlist = Lmgr.getCountBoard();
				//int listsize=vlist.size();
				for (int i = 0; i < Lvlist.size(); i++) {
					LessonBean Lbean = Lvlist.get(i);
					//imgname, ac_name,group2, ac_tel,star,count

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
						src="img/no_image.jpg" alt="Card Image" class="card-img-top">
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
						<img src="img/star.png" width="15" height="15"><%=star%>
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