<!-- 13p 7.신고접수창 학원 잘못된 정보-->
<!-- reportReceipt.jsp -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="java.util.*,alcinfo.*"%>
<jsp:useBean id="rBean" class="alcinfo.MemberBean"/>

<jsp:setProperty name="rBean" property="*"/>
<%
		request.setCharacterEncoding("UTF-8");
//	int num=0;
 	//num = Integer.parseInt(request.getParameter("stopid"));
 	String stopid = request.getParameter("stopid").trim();
	// num=UtilMgr.parseInt(request,"stopid");
	//String stopid=Integer.toString(num);
	System.out.println("여기"+session.getAttribute("idKey")+"stopid는"+stopid);
%>
<html>
<head>
<title>신고하기</title>
<script type="text/javascript">
	function gocheck(){
		document.repFrm.action="reportAInfProc.jsp?stopid="+stopid;
		document.repFrm.submit();
	}
</script>
</head>

<body>
<div class="frame">
    <div class="content">
    	<form name="repFrm" method="post" action="reportAInfProc.jsp">
		<table>
		<tr> 
		<td><input type="hidden" name="kind" value="학생"></td>	
		<td><input type="hidden" name="reid" value="<%=session.getAttribute("idKey")%>"></td>
		</tr>
		<tr>
		<td><input type="text" name="retitle" placeholder="제목을 입력하세요"><br></td>
		</tr>
		<tr>
		<td>
		<input type="text" name="regroup" value="잘못된정보신고" readonly ><br>
		</td> 
		<td>
		<input type="hidden" name="stopid" value="<%=stopid%>">
		</td>
		</tr>
		<tr><td>
		<textarea rows="10" cols="45" name="recontent" placeholder="내용을 입력하세요"></textarea><br>
		</td></tr>
		<tr><td>
		<input type="submit" value="접수" onClick="gocheck()">
		</td></tr>
		<tr><td>
		<input type="hidden" name="reip" value="<%=request.getRemoteAddr()%>">

		</td>
		<td><input type="hidden" name="restate" value="접수중">
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