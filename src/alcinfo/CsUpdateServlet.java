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

@WebServlet("/csUpdate")
public class CsUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String cust_page=request.getParameter("cust_page");
		String nowPage = request.getParameter("nowPage");
		String numPerPage = request.getParameter("numPerPage");
		String keyField = request.getParameter("keyField");	
		String keyWord = request.getParameter("keyWord");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		CSBean bean = (CSBean)session.getAttribute("bean");
		MultipartRequest multi = new MultipartRequest(request, SCommunityMgr.SAVEFOLDER,
				SCommunityMgr.MAXSIZE, SCommunityMgr.ENCTYPE, new DefaultFileRenamePolicy());
		CSMgr mgr = new CSMgr();
		mgr.updatecs(multi);
		if(!(keyWord==null||keyWord.equals(""))) {
			response.sendRedirect("cs_Read.jsp?num="+bean.getNum()+"&cust_page="+cust_page+
					"&nowPage="+nowPage+"&numPerPage="+numPerPage+"&keyField="+keyField+
					"&keyWord="+keyWord);
		} else
			response.sendRedirect("cs_Read.jsp?num="+bean.getNum()+"&cust_page="+cust_page+
					"&nowPage="+nowPage+"&numPerPage="+numPerPage);
	}

}
