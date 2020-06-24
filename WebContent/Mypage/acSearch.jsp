<!-- acSearch.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	request.setCharacterEncoding("UTF-8");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="EUC-KR">
<title>Insert title here</title>
<script language="JavaScript" type="text/JavaScript">
	var xhrObject;

	//ajax객체를 만드는 함수
	function createXHR() {
		if (window.ActiveXObject) {
			xhrObject = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			//ajax객체 만들기
			xhrObject = new XMLHttpRequest();
		}
	}
//페이지를 요청하는 함수(사용자 정의),ajax객체를 사용한다.
	function getData() {
		//HTML 코드에서 javascript 코드영역으로 가져오는 것
		var form_name = "form_main";
		var user_name = document.forms[form_name].elements["txt_user_name"].value;
		
		//Ajax 객체를 만드는 함수
		//만드는 이유는 사용하려고 
		//어디에 사용하는가 1.페이지를 요청한다. 2.(json객체가 있는) 페이지를 요청한다
		createXHR();
		
		//var url = "./testFile.jsp";
		var url="";
		if(user_name==null) user_name="";
		var reqparam = "user_name=" + user_name;
		
		 url = "./academyDB.jsp?reqparam";
		
		//ajax객체에 옵션 4가지를 설정
		xhrObject.onreadystatechange = resGetData; //돌려받을 함수,콜백함수를 등록
		xhrObject.open("Post", url, "true");//요청할 페이지의 경로 입력
		xhrObject.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
		xhrObject.send(reqparam);//객체 실행
	}
	function resGetData() {
		if (xhrObject.readyState == 4) {
			if (xhrObject.status == 200) {
				var result = xhrObject.responseText;
				var objRes = eval("(" + result + ")");
				var num = objRes.datas.length;
				var res = "<table cellpadding='3' cellspacing='0' border='1' width='580'>";
				var resDiv = document.getElementById("div_res");

				if (num < 1) {
					res += "<tr><td width='500' height='30' align='center' style='font-size:20;'>검색 결과가 없습니다.</td></tr>";
				} else {
					for (var i = 0; i < num; i++) {
						var user_name = objRes.datas[i].NAME;
						var user_address = objRes.datas[i].ADDRESS;
						var user_num = objRes.datas[i].NUM;

						res += "<tr>";
						res += "<td width='100' height='15' align='center' style='font-size:15;' bgcolor='#D0E6FC'><br>"
							+"<a href=\"javascript:sendChildValue(\'"+user_name+"\',\'"+user_num+"\')\">"	
						+ user_num + "</a><br></td>";
						res += "<td width='180' height='15' align='center' style='font-size:15;' bgcolor='white'><br>"
						+"<a href=\"javascript:sendChildValue(\'"+user_name+"\',\'"+user_num+"\')\">"
								+ user_name + "</a><br></td>";
								
						res += "<td width='500' height='15' align='center' style='font-size:15;' bgcolor='#D0E6FC'><br>"
							+"<a href=\"javascript:sendChildValue(\'"+user_name+"\',\'"+user_num+"\')\">"			
						+ user_address + "</a><br></td>";

						res += "</tr>";

					}
				}
				res += "</table>";
				resDiv.innerHTML = res;
			}
		}
	}

	function searchData() {
		var form_name = "form_main";
		var user_name = document.forms[form_name].elements["txt_user_name"].value;
			getData();
	}
	function sendChildValue(name,num){
		window.opener.setChildValue(name,num); 
			window.close()
			}
</script>

</head>
<body>
	<div id='div_main' width='380' height="300"
		style="visibility: visible; position: absolute; left: 100px; top: 55px; z-index: 1;">
		<table border='0' width='380' cellpadding='0' cellspacing='0'>
			<form name="form_main" onSubmit="javascript:return false;">
				<tr>
					<td width='145'></td>
					<td width='145' align='right'>
					<input type='text'  
						name='txt_user_name' size='15' maxlength='10'
						style='width: 140px; font-size: 15; text-align: left;'
						onkeyup='javascript:searchData();'></td>
					<td width='45'><img src='../img/search.svg' width='45'
						height='50' onClick='javascript:searchData();' style="margin-left:15px;"></td>
					<td width='145'></td>
			    <input type="text" id="cInput" value="3">

				</tr>
			</form>
		</table>
	</div>

	<div id='div_res' width='380'
		style="visibility: visible; position: absolute; left: 0px; top: 115px; z-index: 1;">
		<table border='1' width='580' cellpadding='10' cellspacing='0'>
			<tr>
				<td align='center' style="width =: 550px; font-size: 20"
					bgcolor='#FFFFCC'>학원목록</td>
			</tr>
		</table>
	</div>
</body>
</html>