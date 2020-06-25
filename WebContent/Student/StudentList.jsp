<!-- 학생 과목별 리스트 출력 -->
<%@page import="alcinfo.StudentBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="Smgr" class="alcinfo.StudentMgr"></jsp:useBean>
<%
		request.setCharacterEncoding("utf-8");
		String pageValue=request.getParameter("pageValue");
%>
<section class="gallery-block cards-gallery">
	<div class="container">
		<div class="heading">
			<h2><%=pageValue %>&nbsp;LIST
			</h2>
		</div>
		<br>
		<div class="row">
			<%
	        	Vector<StudentBean> Svlist=Smgr.getBestBoard(pageValue);
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
					<a class="lightbox" href="stRead.jsp?stunum=<%=num%>"> 
					<img src="../StudentImg/<%=img%>" width="350" height="200" alt="Card Image" class="card-img-top">
					</a>
					<div class="card-body">
						<h6>
							<a href="stRead.jsp?stunum=<%=num%>"><%=name %></a>
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
	<br>
</section>