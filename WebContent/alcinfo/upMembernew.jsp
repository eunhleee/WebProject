<!-- nickCheck.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
<script type="text/javascript">
function goup(){
	opener.document.location.reload();
	self.close();
}
</script>
<title>프로필 사진이 변경되었습니다.</title>
</head>
<body>
<div align="center">
<%
	
			out.println("프로필 사진이 변경 되었습니다..<p/>");
		
%>
<input type="button" style="width:70px; height:30px;" 
								value="완료" onclick="goup();">
</div>
</body>
</html>