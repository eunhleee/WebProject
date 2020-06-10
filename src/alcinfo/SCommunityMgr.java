package alcinfo;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class SCommunityMgr {

	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/myapp/WebContent/board/fileupload/";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 10 * 1024 * 1024;

	public SCommunityMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	public Vector<SCommunityBean> getList() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<SCommunityBean> vlist = new Vector<SCommunityBean>();
		try {
			con = pool.getConnection();
			sql = "select num, sc_title,sc_nick,sc_regdate,sc_count " + " from scommunity  order by sc_regdate desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				SCommunityBean bean = new SCommunityBean();
				bean.setNum(rs.getInt("num"));
				bean.setSc_title(rs.getString("sc_title"));
				bean.setSc_nick(rs.getString("sc_nick"));
				bean.setSc_regdate(rs.getString("sc_regdate"));
				bean.setSc_count(rs.getInt("sc_count"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public void insertBoard(HttpServletRequest req) {
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
			if (multi.getFilesystemName("filename") != null) {
				filename = multi.getFilesystemName("filename");
				filesize = (int) multi.getFile("filename").length();
			}

			String content = multi.getParameter("content");
			String contentType = multi.getParameter("contentType");
			if (contentType.equals("TEXT")) {
				UtilMgr.replace(content, "<", "&lt;");
			}

			int ref = getMaxNum() + 1;
			con = pool.getConnection();
			sql = "insert tblBoard(name,content,subject,ref,pos,depth,";
			sql += "regdate,pass,count,ip,filename,filesize)";
			sql += "values(?, ?, ?, ?, 0, 0, now(), ?, 0, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("name"));
			pstmt.setString(2, content);
			pstmt.setString(3, multi.getParameter("subject"));
			pstmt.setInt(4, ref);
			pstmt.setString(5, multi.getParameter("pass"));
			pstmt.setString(6, multi.getParameter("ip"));
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int maxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(num) from tblBoard";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if (rs.next())
				maxNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return maxNum;
	}

	public int getTotalCount(String keyField, String keyWord, String group) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keyWord.trim().equals("") || keyWord == null) {

				sql = "select count(*) from scommunity where sc_group=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, group);
			} else {

				sql = "select count(*) from scommunity where " + keyField + " like ? and sc_group=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setString(2, group);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	public Vector<SCommunityBean> getBoardList(String keyField, String keyWord, String group, int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<SCommunityBean> vlist = new Vector<SCommunityBean>();
		try {
			con = pool.getConnection();
			if (keyWord.trim().equals("") || keyWord == null) {

				sql = "select num,sc_title,sc_nick,sc_regdate,sc_count,sc_filename from Scommunity where sc_group=? order by num desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, group);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);

			} else {

				sql = "select num,sc_title,sc_nick,sc_regdate,sc_count,sc_filename from Scommunity where " + keyField
						+ " like ? and " + "sc_group=? order by num desc " + "limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setString(2, group);
				pstmt.setInt(3, start);
				pstmt.setInt(4, cnt);

			}

			rs = pstmt.executeQuery();
			while (rs.next()) {
				SCommunityBean bean = new SCommunityBean();
				bean.setNum(rs.getInt("num"));
				bean.setSc_title(rs.getString("sc_title"));
				bean.setSc_nick(rs.getString("sc_nick"));
				bean.setSc_regdate(rs.getString("sc_regdate"));
				bean.setSc_count(rs.getInt("sc_count"));
				bean.setSc_filename(rs.getString("sc_filename"));

				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	public void insertsc(HttpServletRequest req, String group) {
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

			if (multi.getFilesystemName("scfilename") != null) {
				filename = multi.getFilesystemName("scfilename");
				filesize = (int) multi.getFile("scfilename").length();
			}
			con = pool.getConnection();
			sql = "insert scommunity(sc_title,sc_content,sc_id,sc_nick,sc_regdate,"
					+ "sc_ip,sc_filename,sc_filesize,sc_group) " + "values(?,?,?,"
					+ "(select nickname from member where id=? union all select nickname from letea where id=?)"
					+ ",now(),?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("sctitle"));
			pstmt.setString(2, multi.getParameter("sccontent"));
			pstmt.setString(3, multi.getParameter("scid"));
			pstmt.setString(4, multi.getParameter("scid"));
			pstmt.setString(5, multi.getParameter("scid"));
			pstmt.setString(6, multi.getParameter("scip"));
			pstmt.setString(7, filename);
			pstmt.setInt(8, filesize);
			pstmt.setString(9, group);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public SCommunityBean getBoard(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		SCommunityBean bean = new SCommunityBean();
		try {
			con = pool.getConnection();
			sql = "select num, sc_title, sc_content, sc_id, sc_nick, sc_regdate, sc_ip, "
					+ "sc_filename, sc_filesize, sc_count " + "from scommunity where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setSc_title(rs.getString("sc_title"));
				bean.setSc_content(rs.getString("sc_content"));
				bean.setSc_id(rs.getString("sc_id"));
				bean.setSc_nick(rs.getString("sc_nick"));
				bean.setSc_regdate(rs.getString("sc_regdate"));
				bean.setSc_ip(rs.getString("sc_ip"));
				bean.setSc_filename(rs.getString("sc_filename"));
				bean.setSc_filesize(rs.getInt("sc_filesize"));
				bean.setSc_count(rs.getInt("sc_count"));
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
			sql = "select count(num) from scomment where stuc_pnum=?";
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

	public void scupCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update scommunity set sc_count = sc_count +1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public void deletesc(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			SCommunityBean bean = getBoard(num);
			String filename = bean.getSc_filename();
			if (filename != null && !filename.equals("")) {
				File f = new File(SAVEFOLDER + filename);
				if (f.exists()) {
					UtilMgr.delete(SAVEFOLDER + filename);
				}
			}
			con = pool.getConnection();
			sql = "delete from scommunity where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

	public void updatesc(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			int num = Integer.parseInt(multi.getParameter("num"));
			String title = multi.getParameter("sctitle");
			String content = multi.getParameter("sccontent");
			String filename = multi.getFilesystemName("scfilename");
			if (filename != null && !filename.equals("")) {
				SCommunityBean bean = getBoard(num);
				String tempfile = bean.getSc_filename();
				if (tempfile != null && !tempfile.equals("")) {
					File f = new File(SAVEFOLDER + tempfile);
					if (f.exists()) {
						UtilMgr.delete(SAVEFOLDER + tempfile);
					}
				}
				int filesize = (int) multi.getFile("scfilename").length();
				sql = "update scommunity set sc_title=?, sc_content=?, " + "sc_filename=?, sc_filesize=? where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, title);
				pstmt.setString(2, content);
				pstmt.setString(3, filename);
				pstmt.setInt(4, filesize);
				pstmt.setInt(5, num);
			} else {
				sql = "update scommunity set sc_title=?, sc_content=? where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, title);
				pstmt.setString(2, content);
				pstmt.setInt(3, num);
			}
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}

}
