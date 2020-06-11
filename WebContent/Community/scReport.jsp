<!-- 13p 7.신고접수창 학원 잘못된 정보-->
<!-- reportReceipt.jsp -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="java.util.*,alcinfo.*"%>
<jsp:useBean id="rBean" class="alcinfo.MemberBean"/>

<jsp:setProperty name="rBean" property="*"/>
<%
		request.setCharacterEncoding("UTF-8");
	int renum=UtilMgr.parseInt(request,"renum");
	 String stopid = request.getParameter("stopid").trim();

	System.out.println("여기"+session.getAttribute("idKey")+" stopid는"+stopid+" renum은"+renum);
%>
<html>
<head>
<title>잘못된 학원 정보 신고하기</title>
<script type="text/javascript">
	function gocheck(){
		document.repFrm.action="scReportProc.jsp?stopid="+<%=stopid%>+"&renum="+<%=renum%>;
		document.repFrm.submit();
	}
</script>
</head>

<body>
<div class="frame">
    <div class="content">
    	<form name="repFrm" method="post" action="scReportProc.jsp">
		<table width="300">
		<tr>
		<td><input type="hidden" name="kind" value="커뮤니티게시판"></td>	
		<td><input type="hidden" name="reid" value="<%=session.getAttribute("idKey")%>"></td>
		</tr>
		<tr>
		<td><input type="text" name="retitle" placeholder="제목을 입력하세요"><br></td>
		</tr>
		<tr>
		<td>
			<select name=regroup>
			<option value="0">신고분류
			<option value="회원신고">회원신고
			<option value="게시글신고">게시글신고
			<option value="잘못된정보신고">잘못된정보신고
		</select>
		</td> 
		<td>
		<input type="hidden" name="stopid" value="<%=stopid%>">
		</td>
		</tr>
		<tr><td>
		<textarea rows="10" cols="45" name="recontent" placeholder="내용을 입력하세요"></textarea><br>
		</td></tr>
		<tr><td>
		<input type="submit" value="저장" onClick="gocheck()">
		</td></tr>
		<tr><td>
		<input type="hidden" name="reip" value="<%=request.getRemoteAddr()%>">

		</td>
		<td><input type="hidden" name="restate" value="접수중">
		<td><input type="hidden" name="renum" value="<%=renum%>">
		
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
</div>
<!-- //frame -->
</body>
</html>