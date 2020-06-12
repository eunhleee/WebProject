<!-- 13p 7.신고접수창 -->
<!-- reportReceipt.jsp -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="java.util.*,alcinfo.*"%>
<jsp:useBean id="rBean" class="alcinfo.MemberBean"/>
<jsp:setProperty name="rBean" property="*"/>
<%
		request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
<title>신고하기</title>
<script type="text/javascript">
	function check(){
		document.repFrm.action="reportProc.jsp";
		document.repFrm.submit();
	}
</script>
</head>
<body>
<div class="frame">
    <div class="content">
    	<form name="repFrm" method="post" action="reportProc.jsp">
		<table>
		<tr>
		<td><input type="hidden" name="reid" value=""></td>
		</tr>
		<tr>
		<td><input type="text" name="retitle" value="제목을 입력하세요"><br></td>
		</tr>
		<tr><td>
		<select name=regroup>
			<option value="0">신고분류
			<option value="회원신고">회원신고
			<option value="게시글신고">게시글신고
			<option value="잘못된정보신고">잘못된정보신고

		</select>
		</td> 
		<td>
		<input type="text" name="stopid" value="1111"><br>
		</td></tr>
		<tr><td>
		<textarea rows="10" cols="45" name="recontent"></textarea><br>
		</td></tr>
		<tr><td>
		<input type="submit" value="저장">
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