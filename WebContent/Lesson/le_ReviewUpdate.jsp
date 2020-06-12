<!-- le_ReviewUpdate.jsp -->
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
	
	LereviewBean lrbean = lermgr.getReview(lernum);
	String title = lrbean.getLr_title();
	String nickname = lrbean.getLr_nick();
	Double star = lrbean.getLr_star();
	String star1 = Double.toString(star);
	String content = lrbean.getLr_content();
	
	LessonBean lebean = mgr.getLesson(id);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Team Read</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<style>
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
	
	function list() {//[처음으로]를 누르면 게시글의 처음 페이지로 돌아감
		location.href = "leRead.jsp?num=<%=num%>&id=<%=id%>";
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
	function emulAcceptCharset(form) {
	    if (form.canHaveHTML) { // detect IE
	        document.charset = form.acceptCharset;
	    }
	    return true;
	}

	
</script>

</head>
<body>

	<%@ include file="../alcinfo/headerSearch.jsp"%>
	<br>
	<br>
	<form name="cart" action="">
		<table width="70%" align="center">
			<tr>
				<td align="center">
					<table width="100%" style="font-size: 20; background: rgb(250, 248, 235);">
						<tr>
							<td width="25%" align="center">
							<img src="../img/banner1.jpg"	width="100%" height="250">
							</td>
							<td width="60%" height="100%">
								<table width="100%"  style="font-size: 20;">
									<tr height="40">
										<td width="30%">선생님명 / 성별</td>
										<td width="70%"><%=lebean.getName()%> / <%=lebean.getGender() %></td>
									</tr>
									<tr height="40">
										<td width="30%">과외가능지역</td>
										<td width="70%"><%=lebean.getArea() %></td>
									</tr>
									<tr height="40">
										<td width="30%">전화번호</td>
										<td width="70%"><%=lebean.getPhone() %></td>
									</tr>
									<tr height="35">
										<td width="30%">과외 가능한 과목</td>
										<td width="70%"><%=lebean.getLeclass() %></td>
									</tr>
									<tr height="35">
										<td width="30%">과외중인 학생 수</td>
										<td width="70%"><%=lebean.getStudent() %>명</td>
									</tr>
									<tr height="40">
										<td width="30%">재학(졸업)중인 학교</td>
										<td width="70%"><%=lebean.getSchool_name() %></td>
									</tr>
									<tr height="40">
										<td width="30%">비고</td>
										<td width="70%"><%=lebean.getEtc() %></td>
									</tr>

								</table>
							</td>
							<td width="15%" align="center">
								<table name="buttonTable">
									<tr>
										<td><input type="button" value="문의하기"
											style="font-size: 20;" onclick="moveQnA();"></td>
									</tr>
									<tr>
										<td><input type="button" value="잘못된정보 신고하기"
											style="font-size: 20;" onclick="goReport();"></td>
									</tr>
									<tr>
										<td><input type="button" value="신청하기" id="myButton1"
											style="font-size: 20;" onclick="insert()"></input>
											</td>
									</tr>
									<tr>
										<td><input type="button" value="취소하기" id="myButton2"
											style="font-size: 20;" onclick="cancel()"></input>
											</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
		<br>
		<br>
		<table width="70%" height="280" align="center">
			<tr>
				<td width="30%" align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px">
				<button type="button" id="btn" onclick="graph()" >그래프 보기</button>
				<div id="column_chart_div1"  style="height: 440px; width:300px;"></div>
				</div>
				</td>
				<td width="70%" align="center">
				<div style="border:10px solid #36ada9; border-radius:15px; padding:20px">
				
<!-- 읽기 Start -->	
	<table width="600" cellpadding="3">
							<tr>
								<td height="25" align="center">글 수정</td>
							</tr>
						</table>
						<br/>
						<form name="lerupdateFrm" method="post" action="le_ReviewUpdateProc.jsp">
						<table width="600" cellpadding="3" align="center" border="1">
							<tr>
								<td align=center>
								<table align="center">
									<tr>
										<td>제 목</td>
										<td>
											<input name="lertitle" size="50" maxlength="30" value="<%=title%>">
										</td>
									</tr>
									<tr>
										<td>평 점</td>
										<td>
											<select name="lerstar">
												<option value="5" 
												<% if(star1.equals("5.0")) { %> selected <% } %>
												>5점</option>
												<option value="4.5" 
												<% if(star1.equals("4.5")) { %> selected<% } %>
												>4.5점</option>
												<option value="4" 
												<% if(star1.equals("4.0")) { %> selected <% } %>
												>4점</option>
												<option value="3.5" 
												<% if(star1.equals("3.5")) { %> selected <% } %>
												>3.5점</option>
												<option value="3" 
												<% if(star1.equals("3.0")) { %> selected <% } %>
												>3점</option>
												<option value="2.5" 
												<% if(star1.equals("2.5")) { %> selected <% } %>
												>2.5점</option>
												<option value="2" 
												<% if(star1.equals("2.0")) { %> selected <% } %>
												>2점</option>
												<option value="1.5" 
												<% if(star1.equals("1.5")) { %> selected <% } %>
												>1.5점</option>
												<option value="1" 
												<% if(star1.equals("1.0")) { %> selected <% } %>
												>1점</option>
												<option value="0.5" 
												<% if(star1.equals("0.5")) { %> selected <% } %>
												>0.5점</option>
												<option value="0" 
												<% if(star1.equals("0.0")) { %> selected <% } %>
												>0점</option>
											</select>
										</td>
									</tr>
									<tr>
										<td>내 용</td>
										<td>
											<textarea name="lercontent" rows="10" cols="50"><%=content%></textarea>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											 <input type="submit" value="확인">
											 <input type="reset" value="다시쓰기">
											 <input type="button" value="취소"
											 onClick="javascript:location.href='le_ReviewRead.jsp?num=<%=num%>&id=<%=id%>&lernum=<%=lernum%>'">
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						 <input type="hidden" name="lernick" value="<%=nickname%>">
						 <input type="hidden" name="lerip" value="<%=request.getRemoteAddr()%>">
						 <input type="hidden" name="nowPage" value="<%=nowPage %>">
						 <input type="hidden" name="num" value="<%=num%>">
						 <input type="hidden" name="id" value="<%=id%>">
						 <input type='hidden' name="lernum" value="<%=lernum%>">
						 <input type='hidden' name="numPerPage" value="<%=numPerPage%>">
						</form>
					

<!-- 읽기 End -->		
		
				</div>
				</td>
			</tr>
		</table>
		<br>
</body>
<%@ include file="../alcinfo/footer.jsp"%>
</html>