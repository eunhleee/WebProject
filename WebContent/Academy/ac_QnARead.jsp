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
	location.href="ac_QnA.jsp?ac_num=<%=acnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
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
function goRep() {
	
	url = "acQReport.jsp?stopid=<%=id%>&renum=<%=num%>";
	window.open(url, "GoReport", 'width=900, height=560, top=200, left=300');
}

function goCReport(conum,stuc_depth,stopid) {
	url = "acQCReport.jsp?conum="+conum+"&stuc_depth="+stuc_depth+"&renum="+<%=num%>+"&stopid="+stopid;
	window.open(url, "GoReport", "width=900, height=560, top=200, left=300");
	}
</script>
<style>

#inputdiv{
	margin:10px;
	width:150px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#inputdiv input{
	width:140px;
	border:none;
	font-size:15px;
}
#readDiv{
	width:90%;
	align:center;
	border: 10px solid #F88C65; 
	border-radius:10px;
	padding:20px 40px;
}
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

		<div id="readDiv">
		<table align="center" cellspacing="3" width="100%" bgcolor="white">
		 <tr>
		  <td>
		   <table cellpadding="3" cellspacing="0" width="100%"> 
		    <tr height="100"> 
		    <td colspan="6">
		    <span style="font-size:30px;"><%=title%></span> 
		    <% if(loginid!=null) {%>		    
			 <input type="button" value="신고" onclick="javascript:goRep();" style="float:right;">
			  <%}%></td>
		 </tr>
		    <tr height="30"> 
				<td align="center" bgcolor="#FCBC7E" width="15%" style="color:white; font-weight:bold;" > 닉 네 임</td>
				<td bgcolor="#FAF8EB" width="15%"><%=id%></td>
				<td align="center" bgcolor="#FCBC7E" width="15%" style="color:white; font-weight:bold;"> 등록날짜 </td>
				<td bgcolor="#FAF8EB" width="20%"><%=regdate%></td>
				<td align="center" bgcolor="#FCBC7E" width="15%" style="color:white; font-weight:bold;">조회수</td>
				<td bgcolor="#FAF8EB"><%=count%></td>
			</tr>
		   <tr> 
		    <td colspan="6" height="200"><span><%=content%></span></td>
		   </tr>
		   <tr>
		    <td colspan="3" align="left">
		    	댓글 <%=ccount%>
		    </td>
		   </tr>
		   </table>
		  </td>
		 </tr>
		 <tr>
		  <td colspan="2">
	    <hr/>
		   
  			<!-- 댓글 List Start -->
			  <%
			  	Vector<AcQcommentsBean> cvlist = acqcmgr.getAcQComment(num);
			      	if(!cvlist.isEmpty()){
			  %>
				 <table width="100%">
				 <%
					 	for(int i=0;i<cvlist.size();i++){
					 		AcQcommentsBean acqcbean = cvlist.get(i);
	 		 	 			int cnum = acqcbean.getNum();
	 		 	 			String cid = acqcbean.getAcq_id();
	 		 	 			String comment = acqcbean.getAcq_content();
	 		 	 			String cregdate = acqcbean.getAcq_regdate();
	 		 	 			int conum = acqcbean.getAcq_conum();
	 		 	 			int depth = acqcbean.getAcq_depth();
	 		 	 			String stopid=acqcbean.getAcq_id();

			 				String dstyle = "", dstyle1= "";
	 		 	 			if(depth==1) {
	 		 	 				dstyle = "style=\"padding-left:30px;\"";	
	 		 	 				dstyle1 = "padding-left:30px;";
				 			}
				 %>
				 	
				 	<tr>
						<td <%=dstyle%> colspan="4" width="600"><b><%=cid%></b></td>
					</tr>
					<tr>
						<td <%=dstyle%> colspan="3" style=" min-height:150px;"><%=comment%></td>
						<td align="right">
						<% 
						if(loginid!=null) {
							if(loginid.equals(cid) || acqmgr.checkM(loginid)==0) { %>
							<input type="button" value="삭제"
							onclick="cDel('<%=conum%>','<%=cnum%>','<%=depth%>')">
						</td>
						<% 	} %>
							<td align="left" valign="middle">
							<input type="button" value="댓글신고"
							onclick="javascript:goCReport
							('<%=cnum%>','<%=depth%>','<%=stopid%>')">
							
						</td>
						<%} %>
					</tr>
					<tr>
						<td style="font-size:12px; color:gray; <%=dstyle1%>" colspan="3">
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
									<tr>
										<td><%=loginid%>&nbsp;:&nbsp;</td>
										<td colspan="5">
										<div id="inputdiv" style="width:450px; display:flex; backgound-color:white;">
										<input name="comment" size="50" placeholder="댓글을 남겨보세요" style="flex:5;"> 
										<input type="button" value="등록" onclick="rInsert<%=i%>()" style="flex:1; margin-right:5px;">
										<input type="button" value="취소" onclick="offacqReply<%=i%>()" style="flex:1;">
										</div>
										</td>
									</tr>
								</table>
							<input type="hidden" name="cid" value="<%=loginid%>">
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
			 <% } %>
			 <!-- 댓글 List End -->
			 <!-- 댓글 입력폼 Start -->
			<% if(loginid!=null) { %>
		   <form method="post" name="cFrm">
		   	<div id="inputdiv" style="width:97%; background-color:white;">
				<table width="97%">
					<tr>
						<td colspan="4"><%=loginid%></td>
					</tr>
					<tr>
						<td colspan="3" width="90%">
							<input name="comment" placeholder="댓글을 남겨보세요" style="width:95%; height:30px;">
						</td>
						<td align="right">
							<input type="button" value="등록" onclick="cInsert()" style=" height:30px;">
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="cid" value="<%=loginid%>">
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
			
	    <hr/>
		   <!-- 댓글 입력폼 End -->
		 [ <a href="javascript:list();" >리스트</a>
		 <% 
		 if(loginid!=null) {
			 if(loginid.equals(id) || acqmgr.checkM(loginid)==0) { %>
			 | <a href="ac_QnAUpdate.jsp?num=<%=num%>&ac_num=<%=acnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>" >수 정</a> |
			 <a href="ac_QnADelete.jsp?num=<%=num%>&ac_num=<%=acnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
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