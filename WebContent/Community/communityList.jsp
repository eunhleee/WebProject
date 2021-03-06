<!-- 커뮤니티의 리스트 출력 -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.SCommunityBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.SCommunityMgr"></jsp:useBean>

<%
		
		request.setCharacterEncoding("UTF-8");
		String id=(String )session.getAttribute("idKey");
	
		String category="",group="";
		
		if(request.getParameter("pageValue").equals("free")){
			category="자유게시판";
			group="free";
		}
		else if(request.getParameter("pageValue").equals("academy")){
			category="학원 Q&A";
			group="academy";
		}
		else if(request.getParameter("pageValue").equals("lesson")){
			category="과외 Q&A";
			group="lesson";
		}
		else if(request.getParameter("pageValue").equals("onlyst")){
			category="학생 전용 게시판";
			group="onlyst";
		}
		else if(request.getParameter("pageValue").equals("onlyte")){
			category="선생님 전용 게시판";
			group="onlyte";
		}
//검색에 필요한 변수
		
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
			numPerPage=UtilMgr.parseInt(request,"numPerPage");
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
		
		
		totalRecord = mgr.getTotalCount(keyField, keyWord,group);
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-커뮤니티</title>
<script>
function sccheck() {
	if(document.scsearchFrm.keyWord.value==""){
		alert("검색어를 입력하세요.");
		document.scsearchFrm.keyWord.focus();
		return;
	}
	document.scsearchFrm.submit();
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
function list(){//[처음으로]를 누르면 게시글의 처음 페이지로 돌아감
	document.listFrm.action="communityList.jsp?pageValue=<%=group%>";
	document.listFrm.submit();
}
function numPerFn(numPerPage){
	document.readFrm.numPerPage.value=numPerPage;
	document.readFrm.submit();
}
//list.jsp에서 read.jsp로 요청이 될때 기존에 조건
//기존 조건 : keyField,keyWord,nowPage,numPerPage

function clalert() {
	alert("로그인 후 이용가능 합니다.");
	location.href="communityList.jsp?pageValue=<%=group%>";
}
function read(num){
	document.readFrm.num.value=num;
	document.readFrm.action="scRead.jsp?pageValue=<%=group%>";
	document.readFrm.submit();
}
function clalert1(){
	alert("학생만 이용가능 합니다.")
}
function clalert2(){
	alert("선생님만 이용가능 합니다.")
}
</script>
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
	margin-top:25px;
}
#categoryframe{
	margin-left:280px;
	margin-right:80px;
	margin-top:25px;
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
 


</style> 
</head>

<body>

<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>
<table width="70%" align="center">
<tr>
<!-- 카테고리 부분 -->
<td style="vertical-align:top">
	<div id="categoryframe">
		<h3 style="margin-left:50px;">커뮤니티</h3>
		<div id="atag"><a href="communityList.jsp?pageValue=free">&#149; 자유게시판</a></div>
		<div id="atag"><a href="communityList.jsp?pageValue=academy">&#149; 학원 Q&A</a></div>
		<div id="atag"><a href="communityList.jsp?pageValue=lesson">&#149; 과외 Q&A</a></div>
		<div id="atag"><a 
		<%if(mgr.checkM(id)==0||mgr.checkM(id)==1) {%>
		href="communityList.jsp?pageValue=onlyst"
		<%} else { %>
		href="javascript:clalert1()"
		<%} %>
		>&#149; 학생 전용 게시판</a></div>
		<div id="atag"><a 
		<%if(mgr.checkM(id)==0||mgr.checkM(id)==2||mgr.checkM(id)==3) {%>
		href="communityList.jsp?pageValue=onlyte"
		<%} else { %>
		href="javascript:clalert2()"<%} %>
		>&#149; 선생님 전용 게시판</a></div>
	</div>
	</td>
	<!-- 리스트 부분 -->
	<td>
	<div id="insertMember" class="insertMember1" align="left">

		<h2><%=category %></h2>
		<table>
			<tr>
				<td width="600">Total : <%=totalRecord%>Articles(<font
					color="red"> <%=nowPage+"/"+totalPage%>Pages
				</font>)
				</td>
				<td align="right">
					<form name="npFrm" method="post">
						<select name="numPerPage" size="1"
							onchange="numPerFn(this.form.numPerPage.value)" style="font-size:15px;">
							<option value="5">5개 보기</option>
							<option value="10" selected>10개 보기</option>
							<option value="15">15개 보기</option>
							<option value="30">30개 보기</option>
						</select>
					</form> <script>
  			document.npFrm.numPerPage.value=<%=numPerPage%>
  			
  			</script>
				</td>
			</tr>
		</table>
		<table class="table table-hover">
			<tr>
				<td align="center" colspan="2">
					<table cellspacing="0" height="80">
						<tr align="center" id="title">
							<td width="100">번 호</td>
							<td width="280">제 목</td>
							<td width="100">닉네임</td>
							<td width="150">날 짜</td>
							<td width="100">조회수</td>

						</tr>

		
				<%
					Vector<SCommunityBean> vlist = mgr.getBoardList(keyField, keyWord,group, start, cnt);
					int listsize = vlist.size();
					if (vlist.isEmpty()) {
				%>
						<tr>
							<td align="center" colspan="5">
								<%
							out.println("등록된 게시물이 없습니다.");
						%>
							</td>
						</tr>



						<%
					} else {
						for (int i = 0; i <numPerPage; i++) {
							if(i==listsize) break;
							SCommunityBean bean = vlist.get(i);
							int num = bean.getNum();
							String title = bean.getSc_title();
							String nickname = bean.getSc_nick();
							String date = bean.getSc_regdate();
							String filename=bean.getSc_filename();
							int ccount=mgr.ccount(num);
							int count = bean.getSc_count();
				%>

						<tr id="list">
							<td align="center"><%=totalRecord-start-i%></td>
							<td align="left"><a href="javascript:read('<%=num%>')"><%=title%></a>
								<% if(filename!=null) { %>
									<img src="../img/icon_file1.png">
								<% } %>
								<% if(ccount>0) { %>
									<font color="red">[<%=ccount%>]</font>
								<% } %></td>
							<td align="center"><a href=""><%=nickname%></a></td>
							<td align="center"><%=date%></td>
							<td align="center"><%=count%></td>

						</tr>

						<%
						}
					}
				%>


					</table>

				</td>
			</tr>
			<tr>
				<td colspan="2"><br> <br></td>
			</tr>

			<tr>
				<td>
					<!-- 페이징 및 블럭 Start --> 
					<%if(totalPage>0){%> <!-- 이전 블럭 -->
					 <%if(nowBlock>1){ %>
					<a href="javascript:block('<%=nowBlock-1%>')">이전</a> 
					<%} %> <!-- 페이징 -->
					<%
				int pageStart = (nowBlock-1)*pagePerBlock+1;
				int pageEnd = (pageStart+pagePerBlock)<totalPage?
					pageStart+pagePerBlock:totalPage+1;
				for(;pageStart<pageEnd;pageStart++){
					%> 
					<a href="javascript:pageing('<%=pageStart%>')"> 
					<%if(nowPage==pageStart){%>
					<font color="gray">
							<%}%> [<%=pageStart%>]
					 <%if(nowPage==pageStart){%>
					</font>
						<%}%>
					</a>
					 <%}//---for%> <!-- 다음 블럭 -->
					  <%if(totalBlock>nowBlock){ %> 
					  <a href="javascript:block('<%=nowBlock+1%>')">다음</a> <%} %> <%}//---if1%>
					<!-- 페이징 및 블럭 End -->
				</td>
				
				<td align="right"><a 
				<%if(id==null){ %>
					onclick="clalert();" href=""
					<%}else{ %>
					href="scPost.jsp?pageValue=<%=group %>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
 	 	if(!(keyWord==null||keyWord.equals(""))){
	     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>" class="btn btn-default"
					<%} %>>[글쓰기]</a> 
					<a href="javascript:list()">[처음으로]</a></td>
			</tr>
		</table>


		<hr width="750">
		<form name="scsearchFrm" >
			<table align="center" cellpadding="4" cellspacing="0">
				<tr>
					<td align="center" valign="bottom">
						<div id="inputdiv" style="width:320px; display:flex;">
							<select name="keyField" size="1" style="flex:1; border:none;">
								<option value="sc_title" <%if(keyField.equals("sc_title")) {%>selected<%} %>>제 목</option>
								<option value="sc_content" <%if(keyField.equals("sc_content")) {%>selected<%} %>>내 용</option>
								<option value="sc_nick" <%if(keyField.equals("sc_nick")) {%>selected<%} %>>닉 네 임</option>
							</select>
							<input size="16" name="keyWord" value="<%=keyWord%>"  style="flex:2;">
							<input type="submit" value="찾기" onClick="javascript:sccheck()"  style="flex:1;"> 
						</div>
						<input type="hidden" name="nowPage" value="1">
						<input type="hidden" name="pageValue" value="<%=group%>">
					</td>
				</tr>
			</table>
		</form>
	</div>

		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true">
			<!-- 요게 중요 -->
			<input type="hidden" name="nowPage" value="1">
		</form>

		<form name="readFrm">
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<%if(!(keyWord==null||keyWord.equals(""))){%>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}%>
			<input type="hidden" name="pageValue" value="<%=group%>">
			<input type="hidden" name="num">
		</form>
		</td>
		</tr>
	</table>
	<jsp:include page="../alcinfo/footer.jsp"></jsp:include>

</body>

</html>

