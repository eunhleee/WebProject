<!-- cs_Update.jsp -->
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="alcinfo.CSBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String ccid = (String)session.getAttribute("idKey");
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	String cust_page = request.getParameter("cust_page");

	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar today = Calendar.getInstance();
 	String strToday = sdf.format(today.getTime());
 	
	CSBean bean = (CSBean)session.getAttribute("bean");
	String title = bean.getCc_title();
	String content = bean.getCc_content();
	String secret = bean.getCc_secret();
	//scRead.jsp에서 session에 빈즈 단위로 저장 했기 때문에 파일명도 가져 올 수 있다.
	String filename = bean.getCc_filename();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-고객센터</title>
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
#insertMember{
	float: right;
	margin-right:350px;
  	width: 800px;
  	border: 10px solid #F88C65; 
	border-radius:10px;
	padding:20px 40px;
	margin-top:50px;
}
#categoryframe{
	margin-left:280px;
	margin-right:80px;
	margin-top:50px;
	float:left;
	border:10px solid #FCBC7E;
	border-radius:15px;
	background-color:white;
	width:250px;
	height:300px;
	padding:30px 0px;
	background-color:#FAF8EB;
}
 
#list td {
	border-bottom: 1px solid lightgray;
	height:30px;
	
}

#title td {
	color: white;
	background-color: #F88C65;
}

a {
	text-decoration: none;
	color: black;
}

a:hover {
	color: gray;
}


 #atag {
 	margin-left:50px;
 	height:40px;
 	line-height:40px;
 	width:170px;
 	display: block;
 }
 
 
 #atag:hover{
 	background-color:white;
 	border-radius: 10px;
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

	<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>

	<table width="70%" align="center">
		<tr>
		<!-- 카테고리 부분 -->
		<td style="vertical-align:top">
		<div id="categoryframe">
			<h3 style="margin-left:50px;">고객센터</h3>
			<div id="atag">
			<a href="custCenter.jsp?cust_page=ccBestBoard">&#149; 자주 묻는 질문</a>
			</div>
			<br> 
			<div id="atag">
			<a href="custCenter.jsp?cust_page=ccQuery">&#149; 질문하기</a>
			</div>
		</div>
		</td>

<!-- 고객센터 글수정 Start -->
		<td>
		<div id="insertMember">
			<h2 align="center">고객센터 글쓰기</h2>	
			<hr style="border:1px solid #F88C65;">
			<form name="cspostFrm" method="post" action="csUpdate?cust_page=<%=cust_page%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>"
			enctype="multipart/form-data">
			<table width="700" cellpadding="3" align="center">
				<tr>
					<td align=center>
					<table align="center">
						<tr>
							<td>작성자</td>
							<td>
							<div id="inputdiv3">
							<input size="50" maxlength="30" disabled="disabled"
							value="<%=ccid%>">
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
							<input name="cctitle" size="50" maxlength="30" value="<%=title%>">
							</div>
							</td>
						</tr>
						<tr>
							<td>내 용</td>
							<td colspan="3">
							<div id="textareadiv">
							<textarea name="cccontent" rows="10" cols="50"><%=content %></textarea>
							</div>
							</td>
						</tr>
						<tr>
						 <tr>
			     			<td>파일찾기</td> 
			     			<td colspan="3">
								<input id="inputdiv3" value="<%=filename!=null?"첨부된 파일 : "+filename:"첨부된 파일이 없습니다."%>">
			     				<input type="file" name="ccfilename" size="50" maxlength="50"
			     				style="border:1px;">
			     			</td>
			    		</tr>
			    		<tr>
			    			<td colspan="4">
			    			비밀글<input type="checkbox" name="ccsecret" <%if(secret!=null) {%>checked<%} %>>
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
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="ccip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="cust_page" value="<%=cust_page%>">
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
		</td>
		</tr>
		</table>
<!-- 고객센터 글수정 End -->

	<jsp:include page="../alcinfo/footer.jsp"></jsp:include>
</body>
</html>