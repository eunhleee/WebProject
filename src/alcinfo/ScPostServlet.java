package alcinfo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Community/scPost")
public class ScPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		SCommunityMgr mgr = new SCommunityMgr();
		String pageValue=request.getParameter("pageValue");
		String nowPage = request.getParameter("nowPage");
		String numPerPage = request.getParameter("numPerPage");
		String keyField = request.getParameter("keyField");	
		String keyWord = request.getParameter("keyWord");
		
		mgr.insertsc(request,pageValue);
		if(!(keyWord==null||keyWord.equals(""))) {
			response.sendRedirect("communityList.jsp?pageValue="+pageValue+"&nowPage="+
					nowPage+"&numPerPage="+numPerPage+"&keyField="+keyField+
					"&keyWord="+keyWord);
		} else
			response.sendRedirect("communityList.jsp?pageValue="+pageValue+"&nowPage="+
					nowPage+"&numPerPage="+numPerPage);
		
	}

}
