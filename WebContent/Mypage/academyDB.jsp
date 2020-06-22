<!-- academyDB -->
<%@page import="alcinfo.*,java.sql.*,java.util.*,java.io.*" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="aMgr" scope="page" class="alcinfo.AcademyMgr"/>
    <%@page import="alcinfo.AcademyBean"%>

 <%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
	request.setCharacterEncoding("UTF-8");
	String id=request.getParameter("user_name");
	
	ArrayList resArr=new ArrayList();
	
		resArr=aMgr.geAcInfo(id);
	
	out.println("{");
	out.println("\"datas\":[");
	if(resArr.size()==0){
		out.println("]");
		out.println("}");
		}
	else{
		out.print("{ ");
		out.print("\"NUM\":\""+(int)resArr.get(0)+"\", ");
		out.print("\"NAME\":\""+(String)resArr.get(1)+"\", ");
		out.print("\"ADDRESS\":\""+(String)resArr.get(2)+"\", ");

		out.print("} ");
		
		for(int i=3;i<resArr.size();i+=3){
			out.print(", ");
			out.print("{ ");
			out.print("\"NUM\":\""+(int)resArr.get(i)+"\", ");
			out.print("\"NAME\":\""+(String)resArr.get(i+1)+"\", ");
			out.print("\"ADDRESS\":\""+(String)resArr.get(i+2)+"\", ");

			out.print("} ");
		}
		
		out.println("]");
		out.println("}");
			}
%>