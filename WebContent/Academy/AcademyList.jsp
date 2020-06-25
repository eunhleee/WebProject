
<!-- 학원 과목별 정보리스트 -->

<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.AcademyBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="Amgr" class="alcinfo.AcademyMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	String pageValue = request.getParameter("pageValue");
	String sort = request.getParameter("sort");
	Vector<AcademyBean> Avlist = new Vector<AcademyBean>();
	int maxPage;
	int maxPage1=6;
	if(request.getParameter("maxPage")==null){
		maxPage=6;
	}
	else{
		maxPage=UtilMgr.parseInt(request,"maxPage");
	}
	
%>
<html>
<head>

<script>
 function morePage(){
	location.href="../Academy/upPageStar.jsp?maxPage=<%=maxPage%>&pageValue=<%=pageValue%>";
 }
 function morePage1(){
	 location.href="../Academy/upPageCount.jsp?maxPage1=<%=maxPage1%>&pageValue=<%=pageValue%>";
 }
</script>
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
#tab1, #tab2 {
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

#tab1:checked ~ #content1, #tab2:checked ~ #content2{
	display: block;
}
#btnmore{
	border:none;
	background-color:white;
	text-size:20px;
	text-decoration:underline;
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
						Avlist = Amgr.getBestBoard(pageValue, "star",maxPage);
						int listsize = Avlist.size();
	
						for (int i = 0; i < listsize; i++) {
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
							<a class="lightbox" href="acRead.jsp?num=<%=num%>"> <img
								src="../AcademyImg/<%=img %>" width="350" height="200" alt="Card Image" class="card-img-top">
							</a>
							<div class="card-body">
								<h6>
									<a href="acRead.jsp?num=<%=num%>"><%=name%></a>
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
			<input id="btnmore" type="button" onclick="javascript:morePage();" value="학원 더 보기">
			
		</section>

		<section class="gallery-block cards-gallery" id="content2">
			<div class="container">
				<div class="heading">
					<h2>List</h2>
				</div>
				<br>
				<div class="row">
					<%
						Avlist = Amgr.getBestBoard(pageValue, "count",maxPage1);

						for (int i = 0; i < Avlist.size(); i++) {
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
							<a class="lightbox" href="acRead.jsp?num=<%=num%>"> <img
								src="../img/no_image.jpg" alt="Card Image" class="card-img-top">
							</a>
							<div class="card-body">
								<h6>
									<a href="acRead.jsp?num=<%=num%>"><%=name%></a>
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
			<input id="btnmore" type="button" onclick="javascript:morePage1();" value="학원 더 보기">
		</section>

	</div>
</body>
</html>