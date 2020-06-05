package alcinfo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


@WebServlet("/alcinfo/scUpdate")
public class ScUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String pageValue=request.getParameter("pageValue");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		SCommunityBean bean = (SCommunityBean)session.getAttribute("bean");
		MultipartRequest multi = new MultipartRequest(request, SCommunityMgr.SAVEFOLDER,
				SCommunityMgr.MAXSIZE, SCommunityMgr.ENCTYPE, new DefaultFileRenamePolicy());
		SCommunityMgr mgr = new SCommunityMgr();
		mgr.updatesc(multi);
		String nowPage = multi.getParameter("nowPage");
		String numPerPage = multi.getParameter("numPerPage");
		response.sendRedirect("../alcinfo/scRead.jsp?nowPage=" + nowPage + "&num=" + bean.getNum()
				+ "&numPerPage=" + numPerPage+"&pageValue="+pageValue);
	}

}
