
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
		String id=(String)session.getAttribute("idKey");
%>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css" />
<link rel="stylesheet" href="../alcinfo/cards-gallery.css">
<script>
	function goPayment(title){
		<%
		if(id==null){
		%>
		alert("로그인 후 이용 가능 합니다.");
		<%}else{
		%>
		var t="포인트",m="";
		if(title=='1'){t='1일용'+t;	m='500';}
		if(title=='2'){t='1개월용'+t;	m='10000';}
		if(title=='3'){t='6개월용'+t;	m='50000';}
		if(title=='4'){t='1년용'+t;	m='90000';}
		
	 	var url='../Payment/payment.jsp?title='+t+'&money='+m;
	 	window.open(url,"결제 진행 중","width=900,height=650,top=100,left=400");
	 	<%
	 	}
	 	%>
	 	
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
#btn{
	align:center;
	margin:10px;
	background-color:#F88C65;
	border:none;
	border-radius: 6px;
	color:white;
	font-size:20px;
	width:300px;
	height:50px;
}
</style>
</head>
<body>
<%@ include file="../alcinfo/mainHeader.jsp"%>
<br><br>
<section class="gallery-block cards-gallery">
	<div class="container">
		<div class="heading">
			<h2>체험용 포인트 구매하기</h2>
		</div>
		<br>
		<div class="row">
			
			<div class="col-md-6 col-lg-4">
				<div class="card border-0 transform-on-hover">
					 <img src="../img/won_500.png" alt="Card Image" class="card-img-top">
				
					<div class="card-body">
						<h6>1일용 </h6>
						<p class="text-muted card-text">1일간 무제한 후기 보기가 가능합니다.</p>
					</div>
					<div align="center">
						<input id="btn" type="button"  value="구입하기"
						onclick="goPayment('1');">
					</div>
				</div>
			</div>
		</div>
	</div>
<br><br>
	<div class="container">
		<div class="heading">
			<h2>장기 포인트 구매하기</h2>
		</div>
		<br>
		<div class="row">
			
			<div class="col-md-6 col-lg-4">
				<div class="card border-0 transform-on-hover">
					<img src="../img/won_10000.png" alt="Card Image" class="card-img-top">
					
					<div class="card-body">
						<h6>1개월 용</h6>
						<p class="text-muted card-text">1개월간 무제한 후기 보기가 가능합니다.</p>
					</div>
					<div align="center">
						<input id="btn" type="button"  value="구입하기"
						onclick="goPayment('2');">
					</div>
				</div>
			</div>
			<div class="col-md-6 col-lg-4">
				<div class="card border-0 transform-on-hover">
					<img src="../img/won_50000.png" alt="Card Image" class="card-img-top">
					
					<div class="card-body">
						<h6>6개월 용</h6>
						<p class="text-muted card-text">6개월간 무제한 후기 보기가 가능합니다.</p>
					</div>
					<div align="center">
						<input id="btn" type="button"  value="구입하기"
						onclick="goPayment('3');">
					</div>
				</div>
			</div>
			<div class="col-md-6 col-lg-4">
				<div class="card border-0 transform-on-hover">
					<img src="../img/won_90000.png" alt="Card Image" class="card-img-top">
					
					<div class="card-body">
						<h6>1년 용</h6>
						<p class="text-muted card-text">1년간 무제한 후기 보기가 가능합니다.</p>
					</div>
					<div align="center">
						<input id="btn" type="button"  value="구입하기"
						onclick="goPayment('4');">
					</div>
				</div>
			</div>
			

		</div>
	</div>
	</section>

<%@ include file="../alcinfo/footer.jsp"%>
</body>
</html>
