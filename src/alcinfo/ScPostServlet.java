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
		
		mgr.insertsc(request,pageValue);
		
		response.sendRedirect("communityList.jsp?pageValue="+pageValue);
	}

}
