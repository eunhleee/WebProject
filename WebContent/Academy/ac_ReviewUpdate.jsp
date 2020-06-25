<!-- ac_ReviewUpdate.jsp -->
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.AcademyBean"%>
<%@page import="alcinfo.AcreviewBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="acmgr" class="alcinfo.AcademyMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	int acrnum = UtilMgr.parseInt(request, "acrnum");
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar today = Calendar.getInstance();
 	String strToday = sdf.format(today.getTime());
	
	AcreviewBean acrbean = (AcreviewBean)session.getAttribute("bean");
	String title = acrbean.getAc_title();
	Double star = acrbean.getAc_star();
	String nick = acrbean.getAc_nickname(); 
	String content = acrbean.getAc_content();
	
	int num = UtilMgr.parseInt(request, "num");
	AcademyBean bean = acmgr.getAcademy(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>우리 학원 어디?-학원 리뷰</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="./grade2.js"></script>
<script>
		function moveQnA(){
			url = "ac_QnA.jsp?ac_num="+<%=num%>;
			window.open(url, "Ac_QnA", "width=900, height=500, top=200, left=400");
			
		}
		function goReport() {
			url = "../Report/reportReceiptAInf.jsp?stopid="+<%=num%>;
			window.open(url, "GoReport", "width=360, height=300, top=200, left=300");
		}
</script>
<style>
.totalFrame{
	background-color:#FAF8EB;
	padding:40px 0px;
	margin-top:-40px;
}
.tdBorder{
	border-right:3px solid #56C8D3;
}

#readDiv{
	margin-left:10%;
	margin-bottom:40px;
	width:79%;
	align:center;
	background-color:white;
	border: 10px solid #36ada9; 
	border-radius:10px;
	padding:20px 40px;
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
	<!-- 읽기 Start -->
<div class="totalFrame" align="center">
	<div id="readDiv">
		<form name="acrupdateFrm" method="post" action="ac_ReviewUpdateProc.jsp">
		<table align="center" cellspacing="3" width="100%" bgcolor="white">
		 <tr>
		  <td>
		   <table cellpadding="3" cellspacing="0" width="100%"> 
		    <tr height="100">
		    <td colspan="8">
		 	  <input name="acrtitle" size="50" maxlength="30" value="<%=title%>" style="font-size:30px;">
		    <% if(loginid!=null) {%>		    
			 <input type="button" value="신고" onclick="javascript:goRep();" style="float:right;">
			  <%}%></td>
			</tr>
		    <tr height="20"> 
				<td class="tdBorder" width="6%" > 닉 네 임</td>
				<td  width="10%">&nbsp;<%=loginid%></td>
				<td class="tdBorder" width="6%" > 등록날짜 </td>
				<td width="10%">&nbsp;<%=strToday%></td>
				<td class="tdBorder" width="6%" > 조 회 수</td>
				<td  width="10%">&nbsp;<%=acrbean.getAc_count()%></td>
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
									  <input type="hidden" name="acrstar" value="<%=star%>">
									</div>
								</td>
			</tr>
		   
		   <tr><td colspan="8"><hr style="border:1px solid lightgray;"></td>
		   <tr> 
		    <td colspan="6" height="200"><textarea name="acrcontent" rows="10" cols="100"><%=content%></textarea></td>
		   </tr>
		   <tr>
				<td colspan="4" align="center">
					 <input type="submit" value="수정">
					 <input type="reset" value="다시쓰기">
					 <input type="button" value="취소"
					 onClick="javascript:location.href='<%=request.getHeader("referer")%>'">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
 <input type="hidden" name="acrnick" value="<%=nick%>">
 <input type="hidden" name="acrip" value="<%=request.getRemoteAddr()%>">
 <input type="hidden" name="nowPage" value="<%=nowPage %>">
 <input type="hidden" name="num" value="<%=num%>">
 <input type='hidden' name="acrnum" value="<%=acrnum%>">
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
<br>
</div>
	<%@ include file="../alcinfo/footer.jsp"%>
</div>
</body>

</html>