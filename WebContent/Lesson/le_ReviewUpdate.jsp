<!-- le_ReviewUpdate.jsp -->
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	String loginid1 = (String)session.getAttribute("idKey");
	String loginNick = lermgr.memberNick(loginid1);
	String prevurl = request.getHeader("referer");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar today = Calendar.getInstance();
 	String strToday = sdf.format(today.getTime());
	
	String id = request.getParameter("id");
	int num = UtilMgr.parseInt(request, "num");
	int lernum = UtilMgr.parseInt(request, "lernum");
	
	LereviewBean lrbean = lermgr.getReview(lernum);
	String title = lrbean.getLr_title();
	String nickname = lrbean.getLr_nick();
	Double star = lrbean.getLr_star();
	String content = lrbean.getLr_content();
	
	LessonBean lebean = mgr.getLesson(id);
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 학원 어디?-과외 리뷰</title>

<script src="./grade2.js"></script>
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
<!-- 글수정 Start -->	

	<div style="border:10px solid #36ada9; border-radius:15px; padding:20px">
	<h2><%=lebean.getName()%>선생님 리뷰</h2>
	<hr style="border:1px solid #36ada9;">
		<br/>
		<form name="lerupdateFrm" method="post" action="le_ReviewUpdateProc.jsp">
		<table width="600" cellpadding="3" align="center">
			<tr>
				<td align=center>
				<table align="center">
					<tr>
						<td>작성자</td>
						<td>
						<div id="inputdiv3">
						<input size="50" maxlength="30" disabled="disabled"
						value="<%=loginid%>">
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
						<input name="lertitle" size="50" maxlength="30" value="<%=title%>">
						</div>
						</td>
					</tr>
					<tr>
						<td>평 점</td>
						<td colspan="3">
							<div class="starRev">
							<% String[] st = new String[10];
							int intstar = (int)Math.round(star*2);
							for(int i=0; i<intstar; i++) st[i]=" on";
							for(int i=intstar; i<10; i++) st[i]="";%>
							  <span class="starR1<%=st[0]%>" id="star0" onclick="starclick0()">별1_왼쪽</span>
							  <span class="starR2<%=st[1]%>" id="star1" onclick="starclick1()">별1_오른쪽</span>
							  <span class="starR1<%=st[2]%>" id="star2" onclick="starclick2()">별2_왼쪽</span>
							  <span class="starR2<%=st[3]%>" id="star3" onclick="starclick3()">별2_오른쪽</span>
							  <span class="starR1<%=st[4]%>" id="star4" onclick="starclick4()">별3_왼쪽</span>
							  <span class="starR2<%=st[5]%>" id="star5" onclick="starclick5()">별3_오른쪽</span>
							  <span class="starR1<%=st[6]%>" id="star6" onclick="starclick6()">별4_왼쪽</span>
							  <span class="starR2<%=st[7]%>" id="star7" onclick="starclick7()">별4_오른쪽</span>
							  <span class="starR1<%=st[8]%>" id="star8" onclick="starclick8()">별5_왼쪽</span>
							  <span class="starR2<%=st[9]%>" id="star9" onclick="starclick9()">별5_오른쪽</span>
							  <input type="hidden" name="lerstar" value="<%=star%>">
							</div>
						</td>
					</tr>
					<tr>
						<td>내 용</td>
						<td colspan="3">
						<div id="textareadiv">
							<textarea name="lercontent" rows="10" cols="50"><%=content%></textarea>
						</div>
						</td>
					</tr>
					<tr>
						<td colspan="4" align="center">
							 <input type="submit" value="수정">
							 <input type="reset" value="다시쓰기">
							 <input type="button" value="취소"
							 onClick="javascript:location.href='<%=prevurl%>'">
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
	</div>			

<!-- 글수정 End -->		
		
				
				</td>
			</tr>
		</table>
		<br>
</body>
<%@ include file="../alcinfo/footer.jsp"%>
</html>