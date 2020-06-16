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
	public static final String SAVEFOLDER = "C:/Jsp/myapp/WebContent2/fileupload/";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 10*1024*1024;
	
	public CSMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	
	// 고객센터 리스트(관리자모드)
	public Vector<CSBean> getBoardList(String keyField,String keyWord,int start,int cnt, String group){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CSBean> vlist=new Vector<CSBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//占싯삼옙占쏙옙 占싣닌곤옙占�
				sql = "select num, cc_title,cc_id,cc_regdate,cc_count,cc_filename,cc_secret "
						+ " from cs where cc_group=? order by num desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, group);
				pstmt.setInt(2, start); 
				pstmt.setInt(3, cnt);
	
			}
			else {
			//占싯삼옙占쏙옙 占쏙옙占�
			sql = "select num, cc_title,cc_id,cc_regdate,cc_count,cc_filename,cc_secret "
					+ "from cs where "+keyField+" like ? "
					+ "and cc_group=? order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyWord+"%");
			pstmt.setString(2, group);
			pstmt.setInt(3, start); 
			pstmt.setInt(4, cnt);
				 
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				CSBean bean = new CSBean();
				bean.setNum(rs.getInt("num"));
				bean.setCc_title(rs.getString("cc_title"));
				bean.setCc_id(rs.getString("cc_id"));
				bean.setCc_regdate(rs.getString("cc_regdate"));
				bean.setCc_count(rs.getInt("cc_count"));
				bean.setCc_filename(rs.getString("cc_filename"));
				bean.setCc_secret(rs.getString("cc_secret"));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; 
	}
	
	// 고객센터 리스트(회원용)
	public Vector<CSBean> getBoardList1(String keyField,String keyWord,int start,int cnt, String group, String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CSBean> vlist=new Vector<CSBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//占싯삼옙占쏙옙 占싣닌곤옙占�
				sql = "select num, cc_title,cc_id,cc_regdate,cc_count,cc_filename,cc_secret "
						+ " from cs where cc_group=? and cc_secret is null or cc_id=? "
						+ "order by num desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, group);
				pstmt.setString(2, id);
				pstmt.setInt(3, start); 
				pstmt.setInt(4, cnt);
	
			}
			else {
			//占싯삼옙占쏙옙 占쏙옙占�
			sql = "select num, cc_title,cc_id,cc_regdate,cc_count,cc_filename,cc_secret "
					+ "from cs where "+keyField+" like ? and cc_group=? "
					+ "and cc_secret is null or cc_id=? "
					+ "order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyWord+"%");
			pstmt.setString(2, group);
			pstmt.setString(3, id);
			pstmt.setInt(4, start); 
			pstmt.setInt(5, cnt);
				 
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				CSBean bean = new CSBean();
				bean.setNum(rs.getInt("num"));
				bean.setCc_title(rs.getString("cc_title"));
				bean.setCc_id(rs.getString("cc_id"));
				bean.setCc_regdate(rs.getString("cc_regdate"));
				bean.setCc_count(rs.getInt("cc_count"));
				bean.setCc_filename(rs.getString("cc_filename"));
				bean.setCc_secret(rs.getString("cc_secret"));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; 
	}
	
	//Board Total Count:占쏙옙 占쌉시뱄옙 占쏙옙
	//관리자
	public int getTotalCount(String keyField,String keyWord, String group) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount=0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//占싯삼옙占쏙옙 占싣닌곤옙占�
				sql = "select count(*) from cs where cc_group=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, group);
			}
			else {
			//占싯삼옙占쏙옙 占쏙옙占�
			sql = "select count(*) from cs where "
					+keyField+" like ? and cc_group=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyWord+"%");
			pstmt.setString(2, group);
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
	//일반회원
	public int getTotalCount1(String keyField,String keyWord, String group, String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount=0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//占싯삼옙占쏙옙 占싣닌곤옙占�
				sql = "select count(*) from cs where cc_group=? "
						+ "and cc_secret is null or cc_id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, group);
				pstmt.setString(2, id);
			}
			else {
			//占싯삼옙占쏙옙 占쏙옙占�
			sql = "select count(*) from cs where "+keyField+" like ? and cc_group=? "
					+ "and cc_secret is null or cc_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyWord+"%");
			pstmt.setString(2, group);
			pstmt.setString(3, id);
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
	
	public void insertcs(HttpServletRequest req, String group) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			File dir = new File(SAVEFOLDER);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE,
					new DefaultFileRenamePolicy());
			String filename = null;
			int filesize = 0;

			if (multi.getFilesystemName("ccfilename") != null) {
				filename = multi.getFilesystemName("ccfilename");
				filesize = (int) multi.getFile("ccfilename").length();
			}
			con = pool.getConnection();
			sql = "insert cs(cc_title,cc_content,cc_id,cc_regdate,"
					+ "cc_ip,cc_filename,cc_filesize,cc_secret,cc_group) "
					+ "values(?,?,?,now()"
					+ ",?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("cctitle"));
			pstmt.setString(2, multi.getParameter("cccontent"));
			pstmt.setString(3, multi.getParameter("ccid"));
			pstmt.setString(4, multi.getParameter("ccip"));
			pstmt.setString(5, filename);
			pstmt.setInt(6, filesize);
			pstmt.setString(7, multi.getParameter("ccsecret"));
			pstmt.setString(8, group);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public CSBean getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		CSBean bean = new CSBean();
		try {
			con = pool.getConnection();
			sql = "select num, cc_title, cc_content, cc_id, cc_regdate, cc_ip, "
					+ "cc_filename, cc_filesize, cc_count, cc_secret, cc_group " 
					+ "from cs where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setCc_title(rs.getString("cc_title"));
				bean.setCc_content(rs.getString("cc_content"));
				bean.setCc_id(rs.getString("cc_id"));
				bean.setCc_regdate(rs.getString("cc_regdate"));
				bean.setCc_ip(rs.getString("cc_ip"));
				bean.setCc_filename(rs.getString("cc_filename"));
				bean.setCc_filesize(rs.getInt("cc_filesize"));
				bean.setCc_count(rs.getInt("cc_count"));
				bean.setCc_secret(rs.getString("cc_secret"));
				bean.setCc_group(rs.getString("cc_group"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}

	public int ccount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int ccount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from cscomment where ccr_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next())
				ccount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return ccount;
	}

	public void csupCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update cs set cc_count = cc_count +1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public void deletecs(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			CSBean bean = getBoard(num);
			String filename = bean.getCc_filename();
			if (filename != null && !filename.equals("")) {
				File f = new File(SAVEFOLDER + filename);
				if (f.exists()) {
					UtilMgr.delete(SAVEFOLDER + filename);
				}
			}
			con = pool.getConnection();
			sql = "delete from cs where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public void updatecs(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			int num = Integer.parseInt(multi.getParameter("num"));
			String title = multi.getParameter("cctitle");
			String content = multi.getParameter("cccontent");
			String filename = multi.getFilesystemName("ccfilename");
			String secret = multi.getParameter("ccsecret");
			if (filename != null && !filename.equals("")) {
				CSBean bean = getBoard(num);
				String tempfile = bean.getCc_filename();
				if (tempfile != null && !tempfile.equals("")) {
					File f = new File(SAVEFOLDER + tempfile);
					if (f.exists()) {
						UtilMgr.delete(SAVEFOLDER + tempfile);
					}
				}
				int filesize = (int) multi.getFile("ccfilename").length();
				sql = "update cs set cc_title=?, cc_content=?, " 
				+ "cc_filename=?, cc_filesize=?, cc_secret=? where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, title);
				pstmt.setString(2, content);
				pstmt.setString(3, filename);
				pstmt.setInt(4, filesize);
				pstmt.setString(5, secret);
				pstmt.setInt(6, num);
			} else {
				sql = "update cs set cc_title=?, cc_content=?,"
						+ "cc_secret=? where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, title);
				pstmt.setString(2, content);
				pstmt.setString(3, secret);
				pstmt.setInt(4, num);
			}
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public int checkM(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int grade = 1;
		try {
			con = pool.getConnection();
			sql = "select grade from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) grade = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return grade;
	}
	
}
	
	