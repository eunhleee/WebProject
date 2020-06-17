<!-- 학원 리뷰 글쓰기 -->
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
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js">
<title>Team Read</title>

<link href="style.css" rel="stylesheet" type="text/css">

<script>
		function moveQnA(){
			url = "ac_QnA.jsp?ac_num="+<%=num%>;
			window.open(url, "Ac_QnA", "width=800, height=500, top=200, left=400");
			
		}
		
		$('.starRev span').click(function(){
			  $(this).parent().children('span').removeClass('on');
			  $(this).addClass('on').prevAll('span').addClass('on');
			  return false;
			});
</script>
<style>
#inputdiv{
	margin:10px;
	width:490px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#inputdiv input{
	width:480px;
	border:none;
	font-size:15px;
}

#inputdiv1{
	margin:10px;
	width:200px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}

#inputdiv1 input{
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
.starR1.on{background-position:0 0;}
.starR2.on{background-position:-15px 0;}
</style>
</head>
<body>
	<%@ include file="../alcinfo/headerSearch.jsp"%>
	<br>
	<br>
	<form method="post" action="reportReceipt.jsp">
		<table width="70%" align="center">
			<tr>
				<td align="center">
					<table width="100%" border="1"
						style="font-size: 20; background: rgb(250, 248, 235);">
						<tr>
							<td width="25%" align="center"><img src="img/banner1.jpg"
								width="100%" height="250"></td>
							<td width="60%" height="100%">
								<table width="100%" border="1" style="font-size: 20;">
									<tr height="50">
										<td width="30%">학원명</td>
										<td width="70%"><%=bean.getAc_name()%></td>
									</tr>
									<tr height="50">
										<td width="30%">교습계열</td>
										<td width="70%"><%=bean.getGroup1()%></td>
									</tr>
									<tr height="50">
										<td width="30%">교습과정</td>
										<td width="70%"><%=bean.getGroup2()%></td>
									</tr>
									<tr height="50">
										<td width="30%">학원주소</td>
										<td width="100%"><a href=""
											style="color: black; text-decoration: none;"><%=bean.getAc_address()%></a></td>
									</tr>
									<tr height="50">
										<td width="30%">전화번호</td>
										<td width="70%"><%=bean.getAc_tel()%></td>
									</tr>
								</table>
							</td>
							<td width="15%" align="center">
								<table>
									<tr>
										<td><input type="button" value="문의하기"
											style="font-size: 20;" onclick="moveQnA();"></td>
									</tr>
									<tr>
										<td><input type="submit" value="잘못된정보 신고하기"
											style="font-size: 20;"></td>
											
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
		<table width="70%" height="300" align="center">
			<tr>
				<td width="30%" align="center"><jsp:include page="mapJsp.jsp">
						<jsp:param value="<%=bean.getAc_address()%>" name="address" />
					</jsp:include></td>
				<td width="70%" align="center">

<!-- 글쓰기 Start -->
<div style="height:450px;">
	<h2><%=bean.getAc_name()%> 리뷰</h2>	
	<hr style="border:1px solid #36ada9;">	
	<br/>
			<form name="acrpostFrm" method="post" action="ac_ReviewPostProc.jsp">
			<table width="600" cellpadding="3" align="center">
				<tr>
					<td align=center>
					<table align="center">
						<tr>
							<td>제 목</td>
							<td>
							<div id="inputdiv">
							<input name="acrtitle" size="50" maxlength="30">
							</div>
							</td>
						</tr>
						<tr>
							<td>평 점</td>
							<td>
								<div class="starRev">
								  <span class="starR1 on">별1_왼쪽</span>
								  <span class="starR2">별1_오른쪽</span>
								  <span class="starR1">별2_왼쪽</span>
								  <span class="starR2">별2_오른쪽</span>
								  <span class="starR1">별3_왼쪽</span>
								  <span class="starR2">별3_오른쪽</span>
								  <span class="starR1">별4_왼쪽</span>
								  <span class="starR2">별4_오른쪽</span>
								  <span class="starR1">별5_왼쪽</span>
								  <span class="starR2">별5_오른쪽</span>
								</div>
							</td>
						</tr>
						<tr>
							<td>내 용</td>
							<td>
							<div id="textareadiv">
							<textarea name="acrcontent" rows="10" cols="50"></textarea>
							</div></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
						
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

<!-- 글쓰기 End -->

				</td>
			</tr>
		</table>
		<br>
</body>
<%@ include file="../alcinfo/footer.jsp"%>
</html>
<%
	}
%>