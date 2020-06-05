<!-- 19p 12.관리자화면 - 회원상태관리 -->
<!--StateManagement.jsp -->
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.ReportBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="rMgr" class="alcinfo.ReportMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	//검색에 필요한 변수
	String keyField = "", keyWord = "";
	//검색일때
	if (request.getParameter("keyWord") != null) {
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	//검색 후에 다시 처음화면 요청
	if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
		keyField = "";
		keyWord = "";
	}
%>
<html>
<head>
<title>관리자-신고접수건관리</title>
<link href="MyReportListStyle.css" rel="stylesheet">

<script type="text/javascript">
	function check() {
		if (document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
</script>
</head>
<body>
	<jsp:include page="headerSearch.jsp" />
	<div class="frame">
		<div class="container">
			<div class="nav">
				<ul class="nav-list">
					<li class="nav-item"><a href="" class="nav-link">관리자 정보 수정</a></li>
					<li class="nav-item"><a href="" class="nav-link">내가 쓴 글</a></li>
					<li class="nav-item"><a href="" class="nav-link">신고 접수 건</a></li>
					<li class="nav-item"><a href="" class="nav-link">회원 상태 관리</a></li>

				</ul>
			</div>
			<!--nav-->
			<div class="content">
				<form name="searchFrm">
					<table width="600" cellpadding="4" cellspacing="0">
						<tr>
							<td align="center" valign="bottom"><select name="keyField"
								size="1">
									<option value="name">이 름</option>
									<option value="stopid">신고아이디</option>
							</select> <input size="16" name="keyWord"> <input type="button"
								value="찾기" onClick="javascript:check()"> <input
								type="hidden" name="nowPage" value="1"></td>
						</tr>
					</table>
				</form>
				<table>
					<%
						Vector<ReportBean> pvlist = rMgr.SMList(keyField, keyWord);
						int listStze = pvlist.size();
					%>
					<tr>
						<td>아이디</td>
						<td>이름</td>
						<td>사유</td>
						<td>상태</td>
					</tr>
					<%
						for (int i = 0; i < pvlist.size(); i++) {
							ReportBean rbean = pvlist.get(i);
					%>
					<tr>
						<td><%=rbean.getStopid()%></td>
						<td><%=rbean.getName()%></td>
						<td><select name=contents>
								<option value="0">선택하세요.
								<option value="사기">사기
								<option value="도배">도배
								<option value="욕설">욕설
								<option value="기타">기타
						</select></td>
						<td><select name=report>
								<option value="0">선택하세요.
								<option value="1">1일
								<option value="7">7일
								<option value="30">30일 -
						</select></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td colspan="5" align="right"><input type="button" value="완료">
						</td>
					</tr>
				</table>

				<form name="readFrm">
					<input type="hidden" name="keyField" value="<%=keyField%>">
					<input type="hidden" name="keyWord" value="<%=keyWord%>"> <input
						type="hidden" name="num">


				</form>
			</div>
		</div>
		<!-- //container -->
		<div class="footer">
			<p class="copyright">&copy;copy</p>
		</div>
		<!-- //footer -->
		<jsp:include page="footer.jsp" />
	</div>
	<!-- //frame -->
</body>
</html>