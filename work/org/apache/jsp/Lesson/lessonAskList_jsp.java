/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.33
 * Generated at: 2020-06-12 06:17:23 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.Lesson;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import alcinfo.LeteaBean;
import alcinfo.MemberBean;
import alcinfo.UtilMgr;
import alcinfo.LereviewBean;
import java.util.Vector;

public final class lessonAskList_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("alcinfo.MemberBean");
    _jspx_imports_classes.add("java.util.Vector");
    _jspx_imports_classes.add("alcinfo.UtilMgr");
    _jspx_imports_classes.add("alcinfo.LereviewBean");
    _jspx_imports_classes.add("alcinfo.LeteaBean");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
      throws java.io.IOException, javax.servlet.ServletException {

    if (!javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSP들은 오직 GET, POST 또는 HEAD 메소드만을 허용합니다. Jasper는 OPTIONS 메소드 또한 허용합니다.");
        return;
      }
    }

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\n");
      out.write("<!-- 커뮤니티의 자유게시판 리스트 출력 -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\n");
      out.write("<!-- 과외 리뷰 리스트 출력 -->\r\n");
      out.write("\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      alcinfo.LereviewMgr mgr = null;
      mgr = (alcinfo.LereviewMgr) _jspx_page_context.getAttribute("mgr", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (mgr == null){
        mgr = new alcinfo.LereviewMgr();
        _jspx_page_context.setAttribute("mgr", mgr, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\r');
      out.write('\n');
      alcinfo.LoginMgr Loginmgr = null;
      Loginmgr = (alcinfo.LoginMgr) _jspx_page_context.getAttribute("Loginmgr", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (Loginmgr == null){
        Loginmgr = new alcinfo.LoginMgr();
        _jspx_page_context.setAttribute("Loginmgr", Loginmgr, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\r');
      out.write('\n');
      member.MemberMgr Memmgr = null;
      Memmgr = (member.MemberMgr) _jspx_page_context.getAttribute("Memmgr", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (Memmgr == null){
        Memmgr = new member.MemberMgr();
        _jspx_page_context.setAttribute("Memmgr", Memmgr, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\r');
      out.write('\n');
      alcinfo.LeteaMgr Teamgr = null;
      Teamgr = (alcinfo.LeteaMgr) _jspx_page_context.getAttribute("Teamgr", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (Teamgr == null){
        Teamgr = new alcinfo.LeteaMgr();
        _jspx_page_context.setAttribute("Teamgr", Teamgr, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\r');
      out.write('\n');

	request.setCharacterEncoding("UTF-8");
	int num=UtilMgr.parseInt(request,"num");
	String id = request.getParameter("id");
	String loginid = (String)session.getAttribute("idKey");
	//검색에 필요한 변수
	int grade=Loginmgr.getGrade(id);
	
	String mpoint=null;
	if(grade==0||grade==1){
		MemberBean mbean=Memmgr.getInfo(loginid);
		mpoint=mbean.getMpoint();
		
	}
	else if(grade==2||grade==3){
		LeteaBean lbean=Teamgr.getInfo(loginid);
		mpoint=lbean.getMpoint();
	} 
	int totalRecord = 0;//총게시물수
	int numPerPage = 10;//페이지당 레코드 개수(5,10,15,30)
	int pagePerBlock = 15;//블럭당 페이지 개수
	int totalPage = 0;//총 페이지 개수
	int totalBlock = 0;//총 블럭 개수
	int nowPage = 1;//현재 페이지
	int nowBlock = 1;//현재 블럭

	//요청된 numPerPage 처리
	//요청이 있으면 처리가 되지만 그렇지 않으면 기본 10개 세팅이 된다.
	if (request.getParameter("numPerPage") != null) {
		numPerPage = UtilMgr.parseInt(request, "numPerPage");
	}

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

	totalRecord = mgr.getTotalCount(keyField, keyWord);
	//out.print("totalRecord : " + totalRecord);

	//nowPage 요청 처리
	if (request.getParameter("nowPage") != null) {
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}

	//sql문에 들어가는 start, cnt 선언
	int start = (nowPage * numPerPage) - numPerPage;
	int cnt = numPerPage;

	//전체페이지 개수
	totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
	//전체블럭 개수
	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
	//현재블럭
	nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("<title>과외 후기 게시판</title>\r\n");
      out.write("<script>\r\n");
      out.write("\tfunction lecheck() {\r\n");
      out.write("\t\tif (document.lesearchFrm.keyWord.value == \"\") {\r\n");
      out.write("\t\t\talert(\"검색어를 입력하세요.\");\r\n");
      out.write("\t\t\tdocument.lesearchFrm.keyWord.focus();\r\n");
      out.write("\t\t\treturn;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\tdocument.lesearchFrm.submit();\r\n");
      out.write("\t}\r\n");
      out.write("\tfunction pageing(page) {\r\n");
      out.write("\t\tdocument.readFrm.nowPage.value = page;\r\n");
      out.write("\t\tdocument.readFrm.submit();\r\n");
      out.write("\t}\r\n");
      out.write("\tfunction block(block) {\r\n");
      out.write("\t\tdocument.readFrm.nowPage.value =\r\n");
      out.print(pagePerBlock);
      out.write("\r\n");
      out.write("\t* (block - 1) + 1;\r\n");
      out.write("\t\tdocument.readFrm.submit();\r\n");
      out.write("\t}\r\n");
      out.write("\tfunction list() {//[처음으로]를 누르면 게시글의 처음 페이지로 돌아감\r\n");
      out.write("\t\tdocument.listFrm.action = \"leRead.jsp?num=");
      out.print(num);
      out.write("&id=");
      out.print(id);
      out.write("\";\r\n");
      out.write("\t\tdocument.listFrm.submit();\r\n");
      out.write("\t}\r\n");
      out.write("\tfunction numPerFn(numPerPage) {\r\n");
      out.write("\t\tdocument.readFrm.numPerPage.value = numPerPage;\r\n");
      out.write("\t\tdocument.readFrm.submit();\r\n");
      out.write("\t}\r\n");
      out.write("\t//list.jsp에서 read.jsp로 요청이 될때 기존에 조건\r\n");
      out.write("\t//기존 조건 : keyField,keyWord,nowPage,numPerPage\r\n");
      out.write("\tfunction read(num) {\r\n");
      out.write("\t\tdocument.readFrm.lernum.value = num;\r\n");
      out.write("\t\tdocument.readFrm.action = \"le_ReviewRead.jsp\";\r\n");
      out.write("\t\tdocument.readFrm.submit();\r\n");
      out.write("\t}\r\n");
      out.write("\tfunction lealert() {\r\n");
      out.write("\t\talert(\"로그인 후 이용가능합니다.\");\r\n");
      out.write("\t}\r\n");
      out.write("</script>\r\n");
      out.write("<style>\r\n");
      out.write("#list td {\r\n");
      out.write("\tborder-bottom: 1px solid lightgray;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("#title td {\r\n");
      out.write("\tcolor: white;\r\n");
      out.write("\tbackground-color: #36ada9;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("a {\r\n");
      out.write("\ttext-decoration: none;\r\n");
      out.write("\tcolor: black;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("a:hover {\r\n");
      out.write("\tcolor: gray;\r\n");
      out.write("}\r\n");
      out.write("</style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<!-- 리스트 부분 -->\r\n");
      out.write("\r\n");
      out.write("\t<h2>선생님 리뷰</h2>\r\n");
      out.write("\t<table>\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td width=\"600\">Total : ");
      out.print(totalRecord);
      out.write("Articles(<font\r\n");
      out.write("\t\t\t\tcolor=\"red\"> ");
      out.print(nowPage + "/" + totalPage);
      out.write("Pages\r\n");
      out.write("\t\t\t</font>)\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t\t<td align=\"right\">\r\n");
      out.write("\t\t\t\t<form name=\"npFrm\" method=\"post\">\r\n");
      out.write("\t\t\t\t\t<select name=\"numPerPage\" size=\"1\"\r\n");
      out.write("\t\t\t\t\t\tonchange=\"numPerFn(this.form.numPerPage.value)\">\r\n");
      out.write("\t\t\t\t\t\t<option value=\"5\">5개 보기</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"10\" selected>10개 보기</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"15\">15개 보기</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"30\">30개 보기</option>\r\n");
      out.write("\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t</form> <script>\r\n");
      out.write("\t\t\t\t\tdocument.npFrm.numPerPage.value =");
      out.print(numPerPage);
      out.write("\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t</script>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t</table>\r\n");
      out.write("\t<table>\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td align=\"center\" colspan=\"2\">\r\n");
      out.write("\t\t\t\t<table cellspacing=\"0\" height=\"80\">\r\n");
      out.write("\t\t\t\t\t<tr align=\"center\" id=\"title\">\r\n");
      out.write("\t\t\t\t\t\t<td width=\"150\">평 점</td>\r\n");
      out.write("\t\t\t\t\t\t<td width=\"280\">제 목</td>\r\n");
      out.write("\t\t\t\t\t\t<td width=\"100\">닉 네 임</td>\r\n");
      out.write("\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t\t<td width=\"150\">날 짜</td>\r\n");
      out.write("\t\t\t\t\t\t<td width=\"100\">조회수</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t");

						if(loginid==null||mpoint==null){
					
      out.write("\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td align=\"center\" colspan=\"5\" height=\"210\" style=\"background-color:gray;  opacity: 0.5;\">\r\n");
      out.write("\t\t\t\t\t\t\t<p style=\"color:white;\">포인트를 구입하시면 ");
      out.print(totalRecord);
      out.write(" 개의 후기글을 보실 수 있습니다.</p><br>\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"button\" value=\"포인트 구입하러 가기\" onclick=\"moveToBuyPoint();\">\r\n");
      out.write("\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\t");
}else{ 
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t");

						Vector<LereviewBean> vlist = mgr.getBoardList(num,keyField, keyWord, start, cnt);
						int listsize = vlist.size();
						if (vlist.isEmpty()) {
					
      out.write("\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td align=\"center\" colspan=\"5\" height=\"210\">\r\n");
      out.write("\t\t\t\t\t\t\t<p>등록된 게시글이 없습니다.</p>\r\n");
      out.write("\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t");

						} else {
							for (int i = 0; i < listsize; i++) {
								LereviewBean le1bean = vlist.get(i);
								int lnum = le1bean.getNum();
								String title = le1bean.getLr_title();
								String content = le1bean.getLr_content();
								String nick = le1bean.getLr_nick();
								double star = le1bean.getLr_star();
								String date = le1bean.getLr_date();
								int count = le1bean.getLr_count();
								int ccount = mgr.lerccount(lnum);
					
      out.write("\r\n");
      out.write("\t\t\t\t\t<tr id=\"list\">\r\n");
      out.write("\t\t\t\t\t\t\t<td align=\"center\">");
      out.print(star);
      out.write("</a></td>\r\n");
      out.write("\t\t\t\t\t\t<td align=\"center\">\r\n");
      out.write("\t\t\t\t\t\t<a href=\"javascript:read('");
      out.print(lnum);
      out.write("')\">");
      out.print(title);
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t");
 if(ccount>0) { 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<font color=\"red\">[");
      out.print(ccount);
      out.write("]</font>\r\n");
      out.write("\t\t\t\t\t\t");
 } 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t<td align=\"center\"><a href=\"\">");
      out.print(nick);
      out.write("</a></td>\r\n");
      out.write("\t\t\t\t\t\t<td align=\"center\">");
      out.print(date);
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t<td align=\"center\">");
      out.print(count);
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t");

						}
						}
					}
					
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t</table>\r\n");
      out.write("\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td colspan=\"2\"><br> <br></td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\r\n");
      out.write("\t\t<tr>\r\n");
      out.write("\t\t\t<td>\r\n");
      out.write("\t\t\t\t<!-- 페이징 및 블럭 Start --> ");

 	if (totalPage > 0) {
 
      out.write(" <!-- 이전 블럭 --> ");

 	if (nowBlock > 1) {
 
      out.write("\r\n");
      out.write("\t\t\t\t<a href=\"javascript:block('");
      out.print(nowBlock - 1);
      out.write("')\">이전으로</a> ");

 	}
 
      out.write(" <!-- 페이징 -->\r\n");
      out.write("\t\t\t\t");

					int pageStart = (nowBlock - 1) * pagePerBlock + 1;
						int pageEnd = (pageStart + pagePerBlock) < totalPage ? pageStart + pagePerBlock : totalPage + 1;
						for (; pageStart < pageEnd; pageStart++) {
				
      out.write(" <a href=\"javascript:pageing('");
      out.print(pageStart);
      out.write("')\"> ");

 	if (nowPage == pageStart) {
 
      out.write("<font\r\n");
      out.write("\t\t\t\t\tcolor=\"gray\">\r\n");
      out.write("\t\t\t\t\t\t");

							}
						
      out.write(' ');
      out.write('[');
      out.print(pageStart);
      out.write(']');
      out.write(' ');

							if (nowPage == pageStart) {
						
      out.write("\r\n");
      out.write("\t\t\t\t</font>\r\n");
      out.write("\t\t\t\t\t");

						}
					
      out.write("\r\n");
      out.write("\t\t\t</a> ");

 	} //---for
 
      out.write(" <!-- 다음 블럭 --> ");

 	if (totalBlock > nowBlock) {
 
      out.write(" <a\r\n");
      out.write("\t\t\t\thref=\"javascript:block('");
      out.print(nowBlock + 1);
      out.write("')\">다음으로</a> ");

 	}
 
      out.write(' ');

 	} //---if1
 
      out.write("\r\n");
      out.write("\t\t\t\t<!-- 페이징 및 블럭 End -->\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t\t<td align=\"right\">\r\n");
      out.write("\t\t\t\t<a \r\n");
      out.write("\t\t\t\t");
 if(loginid != null) { 
      out.write("\r\n");
      out.write("\t\t\t\thref=\"le_ReviewPost.jsp?num=");
      out.print(num);
      out.write("&id=");
      out.print(id);
      out.write("&numPerPage=");
      out.print(numPerPage);
      out.write("&nowPage=");
      out.print(nowPage);

  	 	if(!(keyWord==null||keyWord.equals(""))){
		     
      out.write("&keyField=");
      out.print(keyField);
      out.write("&keyWord=");
      out.print(keyWord);
}
      out.write("\"\r\n");
      out.write("\t\t\t\t");
 } else { 
      out.write("\r\n");
      out.write("\t\t\t\thref=\"javascript:lealert()\"\r\n");
      out.write("\t\t\t\t");
 } 
      out.write("\r\n");
      out.write("\t\t\t\t>[글쓰기]</a>\r\n");
      out.write("\t\t\t\t<a href=\"javascript:list()\">[처음으로]</a>\r\n");
      out.write("\t\t\t</td>\r\n");
      out.write("\t\t</tr>\r\n");
      out.write("\t</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<hr width=\"800\" align=\"center\">\r\n");
      out.write("\t<form name=\"lesearchFrm\">\r\n");
      out.write("\t\t<table width=\"600\" cellpadding=\"4\" cellspacing=\"0\">\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td align=\"center\" valign=\"bottom\">\r\n");
      out.write("\t\t\t\t<select name=\"keyField\" size=\"1\">\r\n");
      out.write("\t\t\t\t\t<option value=\"lq_name\">제 목</option>\r\n");
      out.write("\t\t\t\t\t<option value=\"lq_subject\">과 목</option>\r\n");
      out.write("\t\t\t\t\t<option value=\"lq_content\">내 용</option>\r\n");
      out.write("\t\t\t\t\t<option value=\"lq_nick\">닉 네 임</option>\r\n");
      out.write("\t\t\t\t</select> \r\n");
      out.write("\t\t\t\t<input size=\"16\" name=\"keyWord\"> \r\n");
      out.write("\t\t\t\t<input type=\"button\" value=\"찾기\" onClick=\"javascript:lecheck()\"> \r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"nowPage\" value=\"1\"></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t</form>\r\n");
      out.write("\t<form name=\"listFrm\" method=\"post\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"reload\" value=\"true\">\r\n");
      out.write("\t\t<!-- 요게 중요 -->\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"nowPage\" value=\"1\">\r\n");
      out.write("\t</form>\r\n");
      out.write("\r\n");
      out.write("\t<form name=\"readFrm\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"nowPage\" value=\"");
      out.print(nowPage);
      out.write("\"> \r\n");
      out.write("\t\t<input type=\"hidden\" name=\"numPerPage\" value=\"");
      out.print(numPerPage);
      out.write("\"> \r\n");
      out.write("\t\t");
if(!(keyWord==null||keyWord.equals(""))){
      out.write("\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"keyField\" value=\"");
      out.print(keyField);
      out.write("\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"keyWord\" value=\"");
      out.print(keyWord);
      out.write("\">\r\n");
      out.write("\t\t");
}
      out.write("\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"num\" value=\"");
      out.print(num);
      out.write("\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"lernum\">\r\n");
      out.write("\t\t<input type=\"hidden\" name=\"id\" value=\"");
      out.print(id);
      out.write("\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t</form>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
      out.write("</html>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
