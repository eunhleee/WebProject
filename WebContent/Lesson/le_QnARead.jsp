<!-- le_QnARead.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.LequeryBean"%>
<%@page import="alcinfo.LeQcommentsBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="leqmgr" class="alcinfo.LequeryMgr"/>
<jsp:useBean id="leqcmgr" class="alcinfo.LeQcommentsMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	//read.jsp?nowPage=1&numPerPage=10&keyField=&keyWord=&num=3
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int num = UtilMgr.parseInt(request, "num");
	int lq_lnum = UtilMgr.parseInt(request, "lq_lnum");
	String loginid = (String)session.getAttribute("idKey");
	
	String flag = request.getParameter("flag");
	if(flag!=null) {
		if(flag.equals("insert")) {
			LeQcommentsBean leqbean = new LeQcommentsBean();
			leqbean.setLeq_num(num);
			leqbean.setLeq_id(request.getParameter("cid"));
			leqbean.setLeq_content(request.getParameter("comment"));
			leqbean.setLeq_ip(request.getParameter("ip"));
			leqcmgr.insertLeQComment(leqbean);
		} else if(flag.equals("insert1")) {
			LeQcommentsBean leqbean = new LeQcommentsBean();
			leqbean.setLeq_num(num);
			leqbean.setLeq_id(request.getParameter("cid"));
			leqbean.setLeq_content(request.getParameter("comment"));
			leqbean.setLeq_ip(request.getParameter("ip"));
			leqbean.setLeq_conum(UtilMgr.parseInt(request, "conum"));
			leqcmgr.insertLeQCReply(leqbean);
		} else if(flag.equals("del1")) {
			leqcmgr.deleteAllLeQCReply(UtilMgr.parseInt(request, "conum"));
		} else if(flag.equals("del2")) {
// 			요청한 댓글 삭제
			leqcmgr.deleteLeQComment(UtilMgr.parseInt(request, "cnum"));
		}
	} else {
// 		조회수 증가 : list.jsp 게시물 읽어옴
		leqmgr.LeQupCount(num);
	}
	
	LequeryBean bean = leqmgr.getQuery(num);
	String id = bean.getLq_id();
	String title = bean.getLq_title();
	String subject = bean.getLq_subject();
	String regdate = bean.getLq_date();
	String content = bean.getLq_content();
	String ip = bean.getLq_ip();
	int count = bean.getLq_count();
	int ccount = leqmgr.leqccount(num);
	//읽어온 게시물을 수정 및 삭제를 위해 세션저장
	session.setAttribute("bean", bean);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-학원 문의 게시판</title>
<script>
function list() {
	location.href="le_QnA.jsp?lq_lnum=<%=lq_lnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
}
function cInsert() {
	if(document.cFrm.comment.value==""){
		alert("댓글을 입력하세요.");
		document.cFrm.comment.focus();
		return;
	}
	document.cFrm.submit();
}
function cDel(conum, cnum, depth) {
	if(depth==0) { // 댓글 삭제 시 대댓글까지 전부 삭제
		document.cFrm.flag.value="del1";
		document.cFrm.conum.value=conum;
		document.cFrm.submit();
	} else if(depth==1) { // 대댓글 삭제
		document.cFrm.flag.value="del2";
		document.cFrm.cnum.value=cnum;
		document.cFrm.submit();
	}
}

</script>
<style>
#list td {
	border-bottom: 1px solid lightgray;
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
	cursor : pointer;
}

.leqReply {
	display: none;
}

</style>
</head>
<body>

	<div style="margin-left: 5%; margin-right: 5%; margin-top:5%;">

		<div>
		<table align="center" cellspacing="3" width="100%">
		 <tr>
		  <td bgcolor="#9CA2EE" height="25" align="center">글읽기
		  </td>
		 </tr>
		 <tr>
		  <td colspan="2">
		   <table cellpadding="3" cellspacing="0" width="100%"> 
		    <tr> 
		  <td align="center" bgcolor="#DDDDDD" width="20%"> 아 이 디 </td>
		  <td bgcolor="#FFFFE8"><%=id%></td>
		  <td align="center" bgcolor="#DDDDDD" width="20%"> 등록날짜 </td>
		  <td bgcolor="#FFFFE8"><%=regdate%></td>
		 </tr>
		   <tr> 
		    <td align="center" bgcolor="#DDDDDD"> 제 목</td>
		    <td bgcolor="#FFFFE8" colspan="3"><%=title%></td>
		   </tr>
		   <tr> 
		    <td align="center" bgcolor="#DDDDDD"> 과 목</td>
		    <td bgcolor="#FFFFE8" colspan="3"><%=subject%></td>
		   </tr>
		   <tr> 
		    <td colspan="4"><br/><pre><%=content%></pre><br/><hr></td>
		   </tr>
		   <tr>
		    <td colspan="3" align="left">
		    	댓글 <%=ccount%>
		    </td>
		    <td align="right">
		     	조회수  <%=count%>
		    </td>
		   </tr>
		   </table>
		  </td>
		 </tr>
		 <tr>
		  <td align="center" colspan="2">
		   <!-- 댓글 입력폼 Start -->
			<% if(loginid!=null) { %>
		   <form method="post" name="cFrm">
				<table>
					<tr  align="center">
						<td width="50">아이디</td>
						<td align="left">
							<input name="cid" size="10" value="<%=loginid%>" readonly>
						</td>
					</tr>
					<tr align="center">
						<td>내 용</td>
						<td>
						<input name="comment" size="50" placeholder="댓글을 남겨보세요"> 
						<input type="button" value="등록" onclick="cInsert()"></td>
					</tr>
				</table>
			 <input type="hidden" name="flag" value="insert">	
			 <input type="hidden" name="num" value="<%=num%>">
			 <input type="hidden" name="cnum">
			 <input type="hidden" name="conum">
		    <input type="hidden" name="nowPage" value="<%=nowPage%>">
		    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
			   <%
			   	if(!(keyWord==null||keyWord.equals(""))){
			   %>
		    <input type="hidden" name="keyField" value="<%=keyField%>">
		    <input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%
				}
			%>
			</form>
			<% } %>
		   <!-- 댓글 입력폼 End -->
		 <hr/>
  			<!-- 댓글 List Start -->
			  <%
			  	Vector<LeQcommentsBean> cvlist = leqcmgr.getLeQComment(num);
			      	if(!cvlist.isEmpty()){
			  %>
				 <table>
				 <%
					 	for(int i=0;i<cvlist.size();i++){
					 		LeQcommentsBean leqcbean = cvlist.get(i);
	 		 	 			int cnum = leqcbean.getNum();
	 		 	 			String cid = leqcbean.getLeq_id();
	 		 	 			String comment = leqcbean.getLeq_content();
	 		 	 			String cregdate = leqcbean.getLeq_regdate();
	 		 	 			int conum = leqcbean.getLeq_conum();
	 		 	 			int depth = leqcbean.getLeq_depth();
	 		 	 			
			 				String dstyle = "";
	 		 	 			if(depth==1) {
	 		 	 				dstyle = "style=\"padding-left:30px;\"";	
				 			}
				 %>
				 	
				 	<tr>
						<td <%=dstyle%> colspan="3" width="600"><b><%=cid%></b></td>
					</tr>
					<tr>
						<td <%=dstyle%> colspan="2"><%=comment%></td>
						<% 
						if(loginid!=null) {
							if(loginid.equals(cid)) { %>
						<td align="center" valign="middle">
							<input type="button" value="삭제"
							onclick="cDel('<%=conum%>','<%=cnum%>','<%=depth%>')">
						</td>
						<% 	
							}
						} %>
					</tr>
					<tr>
						<td <%=dstyle%> colspan="3">
						<%=cregdate%>
						<% if(loginid!=null) { %>
						<a onclick="onleqReply<%=i%>();">답글쓰기</a>
						<% } %>
						
						<!-- 답글쓰기 Start -->
						
						<script>
						 	function onleqReply<%=i%>() {
						 		document.getElementById("leqReply<%=i%>").style.display = 'block';
						 	}
						 	function offleqReply<%=i%>() {
						 		document.getElementById("leqReply<%=i%>").style.display = 'none';
						 	}
						 	function rInsert<%=i%>() {
						 		if(document.leqFrm<%=i%>.comment.value==""){
						 			alert("댓글을 입력하세요.");
						 			document.leqFrm<%=i%>.comment.focus();
						 			return;
						 		}
						 		document.leqFrm<%=i%>.submit();
						 	}
				 		</script>
						<div id="leqReply<%=i%>" class="leqReply">
							<form method="post" name="leqFrm<%=i%>">
								<table>
									<tr align="center">
										<td width="50">아이디</td>
										<td align="left">
											<input name="cid" size="10" value="<%=loginid%>" readonly>
										</td>
									</tr>
									<tr align="center">
										<td>내 용</td>
										<td>
											<input name="comment" size="50" placeholder="댓글을 남겨보세요"> 
											<input type="button" value="등록" onclick="rInsert<%=i%>()">
											<input type="button" value="취소" onclick="offacqReply<%=i%>()">
										</td>
									</tr>
								</table>
							<input type="hidden" name="flag" value="insert1">
							<input type="hidden" name="num" value="<%=num%>">
							<input type="hidden" name="cnum">
							<input type="hidden" name="conum" value="<%=conum%>">
							<input type="hidden" name="depth" value="<%=depth%>">
						    <input type="hidden" name="nowPage" value="<%=nowPage%>">
						    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
							<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
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
						
						<!-- 답글쓰기 End -->
						
						</td>
					</tr>
				 <% }//---for%>
				 </table>	
			 <hr/>
			 <% } %>
			 <!-- 댓글 List End -->
		 [ <a href="javascript:list();" >리스트</a>
		 <% 
		 if(loginid!=null) {
			 if(loginid.equals(id)) { %>
			 | <a href="le_QnAUpdate.jsp?num=<%=num%>&lq_lnum=<%=lq_lnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>" >수 정</a> |
			 <a href="le_QnADelete.jsp?&num=<%=num%>&lq_lnum=<%=lq_lnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>">삭 제</a> 
		 <% }
		 } %>
		 ]<br/>
		  </td>
		 </tr>
		</table>

		<form name="listFrm" method="post" action="ac_QnA.jsp">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<input type="hidden" name="lq_lnum" value="<%=lq_lnum%>">
			<%if(!(keyWord==null||keyWord.equals(""))){%>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}%>
		</form>
		</div>
	</div>
</body>
</html>