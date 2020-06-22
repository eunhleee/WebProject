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
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>우리 학원 어디?-학원 리뷰</title>
<link href="style.css" rel="stylesheet" type="text/css">
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
}
.acrReply {
	display:none;
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
		window.open(url, "GoReport", 'width=360, height=300, top=200, left=300');
	}

	function goCReport(conum,stuc_depth,stopid) {
		url = "acLCReport.jsp?conum="+conum+"&stuc_depth="+stuc_depth+"&renum="+<%=num%>+"&stopid="+stopid;
		window.open(url, "GoReport", "width=360, height=300, top=200, left=300");
		}
</script>
</head>
<body>
	<br>
	<br>
	<form method="post" action="../Report/reportReceipt.jsp">
		<table width="70%" align="center">
			<tr>
				<td align="center">
					<table width="100%" border="1"
						style="font-size: 20; background: rgb(250, 248, 235);">
						<tr>
							<td width="25%" align="center"><img src="../img/banner1.jpg"
								width="100%" height="250"></td>
							<td width="60%" height="100%">
								<table width="100%" border="1" style="font-size: 20;">
									<tr height="50">
										<td width="30%">학원명</td>
										<td width="70%"><%=bean.getAc_name()%></td>
									</tr>
									<tr height="50">
										<td width="30%">교습계열</td>
										<td width="70%"><%=bean.getGroup1()%></td>
									</tr>
									<tr height="50">
										<td width="30%">교습과정</td>
										<td width="70%"><%=bean.getGroup2()%></td>
									</tr>
									<tr height="50">
										<td width="30%">학원주소</td>
										<td width="100%"><a href=""
											style="color: black; text-decoration: none;"><%=bean.getAc_address()%></a></td>
									</tr>
									<tr height="50">
										<td width="30%">전화번호</td>
										<td width="70%"><%=bean.getAc_tel()%></td>
									</tr>
								</table>
							</td>
							<td width="15%" align="center">
								<table>
									<tr>
										<td><input type="button" value="문의하기"
											style="font-size: 20;" onclick="moveQnA();"></td>
									</tr>
									<tr>
										<td><input type="submit" value="잘못된정보 신고하기"
											style="font-size: 20;"></td>
											
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>
		<br>
		<br>
		<table width="70%" height="300" align="center" border="1">
			<tr>
				<td width="30%" align="center"><jsp:include page="mapJsp.jsp">
						<jsp:param value="<%=bean.getAc_address()%>" name="address" />
					</jsp:include></td>
				<td width="70%" align="center">

<!-- 읽기 Start -->

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
		  <td align="center" bgcolor="#DDDDDD" width="20%"> 닉 네 임 </td>
		  <td bgcolor="#FFFFE8"><%=nickname%></td>
		  <td align="center" bgcolor="#DDDDDD" width="20%"> 등록날짜 </td>
		  <td bgcolor="#FFFFE8"><%=regdate%></td>
		 </tr>
		   <tr> 
		    <td align="center" bgcolor="#DDDDDD"> 제 목</td>
		    <td bgcolor="#FFFFE8" colspan="3"><%=title%></td>
		   </tr>
		   <tr> 
		    <td align="center" bgcolor="#DDDDDD"> 평 점</td>
		    <td bgcolor="#FFFFE8" colspan="3"><%=star%></td>
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
		      <% if(loginid!=null) {%>		    
		    <td><input type="button" value="신고" onclick="javascript:goRep();"></td>
		    <%}%>
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
						<td width="50">닉네임</td>
						<td align="left">
							<input name="cid" size="10" value="<%=loginNick%>" readonly>
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
			  	Vector<AcRcommentsBean> cvlist = acrcmgr.getAcRComment(acrnum);
			      	if(!cvlist.isEmpty()){
			  %>
				 <table>
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
			 				String dstyle = "";
	 		 	 			if(depth==1) {
	 		 	 				dstyle = "style=\"padding-left:30px;\"";	
				 			}
				 %>
				 	
				 	<tr>
						<td <%=dstyle%> colspan="3" width="600"><b><%=cnick%></b></td>
					</tr>
					<tr>
						<td <%=dstyle%> colspan="2"><%=comment%></td>
						<% 
						if(loginNick!=null) {
							if(loginNick.equals(cnick) || acrmgr.checkM(loginid)==0) { %>
						<td align="center" valign="middle">
							<input type="button" value="삭제"
							onclick="cDel('<%=conum%>','<%=cnum%>','<%=depth%>')">
						</td>
							<% 	}%>
							<td align="left" valign="middle">
							<input type="button" value="댓글신고"
							onclick="javascript:goCReport
							('<%=acrcbean.getNum()%>','<%=depth%>','<%=stopid%>')">
							
						</td>
						<%} %>
					</tr>
					<tr>
						<td <%=dstyle%> colspan="3">
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
									<tr align="center">
										<td width="50">닉네임</td>
										<td align="left">
											<input name="cid" size="10" value="<%=loginNick%>" readonly>
										</td>
									</tr>
									<tr align="center">
										<td>내 용</td>
										<td>
											<input name="comment" size="50" placeholder="댓글을 남겨보세요"> 
											<input type="button" value="등록" onclick="rInsert<%=i%>()">
											<input type="button" value="취소" onclick="offacrReply<%=i%>()">
										</td>
									</tr>
								</table>
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
	</div>

<!-- 읽기 End -->

				</td>
			</tr>
		</table>
		<br>
</body>
<%@ include file="../alcinfo/footer.jsp"%>
</html>
