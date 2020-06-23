<!-- cs_Read.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="java.util.Vector"%>
<%@page import="alcinfo.CSBean" %>
<%@page import="alcinfo.CSCommentBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="csmgr" class="alcinfo.CSMgr"/>
<jsp:useBean id="cscmgr" class="alcinfo.CSCommentMgr"/>
<%
	request.setCharacterEncoding("utf-8");
	String cust_page=request.getParameter("cust_page");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");	
	int num = UtilMgr.parseInt(request, "num");
	String loginid = (String)session.getAttribute("idKey");
	String flag = request.getParameter("flag");
	if(flag!=null) {
		if(flag.equals("insert")) {
			CSCommentBean csbean = new CSCommentBean();
			csbean.setCcr_num(num);
			csbean.setCcr_id(request.getParameter("cid"));
			csbean.setCcr_content(request.getParameter("comment"));
			csbean.setCcr_ip(request.getParameter("ip"));
			cscmgr.insertCSComment(csbean);
		} else if(flag.equals("insert1")) {
			CSCommentBean csrbean = new CSCommentBean();
			csrbean.setCcr_num(num);
			csrbean.setCcr_id(request.getParameter("cid"));
			csrbean.setCcr_content(request.getParameter("comment"));
			csrbean.setCcr_ip(request.getParameter("ip"));
			csrbean.setCcr_conum(UtilMgr.parseInt(request, "conum"));
			cscmgr.insertSCReply(csrbean);
		} else if(flag.equals("del1")) {
			cscmgr.deleteAllCSCReply(UtilMgr.parseInt(request, "conum"));
		} else if(flag.equals("del2")) {
	//			요청한 댓글 삭제
			cscmgr.deleteCSComment(UtilMgr.parseInt(request, "cnum"));
		}
	} else {
	//		조회수 증가 : list.jsp 게시물 읽어옴
		csmgr.csupCount(num);
	}
	
	CSBean bean = csmgr.getBoard(num);
	String id = bean.getCc_id();
	String title = bean.getCc_title();
	String regdate = bean.getCc_regdate();
	String content = bean.getCc_content();
	String filename = bean.getCc_filename();
	String checkSecret = bean.getCc_secret();
	int filesize = bean.getCc_filesize();
	String ip = bean.getCc_ip();
	int count = bean.getCc_count();
	int ccount = csmgr.ccount(num);
	//읽어온 게시물을 수정 및 삭제를 위해 세션저장
	session.setAttribute("bean", bean);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-고객센터</title>
<style>
#readDiv{
	margin-top:50px;
	margin-left:15%;
	width:65%;
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
}
.csReply {
	display:none;
}
</style>
<script>
function down(filename) {
	document.downFrm.filename.value=filename;
	document.downFrm.submit();
}
function list() {
	document.listFrm.action = "custCenter.jsp?cust_page=<%=cust_page%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
		if(!(keyWord==null||keyWord.equals(""))){%>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
	document.listFrm.submit();
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
	
	url = "csReport.jsp?stopid=<%=id%>&renum=<%=num%>";
	window.open(url, "GoReport", 'width=360, height=300, top=200, left=300');
}

function goCReport(conum,ccr_depth,stopid) {
	url = "csCReport.jsp?conum="+conum+"&ccr_depth="+ccr_depth+"&renum="+<%=num%>+"&stopid="+stopid;
	window.open(url, "GoReport", "width=360, height=300, top=200, left=300");
}
</script>
</head>
<body>
	<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>

<!-- 고객센터 글읽기 Start -->
		<div id="readDiv">
		<table align="center" width="100%" cellspacing="3" bgcolor="white">
		 <tr>
		  <td>
		   <table cellpadding="3" cellspacing="0" width="100%"> 
		    <tr height="100"> 
			    <td colspan="7">
			    <span style="font-size:30px;"><%=title%></span> 
			    <% if(loginid!=null) {%>		    
				<input type="button" value="신고" onclick="javascript:goRep();" style="float:right;">
				<%}%></td>
		 	</tr>
		    <tr> 
				<td align="center" bgcolor="#FCBC7E" width="10%" style="color:white; font-weight:bold;" > 닉 네 임</td>
				<td bgcolor="#FAF8EB" width="10%"><%=id%></td>
				<td align="center" bgcolor="#FCBC7E" width="10%" style="color:white; font-weight:bold;"> 등록날짜 </td>
				<td bgcolor="#FAF8EB" width="15%"><%=regdate%></td>
				<td align="center" bgcolor="#FCBC7E" width="10%" style="color:white; font-weight:bold;">조회수</td>
				<td bgcolor="#FAF8EB" colspan="3"><%=count%></td>
			</tr>
		   <tr> 
		     <td align="center" bgcolor="#FCBC7E" style="color:white; font-weight:bold;" > 첨부파일</td>
		     <td bgcolor="#FFFFE8" colspan="5">
		    	<%
		    		if(filename!=null&&!filename.equals("")){
		    	%>
		    		<a href="javascript:down('<%=filename%>')"><%=filename%></a>
		    		<font color="blue">(<%=UtilMgr.intFormat(filesize)%>bytes)</font>
		    	<%
		    		} else {
		    			out.println("첨부된 파일이 없습니다.");
		    		}
		    	%>
		     </td>
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
			  	Vector<CSCommentBean> cvlist = cscmgr.getCSComment(num);
			      	if(!cvlist.isEmpty()){
			  %>
				 <table width="100%">
				 <%
					 	for(int i=0;i<cvlist.size();i++){
	 		 	 			CSCommentBean sccbean = cvlist.get(i);
	 		 	 			int cnum = sccbean.getNum();
	 		 	 			String cid = sccbean.getCcr_id();
	 		 	 			String comment = sccbean.getCcr_content();
	 		 	 			String cregdate = sccbean.getCcr_regdate();
	 		 	 			int conum = sccbean.getCcr_conum();
	 		 	 			int depth = sccbean.getCcr_depth();
	 		 	 			String stopid= sccbean.getCcr_id();
			 				String dstyle = "", dstyle1 = "";
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
							if(loginid.equals(cid) || csmgr.checkM(loginid)==0) { %>
							<input type="button" value="삭제"
							onclick="cDel('<%=conum%>','<%=cnum%>','<%=depth%>')">
							<%}%>
							<input type="button" value="댓글신고"
							onclick="javascript:goCReport
							('<%=sccbean.getNum()%>','<%=sccbean.getCcr_depth()%>','<%=stopid%>')">
						<%}%>
						</td>
					</tr>
					<tr>
						<td colspan="3" style="font-size:12px; color:gray; <%=dstyle1%>">
						<%=cregdate%>
						<% if(loginid!=null) { %>
						<a onclick="oncsReply<%=i%>();">답글쓰기</a>  
						<% } %>
						
						<!-- 답글쓰기 Start -->
						
						<script>
						 	function oncsReply<%=i%>() {
						 		document.getElementById("csReply<%=i%>").style.display = 'block';
						 	}
						 	function offcsReply<%=i%>() {
						 		document.getElementById("csReply<%=i%>").style.display = 'none';
						 	}
						 	function rInsert<%=i%>() {
						 		if(document.csFrm<%=i%>.comment.value==""){
						 			alert("댓글을 입력하세요.");
						 			document.csFrm<%=i%>.comment.focus();
						 			return;
						 		}
						 		document.csFrm<%=i%>.submit();
						 	}
						 

				 		</script>
						<div id="csReply<%=i%>" class="csReply">
							<form method="post" name="csFrm<%=i%>">
								<table>
									<tr>
										<td><%=loginid%>&nbsp;:&nbsp;</td>
										<td>
										<div id="inputdiv" style="width:500px; display:flex; backgound-color:white;">
										<input name="comment" size="50" placeholder="댓글을 남겨보세요" style="flex:3;"> 
										<input type="button" value="등록" onclick="rInsert<%=i%>()" style="flex:1; margin-right:5px;">
										<input type="button" value="취소" onclick="offscReply<%=i%>()" style="flex:1;">
										</div>
										</td>
									</tr>
								</table>
							<input type="hidden" name="cid" value="<%=loginid%>">
							<input type="hidden" name="flag" value="insert1">
							<input type="hidden" name="num" value="<%=num%>">
							<input type="hidden" name="cnum">
							<input type="hidden" name="conum" value="<%=conum%>">
							<input type="hidden" name="stopid" value="<%=stopid%>">
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
				 <%  }//---for%>
				 </table>	
			 <hr/>
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
								<input name="comment"  placeholder="댓글을 남겨보세요" style="width:95%; height:30px;"> 
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
		   <!-- 댓글 입력폼 End -->
		 [ <a href="javascript:list()" >리스트</a>
		 <% 
		 if(loginid!=null) {
			 if(loginid.equals(id) || csmgr.checkM(loginid)==0) { %>
			 | <a href="cs_Update.jsp?num=<%=num%>&cust_page=<%=cust_page%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
			 if(!(keyWord==null||keyWord.equals(""))){%>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>" >수 정</a> |
			 <a href="cs_Delete.jsp?num=<%=num%>&cust_page=<%=cust_page%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
			 if(!(keyWord==null||keyWord.equals(""))){%>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>">삭 제</a> 
		 <% }
		 } %>
		 ]<br/>
		  </td>
		 </tr>
		</table>

		<form method="post" name="downFrm" action="csdownload.jsp">
			<input type="hidden" name="filename">
		</form>

		<form name="listFrm">
			<input type="hidden" name="cust_page" value="<%=cust_page%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<%if(!(keyWord==null||keyWord.equals(""))){%>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}%>
		</form>
		</div>
<!-- 고객센터 글읽기 End -->

	<jsp:include page="../alcinfo/footer.jsp"></jsp:include>
</body>
</html>