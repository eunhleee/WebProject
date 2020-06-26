
<%@page import="alcinfo.LeteaBean"%>
<%@page import="alcinfo.MemberBean"%>
<%@ page contentType="text/html; charset=utf-8"%>
<jsp:useBean id="Loginmgr" class="alcinfo.LoginMgr"></jsp:useBean>
<jsp:useBean id="Memmgr" class="member.MemberMgr"></jsp:useBean>
<jsp:useBean id="Teamgr" class="alcinfo.LeteaMgr"></jsp:useBean>
<jsp:useBean id="Paymgr" class="alcinfo.PaymentMgr"></jsp:useBean>
<jsp:useBean id="bean" class="alcinfo.PaymentBean"></jsp:useBean>

<%
		request.setCharacterEncoding("utf-8");
		String title=request.getParameter("title");
		String money=request.getParameter("money");
	 	 String id =(String) session.getAttribute("idKey"); 
	 	int grade=Loginmgr.getGrade(id);
		String name="",email="",address="",phone="";
		if(grade==0||grade==1){
			MemberBean mbean=Memmgr.getInfo(id);
			name=mbean.getName();
			email=mbean.getEmail();
			address=mbean.getAddress();
			phone=mbean.getPhone();
		}
		else if(grade==2||grade==3){
			LeteaBean lbean=Teamgr.getInfo(id);
			name=lbean.getName();
			email=lbean.getEmail();
			address=lbean.getAddress();
			phone=lbean.getPhone();
		} 
		
		bean.setId(id);
		bean.setName(name);
		bean.setGrade(grade);
		bean.setProduct_name(title);
		bean.setPrice(Integer.parseInt(money));
		session.setAttribute("bean",bean);
		
%>
<html>
<head>
<link href="../alcinfo/fontStyle.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
var IMP = window.IMP; // 생략가능
IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
IMP.request_pay({
    pg : 'inicis', // version 1.1.0부터 지원.
    pay_method : 'card',
    merchant_uid : 'merchant_' + new Date().getTime(),
    name : '<%=title%>',
    amount : '<%=money%>',
    buyer_email : '<%=email%>',
    buyer_name : '<%=name%>',
    buyer_tel : '<%=phone%>',
    buyer_addr :'<%=address%>',
    buyer_postcode : '0000',
    m_redirect_url : '../alcinfo/buyPoint.jsp'
}, function(rsp) {
    if ( rsp.success ) {
        var msg = '결제가 완료되었습니다.';
        location.href="../Payment/paymentProc.jsp?apply_num="+rsp.apply_num;
        //카드승인번호 넣어야할지 말지 고민 더 해보기
    } else {
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
    }
    alert(msg);
    self.close(); 
});
</script>

</head>
<body>

</body>
</html>