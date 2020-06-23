<!-- ac_ReviewUpdate.jsp -->
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
	String loginid = (String)session.getAttribute("idKey");
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
	
	<br>
	<br>
		<table width="70%" align="center">
			<tr>
				<td align="center">
					<table width="100%" style="font-size: 20; background: rgb(250, 248, 235);">
						<tr>
							<td width="25%" align="center">
							<img src="../img/banner1.jpg" width="100%" height="250">
							</td>
							<td width="60%" height="100%">
								<table width="100%" style="font-size: 20;">
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
											style="font-size: 20;" onclick="goReport();"></td>
											
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		<br>
		<table width="70%" height="300" align="center" >
			<tr>
			
				<td width="30%" align="center">
				<div style="border:10px solid #FCBC7E; border-radius:15px; padding:20px">
					<jsp:include page="mapJsp.jsp">
					<jsp:param value="<%=bean.getAc_address()%>" name="address" />
					</jsp:include>
				</div>
					</td>
				<td width="70%"  align="center">
				
<!---- 글수정 Start ---->

			<div style="border:10px solid #36ada9; border-radius:15px; padding:20px">
				<h2><%=bean.getAc_name()%> 리뷰</h2>	
				<hr style="border:1px solid #36ada9;"><br/>
				<form name="acrupdateFrm" method="post" action="ac_ReviewUpdateProc.jsp">
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
									<input name="acrtitle" size="50" maxlength="30" value="<%=title%>">
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
									  <input type="hidden" name="acrstar" value="<%=star%>">
									</div>
								</td>
							</tr>
							<tr>
								<td>내 용</td>
								<td colspan="3">
								<div id="textareadiv">
									<textarea name="acrcontent" rows="10" cols="50"><%=content%></textarea>
								</div>
								</td>
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
			</div>
					
<!---- 글수정 End ---->

				</td>
			</tr>
		</table>
		<br>
</body>
<%@ include file="../alcinfo/footer.jsp"%>
</html>