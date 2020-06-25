<!-- ac_ReviewRead.jsp -->
<%@page import="java.util.Vector"%>
<%@page import="alcinfo.AcademyBean"%>
<%@page import="alcinfo.AcreviewBean"%>
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.AcRcommentsBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="acmgr" class="alcinfo.AcademyMgr" />
<jsp:useBean id="acrmgr" class="alcinfo.AcreviewMgr" />
<jsp:useBean id="acrcmgr" class="alcinfo.AcRcommentsMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");	
	String numPerPage = request.getParameter("numPerPage");	
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	String loginid = (String)session.getAttribute("idKey");
	String loginNick = acrmgr.memberNick(loginid);
	
	int num = UtilMgr.parseInt(request, "num");
	int acrnum = UtilMgr.parseInt(request, "acrnum");
	AcademyBean bean = acmgr.getAcademy(num);

	String flag = request.getParameter("flag");
	if(flag!=null) {
		if(flag.equals("insert")) {
			AcRcommentsBean acrbean = new AcRcommentsBean();
			acrbean.setAcr_num(acrnum);
			acrbean.setAcr_nick(request.getParameter("cid"));
			acrbean.setAcr_id(loginid);
			acrbean.setAcr_content(request.getParameter("comment"));
			acrbean.setAcr_ip(request.getParameter("ip"));
			acrcmgr.insertAcrComment(acrbean);
		} else if(flag.equals("insert1")) {
			AcRcommentsBean acrrbean = new AcRcommentsBean();
			acrrbean.setAcr_num(acrnum);
			acrrbean.setAcr_nick(request.getParameter("cid"));
			acrrbean.setAcr_id(loginid);
			acrrbean.setAcr_content(request.getParameter("comment"));
			acrrbean.setAcr_ip(request.getParameter("ip"));
			acrrbean.setAcr_conum(UtilMgr.parseInt(request, "conum"));
			acrcmgr.insertAcrCReply(acrrbean);
		} else if(flag.equals("del1")) {
			acrcmgr.deleteAllAcrCReply(UtilMgr.parseInt(request, "conum"));
		} else if(flag.equals("del2")) {
// 			요청한 댓글 삭제
			acrcmgr.deleteAcrComment(UtilMgr.parseInt(request, "cnum"));
		}
	} else {
// 		조회수 증가 : list.jsp 게시물 읽어옴
		acrmgr.AcrupCount(acrnum);
	}
	
	AcreviewBean arbean = acrmgr.getReview(acrnum);
	String id = arbean.getAc_id();
	String title = arbean.getAc_title();
	String nickname = arbean.getAc_nickname();
	Double star = arbean.getAc_star();
	String regdate = arbean.getAc_date();
	String content = arbean.getAc_content();
	String ip = arbean.getAc_ip();
	int count = arbean.getAc_count();
	int ccount = acrmgr.acrccount(acrnum);
	//읽어온 게시물을 수정 및 삭제를 위해 세션저장
	session.setAttribute("bean", arbean);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title>우리 학원 어디?-학원 리뷰</title>
<link href="style.css" rel="stylesheet" type="text/css">
<style>
.totalFrame{
	background-color:#FAF8EB;
	padding:40px 0px;
}

#readDiv{
	margin-left:10%;
	margin-bottom:40px;
	width:79%;
	align:center;
	background-color:white;
	border: 10px solid #36ada9; 
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
.acrReply {
	display:none;
}
.tdBorder{
	border-right:3px solid #56C8D3;
}

</style>
<script>
	function moveQnA(){
		url = "ac_QnA.jsp?ac_num="+<%=num%>;
		window.open(url, "Ac_QnA", "width=800, height=500, top=200, left=400");
		
	}
	function list() {
		location.href = "acRead.jsp?num=<%=num%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
				if(!(keyWord==null||keyWord.equals(""))){%>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>";
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
		
		url = "acLReport.jsp?stopid=<%=id%>&renum=<%=num%>";
		window.open(url, "GoReport", 'width=900, height=560, top=200, left=300');
	}

	function goCReport(conum,stuc_depth,stopid) {
		url = "acLCReport.jsp?conum="+conum+"&stuc_depth="+stuc_depth+"&renum="+<%=num%>+"&stopid="+stopid;
		window.open(url, "GoReport", "width=900, height=560, top=200, left=300");
		}
</script>

</head>
<body>
<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>
	
<!-- 읽기 Start -->
<div class="totalFrame">
	<div id="readDiv">
		<table align="center" cellspacing="3" width="100%" bgcolor="white">
		 <tr>
		  <td>
		   <table cellpadding="3" cellspacing="0" width="100%"> 
		    <tr height="100">
		    <td colspan="8">
		    <span style="font-size:30px;"><%=title%></span> 
		    <% if(loginid!=null) {%>		    
			 <input type="button" value="신고" onclick="javascript:goRep();" style="float:right;">
			  <%}%></td>
			</tr>
		    <tr height="30"> 
				<td class="tdBorder" width="6%" > 닉 네 임</td>
				<td  width="10%">&nbsp;<%=id%></td>
				<td class="tdBorder" width="6%" > 등록날짜 </td>
				<td width="10%">&nbsp;<%=regdate%></td>
				<td class="tdBorder" width="6%" > 조 회 수</td>
				<td  width="10%">&nbsp;<%=count%></td>
				<td class="tdBorder" width="4%"  > 평 점</td>
		    <td >&nbsp;<img src="../img/star.png" width="10" height="10"><%=star%></td>
			</tr>
		   
		   <tr><td colspan="8"><hr style="border:1px solid lightgray;"></td>
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
			  	Vector<AcRcommentsBean> cvlist = acrcmgr.getAcRComment(acrnum);
			      	if(!cvlist.isEmpty()){
			  %>
				 <table width="100%">
				 <%
					 	for(int i=0;i<cvlist.size();i++){
					 		AcRcommentsBean acrcbean = cvlist.get(i);
	 		 	 			int cnum = acrcbean.getNum();
	 		 	 			String cnick = acrcbean.getAcr_nick();
	 		 	 			String comment = acrcbean.getAcr_content();
	 		 	 			String cregdate = acrcbean.getAcr_regdate();
	 		 	 			int conum = acrcbean.getAcr_conum();
	 		 	 			int depth = acrcbean.getAcr_depth();
	 		 	 			String stopid=acrcbean.getAcr_id();
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
						<td align="right">
						<% 
						  if(loginNick!=null) {
							if(loginNick.equals(cnick) || acrmgr.checkM(loginid)==0) { %>
							<input type="button" value="삭제"
							onclick="cDel('<%=conum%>','<%=cnum%>','<%=depth%>')">
							<% 	}%>
							<input type="button" value="댓글신고"
							onclick="javascript:goCReport
							('<%=acrcbean.getNum()%>','<%=depth%>','<%=stopid%>')">
						<%} %>
						</td>
					</tr>
					<tr>
						<td colspan="3" style="font-size:12px; color:gray; <%=dstyle1%>">
						<%=cregdate%>
						<% if(loginid!=null) { %>
						<a href="javascript:onacrReply<%=i%>();">답글쓰기</a>
						<% } %>
						
						<!-- 답글쓰기 Start -->
						
						<script>
						 	function onacrReply<%=i%>() {
						 		document.getElementById("acrReply<%=i%>").style.display = 'block';
						 	}
						 	function offacrReply<%=i%>() {
						 		document.getElementById("acrReply<%=i%>").style.display = 'none';
						 	}
						 	function rInsert<%=i%>() {
						 		if(document.acrFrm<%=i%>.comment.value==""){
						 			alert("댓글을 입력하세요.");
						 			document.acrFrm<%=i%>.comment.focus();
						 			return;
						 		}
						 		document.acrFrm<%=i%>.submit();
						 	}
				 		</script>
						<div id="acrReply<%=i%>" class="acrReply">
							<form method="post" name="acrFrm<%=i%>">
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
							<input type="hidden" name="acrnum" value="<%=acrnum%>">
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
		 [ <a href="javascript:list();" >리스트</a>
		 <% 
		 if(loginNick!=null) {
			 if(loginNick.equals(nickname) || acrmgr.checkM(loginid)==0) { %>
			 | <a href="ac_ReviewUpdate.jsp?num=<%=num%>&acrnum=<%=acrnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
			 if(!(keyWord==null||keyWord.equals(""))){%>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>" >수 정</a> |
			 <a href="ac_ReviewDelete.jsp?num=<%=num%>&acrnum=<%=acrnum%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
			 if(!(keyWord==null||keyWord.equals(""))){%>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>">삭 제</a> 
		 <% }
		 } %>
		 ]<br/>
		  </td>
		 </tr>
		</table>


		<form name="listFrm" method="post">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>">
			<%if(!(keyWord==null||keyWord.equals(""))){%>
			<input type="hidden" name="keyField" value="<%=keyField%>">
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<%}%>
		</form>
	</div>
<%@ include file="../alcinfo/footer.jsp"%>
<!-- 읽기 End -->
</div>
</body>

</html>
