<!-- 학원 정보 중 평점과 조회순으로 6개씩만 읽어오게 하는 창 -->
<%@page import="alcinfo.AcademyBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="Amgr" class="alcinfo.AcademyMgr"></jsp:useBean>

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
				Vector<AcademyBean> Avlist = Amgr.getBestBoard("top", sort);
				//int listsize=vlist.size();
				for (int i = 0; i < 6; i++) {
					AcademyBean Abean = Avlist.get(i);
					//imgname, ac_name,group2, ac_tel,star,count
					int num = Abean.getNum();
					String img = Abean.getImgname();
					String name = Abean.getAc_name();
					String group2 = Abean.getGroup2();
					String tel = Abean.getAc_tel();
					float star = Abean.getStar();
					int count = Abean.getCount();
					if (tel.equals(""))
						tel = "번호 정보가 없습니다.";
			%>
			<div class="col-md-6 col-lg-4">
				<div class="card border-0 transform-on-hover">
					<a class="lightbox" href="../Academy/acRead.jsp?num=<%=num%>"> <img
						src="../img/no_image.jpg" alt="Card Image" class="card-img-top">
					</a>
					<div class="card-body">
						<h6>
							<a href="../Academy/acRead.jsp?num=<%=num%>"><%=name%></a>
						</h6>
						<p class="text-muted card-text"><%=group2%>
							<br>
							<%=tel%></p>
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
				Avlist = Amgr.getCountBoard();
				//int listsize=vlist.size();
				for (int i = 0; i < 6; i++) {
					AcademyBean Abean = Avlist.get(i);
					//imgname, ac_name,group2, ac_tel,star,count
					int num = Abean.getNum();
					String img = Abean.getImgname();
					String name = Abean.getAc_name();
					String group2 = Abean.getGroup2();
					String tel = Abean.getAc_tel();
					float star = Abean.getStar();
					int count = Abean.getCount();
					if (tel.equals(""))
						tel = "번호 정보가 없습니다.";
			%>
			<div class="col-md-6 col-lg-4">
				<div class="card border-0 transform-on-hover">
					<a class="lightbox" href="#"> <img src="//img/no_image.jpg"
						alt="Card Image" class="card-img-top">
					</a>
					<div class="card-body">
						<h6>
							<a href="#"><%=name%></a>
						</h6>
						<p class="text-muted card-text"><%=group2%>
							<br>
							<%=tel%></p>
					</div>
					<div align="right" style="margin-right: 20px;">
						<img src="//img/star.png" width="15" height="15"><%=star%>
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