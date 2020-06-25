<!-- 과외 리뷰 글쓰기 -->
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="alcinfo.MemberBean"%>
<%@page import="alcinfo.LessonBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.LessonMgr" />
<jsp:useBean id="Mmgr" class="alcinfo.MemberMgr" />

<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	/* String loginid = (String)session.getAttribute("idKey"); */
	String prevurl = request.getHeader("referer");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar today = Calendar.getInstance();
 	String strToday = sdf.format(today.getTime());
	String id = "";
	String url = "LessonMain.jsp";
	LessonBean lebean = null;
	int num = UtilMgr.parseInt(request, "num"); // 조회수 증가
	
	if(request.getParameter("id") == null) {
		response.sendRedirect(url);
	} else {
		id = request.getParameter("id");
		lebean = mgr.getLesson(id);
		session.setAttribute("lebean", lebean);
		mgr.upLeCount(num); // 조회수 증가
		
		lebean.setId(id);
		  System.out.println("선생님아이디는"+id);
		%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 학원 어디?-과외 리뷰</title>

<script src="./grade.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>


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
		
</script>
<style>
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
.totalFrame{
	background-color:#FAF8EB;
	margin-top:-40px;
	padding:40px 0px;
}
.subFrame{
	width:70%;
	border:1px solid gray;
	background-color:white;
	padding:30px 30px;
	margin-bottom:40px;
}
.tdBorder{
	border-right:3px solid #F88C65;
}
#inputdiv2{
	margin:10px;
	width:490px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#inputdiv2 input{
	width:480px;
	border:none;
	font-size:15px;
}

#inputdiv3{
	margin:10px;
	width:200px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}

#inputdiv3 input{
	width:180px;
	border:none;
	font-size:15px;
	
}

#textareadiv{
	margin:10px;
	width:490px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#textareadiv textarea{
	border:none;
	font-size:15px;
	width:480px;
}

.starR1{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat -52px 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR2{
    background: url('http://miuu227.godohosting.com/images/icon/ico_review.png') no-repeat right 0;
    background-size: auto 100%;
    width: 15px;
    height: 30px;
    float:left;
    text-indent: -9999px;
    cursor: pointer;
}
.starR1.on{background-position:0px 0px;}
.starR2.on{background-position:-15px 0px;}
.starRev {
	margin-left: 10px;
}
</style>
</head>
<body>
<%@ include file="../alcinfo/headerSearch.jsp"%>
	<br>
	<br>
	<div class="totalFrame" align="center">
	<div class="subFrame">
	<form name="cart" action="">
		<table width="100%" style="margin-bottom:50px;">
			<tr>
				<td align="center">
					<table width="100%" style="font-size: 20;">
						<tr>
							<td>
								<h1><%=lebean.getName()%> <font style="font-size:25px; color:lightgray;">선생님</font></h1>
							</td>
						</tr>
						<tr>
							
							<td width="70%" height="100%">
								<table width="70%" >
									<tr height="20">
										<td class="tdBorder" width="8%">성별</td>
										<td width="10%">&nbsp;<%=lebean.getGender() %></td>
									
										<td class="tdBorder" width="8%">가능지역</td>
										<td width="10%" colspan="4">&nbsp;<%=lebean.getArea() %></td>
								
									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder">과목</td>
										<td >&nbsp;<%=lebean.getLeclass() %></td>
									
										<td class="tdBorder">학생 수</td>
										<td width="10%">&nbsp;<%=lebean.getStudent() %>명</td>
									
										<td width="8%" class="tdBorder">출신 학교</td>
										<td width="15%">&nbsp;<%=lebean.getSchool_name() %></td>
									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder" width="8%">비고</td>
										<td width="15%">&nbsp;<%=lebean.getEtc() %></td>
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
		<table width="90%" height="280" align="center">
		<tr>
			<td>
				<div style="padding:20px 30px;">
				<img src="../TeacherImg/<%=lebean.getImgname() %>"	height="250" width="300">
				</div>
			</td>
			<td align="center"  rowspan="2" >
					<!-- 글쓰기 Start -->	

		<div style="height:100%; border:10px solid #36ada9; border-radius:15px; padding:20px">
			<h2><%=lebean.getName()%>선생님 리뷰</h2>
			<hr style="border:1px solid #36ada9;">
			<br/>
			<form name="lerpostFrm" method="post" action="le_ReviewPostProc.jsp">
			<table width="750" cellpadding="3" align="center">
				<tr>
					<td align=center>
					<table align="center">
						<tr>
							<td>작성자</td>
							<td>
							<div id="inputdiv3">
							<input size="50" maxlength="30" disabled="disabled"
							value="<%=id%>">
							</div>
							</td>
							<td>작성일</td>
							<td>
							<div id="inputdiv3">
							<input size="50" maxlength="30" disabled="disabled"
							value="<%=strToday%>">
							</div>
							</td>
						</tr>
						<tr>
							<td>제 목</td>
							<td colspan="3">
							<div id="inputdiv2">
							<input name="lertitle" size="50" maxlength="30">
							</div>
							</td>
						</tr>
						<tr>
							<td>평 점</td>
							<td colspan="3">
							<div class="starRev">
							  <span class="starR1 on" id="star0" onclick="starclick0()">별1_왼쪽</span>
							  <span class="starR2" id="star1" onclick="starclick1()">별1_오른쪽</span>
							  <span class="starR1" id="star2" onclick="starclick2()">별2_왼쪽</span>
							  <span class="starR2" id="star3" onclick="starclick3()">별2_오른쪽</span>
							  <span class="starR1" id="star4" onclick="starclick4()">별3_왼쪽</span>
							  <span class="starR2" id="star5" onclick="starclick5()">별3_오른쪽</span>
							  <span class="starR1" id="star6" onclick="starclick6()">별4_왼쪽</span>
							  <span class="starR2" id="star7" onclick="starclick7()">별4_오른쪽</span>
							  <span class="starR1" id="star8" onclick="starclick8()">별5_왼쪽</span>
							  <span class="starR2" id="star9" onclick="starclick9()">별5_오른쪽</span>
							  <input type="hidden" name="lerstar" value="0.5">
							</div>
							</td>
						</tr>
						<tr>
							<td>내 용</td>
							<td colspan="3">
							<div id="textareadiv">
							<textarea name="lercontent" rows="20" cols="50"></textarea>
							</div></td>
						</tr>
						<tr>
							<td colspan="4" align="center" valign="bottom">
								 <input type="submit" value="확인">
								 <input type="reset" value="다시쓰기">
								 <input type="button" value="취소"
								 onClick="javascript:location.href='<%=prevurl%>'">
							</td>
						</tr>
					</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="lerid" value="<%=loginid%>">
			<input type="hidden" name="id" value="<%=id%>">
			<input type="hidden" name="lerip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="num" value="<%=num%>">
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
							
<!-- 글쓰기 End -->				
				
				</div>
				</td>
		</tr>
			<tr>
				<td width="30%" align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px">
				<button type="button" id="btn" onclick="graph()" >그래프 보기</button>
				<div id="column_chart_div1"  style="height: 440px; width:300px;"></div>
				</div>
				</td>
				<td width="70%" align="center">
				

				</td>
			</tr>
		</table>
		<br>
		</div>
		<%@ include file="../alcinfo/footer.jsp"%>
	</div>
</body>

</html>
<%
	}
%>