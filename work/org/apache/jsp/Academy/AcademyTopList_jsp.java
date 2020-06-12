/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.33
 * Generated at: 2020-06-12 03:19:34 UTC
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

public final class AcademyTopList_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      response.setContentType("text/html; charset=utf-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("<!-- 학원 정보 중 평점과 조회순으로 6개씩만 읽어오게 하는 창 -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      alcinfo.AcademyMgr Amgr = null;
      Amgr = (alcinfo.AcademyMgr) _jspx_page_context.getAttribute("Amgr", javax.servlet.jsp.PageContext.PAGE_SCOPE);
      if (Amgr == null){
        Amgr = new alcinfo.AcademyMgr();
        _jspx_page_context.setAttribute("Amgr", Amgr, javax.servlet.jsp.PageContext.PAGE_SCOPE);
      }
      out.write("\r\n");
      out.write("\r\n");

	request.setCharacterEncoding("utf-8");
	String sort = request.getParameter("sort");
	

      out.write("\r\n");
      out.write("\r\n");
      out.write("<section class=\"gallery-block cards-gallery\">\r\n");
      out.write("\t<div class=\"container\">\r\n");
      out.write("\t\t<div class=\"heading\">\r\n");
      out.write("\t\t\t<h2>평점 TOP6</h2>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<br>\r\n");
      out.write("\t\t<div class=\"row\">\r\n");
      out.write("\t\t\t");

				Vector<AcademyBean> Avlist = Amgr.getBestBoard("top", sort);
				//int listsize=vlist.size();
				for (int i = 0; i < 6; i++) {
					AcademyBean Abean = Avlist.get(i);
					//imgname, ac_name,group2, ac_tel,star,count
					int num = Abean.getNum();
					String img = Abean.getImgname();
					String name = Abean.getAc_name();
					String group2 = Abean.getGroup2();
					String tel = Abean.getAc_tel();
					float star = Abean.getStar();
					int count = Abean.getCount();
					if (tel.equals(""))
						tel = "번호 정보가 없습니다.";
			
      out.write("\r\n");
      out.write("\t\t\t<div class=\"col-md-6 col-lg-4\">\r\n");
      out.write("\t\t\t\t<div class=\"card border-0 transform-on-hover\">\r\n");
      out.write("\t\t\t\t\t<a class=\"lightbox\" href=\"../Academy/acRead.jsp?num=");
      out.print(num);
      out.write("\"> <img\r\n");
      out.write("\t\t\t\t\t\tsrc=\"../img/no_image.jpg\" alt=\"Card Image\" class=\"card-img-top\">\r\n");
      out.write("\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t<div class=\"card-body\">\r\n");
      out.write("\t\t\t\t\t\t<h6>\r\n");
      out.write("\t\t\t\t\t\t\t<a href=\"../Academy/acRead.jsp?num=");
      out.print(num);
      out.write('"');
      out.write('>');
      out.print(name);
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t</h6>\r\n");
      out.write("\t\t\t\t\t\t<p class=\"text-muted card-text\">");
      out.print(group2);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t");
      out.print(tel);
      out.write("</p>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t<div align=\"right\" style=\"margin-right: 20px;\">\r\n");
      out.write("\t\t\t\t\t\t<img src=\"../img/star.png\" width=\"15\" height=\"15\">");
      out.print(star);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t(");
      out.print(count);
      out.write(")\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t");

				}
			
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<br>\r\n");
      out.write("\t<hr>\r\n");
      out.write("\t<br>\r\n");
      out.write("\t<div class=\"container\">\r\n");
      out.write("\t\t<div class=\"heading\">\r\n");
      out.write("\t\t\t<h2>조회수 TOP6</h2>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<br>\r\n");
      out.write("\t\t<div class=\"row\">\r\n");
      out.write("\t\t\t");

				Avlist = Amgr.getCountBoard();
				//int listsize=vlist.size();
				for (int i = 0; i < 6; i++) {
					AcademyBean Abean = Avlist.get(i);
					//imgname, ac_name,group2, ac_tel,star,count
					int num = Abean.getNum();
					String img = Abean.getImgname();
					String name = Abean.getAc_name();
					String group2 = Abean.getGroup2();
					String tel = Abean.getAc_tel();
					float star = Abean.getStar();
					int count = Abean.getCount();
					if (tel.equals(""))
						tel = "번호 정보가 없습니다.";
			
      out.write("\r\n");
      out.write("\t\t\t<div class=\"col-md-6 col-lg-4\">\r\n");
      out.write("\t\t\t\t<div class=\"card border-0 transform-on-hover\">\r\n");
      out.write("\t\t\t\t\t<a class=\"lightbox\" href=\"../Academy/acRead.jsp?num=");
      out.print(num);
      out.write("\"> <img src=\"../img/no_image.jpg\"\r\n");
      out.write("\t\t\t\t\t\talt=\"Card Image\" class=\"card-img-top\">\r\n");
      out.write("\t\t\t\t\t</a>\r\n");
      out.write("\t\t\t\t\t<div class=\"card-body\">\r\n");
      out.write("\t\t\t\t\t\t<h6>\r\n");
      out.write("\t\t\t\t\t\t\t<a href=\"../Academy/acRead.jsp?num=");
      out.print(num);
      out.write('"');
      out.write('>');
      out.print(name);
      out.write("</a>\r\n");
      out.write("\t\t\t\t\t\t</h6>\r\n");
      out.write("\t\t\t\t\t\t<p class=\"text-muted card-text\">");
      out.print(group2);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t<br>\r\n");
      out.write("\t\t\t\t\t\t\t");
      out.print(tel);
      out.write("</p>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t\t<div align=\"right\" style=\"margin-right: 20px;\">\r\n");
      out.write("\t\t\t\t\t\t<img src=\"../img/star.png\" width=\"15\" height=\"15\">");
      out.print(star);
      out.write("\r\n");
      out.write("\t\t\t\t\t\t(");
      out.print(count);
      out.write(")\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</div>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t\t");

				}
			
      out.write("\r\n");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("</section>");
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
