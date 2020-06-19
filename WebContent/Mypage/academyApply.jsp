<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function goAclist() {
	url = "../Mypage/acSearch.jsp";
	window.open(url, "GoReport", "width=900, height=560, top=200, left=300");
}
</script>
<meta charset="UTF-8">
<title>학원장 신청(권한변경)</title>
</head>
<body>
<table>
<tr>
<td colspan="3"><h3>권한변경</h3></td>
</tr>
<tr>
<td>학원검색</td>
<td><input type="text" value="" readonly="readonly"></td>
<td><input type="text" value="" readonly="readonly"></td>
<td><input type="button" onclick="goAclist();" value="검색"></td>
</tr>
<tr>
<td colspan="3" align="right">
<input type="submit" value="보내기" onclick="send()">
</td>
</tr>
<tr>
<td></td>
</tr>
</table>
</body>
</html>