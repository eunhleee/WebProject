<!-- le_ReviewRead.jsp -->
<%@page import="java.util.Vector"%>
<%@page import="alcinfo.LereviewBean"%>
<%@page import="alcinfo.LeRcommentsBean"%>
<%@page import="alcinfo.MemberBean"%>
<%@page import="alcinfo.LessonBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.LessonMgr" />
<jsp:useBean id="lermgr" class="alcinfo.LereviewMgr"/>
<jsp:useBean id="lercmgr" class="alcinfo.LeRcommentsMgr"/>
<jsp:useBean id="Mmgr" class="alcinfo.MemberMgr" />

<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	String loginid = (String)session.getAttribute("idKey");
	String loginNick = lermgr.memberNick(loginid);
	
	String id = request.getParameter("id");
	int num = UtilMgr.parseInt(request, "num");
	int lernum = UtilMgr.parseInt(request, "lernum");
	LessonBean lebean = mgr.getLesson(id);
	
	String flag = request.getParameter("flag");
	if(flag!=null) {
		if(flag.equals("insert")) {
			LeRcommentsBean lerbean = new LeRcommentsBean();
			lerbean.setLer_num(lernum);
			lerbean.setLer_id(loginid);
			lerbean.setLer_content(request.getParameter("comment"));
			lerbean.setLer_ip(request.getParameter("ip"));
			lercmgr.insertLerComment(lerbean);
		} else if(flag.equals("insert1")) {
			LeRcommentsBean lerrbean = new LeRcommentsBean();
			lerrbean.setLer_num(lernum);
			lerrbean.setLer_id(loginid);
			lerrbean.setLer_content(request.getParameter("comment"));
			lerrbean.setLer_ip(request.getParameter("ip"));
			lerrbean.setLer_conum(UtilMgr.parseInt(request, "conum"));
			lercmgr.insertLerCReply(lerrbean);
		} else if(flag.equals("del1")) {
			lercmgr.deleteAllLerCReply(UtilMgr.parseInt(request, "conum"));
		} else if(flag.equals("del2")) {
	//			요청한 댓글 삭제
			lercmgr.deleteLerComment(UtilMgr.parseInt(request, "cnum"));
		}
	} else {
	//		조회수 증가 : list.jsp 게시물 읽어옴
		lermgr.LerupCount(lernum);
	}
	
	LereviewBean lrbean = lermgr.getReview(lernum);
	String lrid = lrbean.getLr_id();
	String title = lrbean.getLr_title();
	String nickname = lrbean.getLr_nick();
	Double star = lrbean.getLr_star();
	String regdate = lrbean.getLr_date();
	String content = lrbean.getLr_content();
	String ip = lrbean.getLr_ip();
	int count = lrbean.getLr_count();
	int ccount = lermgr.lerccount(lernum);
	//읽어온 게시물을 수정 및 삭제를 위해 세션저장
	session.setAttribute("bean", lrbean);
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>우리 학원 어디?-과외 리뷰</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
.totalFrame{
	background-color:#FAF8EB;
	padding:40px 0px;
}

#readDiv{
	margin-bottom:40px;
	margin-left:10%;
	width:79%;
	align:center;
	background-color:white;
	border: 10px solid #36ada9; 
	border-radius:10px;
	padding:20px 40px;
}
#list td {
	border-bottom: 1px solid lightgray;
}

#title td {
	color: white;
	background-color: #36ada9;
}

a {
	text-decoration: none;
	color: black;
}

a:hover {
	color: gray;
}
.lerReply {
	display:none;
}
.tdBorder{
	border-right:3px solid #56C8D3;
}
</style>

<script>
google.charts.load("current",{packages:['corechart']});

function columnChart1(arrayList) {
	// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
	 
	alert(arrayList);
	 arrayList = eval('('+arrayList+')');

	 
/* 	arrayList=[["2015",2],["2020",5]]; */
	var dataTable = new google.visualization.DataTable();
	dataTable.addColumn('string','Date');
	dataTable.addColumn('number','register');
	dataTable.addRows(arrayList);
	// 옵션객체 준비
	var options = {
	title: '날짜 별 등록 학생수',
	legend: 'top',
	 colors: ['#FCBC7E']
	};
	// 차트를 그릴 영역인 div 객체를 가져옴
	var objDiv = document.getElementById('column_chart_div1');
	// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
	var chart = new google.visualization.ColumnChart(objDiv);
	// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
	chart.draw(dataTable, options);
	/* var chart = new google.charts.Bar(objDiv);
	// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
	chart.draw(dataTable,google.charts.Bar.convertOptions(options)); */
} // drawColumnChart1()의 끝

function graph(){
	$.ajax({
	dataType:"text",
	
	url:'columnChart1.jsp?id=<%=id%>',
	success:function(result){
	columnChart1(result);
	}, 
	error:function(request, error){
		alert("에러");
		alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	} 
	});
}
	
	function moveQnA(){
			url = "le_QnA.jsp?lq_lnum="+<%=lebean.getNum()%>;
			window.open(url, "Le_QnA", "width=800, height=500, top=200, left=400");
			
		}
		
		
		function insert() // no ';' here
		{
		    var elem = document.getElementById("myButton1");
		    
			location.href="insertStudentProc.jsp?id=<%=id%>&num=<%=lebean.getNum()%>";
			   
		}
		
		function cancel(){
			var elem = document.getElementById("myButton2");
			location.href="deleteStudentProc.jsp?id=<%=id%>&num=<%=lebean.getNum()%>";
		}
		
	
	
	function goReport() {
		url = "../Report/reportReceiptLInf.jsp?stopid="+<%=id%>;
		window.open(url, "GoReport", "width=360, height=300, top=200, left=300");
	}
	
	function list() {
		location.href = "leRead.jsp?num=<%=num%>&id=<%=id%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
	  	 	if(!(keyWord==null||keyWord.equals(""))){
			     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
	}
	function cInsert() {
		if(document.cFrm.comment.value==""){
			alert("댓글을 입력하세요.");
			document.cFrm.comment.focus();
			return;
		}
		document.cFrm.submit();
	}
	function cDel(conum, cnum, depth) {
		if(depth==0) { // 댓글 삭제 시 대댓글까지 전부 삭제
			document.cFrm.flag.value="del1";
			document.cFrm.conum.value=conum;
			document.cFrm.submit();
		} else if(depth==1) { // 대댓글 삭제
			document.cFrm.flag.value="del2";
			document.cFrm.cnum.value=cnum;
			document.cFrm.submit();
		}
	}
	
	function goRep() {
		
		url = "stQReport.jsp?stopid=<%=id%>&renum=<%=num%>";
		window.open(url, "GoReport", 'width=900, height=560, top=200, left=300');
	}

	function goCReport(conum,stuc_depth,stopid) {
		url = "stQCReport.jsp?conum="+conum+"&stuc_depth="+stuc_depth+"&renum="+<%=num%>+"&stopid="+stopid;
		window.open(url, "GoReport", "width=900, height=560, top=200, left=300");
		}
	function goRep() {
		
		url = "leLReport.jsp?stopid=<%=id%>&renum=<%=num%>";
		window.open(url, "GoReport", 'width=900, height=560, top=200, left=300');
	}

	function goCReport(conum,stuc_depth,stopid) {
		url = "leLCReport.jsp?conum="+conum+"&stuc_depth="+stuc_depth+"&renum="+<%=num%>+"&stopid="+stopid;
		window.open(url, "GoReport", "width=900, height=560, top=200, left=300");
		}
</script>

</head>
<body>
<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>

<!-- 읽기 Start -->
<div class="totalFrame">
<div id="readDiv">
	<table align="center" cellspacing="3" width="100%" bgcolor="white">
	 <tr>
	  <td>
	   <table cellpadding="3" cellspacing="0" width="100%"> 
	    <tr height="100"> 
	    <td colspan="8">
	    <span style="font-size:30px;"><%=title%></span> 
	    <% if(loginid!=null) {%>		    
		 <input type="button" value="신고" onclick="javascript:goRep();" style="float:right;">
		  <%}%></td>
		</tr>
	    <tr height="20"> 
				<td class="tdBorder" width="6%" > 닉 네 임</td>
				<td  width="10%">&nbsp;<%=id%></td>
				<td class="tdBorder" width="6%" > 등록날짜 </td>
				<td width="10%">&nbsp;<%=regdate%></td>
				<td class="tdBorder" width="6%" > 조 회 수</td>
				<td  width="10%">&nbsp;<%=count%></td>
				<td class="tdBorder" width="4%"  > 평 점</td>
		    <td >&nbsp;<img src="../img/star.png" width="10" height="10"><%=star%></td>
			</tr>
		   
		   <tr><td colspan="8"><hr style="border:1px solid lightgray;"></td>
		   <tr> 
		    <td colspan="6" height="200"><span><%=content%></span></td>
		   </tr>
		   <tr>
		    <td colspan="3" align="left">
		    	댓글 <%=ccount%>
		    </td>
	   </tr>
	   </table>
	  </td>
	 </tr>
	 <tr>
	  <td colspan="2">
	 <hr/>
 	<!-- 댓글 List Start -->
	  <%
	  	Vector<LeRcommentsBean> cvlist = lercmgr.getLeRComment(lernum);
	      	if(!cvlist.isEmpty()){
	  %>
		 <table width="100%">
		 <%
			 	for(int i=0;i<cvlist.size();i++){
			 		LeRcommentsBean lercbean = cvlist.get(i);
		 	 			int cnum = lercbean.getNum();
		 	 			String cnick = lercbean.getLer_nick();
		 	 			String comment = lercbean.getLer_content();
		 	 			String cregdate = lercbean.getLer_regdate();
		 	 			int conum = lercbean.getLer_conum();
		 	 			int depth = lercbean.getLer_depth();
		 	 			String stopid=lercbean.getLer_id();

	 					String dstyle = "", dstyle1 = "";
		 	 			if(depth==1) {
		 	 				dstyle = "style=\"padding-left:30px;\"";		
 		 	 				dstyle1 = "padding-left:30px;";
		 			}
		 %>
		 	
		 	<tr>
				<td <%=dstyle%> colspan="4" width="600"><b><%=cnick%></b></td>
			</tr>
			<tr>
				<td <%=dstyle%> colspan="3" style=" min-height:150px;"><%=comment%></td>
				<td align="right">
				<% 
				  if(loginNick!=null) {
					if(loginNick.equals(cnick)||lermgr.checkM(loginid)==0) { %>
					<input type="button" value="삭제"
					onclick="cDel('<%=conum%>','<%=cnum%>','<%=depth%>')">
					<% 	}%>
					<input type="button" value="댓글신고"
					onclick="javascript:goCReport
					('<%=cnum%>','<%=depth%>','<%=stopid%>')">
				<%} %>
				</td>
			</tr>
			<tr>
				<td colspan="3" style="font-size:12px; color:gray; <%=dstyle1%>">
				<%=cregdate%>
				<% if(loginid!=null) { %>
				<a href="javascript:onlerReply<%=i%>();">답글쓰기</a>
				<% } %>
				
				<!-- 답글쓰기 Start -->
				
				<script>
				 	function onlerReply<%=i%>() {
				 		document.getElementById("lerReply<%=i%>").style.display = 'block';
				 	}
				 	function offlerReply<%=i%>() {
				 		document.getElementById("lerReply<%=i%>").style.display = 'none';
				 	}
				 	function rInsert<%=i%>() {
				 		if(document.lerFrm<%=i%>.comment.value==""){
				 			alert("댓글을 입력하세요.");
				 			document.lerFrm<%=i%>.comment.focus();
				 			return;
				 		}
				 		document.lerFrm<%=i%>.submit();
				 	}
		 		</script>
				<div id="lerReply<%=i%>" class="lerReply">
					<form method="post" name="lerFrm<%=i%>">
						<table>
							<tr>
								<td><%=loginNick%>&nbsp;:&nbsp;</td>
								<td>
								<div id="inputdiv" style="width:500px; display:flex; backgound-color:white;">
								<input name="comment" size="50" placeholder="댓글을 남겨보세요" style="flex:3;"> 
								<input type="button" value="등록" onclick="rInsert<%=i%>()" style="flex:1; margin-right:5px;">
								<input type="button" value="취소" onclick="offscReply<%=i%>()" style="flex:1;">
								</div>
								</td>
							</tr>
						</table>
					<input type="hidden" name="cid" value="<%=loginNick%>">
					<input type="hidden" name="flag" value="insert1">
					<input type="hidden" name="lernum" value="<%=lernum%>">
					<input type="hidden" name="cnum">
					<input type="hidden" name="conum" value="<%=conum%>">
					<input type="hidden" name="depth" value="<%=depth%>">
				    <input type="hidden" name="nowPage" value="<%=nowPage%>">
				    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
					<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
				    <%
				  	 	if(!(keyWord==null||keyWord.equals(""))){
				    %>
				    <input type="hidden" name="keyField" value="<%=keyField%>">
				    <input type="hidden" name="keyWord" value="<%=keyWord%>">
					<%
						}
					%>
					</form>
				</div>
				
				<!-- 답글쓰기 End -->
				
				</td>
			</tr>
		 <% }//---for%>
		 </table>	
	 <hr/>
	 <% } %>
		 <!-- 댓글 List End -->
		 <!-- 댓글 입력폼 Start -->
		<% if(loginid!=null) { %>
	   <form method="post" name="cFrm">
	   <div id="inputdiv" style="width:97%; background-color:white;">
			<table width="97%">
				<tr>
					<td colspan="4"><%=loginNick%></td>
				</tr>
				<tr>
					<td colspan="3" width="90%">
						<input name="comment"  placeholder="댓글을 남겨보세요" style="width:95%; height:30px;"> 
					</td>
					<td align="right">
						<input type="button" value="등록" onclick="cInsert()" style=" height:30px;">
					</td>
				</tr>
			</table>
		</div>
		<input type="hidden" name="cid" value="<%=loginNick%>">
		<input type="hidden" name="flag" value="insert">	
		<input type="hidden" name="num" value="<%=num%>">
		<input type="hidden" name="cnum">
		<input type="hidden" name="conum">
	    <input type="hidden" name="nowPage" value="<%=nowPage%>">
	    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
		<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
		   <%
		   	if(!(keyWord==null||keyWord.equals(""))){
		   %>
	    <input type="hidden" name="keyField" value="<%=keyField%>">
	    <input type="hidden" name="keyWord" value="<%=keyWord%>">
		<%
			}
		%>
		</form>
		<% } %>
	   <!-- 댓글 입력폼 End -->
	 [ <a href="javascript:list();" >리스트</a>
	 <% 
	 if(loginNick!=null) {
		 if(loginNick.equals(nickname)||lermgr.checkM(loginid)==0) { %>
		 | <a href="le_ReviewUpdate.jsp?num=<%=num%>&id=<%=id%>&lernum=<%=lernum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
 	 	if(!(keyWord==null||keyWord.equals(""))){
	     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>" >수 정</a> |
		 <a href="le_ReviewDelete.jsp?num=<%=num%>&id=<%=id%>&lernum=<%=lernum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
 	 	if(!(keyWord==null||keyWord.equals(""))){
	     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>">삭 제</a> 
	 <% }
	 } %>
	 ]<br/>
	  </td>
	 </tr>
	</table>


	<form name="listFrm" method="post">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
		<%if(!(keyWord==null||keyWord.equals(""))){%>
		<input type="hidden" name="keyField" value="<%=keyField%>">
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
		<%}%>
	</form>
	
<!-- 읽기 End -->		
		
	</div>
<%@ include file="../alcinfo/footer.jsp"%>
</div>
</body>

</html>