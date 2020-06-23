<!-- st_QnARead.jsp -->
<%@page import="alcinfo.StinqueryBean"%>
<%@page import="alcinfo.StQcommentsBean"%>
<%@page import="alcinfo.MemberBean"%>
<%@page import="java.util.Vector"%>
<%@page import="alcinfo.StudentBean"%>
<%@page import="alcinfo.LeteaBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.StudentMgr" />
<jsp:useBean id="Lmgr" class="alcinfo.LeteaMgr" />
<jsp:useBean id="Rmgr" class="alcinfo.ReportMgr" />
<jsp:useBean id="stqmgr" class="alcinfo.StinqueryMgr"/>
<jsp:useBean id="stqcmgr" class="alcinfo.StQcommentsMgr"/>

<%
	request.setCharacterEncoding("UTF-8");
	int stunum = Integer.parseInt(request.getParameter("stunum"));
	MemberBean mbean=Rmgr.getStuId(stunum);
	StudentBean stbean = mgr.getStudent(stunum);
// 	stbean.setNum(stunum);

	int num = UtilMgr.parseInt(request, "num");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	String loginid = (String)session.getAttribute("idKey");
	
	String flag = request.getParameter("flag");
	if(flag!=null) {
		if(flag.equals("insert")) {
			StQcommentsBean stqbean = new StQcommentsBean();
			stqbean.setStq_num(num);
			stqbean.setStq_id(request.getParameter("cid"));
			stqbean.setStq_content(request.getParameter("comment"));
			stqbean.setStq_ip(request.getParameter("ip"));
			stqcmgr.insertStQComment(stqbean);
		} else if(flag.equals("insert1")) {
			StQcommentsBean stqrbean = new StQcommentsBean();
			stqrbean.setStq_num(num);
			stqrbean.setStq_id(request.getParameter("cid"));
			stqrbean.setStq_content(request.getParameter("comment"));
			stqrbean.setStq_ip(request.getParameter("ip"));
			stqrbean.setStq_conum(UtilMgr.parseInt(request, "conum"));
			stqcmgr.insertStQCReply(stqrbean);
		} else if(flag.equals("del1")) {
			stqcmgr.deleteAllStQCReply(UtilMgr.parseInt(request, "conum"));
		} else if(flag.equals("del2")) {
// 			요청한 댓글 삭제
			stqcmgr.deleteStQComment(UtilMgr.parseInt(request, "cnum"));
		}
	} else {
// 		조회수 증가 : list.jsp 게시물 읽어옴
		stqmgr.StQupCount(num);
	}
	
	StinqueryBean sqbean = stqmgr.getQuery(num);
	String id = sqbean.getId();
	String title = sqbean.getTitle();
	String regdate = sqbean.getSt_date();
	String content = sqbean.getContent();
	String ip = sqbean.getIp();
	int count = sqbean.getCount();
	int ccount = stqmgr.stqccount(stunum);
	//읽어온 게시물을 수정 및 삭제를 위해 세션저장
	session.setAttribute("bean", sqbean);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>우리 학원 어디?-학생 문의</title>
<style>
#readDiv{
	margin-top:50px;
	margin-left:15%;
	width:65%;
	align:center;
	border: 10px solid #F88C65; 
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
.stqReply {
	display:none;
}
</style>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>

function insert() // no ';' here
{
    var elem = document.getElementById("myButton1");
    location.href="insertTeaProc.jsp?stunum=<%=stunum%>";
}
function deleteT(){
	var elem = document.getElementById("myButton2");
    location.href="deleteTeaProc.jsp?stunum=<%=stunum%>";
	
}

google.charts.load('current',{packages:['corechart']});
google.charts.setOnLoadCallback(drawChart);
google.charts.setOnLoadCallback(function(){
	setInterval(columnChart1(),30000);
	}); 

function columnChart1(arrayList) {
	// 실 데이터를 가진 데이터테이블 객체를 반환하는 메소드
	var dataTable = google.visualization.arrayToDataTable(arrayList);
	// 옵션객체 준비
	var options = {
	title: '날짜 별 등록 선생님 수'
	};
	// 차트를 그릴 영역인 div 객체를 가져옴
	var objDiv = document.getElementById('column_chart_div1');
	// 인자로 전달한 div 객체의 영역에 컬럼차트를 그릴수 있는 차트객체를 반환
	var chart = new google.charts.Bar(objDiv);
	// 차트객체에 데이터테이블과 옵션 객체를 인자로 전달하여 차트 그리는 메소드
	chart.draw(dataTable,google.charts.Bar.convertOptions(options));
} // drawColumnChart1()의 끝


function graph(){
	
		$.ajax({
		url:'columnChart2.jsp?stunum=<%=stunum%>',
		success:function(result){
		columnChart1(result);
		}
		});
		document.getElementById("btn").value='그래프 숨기기';
	
}

function goReport() {
	url = "../Report/reportReceiptLInf.jsp?stopid="+<%=mbean.getId()%>;
	window.open(url, "GoReport", "width=360, height=300, top=200, left=300");
}
function list() {
	location.href = "stRead.jsp?stunum=<%=stunum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
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
	
	url = "stQReport.jsp?stopid=<%=id%>&renum=<%=stunum%>";
	window.open(url, "GoReport", 'width=360, height=300, top=200, left=300');
}

function goCReport(conum,stuc_depth,stopid) {
	url = "stQCReport.jsp?conum="+conum+"&stuc_depth="+stuc_depth+"&renum="+<%=stunum%>+"&stopid="+stopid;
	window.open(url, "GoReport", "width=360, height=300, top=200, left=300");
	}

</script>

</head>
<body>

<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>

<!-- 글읽기 Start -->
	<div id="readDiv">
		<table align="center" cellspacing="3" width="100%" bgcolor="white">
		 <tr>
		  <td>
		   <table cellpadding="3" cellspacing="0" width="100%">
		    <tr height="100"> 
			    <td colspan="7">
			    <span style="font-size:30px;"><%=title%></span> 
			    <% if(loginid!=null) {%>		    
				<input type="button" value="신고" onclick="javascript:goRep();" style="float:right;">
				<%}%></td>
		 </tr>
		    <tr> 
				<td align="center" bgcolor="#FCBC7E" width="10%" style="color:white; font-weight:bold;" > 닉 네 임</td>
				<td bgcolor="#FAF8EB" width="10%"><%=id%></td>
				<td align="center" bgcolor="#FCBC7E" width="10%" style="color:white; font-weight:bold;"> 등록날짜 </td>
				<td bgcolor="#FAF8EB" width="15%"><%=regdate%></td>
				<td align="center" bgcolor="#FCBC7E" width="10%" style="color:white; font-weight:bold;">조회수</td>
				<td bgcolor="#FAF8EB" colspan="3"><%=count%></td>
			</tr>
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
		  <td align="center" colspan="2">
		   
		 <hr/>
  			<!-- 댓글 List Start -->
			  <%
			  	Vector<StQcommentsBean> cvlist = stqcmgr.getStQComment(num);
			      	if(!cvlist.isEmpty()){
			  %>
				 <table width="100%">
				 <%
					 	for(int i=0;i<cvlist.size();i++){
					 		StQcommentsBean acrcbean = cvlist.get(i);
	 		 	 			int cnum = acrcbean.getNum();
	 		 	 			String cid = acrcbean.getStq_id();
	 		 	 			String comment = acrcbean.getStq_content();
	 		 	 			String cregdate = acrcbean.getStq_regdate();
	 		 	 			int conum = acrcbean.getStq_conum();
	 		 	 			int depth = acrcbean.getStq_depth();
	 		 	 			String stopid=acrcbean.getStq_id();
			 				String dstyle = "", dstyle1 = "";
	 		 	 			if(depth==1) {
	 		 	 				dstyle = "style=\"padding-left:30px;\"";	
	 		 	 				dstyle1 = "padding-left:30px;";
				 			}
				 %>
				 	
				 	<tr>
						<td <%=dstyle%> colspan="4" width="600"><b><%=cid%></b></td>
					</tr>
					<tr>
						<td <%=dstyle%> colspan="3" style=" min-height:150px;"><%=comment%></td>
						<td align="right">
						<% 
						if(loginid!=null) {
							if(loginid.equals(cid)||stqmgr.checkM(loginid)==0) { %>
							<input type="button" value="삭제"
							onclick="cDel('<%=conum%>','<%=cnum%>','<%=depth%>')">
							<%}%>
							<input type="button" value="댓글신고"
							onclick="javascript:goCReport
							('<%=acrcbean.getNum()%>','<%=acrcbean.getStq_depth()%>','<%=stopid%>')">
						<%} %>	
						</td>
					</tr>
					<tr>
						<td colspan="3" style="font-size:12px; color:gray; <%=dstyle1%>">
						<%=cregdate%>
						<% if(loginid!=null) { %>
						<a href="javascript:onstqReply<%=i%>();">답글쓰기</a>
						<% } %>
						
						<!-- 답글쓰기 Start -->
						
						<script>
						 	function onstqReply<%=i%>() {
						 		document.getElementById("stqReply<%=i%>").style.display = 'block';
						 	}
						 	function offstqReply<%=i%>() {
						 		document.getElementById("stqReply<%=i%>").style.display = 'none';
						 	}
						 	function rInsert<%=i%>() {
						 		if(document.stqFrm<%=i%>.comment.value==""){
						 			alert("댓글을 입력하세요.");
						 			document.stqFrm<%=i%>.comment.focus();
						 			return;
						 		}
						 		document.stqFrm<%=i%>.submit();
						 	}
				 		</script>
						<div id="stqReply<%=i%>" class="stqReply">
							<form method="post" name="stqFrm<%=i%>">
								<table>
									<tr>
										<td><%=loginid%>&nbsp;:&nbsp;</td>
										<td>
										<div id="inputdiv" style="width:500px; display:flex; backgound-color:white;">
										<input name="comment" size="50" placeholder="댓글을 남겨보세요" style="flex:3;"> 
										<input type="button" value="등록" onclick="rInsert<%=i%>()" style="flex:1; margin-right:5px;">
										<input type="button" value="취소" onclick="offscReply<%=i%>()" style="flex:1;">
										</div>
										</td>
									</tr>
								</table>
							<input type="hidden" name="cid" value="<%=loginid%>">
							<input type="hidden" name="flag" value="insert1">
							<input type="hidden" name="stunum" value="<%=stunum%>">
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
			 <% } %>
			 <!-- 댓글 List End -->
			 <!-- 댓글 입력폼 Start -->
			<% if(loginid!=null) { %>
		   <form method="post" name="cFrm">
		   <div id="inputdiv" style="width:97%; background-color:white;">
				<table width="97%">
					<tr>
						<td colspan="4"><%=loginid%></td>
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
			<input type="hidden" name="cid" value="<%=loginid%>">
			<input type="hidden" name="flag" value="insert">	
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="cnum">
			<input type="hidden" name="conum">
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
		    <input type="hidden" name="nowPage" value="<%=nowPage%>">
		    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
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
		 if(loginid!=null) {
			 if(loginid.equals(id)||stqmgr.checkM(loginid)==0) { %>
			 | <a href="st_QnAUpdate.jsp?num=<%=num%>&stunum=<%=stunum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>" >수 정</a> |
			 <a href="st_QnADelete.jsp?num=<%=num%>&stunum=<%=stunum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>">삭 제</a> 
		 <% }
		 } %>
		 ]<br/>
		  </td>
		 </tr>
		</table>
		</div>
<!-- 글읽기 End -->

</body>
<%@ include file="../alcinfo/footer.jsp"%>
</html>