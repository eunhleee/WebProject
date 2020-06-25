package alcinfo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Mypage/teaImgUp")
public class upteaServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		ReportMgr pMgr = new ReportMgr();
		pMgr.insertteapho(request);
		response.sendRedirect("../Mypage/upMembernew.jsp");
	}
}
