<!-- 13p 7.신고접수창 학원 잘못된 정보-->
<%@page import="java.text.SimpleDateFormat"%>
<!-- reportReceiptAInf.jsp -->
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import ="java.util.*,alcinfo.*"%>
<jsp:useBean id="rBean" class="alcinfo.MemberBean"/>

<jsp:setProperty name="rBean" property="*"/>
<%
		request.setCharacterEncoding("UTF-8");
		int num=0;
 		String stopid = request.getParameter("stopid").trim();
		num=UtilMgr.parseInt(request,"stopid");
		String id=(String)session.getAttribute("idKey");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    Calendar today = Calendar.getInstance();
	 	String strToday = sdf.format(today.getTime());
%>
<html>
<head>
<title>잘못된 학원 정보 신고하기</title>
<script type="text/javascript">
function gocheck(){
	if(document.repFrm.retitle.value==""){
		alert("제목을 입력 하세요");
		document.repFrm.retitle.focus();
		return;
	}
	if(document.repFrm.regroup.value==""){
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
		document.repFrm.submit();
	}
}
</script>
<style>
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
<div class="frame" >
    <div class="content">
    <h2><img src="../img/siren.png" width="30" height="30">&nbsp;잘못된 정보 신고하기</h2>
    <hr style="border:1px solid red;">
    	<form name="repFrm" method="post" action="reportAInfProc.jsp">
		<table width="800"  cellpadding="3" align="center">
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
									<input type="text" name="regroup" value="잘못된정보신고" readonly >
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
						</tr>
						<tr align="center">
							<td  colspan="4" align="center">
								<input type="button" value="저장" onClick="gocheck()">
							</td>
						</tr>
						
				</table>
			</td>
		</tr>
	</table>
	
		<input type="hidden" name="restate" value="접수중">
		<input type="hidden" name="stopid" value="<%=stopid%>">
		<input type="hidden" name="reip" value="<%=request.getRemoteAddr()%>">
		<input type="hidden" name="kind" value="학원">
		<input type="hidden" name="reid" value="<%=session.getAttribute("idKey")%>">
		<input type="hidden" name="stopurl">
		
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