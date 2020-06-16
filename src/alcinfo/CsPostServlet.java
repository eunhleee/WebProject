package alcinfo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CS/csPost")
public class CsPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		CSMgr mgr = new CSMgr();
		String cust_page=request.getParameter("cust_page");
		String nowPage = request.getParameter("nowPage");
		String numPerPage = request.getParameter("numPerPage");
		String keyField = request.getParameter("keyField");	
		String keyWord = request.getParameter("keyWord");
		
		mgr.insertcs(request,cust_page);
		if(!(keyWord==null||keyWord.equals(""))) {
			response.sendRedirect("custCenter.jsp?cust_page="+cust_page+"&nowPage="+
					nowPage+"&numPerPage="+numPerPage+"&keyField="+keyField+
					"&keyWord="+keyWord);
		} else
			response.sendRedirect("custCenter.jsp?cust_page="+cust_page+"&nowPage="+
					nowPage+"&numPerPage="+numPerPage);
		
	}

}
