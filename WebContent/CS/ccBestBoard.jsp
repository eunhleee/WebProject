<!-- 고객센터 게시판 리스트 출력 -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.CSBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.CSMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	String loginid = (String)session.getAttribute("idKey");
	String category="", group="";
	
	if(request.getParameter("cust_page").equals("ccBestBoard")) {
		category="자주 묻는 질문";
		group="ccBestBoard";
	}
	else if(request.getParameter("cust_page").equals("ccQuery")) {
		category="질문하기";
		group="ccQuery";
	}
	//검색에 필요한 변수

	int totalRecord = 0;//총게시물수(관리자)
	int totalRecord1 = 0;//총게시물수(회원)
	int numPerPage = 10;//페이지당 레코드 개수(5,10,15,30)
	int pagePerBlock = 15;//블럭당 페이지 개수
	int totalPage = 0;//총 페이지 개수
	int totalBlock = 0;//총 블럭 개수
	int nowPage = 1;//현재 페이지
	int nowBlock = 1;//현재 블럭

	//요청된 numPerPage 처리
	//요청이 있으면 처리가 되지만 그렇지 않으면 기본 10개 세팅이 된다.
	if (request.getParameter("numPerPage") != null) {
		numPerPage = UtilMgr.parseInt(request, "numPerPage");
	}

	//검색에 필요한 변수
	String keyField = "", keyWord = "";
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

	totalRecord = mgr.getTotalCount(keyField, keyWord, group);
	totalRecord1 = mgr.getTotalCount1(keyField, keyWord, group, loginid);
	//out.print("totalRecord : " + totalRecord);

	//nowPage 요청 처리
	if (request.getParameter("nowPage") != null) {
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}

	//sql문에 들어가는 start, cnt 선언
	int start = (nowPage * numPerPage) - numPerPage;
	int cnt = numPerPage;

	//전체페이지 개수
	if(mgr.checkM(loginid)==0) {
		totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
	} else {
		totalPage = (int) Math.ceil((double) totalRecord1 / numPerPage);
	}
	
	//전체블럭 개수
	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
	//현재블럭
	nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-고객센터</title>
<script>
	function cscheck() {
		if (document.cssearchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.cssearchFrm.keyWord.focus();
			return;
		}
		document.cssearchFrm.submit();
	}
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	function block(block) {
		document.readFrm.nowPage.value =
<%=pagePerBlock%>
	* (block - 1) + 1;
		document.readFrm.submit();
	}
	function list() {//[처음으로]를 누르면 게시글의 처음 페이지로 돌아감
		document.listFrm.action = "custCenter.jsp?cust_page=<%=group%>";
		document.listFrm.submit();
	}
	function numPerFn(numPerPage) {
		document.readFrm.numPerPage.value = numPerPage;
		document.readFrm.submit();
	}
	//list.jsp에서 read.jsp로 요청이 될때 기존에 조건
	//기존 조건 : keyField,keyWord,nowPage,numPerPage
	function read(num) {
		document.readFrm.num.value = num;
		document.readFrm.action = "cs_Read.jsp?cust_page=<%=group%>";
		document.readFrm.submit();
	}
	function csalert() {
		alert("로그인 후 이용가능합니다.");
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
#list td {
	border-bottom: 1px solid lightgray;
	background-color:#FAF8EB;
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
</style>
</head>
<body>




	<!-- 리스트 부분 -->

	<h2><%=category%></h2>
	<table>
		<tr>
			<td width="600">
			Total : 
			<%if(mgr.checkM(loginid)==0) {%><%=totalRecord%>
			<%} else { %><%=totalRecord1%>
			<%} %>Articles(
			<font color="red"> <%=nowPage + "/" + totalPage%>Pages
			</font>)
			</td>
			<td align="right">
				<form name="npFrm" method="post">
					<select name="numPerPage" size="1"
						onchange="numPerFn(this.form.numPerPage.value)">
						<option value="5">5개 보기</option>
						<option value="10" selected>10개 보기</option>
						<option value="15">15개 보기</option>
						<option value="30">30개 보기</option>
					</select>
				</form> <script>
					document.npFrm.numPerPage.value =
				<%=numPerPage%>
					
				</script>
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td align="center" colspan="2">
				<table cellspacing="0" height="80">
					<tr align="center" id="title">
						<td width="100">번 호</td>
						<td width="280">제 목</td>
						<td width="100">아 이 디</td>
						<td width="150">날 짜</td>
						<td width="100">조회수</td>
					</tr>
					
					<!-- 관리자 모드 -->
					<% if(mgr.checkM(loginid)==0) {%>
					<%
						Vector<CSBean> vlist = mgr.getBoardList(keyField, keyWord, start, cnt, group);
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
							for (int i = 0; i < listsize; i++) {
								CSBean bean = vlist.get(i);
								int num = bean.getNum();
								String title = bean.getCc_title();
								String id = bean.getCc_id();
								String date = bean.getCc_regdate();
								String filename = bean.getCc_filename();
								String secret = bean.getCc_secret();
								int count = bean.getCc_count();
								int ccount = mgr.ccount(num);
					%>
					<tr id="list">
						<td align="center"><%=totalRecord-start-i%></td>
						<td align="center">
						<a href="javascript:read('<%=num%>')">
							<% if(secret!=null) {%>
							<img src="../img/key-icon.png">
							<% } %>
							<%=title%></a>
							<% if(filename!=null) { %>
								<img src="../img/icon_file1.png">
							<% } %>
							<% if(ccount>0) { %>
								<font color="red">[<%=ccount%>]</font>
							<% } %>
						</td>
						<td align="center"><a href=""><%=id%></a></td>
						<td align="center"><%=date%></td>
						<td align="center"><%=count%></td>
					</tr>

					<%
							}
						}
					%>
					<%} else {%>
					<!-- 일반 회원 모드 -->
					<%
						Vector<CSBean> vlist = mgr.getBoardList1(keyField, keyWord, start, cnt, group, loginid);
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
							for (int i = 0; i < listsize; i++) {
								CSBean bean = vlist.get(i);
								int num = bean.getNum();
								String title = bean.getCc_title();
								String id = bean.getCc_id();
								String date = bean.getCc_regdate();
								String filename = bean.getCc_filename();
								String secret = bean.getCc_secret();
								int count = bean.getCc_count();
								int ccount = mgr.ccount(num);
					%>
					<tr id="list">
						<td align="center"><%=totalRecord1-start-i%></td>
						<td align="center">
						<a href="javascript:read('<%=num%>')">
							<% if(secret!=null) {%>
							<img src="../img/key-icon.png">
							<% } %>
							<%=title%></a>
							<% if(filename!=null) { %>
								<img src="../img/icon_file1.png">
							<% } %>
							<% if(ccount>0) { %>
								<font color="red">[<%=ccount%>]</font>
							<% } %>
						</td>
						<td align="center"><a href=""><%=id%></a></td>
						<td align="center"><%=date%></td>
						<td align="center"><%=count%></td>
					</tr>

					<%
							}
						}
					%>
					<%} %>
					

				</table>

			</td>
		</tr>
		<tr>
			<td colspan="2"><br> <br></td>
		</tr>

		<tr>
			<td>
				<!-- 페이징 및 블럭 Start --> <%
 	if (totalPage > 0) {
 %> <!-- 이전 블럭 --> <%
 	if (nowBlock > 1) {
 %>
				<a href="javascript:block('<%=nowBlock - 1%>')">이전으로</a> <%
 	}
 %> <!-- 페이징 -->
				<%
					int pageStart = (nowBlock - 1) * pagePerBlock + 1;
						int pageEnd = (pageStart + pagePerBlock) < totalPage ? pageStart + pagePerBlock : totalPage + 1;
						for (; pageStart < pageEnd; pageStart++) {
				%> <a href="javascript:pageing('<%=pageStart%>')"> <%
 	if (nowPage == pageStart) {
 %><font
					color="gray">
						<%
							}
						%> [<%=pageStart%>] <%
							if (nowPage == pageStart) {
						%>
				</font>
					<%
						}
					%>
			</a> <%
 	} //---for
 %> <!-- 다음 블럭 --> <%
 	if (totalBlock > nowBlock) {
 %> <a
				href="javascript:block('<%=nowBlock + 1%>')">다음으로</a> <%
 	}
 %> <%
 	} //---if1
 %>
				<!-- 페이징 및 블럭 End -->
			</td>
			<td align="right"> 
			<% if(group.equals("ccBestBoard"))  {
				 if(mgr.checkM(loginid)==0) {%>
				 <a href="cs_Post.jsp?cust_page=ccBestBoard&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>">[글쓰기]</a>
			<%   }
			   } else if(group.equals("ccQuery")) {
			     if(loginid==null) {%>
			     <a href="javascript:csalert()">[글쓰기]</a>
			<%	 } else {%>
				 <a href="cs_Post.jsp?cust_page=ccQuery&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>">[글쓰기]</a>
			<%   }
			   } %>
			<a href="javascript:list()">[처음으로]</a></td>
		</tr>
	</table>


	<hr width="750">
	<form name="cssearchFrm">
		<table width="600" cellpadding="4" cellspacing="0">
			<tr>
				<td align="center" valign="bottom">
				<select name="keyField" size="1">
					<option value="cc_title" <%if(keyField.equals("cc_title")) {%>selected<%} %>>제 목</option>
					<option value="cc_content" <%if(keyField.equals("cc_content")) {%>selected<%} %>>내 용</option>
					<option value="cc_id" <%if(keyField.equals("cc_id")) {%>selected<%} %>>아 이 디</option>
				</select> 
				 <input size="16" name="keyWord" value="<%=keyWord%>">
				 <input type="submit" value="찾기" onClick="javascript:cscheck()"> 
				 <input type="hidden" name="nowPage" value="1">
				 <input type="hidden" name="cust_page" value="<%=group%>">
				 </td>
			</tr>
		</table>
	</form>
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
		<input type="hidden" name="cust_page" value="<%=group%>">
		<input type="hidden" name="num">
	</form>



</body>

</html>



