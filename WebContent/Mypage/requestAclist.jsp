<!-- requestAclist.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="alcinfo.UtilMgr"%>
<%@page import="alcinfo.AcademyBean"%>
<%@page import="java.util.Vector"%>
<jsp:useBean id="aMgr" class="alcinfo.AcademyMgr" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학원장 신청목록</title>
<script type="text/javascript">
function noPermit(aca_id,aca_state){
	document.permitFrm.aca_id.value=aca_id;
    document.permitFrm.aca_state.value=aca_state;
	document.permitFrm.action="requestAclistProc.jsp?flag=noPermit";
	document.permitFrm.submit();
}
function Permit(aca_id,aca_state){
	document.permitFrm.aca_id.value=aca_id;
    document.permitFrm.aca_state.value=aca_state;
	document.permitFrm.action="requestAclistProc.jsp?flag=Permit";
	document.permitFrm.submit();
}
</script>
	<%
						Vector<AcademyBean> mvlist=aMgr.mGMList();
						int listStze = mvlist.size();

						if(mvlist.isEmpty()){
						out.println("신청된 것이 없습니다.");
						}else{
							for(int i=0;i<mvlist.size();i++){
								AcademyBean mbean=mvlist.get(i);
					%>

</head>
<body>

<table>
<tr>
<td>
<img src="../authority/<%=mbean.getAca_business()%>" style="margin-bottom:10px;width:250px; height:200px; "><br>
</td>
<td>
<img src="../authority/<%=mbean.getAca_identity()%>" style="margin-bottom:10px;width:250px; height:200px; "><br>
</td> 
</tr>
</table>
<table>
<tr>
<td width="100" name="num">접수번호</td>
<td><%=mbean.getNum() %></td>
</tr>
<tr>
<td width="100" name="aca_id">아이디</td>
<td><%=mbean.getAca_id()%></td>
</tr>
<tr>
<td width="100" name="aca_num">학원번호</td>
<td><%=mbean.getAca_num()%></td>
</tr>
<tr>
<td width="100" name="aca_name">학원이름</td>c
<td><%=mbean.getAca_name()%></td>
</tr> 
<tr>
<td width="100" name="aca_state">상태</td>
<td><%=mbean.getAca_state()%></td>
</tr>
<tr>
<td colspan="2" align="right">
	<input type="submit" value="비허가" onclick="noPermit('<%=mbean.getAca_id()%>','<%=mbean.getAca_state()%>')">
	<input type="submit" value="허가" onclick="Permit('<%=mbean.getAca_id()%>','<%=mbean.getAca_state()%>')">
	
</td>
</tr>
<%} }%>
</table>
<form name="permitFrm" method="post">
		<input type="hidden" name="aca_id">
		<input type="hidden" name="aca_state">

</form>
</body>
</html>