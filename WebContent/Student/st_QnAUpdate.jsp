<!-- st_QnAUpdate.jsp -->
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

	int num = UtilMgr.parseInt(request, "num");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	String loginid = (String)session.getAttribute("idKey");
	
	StinqueryBean stqbean = (StinqueryBean)session.getAttribute("bean");
	String title = stqbean.getTitle();
	String id = stqbean.getId();
	String content = stqbean.getContent();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Team Read</title>
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
							<img src="../img/banner1.jpg" width="100%" height="250"></td>
							<td width="60%" height="100%">
								<table width="100%" style="font-size: 20;">
									<tr height="40">
										<td width="30%">학생명 / 성별</td>
										<td width="70%"><%=stbean.getName()%> / <%=stbean.getGender() %></td>
									</tr>
									<tr height="40">
										<td width="30%">원하는지역</td>
										<td width="70%"><%=stbean.getAddress() %></td>
									</tr>
									<tr height="40">
										<td width="30%">전화번호</td>
										<td width="70%"><%=stbean.getPhone() %></td>
									</tr>
									<tr height="35">
										<td width="30%">원하는과목</td>
										<td width="70%"><%=stbean.getStclass() %></td>
									</tr>
									<tr height="40">
										<td width="30%">재학중인 학교 / 학년</td>
										<td width="70%"><%=stbean.getSchool_name() %> / <%=stbean.getSchool_grade() %></td>
									</tr>
									<tr height="40">
										<td width="30%">비고</td>
										<td width="70%"><%=stbean.getEtc() %></td>
									</tr>

								</table>
							</td>
							<td width="15%" align="center">
								<table>
									
									<tr>
										<td><input type="button" value="잘못된정보 신고하기"
											style="font-size: 20;" onclick="goReport();"></td>
									</tr>
									<tr>
										<td><input type="button" value="신청하기" id="myButton1"
											style="font-size: 20;" onclick="insert();"></td>
									</tr>
									<tr>
										<td><input type="button" value="취소하기" id="myButton2"
											style="font-size: 20;" onclick="deleteT();"></td>
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
		<table width="70%" height="280" align="center" >
			<tr>
				<td width="30%" align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px">
				<button type="button" id="btn" onclick="graph()" >그래프 보기</button>
				<div id="column_chart_div1" style="height: 440px;"></div>
				</div>
				</td>
				<td width="70%" align="center">
					<div style="border:10px solid #36ada9; border-radius:15px; padding:20px">

<!-- 글수정 Start -->
		<table width="600" cellpadding="3">
			<tr>
				<td height="25" align="center">글 수정</td>
			</tr>
		</table>
		<br/>
		<form name="stqupdateFrm" method="post" action="st_QnAUpdateProc.jsp">
		<table width="600" cellpadding="3" align="center" border="1">
			<tr>
				<td align=center>
				<table align="center">
					<tr>
						<td>제 목</td>
						<td>
							<input name="stqtitle" size="50" maxlength="30" value="<%=title%>">
						</td>
					</tr>
					<tr>
						<td>내 용</td>
						<td>
							<textarea name="stqcontent" rows="10" cols="50"><%=content%></textarea>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							 <input type="submit" value="확인">
							 <input type="reset" value="다시쓰기">
							 <input type="button" value="취소"
							 onClick="javascript:location.href='st_QnARead.jsp?num=<%=num%>&stunum=<%=stunum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>'">
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		 <input type="hidden" name="stqid" value="<%=id%>">
		 <input type="hidden" name="acrip" value="<%=request.getRemoteAddr()%>">
		 <input type="hidden" name="nowPage" value="<%=nowPage %>">
		 <input type="hidden" name="num" value="<%=num%>">
		 <input type='hidden' name="stunum" value="<%=stunum%>">
		 <input type='hidden' name="numPerPage" value="<%=numPerPage%>">
		 <%
	  	 	if(!(keyWord==null||keyWord.equals(""))){
	     %>
	     <input type="hidden" name="keyField" value="<%=keyField%>">
	     <input type="hidden" name="keyWord" value="<%=keyWord%>">
	 	 <%
			}
		 %>
		</form>
<!-- 글수정 End -->

					</div>
				</td>
			</tr>
		</table>
		<br>
</body>
<%@ include file="../alcinfo/footer.jsp"%>
</html>