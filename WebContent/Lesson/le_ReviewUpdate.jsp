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
<div class="totalFrame">
<div id="readDiv">
	<form name="lerupdateFrm" method="post" action="le_ReviewUpdateProc.jsp">
		
	<table align="center" cellspacing="3" width="100%" bgcolor="white">
	 <tr>
	  <td>
	   <table cellpadding="3" cellspacing="0" width="100%"> 
	    <tr height="100"> 
	    <td colspan="8">
	   <input name="lertitle" size="50" maxlength="30" value="<%=title%>" style="font-size:30px;">
	    <% if(loginid!=null) {%>		    
		 <input type="button" value="신고" onclick="javascript:goRep();" style="float:right;">
		  <%}%></td>
		</tr>
	    <tr height="20"> 
				<td class="tdBorder" width="6%" > 닉 네 임</td>
				<td  width="10%">&nbsp;<%=id%></td>
				<td class="tdBorder" width="6%" > 등록날짜 </td>
				<td width="10%">&nbsp;<%=strToday%></td>
				<td class="tdBorder" width="6%" > 조 회 수</td>
				<td  width="10%">&nbsp;<%=lrbean.getLr_count()%></td>
				<td class="tdBorder" width="6%">평 점</td>
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
		   
		   <tr><td colspan="8"><hr style="border:1px solid lightgray;"></td>
		   <tr> 
		    <td colspan="6" height="200"><textarea name="lercontent" rows="10" cols="100"><%=content%></textarea></td>
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
		

<!-- 글수정 End -->		
		
				
		<br>
		</div>		
		<%@ include file="../alcinfo/footer.jsp"%>
</div>
		

</body>

</html>