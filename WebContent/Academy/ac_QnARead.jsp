<!-- ac_QnARead.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.AcqueryBean"%>
<%@page import="alcinfo.AcQcommentsBean"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="acqmgr" class="alcinfo.AcqueryMgr"/>
<jsp:useBean id="acqcmgr" class="alcinfo.AcQcommentsMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	//read.jsp?nowPage=1&numPerPage=10&keyField=&keyWord=&num=3
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	int num = UtilMgr.parseInt(request, "num");
	int acnum = UtilMgr.parseInt(request, "ac_num");
	String loginid = (String)session.getAttribute("idKey");
	
	String flag = request.getParameter("flag");
	if(flag!=null) {
		if(flag.equals("insert")) {
			AcQcommentsBean acqbean = new AcQcommentsBean();
			acqbean.setAcq_num(num);
			acqbean.setAcq_id(request.getParameter("cid"));
			acqbean.setAcq_content(request.getParameter("comment"));
			acqbean.setAcq_ip(request.getParameter("ip"));
			acqcmgr.insertAcQComment(acqbean);
		} else if(flag.equals("insert1")) {
			AcQcommentsBean acqrbean = new AcQcommentsBean();
			acqrbean.setAcq_num(num);
			acqrbean.setAcq_id(request.getParameter("cid"));
			acqrbean.setAcq_content(request.getParameter("comment"));
			acqrbean.setAcq_ip(request.getParameter("ip"));
			acqrbean.setAcq_conum(UtilMgr.parseInt(request, "conum"));
			acqcmgr.insertAcQCReply(acqrbean);
		} else if(flag.equals("del1")) {
			acqcmgr.deleteAllAcQCReply(UtilMgr.parseInt(request, "conum"));
		} else if(flag.equals("del2")) {
// 			요청한 댓글 삭제
			acqcmgr.deleteAcQComment(UtilMgr.parseInt(request, "cnum"));
		}
	} else {
// 		조회수 증가 : list.jsp 게시물 읽어옴
		acqmgr.AcQupCount(num);
	}
	
	AcqueryBean bean = acqmgr.getQuery(num);
	String id = bean.getAc_id();
	String title = bean.getAc_title();
	String subject = bean.getAc_subject();
	String regdate = bean.getAc_date();
	String content = bean.getAc_content();
	String ip = bean.getAc_ip();
	int count = bean.getAc_count();
	int ccount = acqmgr.acqccount(num);
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
	location.href="ac_QnA.jsp?ac_num=<%=acnum%>";
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

.acqReply {
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
			  	Vector<AcQcommentsBean> cvlist = acqcmgr.getAcQComment(num);
			      	if(!cvlist.isEmpty()){
			  %>
				 <table>
				 <%
					 	for(int i=0;i<cvlist.size();i++){
					 		AcQcommentsBean acqcbean = cvlist.get(i);
	 		 	 			int cnum = acqcbean.getNum();
	 		 	 			String cid = acqcbean.getAcq_id();
	 		 	 			String comment = acqcbean.getAcq_content();
	 		 	 			String cregdate = acqcbean.getAcq_regdate();
	 		 	 			int conum = acqcbean.getAcq_conum();
	 		 	 			int depth = acqcbean.getAcq_depth();
	 		 	 			
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
						<a onclick="onacqReply<%=i%>();">답글쓰기</a>
						<% } %>
						
						<!-- 답글쓰기 Start -->
						
						<script>
						 	function onacqReply<%=i%>() {
						 		document.getElementById("acqReply<%=i%>").style.display = 'block';
						 	}
						 	function offacqReply<%=i%>() {
						 		document.getElementById("acqReply<%=i%>").style.display = 'none';
						 	}
						 	function rInsert<%=i%>() {
						 		if(document.acqFrm<%=i%>.comment.value==""){
						 			alert("댓글을 입력하세요.");
						 			document.acqFrm<%=i%>.comment.focus();
						 			return;
						 		}
						 		document.acqFrm<%=i%>.submit();
						 	}
				 		</script>
						<div id="acqReply<%=i%>" class="acqReply">
							<form method="post" name="acqFrm<%=i%>">
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
			 | <a href="ac_QnAUpdate.jsp?num=<%=num%>&ac_num=<%=acnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%>&keyField=<%=keyField%>&keyWord=<%=keyWord%>" >수 정</a> |
			 <a href="ac_QnADelete.jsp?nowPage=<%=nowPage%>&num=<%=num%>&ac_num=<%=acnum%>">삭 제</a> 
		 <% }
		 } %>
		 ]<br/>
		  </td>
		 </tr>
		</table>
		
		<form name="listFrm" method="post" action="ac_QnA.jsp">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<input type="hidden" name="ac_num" value="<%=acnum%>">
			<%if(!(keyWord==null||keyWord.equals(""))){%>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}%>
		</form>
		</div>
	</div>
</body>
</html>