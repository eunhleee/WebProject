/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/9.0.33
 * Generated at: 2020-06-12 03:19:36 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.Academy;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class mapJsp_jsp extends org.apache.jasper.runtime.HttpJspBase
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
    _jspx_imports_classes = null;
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

      out.write("<!-- 지도 출력 창 -->\r\n");
      out.write("\r\n");
      out.write("\r\n");

		request.setCharacterEncoding("euc-kr");	
		String address=request.getParameter("address");
		

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<body>\r\n");
      out.write("\t<p style=\"margin-top: 3px\">\r\n");
      out.write("\t\t<em class=\"link\"> <a href=\"javascript:void(0);\"\r\n");
      out.write("\t\t\tonclick=\"window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')\">\r\n");
      out.write("\t\t\t\t혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요. </a>\r\n");
      out.write("\t\t</em>\r\n");
      out.write("\t</p>\r\n");
      out.write("\t<div id=\"map\" style=\"width: 400px; height: 400px;\"></div>\r\n");
      out.write("\r\n");
      out.write("\t<script type=\"text/javascript\"\r\n");
      out.write("\t\tsrc=\"//dapi.kakao.com/v2/maps/sdk.js?appkey=79e30f46c54cd357a1c1d9d9fa64f2b6&libraries=services\"></script>\r\n");
      out.write("\t<script>\r\n");
      out.write("var mapContainer = document.getElementById('map'), // 지도를 표시할 div \r\n");
      out.write("    mapOption = {\r\n");
      out.write("        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표\r\n");
      out.write("        level: 3 // 지도의 확대 레벨\r\n");
      out.write("    };  \r\n");
      out.write(" \r\n");
      out.write("// 지도를 생성합니다    \r\n");
      out.write("var map = new kakao.maps.Map(mapContainer, mapOption); \r\n");
      out.write("\r\n");
      out.write("// 주소-좌표 변환 객체를 생성합니다\r\n");
      out.write("var geocoder = new kakao.maps.services.Geocoder();\r\n");
      out.write("\r\n");
      out.write("// 주소로 좌표를 검색합니다\r\n");
      out.write("geocoder.addressSearch(");
      out.print("'"+address+"'");
      out.write("\r\n");
      out.write("\t\t,\r\n");
      out.write("\t\t\t\t\t\tfunction(result, status) {\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t// 정상적으로 검색이 완료됐으면 \r\n");
      out.write("\t\t\t\t\t\t\tif (status === kakao.maps.services.Status.OK) {\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\tvar coords = new kakao.maps.LatLng(result[0].y,\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\tresult[0].x);\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t// 결과값으로 받은 위치를 마커로 표시합니다\r\n");
      out.write("\t\t\t\t\t\t\t\tvar marker = new kakao.maps.Marker({\r\n");
      out.write("\t\t\t\t\t\t\t\t\tmap : map,\r\n");
      out.write("\t\t\t\t\t\t\t\t\tposition : coords\r\n");
      out.write("\t\t\t\t\t\t\t\t});\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t// 인포윈도우로 장소에 대한 설명을 표시합니다\r\n");
      out.write("\t\t\t\t\t\t\t\tvar infowindow = new kakao.maps.InfoWindow(\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t{\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\tcontent : '<div style=\"width:150px;text-align:center;padding:6px 0;\">위치</div>'\r\n");
      out.write("\t\t\t\t\t\t\t\t\t\t});\r\n");
      out.write("\t\t\t\t\t\t\t\tinfowindow.open(map, marker);\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t\t\t\t\t// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다\r\n");
      out.write("\t\t\t\t\t\t\t\tmap.setCenter(coords);\r\n");
      out.write("\t\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\t});\r\n");
      out.write("\t</script>\r\n");
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