/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.33
 * Generated at: 2020-06-12 03:19:33 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.Academy;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import alcinfo.AcademyBean;
import java.util.Vector;

public final class AcademyMain_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes.add("alcinfo.AcademyBean");
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

      out.write("<!-- 학원 메인 창 -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      alcinfo.AcademyMgr Amgr = null;
      Amgr = (alcinfo.AcademyMgr) _jspx_page_context.getAttribute("Amgr", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (Amgr == null){
        Amgr = new alcinfo.AcademyMgr();
        _jspx_page_context.setAttribute("Amgr", Amgr, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\r');
      out.write('\n');
      alcinfo.LessonMgr Lmgr = null;
      Lmgr = (alcinfo.LessonMgr) _jspx_page_context.getAttribute("Lmgr", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (Lmgr == null){
        Lmgr = new alcinfo.LessonMgr();
        _jspx_page_context.setAttribute("Lmgr", Lmgr, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write('\r');
      out.write('\n');

	String pageValue = request.getParameter("pageValue");
	

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"utf-8\">\r\n");
      out.write("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n");
      out.write("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n");
      out.write("<title>우리학원 어디?-학원</title>\r\n");
      out.write("<link rel=\"stylesheet\"\r\n");
      out.write("\thref=\"https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css\">\r\n");
      out.write("<link rel=\"stylesheet\"\r\n");
      out.write("\thref=\"https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.css\" />\r\n");
      out.write("<link rel=\"stylesheet\" href=\"../alcinfo/cards-gallery.css\">\r\n");
      out.write("<style>\r\n");
      out.write("#total {\r\n");
      out.write("\twidth: 100%;\r\n");
      out.write("\tbackground-color: #FAF8EB;\r\n");
      out.write("\tmargin-bottom: 50px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("#table {\r\n");
      out.write("\twidth: 70%;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("#table td {\r\n");
      out.write("\ttext-align: center;\r\n");
      out.write("\twidth: 150px;\r\n");
      out.write("\theight: 100px;\r\n");
      out.write("\tbackground-color: #FAF8EB;\r\n");
      out.write("\tborder: none;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("td a {\r\n");
      out.write("\tcolor: black;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("td a:hover {\r\n");
      out.write("\tcolor: white;\r\n");
      out.write("\tfont-weight: bold;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("#td:hover {\r\n");
      out.write("\tbackground-color: #FCBC7E;\r\n");
      out.write("}\r\n");
      out.write("</style>\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../alcinfo/mainHeader.jsp", out, false);
      out.write("\r\n");
      out.write("\t<div id=\"total\" align=\"center\">\r\n");
      out.write("\t\t<table id=\"table\">\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=top\">TOP6</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=예능\">예능</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=외국어\">외국어</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=국제\">국제</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=보통교과\">보통 교과</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=종합\">종합</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=인문사회\">인문 사회</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=컴퓨터\">컴퓨터</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=간호보조기술\">간호\r\n");
      out.write("\t\t\t\t\t\t보조 기술</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=특수교육\">특수 교육</a></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=문화관광\">문화 관광</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=경영.사무관리\">경영/사무관리</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=기예\">기예</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=기타\">기타</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=산업응용기술\">산업\r\n");
      out.write("\t\t\t\t\t\t응용 기술</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=산업기반기술\">산업\r\n");
      out.write("\t\t\t\t\t\t기반 기술</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=산업서비스\">산업\r\n");
      out.write("\t\t\t\t\t\t서비스</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=일반서비스\">일반\r\n");
      out.write("\t\t\t\t\t\t서비스</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=진학지도\">진학지도</a></td>\r\n");
      out.write("\t\t\t\t<td id=\"td\"><a href=\"AcademyMain.jsp?pageValue=독서실\">독서실</a></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t");

		if (pageValue.equals("top")) {
		
	
      out.write('\r');
      out.write('\n');
      out.write('	');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "AcademyTopList.jsp", out, false);
      out.write('\r');
      out.write('\n');
      out.write('	');

		} else {
	
      out.write('\r');
      out.write('\n');
      out.write('	');
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "AcademyList.jsp?pageValue=<%=pageValue%>", out, false);
      out.write('\r');
      out.write('\n');
      out.write('	');

		}
	
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t<script\r\n");
      out.write("\t\tsrc=\"https://cdnjs.cloudflare.com/ajax/libs/baguettebox.js/1.10.0/baguetteBox.min.js\"></script>\r\n");
      out.write("\t<script>\r\n");
      out.write("\t\tbaguetteBox.run('.cards-gallery', {\r\n");
      out.write("\t\t\tanimation : 'slideIn'\r\n");
      out.write("\t\t});\r\n");
      out.write("\t</script>\r\n");
      out.write("\t");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "../alcinfo/footer.jsp", out, false);
      out.write("\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
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
