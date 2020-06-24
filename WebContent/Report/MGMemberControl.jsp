<!-- 18p 12.관리자화면 - 신고접수건관리 -->
<!-- MGMemberContol.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.ReportBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="rMgr" class="alcinfo.ReportMgr" />

<%@ page contentType="text/html; charset=UTF-8"%>
<%
		request.setCharacterEncoding("UTF-8");
		int totalRecord=0;//총 게시물 수
		int numPerPage=10;//페이지당 레코드 개수(5,10,15,30)
		int pagePerBlock=15;//블럭당 페이지 개수
		int totalPage=0;//총 페이지 개수
		int totalBlock=0;//총 블럭개수
		int nowPage=1;//현재 페이지
		int nowBlock=1;//현재 블럭
		String keyField = "", keyWord = "";
		//요청된 numPerPage 처리
		//요청이 있으면 처리가 되지만 그렇지 않으면 기본 10개 세팅이 된다
		if(request.getParameter("numPerPage")!=null){
			numPerPage=UtilMgr.parseInt(request,"numPerPage");
		}//여기까지만 하면 10개가 기본값이기 때문에 10개로 다시 바꾸고 싶을때 반응하지 않는다.
		
		//검색일때
		if (request.getParameter("keyWord") != null) {
			keyField = request.getParameter("keyField");
			keyWord = request.getParameter("keyWord");
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
<!-- <link href="../Report/MyReportListStyle.css" rel="stylesheet"> -->

<script type="text/javascript">
	function goupdate(num,restate) {
	   //alert(restate);
	   document.readFrm.num.value=num;
	   document.readFrm.restate.value=restate;
	   document.readFrm.submit();
	}
	function msearch() {
		if (document.searchF.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchF.keyWord.focus();
			return;
		}
		document.searchF.submit();
	}
	function pageing(page) {//페이지 번호 넘기는 것(값을 가져다줌)
		document.readFr.nowPage.value=page;
		document.readFr.submit();
	}
	function block(block) {
		document.readFr.nowPage.value=
			<%=pagePerBlock%>*(block-1)+1;
		document.readFr.submit();
	}
	function list(){//처음으로를 누르면 처음으로 가게 도와주는 함수(24번째줄 참고)
		document.listFr.action="MGMemberControl.jsp";
		document.listFr.submit();
		
	}
	function numPerFn(numPerPage){//5개보기,10개보기 등등 보기리스트 함수
		//alert(numPerPage);//보기리스트를 누르면 팝압창생성
		document.readFr.numPerPage.value=numPerPage;
		document.readFr.submit();
	}
	//list.jsp에서 read.jsp로 요청이 될때 기존에 조건
	//기존 조건 : keyField,keyWord,nowPage,numPerPage
	function read(num){
		document.readFr.num.value=num;
		document.readFr.action="read.jsp";
		document.readFr.submit();
	}

</script>
<style>
#content{
	margin : auto;
  	width: 100%;
  	border: 10px solid #36ada9; 
	border-radius:10px;
	margin-top:50px;
}
#list td {
	border-bottom: 1px solid lightgray;
	height:30px;
}

#title td {
	height:30px;
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
#nav_table tr {
	border:5px solid #56C8D3;
}

#nav_td {
	text-align: center;
	width:330px;
	height: 100px;
	border: none;
	
}

#nav_td a {
	color: black;
	text-decoration: none;
}

#nav_td a:hover {
	color: white;
	font-weight: bold;
}

#nav_td:hover {
	background-color: #56C8D3;
}
#graphList{
	width:70%;
}


</style>
</head>
<body>
<jsp:include page="../alcinfo/headerSearch.jsp" />
	<div id="frame" >
		<div id="container" align="center">
			<div id="total" align="center">
				<table id="nav_table">
					<tr>
						<td id="nav_td"><a href="../Mypage/managerPage.jsp?pageValue=salesList">매출 현황</a></td>
						<td id="nav_td"><a href="../Mypage/managerPage.jsp?pageValue=memberChart">회원 현황</a></td>
						<td id="nav_td"><a href="../Report/MGMemberControl.jsp">신고 접수건</a></td>
						<td id="nav_td"><a href="../Report/StateManagement.jsp">회원 관리</a></td>
						<td id="nav_td"><a href="../Mypage/requestAclist.jsp">학원장 접수 관리</a></td>
						
					</tr>
				</table>
			</div>
		<div id="graphList">
		
		<div align="center" id="content" class="content">
	
		<form style="margin-top:30;" name="searchF">
			<table id="sr" cellpadding="4" cellspacing="0">
		 		<tr>
		  			<td style="align:center;"  valign="bottom">
		  				<div id="inputdiv" style="width:320px; display:flex;">
		   					<select name="keyField" size="1" style="flex:1; border:none;">
		    					<option value="stopid"> 신고당한아이디 </option>
		    					<option value="retitle"> 제 목</option>
		    					<option value="regroup"> 신고분류</option>
			   				</select>
		   					<input size="16" name="keyWord">
		   					<input type="button"  value="찾기" onClick="javascript:msearch()">
		   					</div>
		   					<input type="hidden" name="nowPage" value="1">
		  			</td>
		 		</tr>
			</table>
		</form>
		<table width="90%">
			<tr >
				<td>
				Total : <%=totalRecord%>Articles(
				<font color="red"><%=nowPage+"/"+totalPage%>Pages</font>)
				</td>
				<td align="right">
					<form name="npFrm" method="post">
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
		<table width="90%">
			<tr>
				<td align="center" colspan="2">
					<%
						Vector<ReportBean> mvlist=rMgr.mGMList(keyField,keyWord,start,cnt);
						int listSize=mvlist.size();//브라우저 화면에 표시될 게시물 번호
						if(mvlist.isEmpty()){
						out.println("등록된 게시물이 없습니다.");
						}else{
					%>
						<table align="center" cellspacing="0" width="100%">
							<tr align="center" id="title">
								<td>신고접수번호</td>
								<td>신고분류</td>
								<td>신고자 아이디</td>
								<td>신고당한 아이디</td>
								<td>제목</td>
								<td>사유</td>
								<td colspan="2">상태</td>
							</tr>
					<%
						for(int i=0;i<numPerPage;i++){
							if(i==listSize) break;
						ReportBean mbean=mvlist.get(i);
					%>
					<form method="post" action="MGMCUpdateProc.jsp">
						<tr align="center" id="list">
							<td><a href="<%=mbean.getStopurl() %>"><%=mbean.getNum()%></a></td>
								<td><a href="<%=mbean.getStopurl() %>"><%=mbean.getRegroup()%></a></td>
								<td><a href="<%=mbean.getStopurl() %>"><%=mbean.getReid()%></a></td>
								<td><a href="<%=mbean.getStopurl() %>"><%=mbean.getStopid()%></a></td>
								<td><a href="<%=mbean.getStopurl() %>"><%=mbean.getRetitle()%></a></td>
								<td><a href="<%=mbean.getStopurl() %>"><%=mbean.getRecontent()%></a></td>
								<td>
									<select name="restate">
										<option value="접수중"
											<%=mbean.getRestate().equals("접수중")?"selected":""%>>접수중
									
										<option value="처리중"
											<%=mbean.getRestate().equals("처리중")?"selected":""%>>처리중
										
										<option value="완료"
											<%=mbean.getRestate().equals("완료")?"selected":""%>>완료
									
									</select>
								</td>
								<td>
									<input type="button" value="완료"
										onClick="goupdate('<%=mbean.getNum()%>',this.form.restate.value)">
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
		<%if(nowPage==pageStart){ %><font color="black"><%}%>
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
	<hr width="90%">
</div>
</div>

	<form name="listFr" method="post">
		<input type="hidden" name="reload" value="true">
		<input type="hidden" name="noPage" value="1">
	</form>
	<form name="readFrm" action="MGMCUpdateProc.jsp">
		<input type="hidden" name="keyField" value="<%=keyField%>">
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
		<input type="hidden" name="pageValue" value="reportList"> 
		<input type="hidden" name="num">
		<input type="hidden" name="restate">
	</form>
	<form name="readFr">
		<input type="hidden" name="nowPage" value="<%=nowPage%>">
		<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
		<input type="hidden" name="keyField" value="<%=keyField%>">
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
		<input type="hidden" name="pageValue" value="reportList">
		<input type="hidden" name="num">
	</form>
</div>
		<!-- //container -->
		<div class="footer">
			<p style="text-align:left; margin-left:15%" class="copyright">&copy;copy</p>
		</div>
	<!-- //frame -->
</body>
</html>