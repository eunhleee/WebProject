
<!-- 학원 리뷰 리스트 출력 -->
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="alcinfo.LeteaBean"%>
<%@page import="alcinfo.MemberBean"%>

<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.AcreviewBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="mgr" class="alcinfo.AcreviewMgr"></jsp:useBean>
<jsp:useBean id="Loginmgr" class="alcinfo.LoginMgr"></jsp:useBean>
<jsp:useBean id="Memmgr" class="member.MemberMgr"></jsp:useBean>
<jsp:useBean id="Teamgr" class="alcinfo.LeteaMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	int ac_serialnum=UtilMgr.parseInt(request,"num");
	String loginid = (String)session.getAttribute("idKey");
	
	//로그인한 상태인지 회원의 포인트 멤버쉽이 오늘날까지 유효한지 비교하기 위함
	int grade=Loginmgr.getGrade(loginid);
	int todaynumber=0,mpointnumber=0;
	String mpoint=null;
	if(loginid!=null){
	if(grade==1){
		MemberBean mbean=Memmgr.getInfo(loginid);
		mpoint=mbean.getMpoint();
		
	}
	else if(grade==2||grade==3){
		LeteaBean lbean=Teamgr.getInfo(loginid);
		mpoint=lbean.getMpoint();
	} 
	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    Calendar today = Calendar.getInstance();
 	String strToday = sdf.format(today.getTime());
	
	 todaynumber=Integer.parseInt(strToday);
	 if(mpoint!=null){
	 mpoint=mpoint.replace("-", "");
	 mpointnumber=Integer.parseInt(mpoint);
	 }
	}
	
	int totalRecord = 0;//총게시물수
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

	totalRecord = mgr.getTotalCount(keyField, keyWord,ac_serialnum);
	//out.print("totalRecord : " + totalRecord);

	//nowPage 요청 처리
	if (request.getParameter("nowPage") != null) {
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}

	//sql문에 들어가는 start, cnt 선언
	int start = (nowPage * numPerPage) - numPerPage;
	int cnt = numPerPage;

	//전체페이지 개수
	totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
	//전체블럭 개수
	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
	//현재블럭
	nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>학원 후기 게시판</title>
<script>
	function accheck() {
		if (document.acsearchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.acsearchFrm.keyWord.focus();
			return;
		}
		document.acsearchFrm.action = "acRead.jsp";
		document.acsearchFrm.submit();
	}
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	function block(block) {
		document.readFrm.nowPage.value =<%=pagePerBlock%> * (block - 1) + 1;
		document.readFrm.submit();
	}
	function list() {//[처음으로]를 누르면 게시글의 처음 페이지로 돌아감
		document.listFrm.action = "acRead.jsp?num=<%=ac_serialnum%>";
		document.listFrm.submit();
	}
	function numPerFn(numPerPage) {
		document.readFrm.numPerPage.value = numPerPage;
		document.readFrm.submit();
	}
	//list.jsp에서 read.jsp로 요청이 될때 기존에 조건
	//기존 조건 : keyField,keyWord,nowPage,numPerPage
	function read(num) {
		document.readFrm.acrnum.value = num;
		document.readFrm.action = "ac_ReviewRead.jsp";
		document.readFrm.submit();
	}

	function moveToBuyPoint(){
		location.href="../Payment/buyPoint.jsp";
	
	}
	function acalert() {
		alert("로그인 후 이용가능합니다.");
	}
</script>
<style>
#list td {
	border-bottom: 1px solid lightgray;
	height:30px;
}

#title td {
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
</style>
</head>
<body>

	<!-- 리스트 부분 -->

	<h2>학원 리뷰</h2>
	<table>
		<tr>
			<td width="600">Total : <%=totalRecord%>Articles(<font
				color="red"> <%=nowPage + "/" + totalPage%>Pages
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
						<td width="150">평 점</td>
						<td width="280">제 목</td>
						<td width="100">닉 네 임</td>
						
						<td width="150">날 짜</td>
						<td width="100">조회수</td>
					</tr>
					<%
						if(grade!=0&&(loginid==null||mpoint==null||mpointnumber<todaynumber)){
					%>
					<tr>
						<td align="center" colspan="5" height="180" style="background-color:gray;  opacity: 0.5;">
							<p style="color:white;">포인트를 구입하시면 <%=totalRecord%> 개의 후기글을 보실 수 있습니다.</p><br>
							<input type="button" value="포인트 구입하러 가기" onclick="moveToBuyPoint();">
						</td>
					</tr>
					<%}else{ %>
					<%
						Vector<AcreviewBean> vlist = mgr.getBoardList(ac_serialnum,keyField, keyWord, start, cnt);
						int listsize = vlist.size();
						if (vlist.isEmpty()) {
					%>
					<tr>
						<td align="center" colspan="5" height="180">
							<%
								out.println("등록된 게시물이 없습니다.");
							%>
						</td>
					</tr>


					<%
						} else {
							for (int i = 0; i < listsize; i++) {
								AcreviewBean acbean = vlist.get(i);
								int num = acbean.getNum();
								String title = acbean.getAc_title();
								String nick = acbean.getAc_nickname();
								Double star = acbean.getAc_star();
								String date = acbean.getAc_date();
								int count = acbean.getAc_count();
								int ccount = mgr.acrccount(num);
					%>
						<tr id="list">
							<td align="center"><%=star%></td>
						<td align="center">
						<a href="javascript:read('<%=num%>')"><%=title%></a>
						<% if(ccount>0) { %>
							<font color="red">[<%=ccount%>]</font>
						<% } %>
						</td>
						<td align="center"><a href=""><%=nick%></a></td>
						<td align="center"><%=date%></td>
						<td align="center"><%=count%></td>
					</tr>

					<%
							}
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
			<%
				if(loginid!=null&&mpoint!=null&&mpointnumber>=todaynumber){
			%>
			<td align="right">
			<a 
			<% if(loginid != null) { %>
			href="ac_ReviewPost.jsp?num=<%=ac_serialnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>"
			<% } else { %>
				href="javascript:acalert()"
			<% } %>
			>[글쓰기]</a> 
			<a href="javascript:list()">[처음으로]</a></td>
			
			<%} %>
		</tr>
	</table>


	<hr width="800" align="center">
	<form name="acsearchFrm">
		<table width="600" cellpadding="4" cellspacing="0">
			<tr>
				<td align="center" valign="bottom">
					<div id="inputdiv" style="width:320px; display:flex;">
						<select name="keyField" size="1" style="flex:1; border:none;">
							<option value="ac_title" <%if(keyField.equals("ac_title")) {%>selected<%} %>>제 목</option>
							<option value="ac_content" <%if(keyField.equals("ac_content")) {%>selected<%} %>>내 용</option>
							<option value="ac_nickname" <%if(keyField.equals("ac_nickname")) {%>selected<%} %>>닉 네 임</option>
						</select> 
						<input size="16" name="keyWord" value="<%=keyWord%>" style="flex:2;"> 
						<input type="button" value="찾기" onClick="javascript:accheck()"> 
					</div>
					<input type="hidden" name="nowPage" value="1"  style="flex:1;">
					<input type="hidden" name="num" value="<%=ac_serialnum%>">
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
		<input type="hidden" name="acrnum">
		<input type="hidden" name="num" value="<%=ac_serialnum%>">
	</form>



</body>

</html>



