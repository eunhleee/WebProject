<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="alcinfo.*"%>
<jsp:useBean id="pmgr" class="alcinfo.ReportMgr" />
<%
	String id = (String) session.getAttribute("idKey");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>프로필 사진 변경</title>
<%-- <%@include file="js_css.html"%>
 --%><script type="text/javascript">
	function send() {
		document.frm.submit();
	}
	function goURL(url) {
		document.frm1.action = url;
		document.frm1.submit();
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
font-family:'Godo';
background-color: #F8FFFF;
overflow:hidden;
display:flex;

hight:100%;
width:100%;

}
.right {
	position:absolute;
	text-align: center;
	float:right;
	bottom: 5%;
	right: 10%;
	
}
#id_photo{
	position:absolute;

	bottom: 15%;
	left: 5%;
}
button {
	-webkit-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-moz-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-ms-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	-o-transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	transition: all 200ms cubic-bezier(0.390, 0.500, 0.150, 1.360);
	display: block;
	margin: 10px auto;
	max-width: 180px;
	text-decoration: none;
	border:0px;
	border-radius: 4px;
	padding: 5px 10px;
}


button.btn {
	color: #353535;
	box-shadow: rgba(248, 180, 207, 0.4) 0 0px 0px 2px inset;
}

button.btn:hover {
	color: rgba(255, 255, 255, 0.85);
	box-shadow: rgba(248, 180, 207, 0.7) 0 0px 0px 40px inset;
}

.total{
}
.post_btn{

}
#imageCanvas{
}
.preview{
hight:500px;
}
</style>
</head>
<body>
<div data-role="content" class="total">
			<form method="post" name="frm" action="teaImgUp"
				enctype="multipart/form-data" class="post_form">
				<div class="preview" >
				<h4 align="center"> 이미지를 업로드 해주세요</h4>
					<div class="upload">
						<div class="post_btn" >
							<div class="plus_icon"></div>
							<canvas id="imageCanvas" style="padding-left:40px; higth:400px;"></canvas>
						</div>
					</div>
				</div>
				<p>
					<input type="file" name="photo" id="id_photo" required="required">
				</p>
				
				<input type="hidden" value="<%=id%>" name="id"> 
				<div class="right">
				<button type="button" onclick="send()" class="btn">저장</button>
				</div>
			</form>
		
		<form method="post" name="frm1"></form>
		
	</div>
	<script>
		var fileInput = document.querySelector("#id_photo"), button = document
				.querySelector(".input-file-trigger"), the_return = document
				.querySelector(".file-return");
		fileInput.addEventListener('change', handleImage, false);
		var canvas = document.getElementById('imageCanvas');
		var ctx = canvas.getContext('2d');

		function handleImage(e) {
			var reader = new FileReader();
			reader.onload = function(event) {
				var img = new Image();
				img.onload = function() {
					canvas.width = 250;
					canvas.height = 300;
					ctx.drawImage(img, 0, 0, 250, 230);
				};
				img.src = event.target.result;
			};
			reader.readAsDataURL(e.target.files[0]);
		}
	</script>
</body>
</html>