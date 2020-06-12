<!-- 19p 12.관리자화면 - 회원상태관리 -->
<!--StateManagement.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.ReportBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="rMgr" class="alcinfo.ReportMgr" />

<%
	request.setCharacterEncoding("UTF-8");
		//검색에 필요한 변수
		int totalRecord=0;//총 게시물 수
		int numPerPage=10;//페이지당 레코드 개수(5,10,15,30)
		int pagePerBlock=15;//블럭당 페이지 개수
		int totalPage=0;//총 페이지 개수
		int totalBlock=0;//총 블럭개수
		int nowPage=1;//현재 페이지
		int nowBlock=1;//현재 블럭
		String keyField="",keyWord="";
		//요청이 있으면 처리가 되지만 그렇지 않으면 기본 10개 세팅이 된다
		if(request.getParameter("numPerPage")!=null){
			numPerPage=UtilMgr.parseInt(request,"numPerPage");
		}//여기까지만 하면 10개가 기본값이기 때문에 10개로 다시 바꾸고 싶을때 반응하지 않는다.
		//따라서110번째 줄을 추가하면 값이 바뀌어 되게된다.
		//검색일때
		if(request.getParameter("keyWord")!=null){
			keyField=request.getParameter("keyField");
			keyWord=request.getParameter("keyWord");}
		
		//검색 후에 다시 처음화면 요청
		if(request.getParameter("reload")!=null&&
		request.getParameter("reload").equals("true")){
			keyField ="";keyWord="";
		}
		//검색 후에 다시 처음화면 요청
		if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
			keyField = "";
			keyWord = "";
		}
			//	Vector<ReportBean> mvlist=rMgr.mGMList();
				totalRecord=rMgr.rgetTotalCount(keyField, keyWord);
			//	out.print("totalRecord : "+totalRecord);//레코드 다 나오는지 확인코드
			
			
			//nowPage 요청처리
			if(request.getParameter("nowPage")!=null){
				nowPage=UtilMgr.parseInt(request,"nowPage");
			}	
			
			
			//sql문에 들어가는 start,cnt선언
			int start=(nowPage*numPerPage)-numPerPage;
			int cnt=numPerPage;
			
			//전체페이지수 개수
			totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
			//전체블럭 개수
			totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
			//현재블럭
			nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
		
%>
<html>
<head>
<title>관리자-신고접수건관리</title>
<link href="MyReportListStyle.css" rel="stylesheet">

<script type="text/javascript">
function smupdate(renum,plusdate,num,contents,stopid) {
	if(contents=="")
	{
		alert("사유를 선택해주세요");
		return;

	}
	if(plusdate=="")
		{
			alert("상태를 선택해주세요");
			return;

		}
	else{
	   document.readFr.renum.value=renum;
	   document.readFr.plusdate.value=plusdate;
	   document.readFr.num.value=num;
	   document.readFr.contents.value=contents;
	   document.readFr.stopid.value=stopid;
	   document.readFr.submit();
	}
	}
function scheck() {
	if(document.searchF.keyWord.value==""){
		alert("검색어를 입력하세요.");
		document.searchF.keyWord.focus();
		return;
	}
	document.searchF.submit();
}
function pageing(page) {//페이지 번호 넘기는 것(값을 가져다줌)
	document.readF.nowPage.value=page;
	document.readF.submit();
}
function block(block) {
	document.readF.nowPage.value=
		<%=pagePerBlock%>*(block-1)+1;
	document.readF.submit();
}
function list(){//처음으로를 누르면 처음으로 가게 도와주는 함수(24번째줄 참고)
	document.listFr.action="list.jsp";
	document.listFr.submit();
	
}
function numPerFn(numPerPage){//5개보기,10개보기 등등 보기리스트 함수
	//alert(numPerPage);//보기리스트를 누르면 팝압창생성
	document.readF.numPerPage.value=numPerPage;
	document.readF.submit();
}
//list.jsp에서 read.jsp로 요청이 될때 기존에 조건
//기존 조건 : keyField,keyWord,nowPage,numPerPage
function read(num){
	document.readF.num.value=num;
	document.readF.action="read.jsp";
	document.readF.submit();
}
</script>
</head>
<body>
	<jsp:include page="../alcinfo/headerSearch.jsp" />
	<div class="frame">
		<div class="container">
			<div class="nav">
				<ul class="nav-list">
					<li class="nav-item"><a href="" class="nav-link">관리자 정보 수정</a></li>
					<li class="nav-item"><a href="" class="nav-link">내가 쓴 글</a></li>
					<li class="nav-item"><a href="" class="nav-link">신고 접수 건</a></li>
					<li class="nav-item"><a href="" class="nav-link">회원 상태 관리</a></li>

				</ul>
			</div>
			<!--nav-->
			<div class="content">
				<form name="searchF">
					<table width="600" cellpadding="4" cellspacing="0">
						<tr>
							<td align="center" valign="bottom"><select name="keyField" size="1">
							<option value="name">이 름</option>
							<option value="stopid">신고아이디</option>
							</select> <input size="16" name="keyWord">
							<input type="button" value="찾기" onClick="javascript:scheck()"> 
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
			
				Vector<ReportBean> pvlist = rMgr.SMList(keyField, keyWord,start,cnt);
				int listSize=pvlist.size();//브라우저 화면에 표시될 게시물 번호
				if(pvlist.isEmpty()){
				out.println("등록된 게시물이 없습니다.");
				}else{
				%>
				<table cellspacing="0">
					<tr>
						<td>아이디</td>
						<td>이름</td>
						<td>사유</td>
						<td>상태</td>
					</tr>
					<%
						for (int i = 0; i < numPerPage; i++) {
							if(i==listSize) break;
						ReportBean rbean = pvlist.get(i);
					%>
				<form method="post" action="SMupdateProc.jsp">
				<tr>
						<td><%=rbean.getStopid()%></td>
						<td><%=rbean.getName()%></td>
						<td><select name=contents>
								<option value="">선택하세요.
								<option value="사기">사기
								<option value="도배">도배
								<option value="욕설">욕설
								<option value="기타">기타
						</select></td>
						<td><select name=plusdate>
								<option value="">선택하세요.
								<option value="1">1일
								<option value="7">7일
								<option value="30">30일 
						</select></td>

						<td><input type="button" value="입력" 
							onClick="javascript:smupdate('<%=rbean.getRenum()%>',this.form.plusdate.value,'<%=rbean.getNum()%>',
							this.form.contents.value,'<%=rbean.getStopid()%>')">
						</td>
					</tr>
				
				</form>
					<%}%>
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
<hr width="750">
			</div>
			<form name="listFr" method="post">
	<input type="hidden" name="reload" value="true">
	<input type="hidden" name="noPage" value="1">
	
</form>
			</div>
			<form name="readFr" action="SMupdateProc.jsp">
					<input type="hidden" name="keyField" value="<%=keyField%>">
					<input type="hidden" name="keyWord" value="<%=keyWord%>"> 
					<input type="hidden" name="num">
					<input type="hidden" name="renum">
					<input type="hidden" name="contents">
					<input type="hidden" name="stopid">
					<input type="hidden" name="plusdate">
			</form>
				<form name="readF">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
	<input type="hidden" name="num">
	</form>
	
		</div>
		<!-- //container -->
		<div class="footer">
			<p class="copyright">&copy;copy</p>
		</div>
		<!-- //footer -->
		<jsp:include page="../alcinfo/footer.jsp" />
	</div>
	<!-- //frame -->
</body>
</html>