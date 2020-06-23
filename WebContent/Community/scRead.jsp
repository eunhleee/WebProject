<!-- scRead.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.SCommentBean"%>
<%@page import="java.util.Vector"%>
<%@page import="alcinfo.SCommunityBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="scmgr" class="alcinfo.SCommunityMgr"/>
<jsp:useBean id="sccmgr" class="alcinfo.SCommentMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String pageValue=request.getParameter("pageValue");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");	
	int num = UtilMgr.parseInt(request, "num");
	String loginid = (String)session.getAttribute("idKey");
	String loginNick = null;
	if(loginid!=null) {
		loginNick = sccmgr.memberNick(loginid);
	}
	
	String flag = request.getParameter("flag");
	if(flag!=null) {
		if(flag.equals("insert")) {
			SCommentBean scbean = new SCommentBean();
			scbean.setNum(num);
			scbean.setStuc_nick(request.getParameter("cNick"));
			scbean.setStuc_content(request.getParameter("comment"));
			scbean.setStuc_ip(request.getParameter("ip"));
			sccmgr.insertSComment(scbean);
		} else if(flag.equals("insert1")) {
			SCommentBean scrbean = new SCommentBean();
			scrbean.setNum(num);
			scrbean.setStuc_nick(request.getParameter("cNick"));
			scrbean.setStuc_content(request.getParameter("comment"));
			scrbean.setStuc_ip(request.getParameter("ip"));
			scrbean.setStuc_conum(UtilMgr.parseInt(request, "conum"));
			sccmgr.insertSCReply(scrbean);
		} else if(flag.equals("del1")) {
			sccmgr.deleteAllSCReply(UtilMgr.parseInt(request, "conum"));
		} else if(flag.equals("del2")) {
// 			요청한 댓글 삭제
			sccmgr.deleteSComment(UtilMgr.parseInt(request, "cnum"));
		}
	} else {
// 		조회수 증가 : list.jsp 게시물 읽어옴
		scmgr.scupCount(num);
	}
	
	SCommunityBean bean = scmgr.getBoard(num);
	String id = bean.getSc_id();
	String nick = bean.getSc_nick();
	String title = bean.getSc_title();
	String regdate = bean.getSc_regdate();
	String content = bean.getSc_content();
	String filename = bean.getSc_filename();
	int filesize = bean.getSc_filesize();
	String ip = bean.getSc_ip();
	int count = bean.getSc_count();
	int ccount = scmgr.ccount(num);
	//읽어온 게시물을 수정 및 삭제를 위해 세션저장
	session.setAttribute("bean", bean);
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리학원 어디?-자유게시판</title>
<script>
function down(filename) {
	document.downFrm.filename.value=filename;
	document.downFrm.submit();
}
function list() {
	document.listFrm.action = "communityList.jsp?pageValue=<%=pageValue%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
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
	
	url = "scReport.jsp?stopid=<%=id%>&renum=<%=num%>";
	window.open(url, "GoReport", 'width=360, height=300, top=200, left=300');
}

function goCReport(conum,stuc_depth,stopid) {
	url = "scCReport.jsp?conum="+conum+"&stuc_depth="+stuc_depth+"&renum="+<%=num%>+"&stopid="+stopid;
	window.open(url, "GoReport", "width=360, height=300, top=200, left=300");
	}
</script>
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
	cursor : pointer;
}

.scReply {
	display: none;
}

</style>
</head>
<body>

	<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>

<!-- 글읽기 Start -->

		<div id="readDiv">
		<table align="center" width="100%" cellspacing="3" bgcolor="white">
		
		 <tr>
		  <td>
		   <table cellpadding="3" cellspacing="0" width="100%" >
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
		     <td align="center" bgcolor="#FCBC7E" style="color:white; font-weight:bold;">첨부파일</td>
		     <td bgcolor="#FAF8EB" colspan="5">
		    	<%
		    		if(filename!=null&&!filename.equals("")){
		    	%>
		    		<a href="javascript:down('<%=filename%>')" style="margin-right:15px;"><%=filename%></a>
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
			  	Vector<SCommentBean> cvlist = sccmgr.getSComment(num);
			      	if(!cvlist.isEmpty()){
			  %>
				 <table width="100%">
				 <%
					 	for(int i=0;i<cvlist.size();i++){
	 		 	 			SCommentBean sccbean = cvlist.get(i);
	 		 	 			int cnum = sccbean.getNum();
	 		 	 			String cnick = sccbean.getStuc_nick();
	 		 	 			String comment = sccbean.getStuc_content();
	 		 	 			String cregdate = sccbean.getStuc_regdate();
	 		 	 			int conum = sccbean.getStuc_conum();
	 		 	 			int depth = sccbean.getStuc_depth();
	 		 	 			String stopid= sccbean.getStuc_id();
			 				String dstyle = "", dstyle1 = "";
	 		 	 			if(depth==1) {
	 		 	 				dstyle = "style=\"padding-left:30px;\"";
	 		 	 				dstyle1 = "padding-left:30px;";
				 			}
				 %>
				 	
				 	<tr>
						<td <%=dstyle%> colspan="4" width="600"><b><%=cnick%></b></td>
					</tr>
					<tr>
						<td <%=dstyle%> colspan="3" style=" min-height:150px;"><%=comment%></td>
						<td align="right" >
						<% 
						if(loginNick!=null) {
							if(loginNick.equals(cnick)||scmgr.checkM(loginid)==0) { %>
							<input type="button" value="삭제"
							onclick="cDel('<%=conum%>','<%=cnum%>','<%=depth%>')">
							<%}%>
							<input type="button" value="댓글신고" 
							onclick="javascript:goCReport
							('<%=sccbean.getNum()%>','<%=sccbean.getStuc_depth()%>','<%=stopid%>')">
						<%}%>
						</td>
					</tr>
					<tr>
						<td colspan="3" style="font-size:12px; color:gray; <%=dstyle1%>">
						<%=cregdate%>
						<% if(loginid!=null) { %>
						<a onclick="onscReply<%=i%>();">답글쓰기</a>  
						<% } %>
						
						<!-- 답글쓰기 Start -->
						
						<script>
						 	function onscReply<%=i%>() {
						 		document.getElementById("scReply<%=i%>").style.display = 'block';
						 	}
						 	function offscReply<%=i%>() {
						 		document.getElementById("scReply<%=i%>").style.display = 'none';
						 	}
						 	function rInsert<%=i%>() {
						 		if(document.crFrm<%=i%>.comment.value==""){
						 			alert("댓글을 입력하세요.");
						 			document.crFrm<%=i%>.comment.focus();
						 			return;
						 		}
						 		document.crFrm<%=i%>.submit();
						 	}
						 

				 		</script>
						<div id="scReply<%=i%>" class="scReply">
							<form method="post" name="crFrm<%=i%>">
								<table>
									<tr>
										<td><%=loginNick%>&nbsp;:&nbsp;</td>
										<td>
										<div id="inputdiv" style="width:500px; display:flex; backgound-color:white;">
										<input name="comment" size="50" placeholder="댓글을 남겨보세요" style="flex:3;"> 
										<input type="button" value="등록" onclick="rInsert<%=i%>()" style="flex:1; margin-right:5px;">
										<input type="button" value="취소" onclick="offscReply<%=i%>()" style="flex:1;">
										</div>
										</td>
									</tr>
								</table>
							<input type="hidden" name="cid" value="<%=loginNick%>">
							<input type="hidden" name="flag" value="insert1">
							<input type="hidden" name="num" value="<%=num%>">
							<input type="hidden" name="cnum">
							<input type="hidden" name="conum" value="<%=conum%>">
							<input type="hidden" name="stopid" value="<%=stopid%>">
							<input type="hidden" name="depth" value="<%=depth%>">
						    <input type="hidden" name="nowPage" value="<%=nowPage%>">
						    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
							<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
							<input type="hidden" name="cNick" size="10" value="<%=loginNick%>">
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
			
			 <% } %>
			 <!-- 댓글 List End -->
			 <!-- 댓글 입력폼 Start -->
			
			 <% if(loginid!=null) { %>
		   <form method="post" name="cFrm">
			   <div id="inputdiv" style="width:97%; background-color:white;">
					<table width="97%">
						<tr>
							<td colspan="4"><%=loginNick%></td>
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
			<input type="hidden" name="cid" value="<%=loginNick%>">
			<input type="hidden" name="flag" value="insert">	
			<input type="hidden" name="num" value="<%=num%>">
			<input type="hidden" name="cnum">
			<input type="hidden" name="conum">
		    <input type="hidden" name="nowPage" value="<%=nowPage%>">
		    <input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="cNick" size="10" value="<%=loginNick%>">
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
			<hr>
		 [ <a href="javascript:list()" >리스트</a>
		 <% 
		 if(loginid!=null) {
			 if(loginid.equals(id)||scmgr.checkM(loginid)==0) { %>
			 | <a href="scUpdate.jsp?nowPage=<%=nowPage%>&num=<%=num%>&numPerPage=<%=numPerPage%>&pageValue=<%=pageValue %>" >수 정</a> |
			 <a href="scDelete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">삭 제</a> 
		 <% }
		 } %>
		 ]<br/>
		  </td>
		 </tr>
		</table>

		<form method="post" name="downFrm" action="scdownload.jsp">
			<input type="hidden" name="filename">
		</form>

		<form name="listFrm">
			<input type="hidden" name="pageValue" value="<%=pageValue%>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<%if(!(keyWord==null||keyWord.equals(""))){%>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}%>
		</form>
		</div>
<!-- 글읽기 End -->
	
	<jsp:include page="../alcinfo/footer.jsp"/>
</body>
</html>