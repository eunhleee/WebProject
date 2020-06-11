<!-- 7p 4. 마이페이지 나의 신고 글 창 -->
<!-- MypeportList.jsp -->
<!-- 검색까지됨 -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.ReportBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="rMgr" class="alcinfo.ReportMgr"/>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
		
		request.setCharacterEncoding("UTF-8");
		String reid=(String)session.getAttribute("idKey");
		int totalRecord = 0;//총게시물수
		int numPerPage = 10;//페이지당 레코드 개수(5,10,15,30)
		int pagePerBlock = 15;//블럭당 페이지 개수
		int totalPage = 0;//총 페이지 개수
		int totalBlock = 0;//총 블럭 개수
		int nowPage = 1;//현재 페이지
		int nowBlock = 1;//현재 블럭
		
		//요청된 numPerPage 처리
		//요청이 있으면 처리가 되지만 그렇지 않으면 기본 10개 세팅이 된다.
		if(request.getParameter("numPerPage")!=null){
			numPerPage = UtilMgr.parseInt(request, "numPerPage");
		}
		
		//검색에 필요한 변수
		String keyField="",keyWord="";
		//검색일때
		if(request.getParameter("keyWord")!=null){
			keyField=request.getParameter("keyField");
			keyWord=request.getParameter("keyWord");}
		
		//검색 후에 다시 처음화면 요청
		if(request.getParameter("reload")!=null&&
		request.getParameter("reload").equals("true")){
			keyField ="";keyWord="";
		}
		totalRecord = rMgr.getTotalCount(keyField, keyWord,reid);
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
<link rel="stylesheet" sype="text/css" href = "MyReportListStyle.css">

<title>GuestBook</title>
<script type="text/javascript">
function mycheck() {
	if(document.searchF.keyWord.value==""){
		alert("검색어를 입력하세요.");
		document.searchF.keyWord.focus();
		return;
	}
	document.searchF.submit();
}
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
	document.listFrm.action = "MyReportList.jsp";
	document.listFrm.submit();
}
function numPerFn(numPerPage) {
	document.readFrm.numPerPage.value = numPerPage;
	document.readFrm.submit();
}
</script>
</head>
<body>
<jsp:include page="../alcinfo/headerSearch.jsp"/>
<div class="frame">
  <div class="container">
    <div class="nav">
      <ul class="nav-list">
        <li class="nav-item"><a href="" class="nav-link">개인정보 변경</a></li>
        <li class="nav-item"><a href="" class="nav-link">내가 쓴 글</a></li>      
        <li class="nav-item"><a href="" class="nav-link">나의신고</a></li>
        <li class="nav-item"><a href="" class="nav-link">신청한 과외</a></li>
        <li class="nav-item"><a href="" class="nav-link">접수된 학생</a></li>
      
      </ul>
    </div>
    <!--nav-->
    <div class="content">
		<form name="searchF">
					<table width="600" cellpadding="4" cellspacing="0">
						<tr>
							<td align="center" valign="bottom"><select name="keyField" size="1">
							<option value="renum">글번호</option>
							<option value="regroup">글분류</option>
							<option value="retitle">제목</option>
							<option value="recontent">내용</option>
							<option value="restate">상태</option>
							
							</select> <input size="16" name="keyWord">
							<input type="button" value="찾기" onClick="javascript:mycheck()"> 
							<input type="hidden" name="nowPage" value="1"></td>
						</tr>
					</table>
				</form>
	<table>
	<tr>
		<td width="600">
		Total : <%=totalRecord%>Articles(
		<font color="red"><%=nowPage+"/"+totalPage%>Pages</font>)
		</td>
		<td align="right"><form name="npFrm" method="post">
					<select name="numPerPage" size="1" onchange="numPerFn(this.form.numPerPage.value)">
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
		<table>
	<tr>
		<td align="center" colspan="2">
		<%
				Vector<ReportBean> vlist = 
				rMgr.MRList(keyField, keyWord,reid, start, cnt);
				int listSize = vlist.size();//브라우저 화면에 표시될 게시물 번호
				if(vlist.isEmpty()){
					out.println("등록된 게시물이 없습니다.");
				}else{
		//Vector<ReportBean> mvlist=rMgr.MRList(keyField, keyWord,reid);
		//int listStze =mvlist.size();
%>
	<table cellspacing="0">

			<tr>
				<td>글번호</td>
				<td>글분류</td>
				<td>제목</td>
				<td>내용</td>
				<td>상태</td>
			</tr>
		<%for(int i=0;i<numPerPage;i++){
			if(i==listSize) break;
			ReportBean mbean=vlist.get(i);
		%>
			<tr>
			<td><%=mbean.getRenum()%></td>
			<td><%=mbean.getRegroup()%></td>
			<td><%=mbean.getRetitle()%></td>
			<td><%=mbean.getRecontent()%></td>
			<td><%=mbean.getRestate()%></td>
			</tr>
			<%}//for%>
		</table>
		<%}//if-else %>
	</tr>
		<tr>
		<td colspan="2"><br><br></td>
	</tr>
	<tr>
	<td>
	<!-- 페이징 및 블럭 Start -->
		<%if(totalPage>0){ %>
	<!-- 이전블럭 (이전페이지로 넘긴다)-->
	<%if(nowBlock>1){ %>
	<a href="javascript:block('<%=nowBlock-1%>')">prev...</a>
		<%} %>
	
	<!-- 페이징 -->
	<%
	
		int pageStart=(nowBlock-1)*pagePerBlock+1;
		int pageEnd=(pageStart+pagePerBlock)<totalPage?//제일 마지막 페이지는 15개가 아니다그래서 들어온 조건
				pageStart+pagePerBlock:totalPage+1;
		for(;pageStart<pageEnd;pageStart++){
	%>
	<a href="javascript:pageing('<%=pageStart%>')"><!-- 페이징처리(페이지번호 넘기기) -->
	<%if(nowPage==pageStart){ %><font color="blue"><%}%>
	[<%=pageStart%>]
	<%if(nowPage==pageStart){ %></font><%}%>
	</a>
	<%}//---for%>
	<!-- 다음 블럭(다음페이지로 넘긴다) -->
	<%if(totalBlock>nowBlock){ %>
			<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
		<%}%>
	<%}///-if1%>
	<!-- 페이징 및 블럭 End -->
	</td>
	<td align="right">
		<a href="javascript:list()">[처음으로]</a>
	</td>
	</tr>
</table>
	<form name="listFrm" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="nowPage" value="1">
</form>
	<form name="readFrm">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<input type="hidden" name="num">
	
	
</form>
    </div>
  </div>
  <!-- //container -->
    <div class="footer">
  </div>
  <!-- //footer -->
  <jsp:include page="../alcinfo/footer.jsp"/>
</div>
<!-- //frame -->
</body>
</html>