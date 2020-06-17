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


@WebServlet("/Community/scUpdate")
public class ScUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String pageValue=request.getParameter("pageValue");
		String nowPage = request.getParameter("nowPage");
		String numPerPage = request.getParameter("numPerPage");
		String keyField = request.getParameter("keyField");	
		String keyWord = request.getParameter("keyWord");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		SCommunityBean bean = (SCommunityBean)session.getAttribute("bean");
		MultipartRequest multi = new MultipartRequest(request, SCommunityMgr.SAVEFOLDER,
				SCommunityMgr.MAXSIZE, SCommunityMgr.ENCTYPE, new DefaultFileRenamePolicy());
		SCommunityMgr mgr = new SCommunityMgr();
		mgr.updatesc(multi);
		if(!(keyWord==null||keyWord.equals(""))) {
			response.sendRedirect("scRead.jsp?num="+bean.getNum()+"&pageValue="+pageValue+
					"&nowPage="+nowPage+"&numPerPage="+numPerPage+"&keyField="+keyField+
					"&keyWord="+keyWord);
		} else
			response.sendRedirect("scRead.jsp?num="+bean.getNum()+"&pageValue="+pageValue+
					"&nowPage="+nowPage+"&numPerPage="+numPerPage);
	}

}
