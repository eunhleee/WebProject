package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class CSCommentMgr {
	private DBConnectionMgr pool;
	
	public CSCommentMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	//Comment List
	public Vector<CSCommentBean> getCSComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<CSCommentBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select num, ccr_id, ccr_content, ccr_ip, ccr_regdate, ccr_conum, ccr_depth "
					+ "from cscomment where ccr_num=? order by ccr_conum, num";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()){
				CSCommentBean bean = new CSCommentBean();
				bean.setNum(rs.getInt("num"));
				bean.setCcr_id(rs.getString("ccr_id"));
				bean.setCcr_content(rs.getString("ccr_content"));
				bean.setCcr_ip(rs.getString("ccr_ip"));
				bean.setCcr_regdate(rs.getString("ccr_regdate"));
				bean.setCcr_conum(rs.getInt("ccr_conum"));
				bean.setCcr_depth(rs.getInt("ccr_depth"));

				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	//Comment Insert
	public void insertCSComment(CSCommentBean bean){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert cscomment(ccr_num, ccr_id, ccr_content, ccr_ip, ccr_regdate,"
					+ "ccr_conum, ccr_depth) values(?,?,?,?,now(),"
					+ "(select max(stuc_conum) from cscomment s)+1),0";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getCcr_num());
			pstmt.setString(2, bean.getCcr_id());
			pstmt.setString(3, bean.getCcr_content());
			pstmt.setString(4, bean.getCcr_ip());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Comment Count
	public int getCSCommentCount(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count  = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from cscomment where ccr_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next())
				count = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	//Comment or CReply Delete
	public void deleteCSComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from cscomment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Comment and C's Reply All Delete (�뙎湲� �궘�젣�븷 �븣 ���뙎湲�源뚯� �쟾遺� �궘�젣)
	public void deleteAllCSCReply(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from cscomment where ccr_conum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Comment All Delete
	public void deleteAllCSComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from cscomment where ccr_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// CommentReply Insert
	public void insertSCReply(CSCommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert cscomment(ccr_num,ccr_id,ccr_content,ccr_ip,"
					+ "ccr_regdate,ccr_conum,ccr_depth) value(?,?,?"
					+ ",?,now(),?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getCcr_num());
			pstmt.setString(2, bean.getCcr_id());
			pstmt.setString(3, bean.getCcr_content());
			pstmt.setString(4, bean.getCcr_ip());
			pstmt.setInt(5, bean.getCcr_conum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
}
