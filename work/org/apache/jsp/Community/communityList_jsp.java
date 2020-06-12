/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.33
 * Generated at: 2020-06-12 05:20:26 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.Community;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import alcinfo.UtilMgr;
import alcinfo.SCommunityBean;
import java.util.Vector;

public final class communityList_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes.add("java.util.Vector");
    _jspx_imports_classes.add("alcinfo.UtilMgr");
    _jspx_imports_classes.add("alcinfo.SCommunityBean");
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

      out.write("<!-- 커뮤니티의 리스트 출력 -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      alcinfo.SCommunityMgr mgr = null;
      mgr = (alcinfo.SCommunityMgr) _jspx_page_context.getAttribute("mgr", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (mgr == null){
        mgr = new alcinfo.SCommunityMgr();
        _jspx_page_context.setAttribute("mgr", mgr, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\r');
      out.write('\n');

		request.setCharacterEncoding("UTF-8");
		String id=(String )session.getAttribute("idKey");
		String category="",group="";
		
		if(request.getParameter("pageValue").equals("free")){
			category="자유게시판";
			group="free";
		}
		else if(request.getParameter("pageValue").equals("academy")){
			category="학원 Q&A";
			group="academy";
		}
		else if(request.getParameter("pageValue").equals("lesson")){
			category="과외 Q&A";
			group="lesson";
		}
//검색에 필요한 변수
		
		int totalRecord = 0;//총게시물수
		int numPerPage = 10;//페이지당 레코드 개수(5,10,15,30)
		int pagePerBlock = 15;//블럭당 페이지 개수
		int totalPage = 0;//총 페이지 개수
		int totalBlock = 0;//총 블럭 개수
		int nowPage = 1;//현재 페이지
		int nowBlock = 1;//현재 블럭
		
		
		
		//요청된 numPerPage 처리
		//요청이 있으면 처리가 되지만 그렇지 않으면 기본 10개 세팅이 된다.
		if(request.getParameter("numPerPage")!=null){
			numPerPage=UtilMgr.parseInt(request,"numPerPage");
		}
		
		//검색에 필요한 변수
		String keyField="",keyWord="";
		//검색일때
		if(request.getParameter("keyWord")!=null){
			keyField=request.getParameter("keyField");
			keyWord=request.getParameter("keyWord");}
		//검색 후에 다시 처음화면 요청
		if(request.getParameter("reload")!=null&&
		request.getParameter("reload").equals("true")){
			keyField ="";keyWord="";
		}
		
		
		totalRecord = mgr.getTotalCount(keyField, keyWord,group);
		//out.print("totalRecord : " + totalRecord);
		
		//nowPage 요청 처리
		if(request.getParameter("nowPage")!=null){
			nowPage = UtilMgr.parseInt(request, "nowPage");
		}
		
		//sql문에 들어가는 start, cnt 선언
		int start = (nowPage*numPerPage)-numPerPage;
		int cnt = numPerPage;
		
		//전체페이지 개수
		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
		//전체블럭 개수
		 totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
		//현재블럭
		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
		

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("<title>우리학원 어디?-커뮤니티</title>\r\n");
      out.write("<script>\r\n");
      out.write("function sccheck() {\r\n");
      out.write("\tif(document.scsearchFrm.keyWord.value==\"\"){\r\n");
      out.write("\t\talert(\"검색어를 입력하세요.\");\r\n");
      out.write("\t\tdocument.scsearchFrm.keyWord.focus();\r\n");
      out.write("\t\treturn;\r\n");
      out.write("\t}\r\n");
      out.write("\tdocument.scsearchFrm.submit();\r\n");
      out.write("}\r\n");
      out.write("function pageing(page) {\r\n");
      out.write("\tdocument.readFrm.nowPage.value = page;\r\n");
      out.write("\tdocument.readFrm.submit();\r\n");
      out.write("}\r\n");
      out.write("function block(block) {\r\n");
      out.write("\tdocument.readFrm.nowPage.value = \r\n");
      out.write("\t\t");
      out.print(pagePerBlock);
      out.write("*(block-1)+1;\r\n");
      out.write("\tdocument.readFrm.submit();\r\n");
      out.write("}\r\n");
      out.write("function list(){//[처음으로]를 누르면 게시글의 처음 페이지로 돌아감\r\n");
      out.write("\tdocument.listFrm.action=\"communityList.jsp?pageValue=");
      out.print(group);
      out.write("\";\r\n");
      out.write("\tdocument.listFrm.submit();\r\n");
      out.write("}\r\n");
      out.write("function numPerFn(numPerPage){\r\n");
      out.write("\tdocument.readFrm.numPerPage.value=numPerPage;\r\n");
      out.write("\tdocument.readFrm.submit();\r\n");
      out.write("}\r\n");
      out.write("//list.jsp에서 read.jsp로 요청이 될때 기존에 조건\r\n");
      out.write("//기존 조건 : keyField,keyWord,nowPage,numPerPage\r\n");
      out.write("\r\n");
      out.write("function clalert() {\r\n");
      out.write("\talert(\"로그인 후 이용가능 합니다.\");\r\n");
      out.write("\tlocation.href=\"communityList.jsp?pageValue=");
      out.print(group);
      out.write("\";\r\n");
      out.write("}\r\n");
      out.write("function read(num){\r\n");
      out.write("\tdocument.readFrm.num.value=num;\r\n");
      out.write("\tdocument.readFrm.action=\"scRead.jsp?pageValue=");
      out.print(group);
      out.write("\";\r\n");
      out.write("\tdocument.readFrm.submit();\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write(" <style>\r\n");
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
      out.write("</style> \r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t\r\n");
      out.write("\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../alcinfo/headerSearch.jsp", out, false);
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<div style=\"display: flex; margin-left: 15%; margin-right: 15%\">\r\n");
      out.write("\r\n");
      out.write("\t\t<div\r\n");
      out.write("\t\t\tstyle=\"width: 50px; text-align: left; flex: 1; border: 1px solid black; margin-right: 10%; padding: 40px 40px;\">\r\n");
      out.write("\t\t\t<h3>커뮤니티</h3>\r\n");
      out.write("\t\t\t<a href=\"communityList.jsp?pageValue=free\">&#149; 자유게시판</a><br>\r\n");
      out.write("\t\t\t<a href=\"communityList.jsp?pageValue=academy\">&#149; 학원 Q&A</a><br>\r\n");
      out.write("\t\t\t<a href=\"communityList.jsp?pageValue=lesson\">&#149; 과외 Q&A</a><br>\r\n");
      out.write("\t\t\t<br>\r\n");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\r\n");
      out.write("\t\t<!-- 리스트 부분 -->\r\n");
      out.write("\t\t<div\r\n");
      out.write("\t\t\tstyle=\"width: 800px; flex: 2; border: 1px solid black; padding: 20px 20px;\">\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t<h2>");
      out.print(category );
      out.write("</h2>\r\n");
      out.write("\t\t\t<table>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td width=\"600\">Total : ");
      out.print(totalRecord);
      out.write("Articles(<font\r\n");
      out.write("\t\t\t\t\t\tcolor=\"red\"> ");
      out.print(nowPage+"/"+totalPage);
      out.write("Pages\r\n");
      out.write("\t\t\t\t\t</font>)\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t<td align=\"right\">\r\n");
      out.write("\t\t\t\t\t\t<form name=\"npFrm\" method=\"post\">\r\n");
      out.write("\t\t\t\t\t\t\t<select name=\"numPerPage\" size=\"1\"\r\n");
      out.write("\t\t\t\t\t\t\t\tonchange=\"numPerFn(this.form.numPerPage.value)\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"5\">5개 보기</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"10\" selected>10개 보기</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"15\">15개 보기</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"30\">30개 보기</option>\r\n");
      out.write("\t\t\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t\t</form> <script>\r\n");
      out.write("   \t\t\tdocument.npFrm.numPerPage.value=");
      out.print(numPerPage);
      out.write("\r\n");
      out.write("   \t\t\t\r\n");
      out.write("   \t\t\t</script>\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t\t<table class=\"table table-hover\">\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td align=\"center\" colspan=\"2\">\r\n");
      out.write("\t\t\t\t\t\t<table cellspacing=\"0\" height=\"80\">\r\n");
      out.write("\t\t\t\t\t\t\t<tr align=\"center\" id=\"title\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<td width=\"100\">번 호</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td width=\"280\">제 목</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td width=\"100\">닉네임</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td width=\"150\">날 짜</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td width=\"100\">조회수</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t");

						Vector<SCommunityBean> vlist = mgr.getBoardList(keyField, keyWord,group, start, cnt);
						int listsize = vlist.size();
						if (vlist.isEmpty()) {
					
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td align=\"center\" colspan=\"5\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");

								out.println("등록된 게시물이 없습니다.");
							
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t");

						} else {
							for (int i = 0; i <numPerPage; i++) {
								if(i==listsize) break;
								SCommunityBean bean = vlist.get(i);
								int num = bean.getNum();
								String title = bean.getSc_title();
								String nickname = bean.getSc_nick();
								String date = bean.getSc_regdate();
								String filename=bean.getSc_filename();
								int ccount=mgr.ccount(num);
								int count = bean.getSc_count();
					
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<tr id=\"list\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<td align=\"center\">");
      out.print(totalRecord-start-i);
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td align=\"center\"><a href=\"javascript:read('");
      out.print(num);
      out.write("')\">");
      out.print(title);
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
 if(filename!=null) { 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<img src=\"../img/icon_file1.png\">\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
 } 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
 if(ccount>0) { 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<font color=\"red\">[");
      out.print(ccount);
      out.write("]</font>\r\n");
      out.write("\t\t\t\t\t\t\t\t\t");
 } 
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td align=\"center\"><a href=\"\">");
      out.print(nickname);
      out.write("</a></td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td align=\"center\">");
      out.print(date);
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t\t\t\t<td align=\"center\">");
      out.print(count);
      out.write("</td>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t</tr>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t");

						}
						}
					
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t</table>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td colspan=\"2\"><br> <br></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t\t<!-- 페이징 및 블럭 Start --> \r\n");
      out.write("\t\t\t\t\t\t");
if(totalPage>0){
      out.write(" <!-- 이전 블럭 -->\r\n");
      out.write("\t\t\t\t\t\t ");
if(nowBlock>1){ 
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<a href=\"javascript:block('");
      out.print(nowBlock-1);
      out.write("')\">이전</a> \r\n");
      out.write("\t\t\t\t\t\t");
} 
      out.write(" <!-- 페이징 -->\r\n");
      out.write("\t\t\t\t\t\t");

					int pageStart = (nowBlock-1)*pagePerBlock+1;
					int pageEnd = (pageStart+pagePerBlock)<totalPage?
						pageStart+pagePerBlock:totalPage+1;
					for(;pageStart<pageEnd;pageStart++){
						
      out.write(" \r\n");
      out.write("\t\t\t\t\t\t<a href=\"javascript:pageing('");
      out.print(pageStart);
      out.write("')\"> \r\n");
      out.write("\t\t\t\t\t\t");
if(nowPage==pageStart){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<font color=\"gray\">\r\n");
      out.write("\t\t\t\t\t\t\t\t");
}
      out.write(' ');
      out.write('[');
      out.print(pageStart);
      out.write("]\r\n");
      out.write("\t\t\t\t\t\t ");
if(nowPage==pageStart){
      out.write("\r\n");
      out.write("\t\t\t\t\t\t</font>\r\n");
      out.write("\t\t\t\t\t\t\t");
}
      out.write("\r\n");
      out.write("\t\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t\t ");
}//---for
      out.write(" <!-- 다음 블럭 -->\r\n");
      out.write("\t\t\t\t\t\t  ");
if(totalBlock>nowBlock){ 
      out.write(" \r\n");
      out.write("\t\t\t\t\t\t  <a href=\"javascript:block('");
      out.print(nowBlock+1);
      out.write("')\">다음</a> ");
} 
      out.write(' ');
}//---if1
      out.write("\r\n");
      out.write("\t\t\t\t\t\t<!-- 페이징 및 블럭 End -->\r\n");
      out.write("\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t<td align=\"right\"><a \r\n");
      out.write("\t\t\t\t\t");
if(id==null){ 
      out.write("\r\n");
      out.write("\t\t\t\t\t\tonclick=\"clalert();\" href=\"\"\r\n");
      out.write("\t\t\t\t\t\t");
}else{ 
      out.write("\r\n");
      out.write("\t\t\t\t\t\thref=\"scPost.jsp?pageValue=");
      out.print(group );
      out.write("\" class=\"btn btn-default\"\r\n");
      out.write("\t\t\t\t\t\t");
} 
      out.write(">[글쓰기]</a> \r\n");
      out.write("\t\t\t\t\t\t<a href=\"javascript:list()\">[처음으로]</a></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t\t<hr width=\"750\">\r\n");
      out.write("\t\t\t<form name=\"scsearchFrm\" >\r\n");
      out.write("\t\t\t\t<table width=\"600\" cellpadding=\"4\" cellspacing=\"0\">\r\n");
      out.write("\t\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t\t<td align=\"center\" valign=\"bottom\">\r\n");
      out.write("\t\t\t\t\t\t\t<select name=\"keyField\" size=\"1\">\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"sc_title\">제 목</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"sc_content\">내 용</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t<option value=\"sc_nick\">닉 네 임</option>\r\n");
      out.write("\t\t\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t\t\t<input size=\"16\" name=\"keyWord\">\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"submit\" value=\"찾기\" onClick=\"javascript:sccheck()\"> \r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"hidden\" name=\"nowPage\" value=\"1\">\r\n");
      out.write("\t\t\t\t\t\t\t<input type=\"hidden\" name=\"pageValue\" value=\"");
      out.print(group);
      out.write("\">\r\n");
      out.write("\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t</table>\r\n");
      out.write("\t\t\t</form>\r\n");
      out.write("\t\t\t<form name=\"listFrm\" method=\"post\">\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"reload\" value=\"true\">\r\n");
      out.write("\t\t\t\t<!-- 요게 중요 -->\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"nowPage\" value=\"1\">\r\n");
      out.write("\t\t\t</form>\r\n");
      out.write("\r\n");
      out.write("\t\t\t<form name=\"readFrm\">\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"nowPage\" value=\"");
      out.print(nowPage);
      out.write("\"> \r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"numPerPage\" value=\"");
      out.print(numPerPage);
      out.write("\">\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"keyField\" value=\"");
      out.print(keyField);
      out.write("\"> \r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"keyWord\" value=\"");
      out.print(keyWord);
      out.write("\">\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"pageValue\" value=\"");
      out.print(group);
      out.write("\">\r\n");
      out.write("\t\t\t\t<input type=\"hidden\" name=\"num\">\r\n");
      out.write("\t\t\t</form>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../alcinfo/footer.jsp", out, false);
      out.write("\r\n");
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("\r\n");
      out.write("</html>\r\n");
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