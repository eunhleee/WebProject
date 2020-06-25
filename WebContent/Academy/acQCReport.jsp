<!-- 13p 7.신고접수창 학원문의댓글신고-->
<!-- acQCReport.jsp -->
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="java.util.*,alcinfo.*"%>
<jsp:useBean id="rBean" class="alcinfo.MemberBean"/>

<jsp:setProperty name="rBean" property="*"/>
<%
		request.setCharacterEncoding("UTF-8");
	int renum=UtilMgr.parseInt(request,"renum");
	int conum=UtilMgr.parseInt(request,"conum");
	int stuc_depth=UtilMgr.parseInt(request,"stuc_depth");
	 String stopid = request.getParameter("stopid").trim();
	//추가 id, sdf, today, strToday
	String id =(String)session.getAttribute("idKey");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar today = Calendar.getInstance();
	String strToday = sdf.format(today.getTime());

%>
<html>
<head>
<title>학원문의글 댓글신고하기</title>
<link href="../alcinfo/reportStyle.css" rel="stylesheet">
<script type="text/javascript">
var stopurl=document.referrer;
	function singo(){
		if(document.repFrm.retitle.value==""){
			alert("제목을 입력 하세요");
			return;
		}
		 if(document.repFrm.regroup.value=="")
		{
			alert("신고분류를 선택하세요");
			return;

		}
		if(document.repFrm.recontent.value==""){
			alert("내용을 입력 하세요");
			return;
		} 
		if(document.repFrm.retitle.value!=""&&document.repFrm.regroup.value!=""&&document.repFrm.recontent.value!=""){ 
		document.repFrm.stopurl.value=stopurl;
		document.repFrm.action="acQCReportProc.jsp?stopid=<%=stopid%>&renum=<%=renum%>&conum=<%=conum%>&stuc_depth=<%=stuc_depth%>";
		document.repFrm.submit();

		} 

	}
</script>
</head>

<body>
<div class="frame">
    <div class="content">
    <h2><img src="../img/siren.png" width="30" height="30">&nbsp;댓글 신고하기</h2>
    <hr style="border:1px solid red;">
    	<form name="repFrm" method="post">
		<table style="width:800; cellpadding:3; align:center;">
		<tr>
		<td><input type="hidden" name="kind" value="학원문의게시판댓글"></td>	
		<td><input type="hidden" name="reid" value="<%=session.getAttribute("idKey")%>"></td>
		</tr>
		
		<tr>
			<td  align="center">
				<table align="center" >
						<tr align="center">
							<td>작성자</td>
							<td>
								<div id="inputdiv1" >
									<input name="stqtitle" size="50" maxlength="30" disabled="disabled" value="<%=id%>">
								</div>
							</td>
							<td>작성일</td>
							<td>
								<div id="inputdiv1">
									<input name="stqtitle" size="50" maxlength="30" disabled="disabled" value="<%=strToday%>">
								</div>
							</td>
						</tr>
						<tr align="center">
							<td>제목</td>
							<td colspan="3">
								<div id="inputdiv">
								<input type="text" name="retitle" placeholder="제목을 입력하세요">
								</div>
							</td>
						</tr>
						<tr align="center">
							<td>신고분류</td>
							<td colspan="3">
								<div id="inputdiv">
								<input type="text" name="regroup" value="댓글신고" readonly="readonly">
								</div>
							</td> 
							<td>
							<input type="hidden" name="stopid" value="<%=stopid%>">
							</td>
						</tr>
						<tr align="center">
							<td>내용</td>
							<td colspan="3">
								<div id="textareadiv">
								<textarea rows="10" cols="45" name="recontent" placeholder="내용을 입력하세요"></textarea>
								</div>
							</td>
							<td>
							<input type="hidden" name="stopid" value="<%=stopid%>">
							</td>
						</tr>
						<tr align="center">
							<td  colspan="4" align="center">
						<input type="submit" value="신고" onClick="singo()">
						</td>
						</tr>
						<tr><td>
						<input type="hidden" name="reip" value="<%=request.getRemoteAddr()%>">
						</td>
						<td><input type="hidden" name="restate" value="접수중"></td>
						<td><input type="hidden" name="renum" value="<%=renum%>"></td>
						<td><input type="hidden" name="conum" value="<%=conum%>"></td>
						<td><input type="hidden" name="stuc_depth" value="<%=stuc_depth%>"></td>
						<td><input type="hidden" name="stopurl"></td>
						</tr>
		</table>
		</td>
		</tr>
		</table>
		</form>
    </div>
  </div>
  <!-- //container -->
    <div class="footer">
    <p class="copyright">&copy;copy</p>
  </div>
  <!-- //footer -->
<!-- //frame -->
</body>
</html>