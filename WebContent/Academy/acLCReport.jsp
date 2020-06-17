<!-- 13p 7.신고접수창 학원리뷰댓글신고-->
<!-- acLCReport.jsp -->
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

%>
<html>
<head>
<title>학원리뷰 댓글신고하기</title>
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
		document.repFrm.action="acLCReportProc.jsp?stopid=<%=stopid%>&renum=<%=renum%>&conum=<%=conum%>&stuc_depth=<%=stuc_depth%>";
		document.repFrm.submit();

		} 

	}
</script>
</head>

<body>
<div class="frame">
    <div class="content">
    	<form name="repFrm" method="post">
		<table width="300">
		<tr>
		<td><input type="hidden" name="kind" value="학원리뷰게시판댓글"></td>	
		<td><input type="hidden" name="reid" value="<%=session.getAttribute("idKey")%>"></td>
		</tr>
		<tr>
		<td><input type="text" name="retitle" placeholder="제목을 입력하세요"><br></td>
		</tr>
		<tr>
		<td>
			<select name=regroup>
			<option value="회원신고">회원신고
			<option value="게시글신고" selected>게시글신고
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
		<input type="submit" value="신고" onClick="singo()">
		</td></tr>
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