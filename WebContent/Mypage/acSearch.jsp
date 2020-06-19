<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
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

	//ajax��ü�� ����� �Լ�
	function createXHR() {
		if (window.ActiveXObject) {
			xhrObject = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			//ajax��ü �����
			xhrObject = new XMLHttpRequest();
		}
	}
//�������� ��û�ϴ� �Լ�(����� ����),ajax��ü�� ����Ѵ�.
	function getData() {
		//HTML �ڵ忡�� javascript �ڵ念������ �������� ��
		var form_name = "form_main";
		var user_id = document.forms[form_name].elements["txt_user_id"].value;
		
		//Ajax ��ü�� ����� �Լ�
		//����� ������ ����Ϸ��� 
		//��� ����ϴ°� 1.�������� ��û�Ѵ�. 2.(json��ü�� �ִ�) �������� ��û�Ѵ�
		createXHR();
		
		//var url = "./testFile.jsp";
		var url="";
		if(user_id==null) user_id="";
		var reqparam = "user_id=" + user_id;
		
		 url = "./testDB.jsp?reqparam";
		
		//ajax��ü�� �ɼ� 4������ ����
		xhrObject.onreadystatechange = resGetData; //�������� �Լ�,�ݹ��Լ��� ���
		xhrObject.open("Post", url, "true");//��û�� �������� ��� �Է�
		xhrObject.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
		xhrObject.send(reqparam);//��ü ����
	}
	
	

	function resGetData() {
		if (xhrObject.readyState == 4) {
			if (xhrObject.status == 200) {
				var result = xhrObject.responseText;
				var objRes = eval("(" + result + ")");
				var num = objRes.datas.length;
				var res = "<table cellpadding='3' cellspacing='0' border='1' width='980'>";
				var resDiv = document.getElementById("div_res");

				if (num < 1) {
					res += "<tr><td width='980' height='50' align='center' style='font-size:20;'>�˻� ����� �����ϴ�.</td></tr>";
				} else {
					for (var i = 0; i < num; i++) {
						var user_id = objRes.datas[i].ID;
						var user_name = objRes.datas[i].NAME;
						var user_address = objRes.datas[i].ADDRESS;
						var user_phone = objRes.datas[i].PHONE;

						res += "<tr>";
						res += "<td width='980' height='50' align='center' style='font-size:20;' bgcolor='#D0E6FC'>"
								+ user_id + "</td>";
					
						res += "<td width='980' height='50' align='center' style='font-size:20;' bgcolor='white'><br>"
								+ user_name + "<br></td>";
								
						res += "<td width='980' height='50' align='center' style='font-size:20;' bgcolor='#D0E6FC'><br>"
									+ user_address + "<br></td>";
									
						res += "<td width='980' height='50' align='center' style='font-size:20;' bgcolor='white'><br>"
								+ user_phone + "<br></td>";
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
		var user_id = document.forms[form_name].elements["txt_user_id"].value;

		//if (user_id == "") {
			
		//	document.forms[form_name].elements["txt_user_id"].focus();
		//	getData();
		//	return;
		//} else {
			//Ajax ��ü�� �ִ� �ٸ� ���������� ȣ���ϴ� �Լ�(����ڰ� ����)
			//text_main.jsp���� textDB.jsp�� ȣ���Ѵ�.
			getData();
		//}
	}
</script>

</head>
<body>
	<div id='div_main' width='980' height="300"
		style="visibility: visible; position: absolute; left: 0px; top: 115px; z-index: 1;">
		<table border='0' width='980' cellpadding='0' cellspacing='0'>
			<form name="form_main" onSubmit="javascript:return false;">
				<tr>
					<td width='245'></td>
					<td width='245' align='right'>
					<input type='text'
						name='txt_user_id' size='10' value='' maxlength='10'
						style='width: 240px; font-size: 50; text-align: left;'
						onkeyup='javascript:searchData();'></td>
					<td width='245'><img src='./img/search.gif' width='245'
						height='100' onClick='javascript:searchData();'></td>
					<td width='245'></td>
				</tr>
			</form>
		</table>
	</div>

	<div id='div_res' width='980'
		style="visibility: visible; position: absolute; left: 0px; top: 215px; z-index: 1;">
		<table border='1' width='980' cellpadding='10' cellspacing='0'>
			<tr>
				<td align='center' style="width =: 950px; font-size: 50"
					bgcolor='#FFFFCC'>�����</td>
			</tr>
		</table>
	</div>
</body>
</html>