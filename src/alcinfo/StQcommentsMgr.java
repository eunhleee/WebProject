package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class StQcommentsMgr {
	private DBConnectionMgr pool;
	
	public StQcommentsMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Comment List
	public Vector<StQcommentsBean> getStQComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<StQcommentsBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select num,stq_id,stq_content,stq_ip,stq_regdate,stq_conum,stq_depth "
					+ "from stqcomments where stq_num=? order by stq_conum, num";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()){
				StQcommentsBean bean = new StQcommentsBean();
				bean.setNum(rs.getInt("num"));
				bean.setStq_id(rs.getString("stq_id"));
				bean.setStq_content(rs.getString("stq_content"));
				bean.setStq_regdate(rs.getString("stq_regdate"));
				bean.setStq_conum(rs.getInt("stq_conum"));
				bean.setStq_depth(rs.getInt("stq_depth"));
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
	public void insertStQComment(StQcommentsBean bean){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert stqcomments(stq_num,stq_id,stq_content,stq_ip,stq_regdate,stq_conum,"
					+ "stq_depth) values(?,?,?,?,now(),"
					+ "(select max(stq_conum) from stqcomments s)+1,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getStq_num());
			pstmt.setString(2, bean.getStq_id());
			pstmt.setString(3, bean.getStq_content());
			pstmt.setString(4, bean.getStq_ip());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Comment Count
	public int getStQCommentCount(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count  = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from stqcomments where stq_num=?";
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
	public void deleteStQComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from stqcomments where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Comment and C's Reply All Delete (댓글 삭제할 때 대댓글까지 전부 삭제)
	public void deleteAllStQCReply(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from stqcomments where stq_conum=?";
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
	public void deleteAllStQComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from stqcomments where stq_num=?";
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
	public void insertStQCReply(StQcommentsBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert stqcomments(stq_num,stq_id,stq_content,stq_ip,"
					+ "stq_regdate,stq_conum,stq_depth) "
					+ "value(?,?,?,?,now(),?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getStq_num());
			pstmt.setString(2, bean.getStq_id());
			pstmt.setString(3, bean.getStq_content());
			pstmt.setString(4, bean.getStq_ip());
			pstmt.setInt(5, bean.getStq_conum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
