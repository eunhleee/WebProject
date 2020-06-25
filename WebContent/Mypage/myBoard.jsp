<!-- 7p 4. 마이페이지 나의 신고 글 창 -->
<!-- MypeportList.jsp -->
<!-- 검색까지됨 -->
<%@page import="alcinfo.MyBoardBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.ReportBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="rMgr" class="alcinfo.ReportMgr"/>
<jsp:useBean id="mbMgr" class="alcinfo.MyBoardMgr"/>
<jsp:useBean id="HeaderMmgr" class="member.MemberMgr"/>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
		
		request.setCharacterEncoding("UTF-8");
	if(session.getAttribute("idKey")==null||session.getAttribute("idKey").equals("")){
		response.sendRedirect("../alcinfo/cards-gallery.jsp");
	}
 		String reid=(String)session.getAttribute("idKey");
 		int logingrade=HeaderMmgr.checkM(reid);

 		int totalRecord = 0;//총게시물수
		int numPerPage = 10;//페이지당 레코드 개수(5,10,15,30)
		int pagePerBlock = 10;//블럭당 페이지 개수
		int totalPage = 0;//총 페이지 개수
		int totalBlock = 0;//총 블럭 개수
		int nowPage = 1;//현재 페이지
		int nowBlock = 1;//현재 블럭
		
		//요청된 numPerPage 처리
		//요청이 있으면 처리가 되지만 그렇지 않으면 기본 10개 세팅이 된다.
		if(request.getParameter("numPerPage")!=null){
			numPerPage = UtilMgr.parseInt(request, "numPerPage");
		}
		
		totalRecord = mbMgr.getTotalCount(reid);
		//out.print("totalRecord : " + totalRecord);
		
		//nowPage 요청 처리
		if(request.getParameter("nowPage")!=null){
			nowPage = UtilMgr.parseInt(request, "nowPage");
		}
		
		//sql문에 들어가는 start, cnt 선언
		int start = (nowPage*numPerPage)-numPerPage;
		int cnt = numPerPage;
		
		//전체페이지 개수
		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
		//전체블럭 개수
		 totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
		//현재블럭
		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
%>

<html>
<head>

<title>GuestBook</title>
<script type="text/javascript">
function pageing(page) {
	document.readFrm.nowPage.value = page;
	document.readFrm.submit();
}
function block(block) {
	document.readFrm.nowPage.value = 
		<%=pagePerBlock%>*(block-1)+1;
	document.readFrm.submit();
}
function  list() {
	document.listFrm.action = "myBoard.jsp";
	document.listFrm.submit();
}
function numPerFn(numPerPage) {
	document.readFrm.numPerPage.value = numPerPage;
	document.readFrm.submit();
}
function moveAcQnA(ac_num,num){
	url = "../Academy/ac_QnARead.jsp?nowPage=1&numPerPage=10&ac_num="+ac_num+"&num="+num;
	window.open(url, "Ac_QnA", "width=900, height=560, top=200, left=400");
}
function moveLeQnA(lq_lnum,num){
	url = "../Lesson/le_QnARead.jsp?nowPage=1&numPerPage=10&lq_lnum="+lq_lnum+"&num="+num;
	window.open(url, "Le_QnA", "width=900, height=560, top=200, left=400");
}
</script>
<style>
#totalframe{
	background-color:#FAF8EB;
	width:96.5%;
	height:100%;
	padding:30px 50px;
	
}
#insertMember{
	float: right;
	margin-right:400px;
  	width: 800px;
}
#categoryframe{
	margin-left:280px;
	margin-right:80px;
	float:left;
	border:10px solid #FCBC7E;
	border-radius:15px;
	background-color:white;
	width:250px;
	height:300px;
	padding:30px 0px;
}

#atag {
	width:150px;
 	height:40px;
 	line-height:40px;
 	display: block;
 	margin-left:60px;
 }
 
 
#atag:hover{
 	background-color:#FAF8EB;
 	border-radius: 10px;
 }
 
#atag a {
	text-decoration: none;
	color: black;
}

#atag a:hover {
	color: gray;
}

#list td {
	border-bottom: 1px solid lightgray;
	background-color:white;
	height:30px;
}

#title td {
	color: white;
	background-color: #F88C65;
}

select{
	font-size:15px;
}

#inputdiv{
	background-color:white;
}
a {
	text-decoration: none;
	color: black;
}

a:hover {
	color: gray;
}

</style>
</head>
<body>
<jsp:include page="../alcinfo/headerSearch.jsp"/>
<div id="totalframe">
	<div id="categoryframe">
		<h3 align="center">마이 페이지</h3>
		<%if(logingrade==1) {%>
		<div id="atag"><a href="../Mypage/upMember.jsp">&#149; 개인 정보 수정</a></div>
		<div id="atag"><a href="../Mypage/myBoard.jsp">&#149; 내가 쓴 글</a></div>
		<div id="atag"><a href="../Mypage/MyReportList.jsp">&#149; 나의 신고</a></div>
		<div id="atag"><a href="../Mypage/myLesson.jsp">&#149; 신청한 과외</a></div>
		<div id="atag"><a href="../Mypage/myReceiveLesson.jsp">&#149; 신청 받은 과외</a></div>
		<%}else{ %>
		<div id="atag"><a href="../Mypage/upTeachar.jsp">&#149; 개인 정보 수정</a></div>
		<div id="atag"><a href="../Mypage/myBoard.jsp">&#149; 내가 쓴 글</a></div>
		<div id="atag"><a href="../Mypage/MyReportList.jsp">&#149; 나의 신고</a></div>
		<div id="atag"><a href="../Mypage/myStudent.jsp">&#149; 내가 신청한 학생</a></div>
		<div id="atag"><a href="../Mypage/myReceiveStudent.jsp">&#149; 과외 신청함</a></div>
		<div id="atag"><a href="">&#149; 권한 변경 신청</a></div>
		<%} %>
	</div>
    <!--nav-->
  <div id="insertMember" class="insertMember1" align="left">
  <div><h2>내가 쓴 글</h2></div>
	
	<table >
		<tr>
		<td width="700">
		Total : <%=totalRecord%>Articles(
		<font color="red"><%=nowPage+"/"+totalPage%>Pages</font>)
		</td>
		<td align="right"><form name="npFrm" method="post">
					<select name="numPerPage" size="1" onchange="numPerFn(this.form.numPerPage.value)" style="font-size:15px;">
	   					<option value="5">5개 보기</option>
	   					<option value="10" selected>10개 보기</option>
	   					<option value="15">15개 보기</option>
	   					<option value="30">30개 보기</option>
	  				</select>
	  			</form>
	  			<script>
	  			document.npFrm.numPerPage.value=<%=numPerPage%>
	  			//19번째 줄에 10개 셋팅시에 값을 바꾸는 역할을 한다. 이게 없으면 값이 처음기본 세팅의 10으로 돌아올수가 없다.
	  			</script>
	   	</td>
			
		</tr>
	</table>
		<table >
		<tr>
			<td align="center" colspan="2" width="800">
				<table cellspacing="0"  width="800" >
	
			<tr id="title" align="center">
				<td>글분류</td>
				<td>제목</td>
				<td>작성날짜</td>
				<td>조회수</td>
			</tr>
			<%
				Vector<MyBoardBean> vlist1 = mbMgr.MBList(reid, start, cnt);
				int listSize1 = vlist1.size();
				if(vlist1.isEmpty()) {
					%>
					<tr>
						<td align="center" colspan="6" height="150" style="background-color:white;">
							<% out.println("등록된 게시물이 없습니다."); %>
						</td>
					</tr>
			<%
				} else {
			%> 
				<% for(int i=0; i<listSize1; i++) {
					MyBoardBean mbBean = vlist1.get(i); %>
					<tr id="list">
					<td align="center">
					<%if(mbBean.getAc_num()!=null) { %>학원 문의 게시판<%} %>
					<%if(mbBean.getAc_serialnum()!=null) { %>학원 리뷰 게시판<%} %>
					<%if(mbBean.getLq_lnum()!=null) { %>과외 문의 게시판<%} %>
					<%if(mbBean.getLr_lnum()!=null) { %>과외 리뷰 게시판<%} %>
					<%if(mbBean.getStunum()!=null) { %>학생 문의 게시판<%} %>
					<%if(mbBean.getSc_group()!=null) { 
						if(mbBean.getSc_group().equals("free")) {%>커뮤니티 - 자유게시판<%} %>
						<%if(mbBean.getSc_group().equals("academy")) {%>커뮤니티 - 학원 Q&A<%} %>
						<%if(mbBean.getSc_group().equals("lesson")) {%>커뮤니티 - 과외 Q&A<%} %>
						<%if(mbBean.getSc_group().equals("onlyst")) {%>커뮤니티 - 학생 전용 게시판<%} %>
						<%if(mbBean.getSc_group().equals("onlyte")) {%>커뮤니티 - 선생님 전용 게시판<%} %>
						
					<%} %>
					<%if(mbBean.getCc_group()!=null) { %>고객센터 질문<%} %>
					</td>
					<td><a 
					<%if(mbBean.getAc_num()!=null) {
					%>href="javascript:moveAcQnA('<%=mbBean.getAc_num()%>','<%=mbBean.getNum()%>');"><%} %>
					<%if(mbBean.getAc_serialnum()!=null) {
					%>href="../Academy/ac_ReviewRead.jsp?nowPage=1&numPerPage=10&num=<%=mbBean.getAc_serialnum()%>&acrnum=<%=mbBean.getNum()%>"><%} %>
					<%if(mbBean.getLq_lnum()!=null) {
					%>href="javascript:moveLeQnA('<%=mbBean.getLq_lnum()%>','<%=mbBean.getNum()%>');"><%} %>
					<%if(mbBean.getLr_lnum()!=null) {
							String leid = mbMgr.checkleid(mbBean.getLr_lnum());
					%>href="../Lesson/le_ReviewRead.jsp?nowPage=1&numPerPage=10&num=<%=mbBean.getLr_lnum()%>&lernum=<%=mbBean.getNum()%>&id=<%=leid%>"><%} %>
					<%if(mbBean.getStunum()!=null) {
					%>href="../Student/st_QnARead.jsp?nowPage=1&numPerPage=10&stunum=<%=mbBean.getStunum()%>&num=<%=mbBean.getNum()%>"><%} %>
					<%if(mbBean.getSc_group()!=null) {
					%>href="../Community/scRead.jsp?nowPage=1&numPerPage=10&pageValue=<%=mbBean.getSc_group()%>&num=<%=mbBean.getNum()%>"><%} %>
					<%if(mbBean.getCc_group()!=null) {
					%>href="../CS/cs_Read.jsp?nowPage=1&numPerPage=10&cust_page=<%=mbBean.getCc_group()%>&num=<%=mbBean.getNum()%>"><%} %>
					<%=mbBean.getTitle()%></a>
					</td>
					<td align="center"><%=mbBean.getDate()%></td>
					<td align="center"><%=mbBean.getCount()%></td>
					</tr>
				<%} %>
				<%
				}%>
			
			</table>
	</tr>
	<tr>
	<td>
	<!-- 페이징 및 블럭 Start -->
		<%if(totalPage>0){ %>
	<!-- 이전블럭 (이전페이지로 넘긴다)-->
	<%if(nowBlock>1){ %>
	<a href="javascript:block('<%=nowBlock-1%>')">이전</a>
		<%} %>
	
	<!-- 페이징 -->
	<%
	
		int pageStart=(nowBlock-1)*pagePerBlock+1;
		int pageEnd=(pageStart+pagePerBlock)<totalPage?//제일 마지막 페이지는 15개가 아니다그래서 들어온 조건
				pageStart+pagePerBlock:totalPage+1;
		for(;pageStart<pageEnd;pageStart++){
	%>
	<a href="javascript:pageing('<%=pageStart%>')"><!-- 페이징처리(페이지번호 넘기기) -->
	<%if(nowPage==pageStart){ %><font color="gray"><%}%>
	[<%=pageStart%>]
	<%if(nowPage==pageStart){ %></font><%}%>
	</a>
	<%}//---for%>
	<!-- 다음 블럭(다음페이지로 넘긴다) -->
		<%if(totalBlock>nowBlock){ %>
			<a href="javascript:block('<%=nowBlock+1%>')">다음</a>
		<%}%>
	<%}///-if1%>
		<!-- 페이징 및 블럭 End -->
		</td>
		<td align="right">
			<a href="javascript:list()">[처음으로]</a>
		</td>
		</tr>
	</table>
 </div>
</div>
<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="nowPage" value="1">
</form>
<form name="readFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<input type="hidden" name="num">
	
</form>
   
 
  <!-- //container -->


<!-- //frame -->
</body>
</html>