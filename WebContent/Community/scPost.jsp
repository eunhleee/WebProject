<!-- 커뮤니티의 자유게시판 리스트 출력 -->
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="Mmgr" class="member.MemberMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");
	String numPerPage = request.getParameter("numPerPage");
	String keyField = request.getParameter("keyField");	
	String keyWord = request.getParameter("keyWord");
	String scid = (String)session.getAttribute("idKey");
	String nick = Mmgr.memberNick(scid);
	String category="";
	String group=request.getParameter("pageValue");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    Calendar today = Calendar.getInstance();
 	String strToday = sdf.format(today.getTime());
 	
 	if(request.getParameter("pageValue").equals("free")){
		category="자유게시판";
	}
	else if(request.getParameter("pageValue").equals("academy")){
		category="학원 Q&A";
	}
	else if(request.getParameter("pageValue").equals("lesson")){
		category="과외 Q&A";
	}
	else if(request.getParameter("pageValue").equals("onlyst")){
		category="학생 전용 게시판";
	}
	else if(request.getParameter("pageValue").equals("onlyte")){
		category="선생님 전용 게시판";
	}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../smartEditor/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.0.min.js"></script>
<script type="text/javascript"> 
var oEditors = [];
$(function(){
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "sccontent", //textarea에서 지정한 id와 일치해야 합니다. 
          //SmartEditor2Skin.html 파일이 존재하는 경로
          sSkinURI: "../smartEditor/SmartEditor2Skin.html",  
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,             
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : false,     
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : false,         
              fOnBeforeUnload : function(){
                   
              }
          }, 
          fOnAppLoad : function(){
              //기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용
              oEditors.getById["sccontent"].exec("PASTE_HTML", [" "]);
          },
          fCreator: "createSEditor2"
      });
      
      //저장버튼 클릭시 form 전송
      $("#save").click(function(){
          oEditors.getById["sccontent"].exec("UPDATE_CONTENTS_FIELD", []);
          $("#scpostfrm").submit();
      });    
});
</script>
<title>우리학원 어디?-커뮤니티</title>
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
#list td {
	border-bottom: 1px solid lightgray;
}

#title td {
	color: white;
	background-color: #36ada9;
}

a {
	text-decoration: none;
	color: black;
}

a:hover {
	color: gray;
}
#insertMember{
	float: right;
	margin-right:350px;
  	width: 900px;
  	border: 10px solid #F88C65; 
	border-radius:10px;
	padding:20px 40px;
	margin-top:50px;
}
#categoryframe{
	margin-left:280px;
	margin-right:80px;
	margin-top:50px;
	float:left;
	border:10px solid #FCBC7E;
	border-radius:15px;
	background-color:white;
	width:250px;
	height:300px;
	padding:30px 0px;
	background-color:#FAF8EB;
}
 
 
 #atag {
 	margin-left:50px;
 	height:40px;
 	line-height:40px;
 	width:170px;
 	display: block;
 }
 
 
 #atag:hover{
 	background-color:white;
 	border-radius: 10px;
 }

#inputdiv2{
	margin:10px;
	width:570px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}
#inputdiv2 input{
	width:500px;
	border:none;
	font-size:15px;
}

#inputdiv3{
	margin:10px;
	width:210px;
	border:1px solid gray;
	border-radius: 6px;
	padding:3px;
}

#inputdiv3 input{
	width:190px;
	border:none;
	font-size:15px;
	
}

#textareadiv{
	margin:10px;
	width:630px;
	padding:3px;
}
</style>
</head>
<body>

	<jsp:include page="../alcinfo/headerSearch.jsp"></jsp:include>
	<table>
		<tr>
		<td style="vertical-align:top">
		
		<div id="categoryframe">
			<h3 style="margin-left:50px;">커뮤니티</h3>
			<div id="atag"><a href="communityList.jsp?pageValue=free">&#149; 자유게시판</a></div>
			<div id="atag"><a href="communityList.jsp?pageValue=academy">&#149; 학원 Q&A</a></div>
			<div id="atag"><a href="communityList.jsp?pageValue=lesson">&#149; 과외 Q&A</a></div>
			<div id="atag"><a 
			<%if(Mmgr.checkM(scid)==0||Mmgr.checkM(scid)==1) {%>
			href="communityList.jsp?pageValue=onlyst"
			<%} else { %>
			href="javascript:clalert1()"
			<%} %>
			>&#149; 학생 전용 게시판</a></div>
			<div id="atag"><a 
			<%if(Mmgr.checkM(scid)==0||Mmgr.checkM(scid)==2||Mmgr.checkM(scid)==3) {%>
			href="communityList.jsp?pageValue=onlyte"
			<%} else { %>
			href="javascript:clalert2()"<%} %>
			>&#149; 선생님 전용 게시판</a></div>
		</div>
		</td>
		
		<td>
		<div id="insertMember" class="insertMember1" align="left">
			<h2><img src="../img/questionmark2.png" width="40" height="40">&nbsp;<%=category%> 글쓰기</h2>	
			<hr style="border:1px solid #F88C65;">	
			<br/>
			<form name="scpostFrm" method="post" action="scPost?pageValue=<%=group%>&numPerPage=<%=numPerPage%>&nowPage=<%=nowPage%><%
  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>&keyField=<%=keyField%>&keyWord=<%=keyWord%><%}%>"
			enctype="multipart/form-data">
			<table width="750" cellpadding="3" align="center">
				<tr>
					<td align=center>
					<table  align="center" >
						<tr>
							<td>작성자</td>
							<td>
								<div id="inputdiv3">
									<input name="stqtitle" size="50" maxlength="30" disabled="disabled"
									value="<%=nick%>">
								</div>
							</td>
							<td>작성일</td>
							<td>
								<div id="inputdiv3">
									<input name="stqtitle" size="50" maxlength="30" disabled="disabled"
									value="<%=strToday%>">
								</div>
							</td>
						</tr>
						<tr>
							<td>제 목</td>
							<td colspan="3">
							<div id="inputdiv2">
							<input name="sctitle" size="50" maxlength="30">
							</div></td>
						</tr>
						<tr>
							<td>내 용</td>
							<td colspan="3">
							<div id="textareadiv">
							<textarea id="sccontent" name="sccontent" rows="10" cols="50"></textarea>
							</div>
							</td>
						</tr>
						<tr>
						 <tr>
			     			<td>파일찾기</td> 
			     			<td colspan="3"><input type="file" name="scfilename" size="50" maxlength="50"></td>
			    		</tr>
						
						<tr>
							<td colspan="4" align="right">
						
								 <input type="submit" id="save" value="확인">
								 <input type="reset" value="다시쓰기">
								 <input type="button" value="취소"
								 onClick="javascript:location.href='<%=request.getHeader("referer")%>'">

							</td>
						</tr>
					</table>
					</td>
					</tr>
			</table>
			<input type="hidden" name="scid" value="<%=scid%>">
			<input type="hidden" name="scip" value="<%=request.getRemoteAddr()%>">
			<input type="hidden" name="pageValue" value="<%=group %>">
			<input type="hidden" name="nowPage" value="<%=nowPage%>">
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
			<%
		  	 	if(!(keyWord==null||keyWord.equals(""))){
		     %>
		     <input type="hidden" name="keyField" value="<%=keyField%>">
		     <input type="hidden" name="keyWord" value="<%=keyWord%>">
		 	 <%
				}
			 %>
			</form>
		</div>
		</td>
		</tr>
		</table>
		
	<jsp:include page="../alcinfo/footer.jsp" />

</body>

</html>

