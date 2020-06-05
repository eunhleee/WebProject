package alcinfo;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class CSMgr {
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/WebContent/board/fileupload/";
	public static final String ENCTYPE = "EUC-KR";
	public static int MAXSIZE = 10*1024*1024;
	
	public CSMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	
	public Vector<CSBean> getBoardList(String keyField,String keyWord,int start,int cnt){
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CSBean> vlist=new Vector<CSBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//�˻��� �ƴѰ��
				sql = "select num, cc_title,cc_id,cc_regdate,cc_count "
						+ " from cs  order by cc_count desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start); 
				pstmt.setInt(2, cnt);
	
			}
			else {
			//�˻��� ���
			sql = "select num, cc_title,cc_id,cc_regdate,cc_count from cs where "+keyField+" like ? "
				+ "limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyWord+"%");
			pstmt.setInt(2, start); 
			pstmt.setInt(3, cnt);
				 
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				CSBean bean = new CSBean();
				bean.setNum(rs.getInt("num"));
				bean.setCc_title(rs.getString("cc_title"));
				bean.setCc_id(rs.getString("cc_id"));
				bean.setCc_regdate(rs.getString("cc_regdate"));
				bean.setCc_count(rs.getInt("cc_count"));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; 
	}
	
	//Board Total Count:�� �Խù� ��
		public int getTotalCount(String keyField,String keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount=0;
			try {
				con = pool.getConnection();
				if(keyWord.trim().equals("")||keyWord==null) {
					//�˻��� �ƴѰ��
					sql = "select count(*) from cs ";
					pstmt = con.prepareStatement(sql);
				}
				else {
				//�˻��� ���
				sql = "select count(*) from cs where "
						+keyField+" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				}
				rs = pstmt.executeQuery();
				while(rs.next()) {
					totalCount=rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
	
		
}
	
	