<!-- 학원 리뷰 글쓰기 -->
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.AcademyBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.AcademyMgr" />
<%
	request.setCharacterEncoding("UTF-8"); 
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	String prevurl = request.getHeader("referer");
	String id = (String)session.getAttribute("idKey");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar today = Calendar.getInstance();
 	String strToday = sdf.format(today.getTime());
	int num = 0;
	String url = "AcademyMain.jsp";
	AcademyBean bean = null;
	if (request.getParameter("num") == null) {
		response.sendRedirect(url);
	} else if (!UtilMgr.isNumeric(request.getParameter("num"))) {
		response.sendRedirect(url);
	} else {
		num = Integer.parseInt(request.getParameter("num"));
		bean = mgr.getAcademy(num);
		session.setAttribute("bean", bean);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 학원 어디?-학원 리뷰</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script src="./grade.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js">
	$('.starRev span').click(function(){
		  $(this).parent().children('span').removeClass('on');
		  $(this).addClass('on').prevAll('span').addClass('on');
		  return false;
		});
</script>
<script>
function moveQnA(){
	url = "ac_QnA.jsp?ac_num="+<%=num%>;
	window.open(url, "Ac_QnA", "width=900, height=500, top=200, left=400");
	
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
	<form method="post" action="reportReceipt.jsp">
		<table width="100%" >
			<tr>
				<td >
					<table  style="font-size: 20;" >
						<tr>
						<td width="95%"><h1><%=bean.getAc_name()%></h1>
						</td>
						
						<td><input type="button" value="문의하기" 	style="font-size: 20;" onclick="moveQnA();"></td>
						<%	if(session.getAttribute("idKey")==null||session.getAttribute("idKey").equals("")){ %>
							<td ><input type="button" value="잘못된정보 신고하기" style="font-size: 20;" onclick="goErr();"></td>
						<%}else{%>
							<td><input type="submit" value="잘못된정보 신고하기" style="font-size: 20;" onclick="goReport();"></td><%} %>
						
						</tr>
						<tr>
						<td width="70%">
						<table width="80%" style="font-size: 17px;"  >
									
									<tr height="20">
										<td class="tdBorder" width="8%">계열</td>
										<td width="15%">&nbsp;<%=bean.getGroup1()%></td>
										<td class="tdBorder" width="8%">과정</td>
										<td width="15%">&nbsp;<%=bean.getGroup2()%></td>
										<td class="tdBorder" width="8%">번호</td>
										<td  colspan="3">&nbsp;<%=bean.getAc_tel()%></td>

									</tr>
									<tr height="5"></tr>
									<tr height="20">
										<td class="tdBorder">주소</td>
										<td colspan="5">&nbsp;<%=bean.getAc_address()%></td>	
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
				<div style="padding:20px">
						<img src="../AcademyImg/<%=bean.getImgname()%>" width="350" height="250">
				</div>
			</td>
			<td  align="center" rowspan="2" >
			<!-- 글쓰기 시작 -->
				<div style="height:100%; border:10px solid #36ada9; border-radius:15px; padding:20px;">
					<h2><%=bean.getAc_name()%> 리뷰</h2>	
					<hr style="border:1px solid #36ada9;">	
					<br/>
						<form name="acrpostFrm" method="post" action="ac_ReviewPostProc.jsp">
						<table width="600" cellpadding="3" align="center">
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
						<input name="acrtitle" size="50" maxlength="30">
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
							  <input type="hidden" name="acrstar" value="0.5">
							</div>
						</td>
					</tr>
					<tr>
						<td>내 용</td>
						<td colspan="3">
						<div id="textareadiv">
						<textarea name="acrcontent" rows="20" cols="50"></textarea>
						</div></td>
					</tr>
					<tr>
						<td colspan="4" align="center" valign="bottom">
							 <input type="submit" value="확인">
							 <input type="reset" value="다시쓰기">
							 <input type="button" value="취소"
							 onClick="javascript:location.href='<%=prevurl%>';">
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<input type="hidden" name="acqid" value="<%=id%>">
		<input type="hidden" name="acqip" value="<%=request.getRemoteAddr()%>">
		<input type="hidden" name="acnum" value="<%=num%>">
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
	<!-- 글쓰기 끝 -->
				</td>
			</tr>
			<tr>
				<td align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px">
					<jsp:include page="mapJsp.jsp">
					<jsp:param value='<%=URLEncoder.encode(bean.getAc_address(),"UTF-8")%>' name="address" />
					</jsp:include>
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