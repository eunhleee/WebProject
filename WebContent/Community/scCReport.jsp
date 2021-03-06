<!-- 13p 7.신고접수창 학원 잘못된 정보-->
<!-- reportReceipt.jsp -->
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
<title>잘못된 학원 정보 신고하기</title>
<script type="text/javascript">
	function singo(){
		if(document.repFrm.retitle.value==""){
			alert("제목을 입력 하세요");
			document.repFrm.retitle.focus();
			return;
		}
		 if(document.repFrm.regroup.value=="")
		{
			alert("신고분류를 선택하세요");
			document.repFrm.regroup.focus();
			return;

		}
		if(document.repFrm.recontent.value==""){
			alert("내용을 입력 하세요");
			document.repFrm.recontent.focus();
			return;
		} 
		if(document.repFrm.retitle.value!=""&&document.repFrm.regroup.value!=""&&document.repFrm.recontent.value!=""){
		 	var stopurl=document.referrer
			document.repFrm.stopurl.value=stopurl;
			document.repFrm.action="scCReportProc.jsp?stopid=<%=stopid%>&renum=<%=renum%>&conum=<%=conum%>&stuc_depth=<%=stuc_depth%>";
	}
		document.repFrm.submit();
	}
</script>
<style>
@font-face { 
font-family: 'Godo'; font-style: normal;
font-weight: 400;
src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff2') format('woff2'), 
	url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoM.woff') format('woff'); }
@font-face {
	font-family: 'Godo'; font-style: normal;
	font-weight: 700; 
 	src: url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff2') format('woff2'),
url('//cdn.jsdelivr.net/korean-webfonts/1/corps/godo/Godo/GodoB.woff') format('woff'); } 
 	.godo * { font-family: 'Godo', sans-serif; }
 body{
 	font-family:'Godo';}
.frame{
	padding:10px; 
	border:8px solid red; 
	border-radius: 10px;
	width:830px;
}
#inputdiv{
	margin:10px;
	width:490px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#inputdiv input{
	width:480px;
	border:none;
	font-size:15px;
}

#inputdiv1{
	margin:10px;
	width:200px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}

#inputdiv1 input{
	width:180px;
	border:none;
	font-size:15px;
	
}

#textareadiv{
	margin:10px;
	width:490px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#textareadiv textarea{
	border:none;
	font-size:15px;
	width:480px;
}
</style>
</head>

<body>
<div class="frame">
    <div class="content">
    <h2><img src="../img/siren.png" width="30" height="30">&nbsp;댓글 신고하기</h2>
    <hr style="border:1px solid red;">
    	<form name="repFrm" method="post">
		<table style="width:800; cellpadding:3; align:center;">
		<tr>
		<td><input type="hidden" name="kind" value="커뮤니티게시판댓글"></td>	
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
								<input type="text" name="regroup" value="댓글신고" readonly >
								</div>
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
</div>
<!-- //frame -->
</body>
</html>