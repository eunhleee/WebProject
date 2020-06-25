<!-- st_QnAPost.jsp -->
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
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

<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	String prevurl = request.getHeader("referer");
	String stqid = (String)session.getAttribute("idKey");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar today = Calendar.getInstance();
 	String strToday = sdf.format(today.getTime());
	int stunum = 0;
	String url = "StudentMain.jsp";
	StudentBean stbean = null;
	int num=Integer.parseInt(request.getParameter("stunum"));
	MemberBean mbean=Rmgr.getStuId(num);
	//System.out.println("학생의 아이디는"+mbean.getId());

	if(request.getParameter("stunum") == null) {
		//response.sendRedirect(url);
	} else if (!UtilMgr.isNumeric(request.getParameter("stunum"))) {
		response.sendRedirect(url);
	} else {
		stunum = Integer.parseInt(request.getParameter("stunum"));
		//한준씨 getStudent 메소드 수정함
		stbean = mgr.getStudent(stunum);
		stbean.setNum(stunum);
		mgr.upStCount(num); // 조회수 증가
		%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>우리 학원 어디?-학생 문의</title>

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
	


</script>
<style>
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
</style>
</head>
<body>
	<%@ include file="../alcinfo/headerSearch.jsp"%>
	<br>
	<br>
	<div class="totalFrame" align="center">
	<div class="subFrame">
	<form name="cart" action="">
		<table width="100%" >
			<tr>
				<td align="center">
					<table width="100%" style="font-size: 20;">
						<tr>
							<td>
								<h1><%=stbean.getName()%> <font style="font-size:25px; color:lightgray;">학생</font></h1>
							</td>
						</tr>
						<tr>
							
							<td width="70%" height="100%">
								<table width="70%" style="font-size: 17px;">
									<tr height="20">
										<td class="tdBorder" width="8%">성별</td>
										<td width="10%">&nbsp;<%=stbean.getGender() %></td>
									
										<td class="tdBorder" width="8%">과목</td>
										<td width="10%">&nbsp;<%=stbean.getStclass() %></td>
										<td class="tdBorder" width="8%">번호</td>
										<td colspan="2">&nbsp;<%=stbean.getPhone()%></td>
										
									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder" width="12%">가능 지역</td>
										<td colspan="5">&nbsp;<%=stbean.getAddress() %></td>
									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder" width="12%">학교 /학년</td>
										<td colspan="5">&nbsp;<%=stbean.getSchool_name() %> / <%=stbean.getSchool_grade() %></td>
									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder" width="8%">비고</td>
										<td colspan="5">&nbsp;<%=stbean.getEtc() %></td>
									</tr>

								</table>
							</td>
							<td width="15%" align="center">
								<table>
									<tr>
										<td><input type="button" value="신청하기" id="myButton1"
											style="font-size: 20;" onclick="insert();"></td>
									</tr>
									<tr>
										<td><input type="button" value="취소하기" id="myButton2"
											style="font-size: 20;" onclick="deleteT();"></td>
									</tr>		
									<tr>
									<%	if(session.getAttribute("idKey")==null||session.getAttribute("idKey").equals("")){ %>
									<td><input type="button" value="잘못된정보 신고하기"
											style="font-size: 20;" onclick="goErr();"></td>
									<%}else{%><td><input type="button" value="잘못된정보 신고하기"
											style="font-size: 20;" onclick="goReport();"></td><%} %>
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
		<table width="90%" height="300" align="center" >
			<tr>
			<td>
			<div style="padding:20px 30px;">
				<img src="../StudentImg/<%=stbean.getImgname() %>" width="300" height="250">
			</div>
			</td>
			<td  align="center" rowspan="2">
			<div style="height:100%;border:10px solid #36ada9; border-radius:15px; padding:20px">
						<!-- 글쓰기 Start -->
		<div style="height:480px;">
			<h2><img src="../img/questionmark2.png" width="40" height="40">&nbsp;문의 하기</h2>	
			<hr style="border:1px solid #36ada9;">	
			<br/>
			<form name="stpostFrm" method="post" action="st_QnAPostProc.jsp">
			<table width="750" cellpadding="3" align="center">
				<tr>
					<td align="center">
					<table align="center" >
						<tr>
							<td>작성자</td>
							<td>
								<div id="inputdiv3">
									<input name="stqtitle" size="50" maxlength="30" disabled="disabled"
									value="<%=stqid%>">
								</div>
							</td>
							<td>작성일</td>
							<td>
								<div id="inputdiv3">
									<input name="stqtitle" size="50" maxlength="30" disabled="disabled"
									value="<%=strToday%>">
								</div>
							</td>
						</tr>
						<tr >
							<td>제 목</td>
							<td colspan="3">
							<div id="inputdiv2">
							<input name="stqtitle" size="50" maxlength="30">
							</div></td>
						</tr>
						<tr>
							<td>내 용</td>
							<td colspan="3">
							<div id="textareadiv">
							<textarea name="stqcontent" rows="17" cols="50"></textarea>
							</div></td>
						</tr>
						<tr>
			    			<td colspan="1">
			    			비밀글
							</td>
							<td><input type="checkbox" name="stqsecret"></td>
			    		</tr>
						<tr>
							<td colspan="4" align="center">
						
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
			<input type="hidden" name="stqid" value="<%=stqid%>">
			<input type="hidden" name="stqip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="stunum" value="<%=stunum%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<%if(!(keyWord==null||keyWord.equals(""))){%>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}%>
			</form>
		</div>
<!-- 글쓰기 End -->
					</div>
				</td>
			</tr>
			<tr>
				<td width="30%" align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px">
				<button type="button" id="btn" onclick="graph()" >그래프 보기</button>
				<div id="column_chart_div1" style="height: 440px;"></div>
				</div>
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