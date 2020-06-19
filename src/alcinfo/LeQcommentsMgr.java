package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class LeQcommentsMgr {
	
	private DBConnectionMgr pool;
	
	public LeQcommentsMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	//Comment List
	public Vector<LeQcommentsBean> getLeQComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<LeQcommentsBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select num,leq_id,leq_content,leq_ip,leq_regdate,leq_conum,leq_depth "
					+ "from leqcomments where leq_num=? order by leq_conum, num";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()){
				LeQcommentsBean bean = new LeQcommentsBean();
				bean.setNum(rs.getInt("num"));
				bean.setLeq_id(rs.getString("leq_id"));
				bean.setLeq_content(rs.getString("leq_content"));
				bean.setLeq_regdate(rs.getString("leq_regdate"));
				bean.setLeq_conum(rs.getInt("leq_conum"));
				bean.setLeq_depth(rs.getInt("leq_depth"));
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
	public void insertLeQComment(LeQcommentsBean bean){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert leqcomments(leq_num,leq_id,leq_content,leq_ip,leq_regdate,"
					+ "leq_conum,leq_depth) "
					+ "values(?,?,?,?,now(),"
					+ "coalesce((select max(leq_conum) from leqcomments a)+1,0),0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getLeq_num());
			pstmt.setString(2, bean.getLeq_id());
			pstmt.setString(3, bean.getLeq_content());
			pstmt.setString(4, bean.getLeq_ip());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Comment Count
	public int getLeQCommentCount(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count  = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from leqcomments where leq_num=?";
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
	public void deleteLeQComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from leqcomments where num=?";
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
	public void deleteAllLeQCReply(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from leqcomments where leq_conum=?";
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
	public void deleteAllLeQComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from leqcomments where leq_num=?";
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
	public void insertLeQCReply(LeQcommentsBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert leqcomments(leq_num,leq_id,leq_content,leq_ip,"
					+ "leq_regdate,leq_conum,leq_depth) "
					+ "value(?,?,?,?,now(),?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getLeq_num());
			pstmt.setString(2, bean.getLeq_id());
			pstmt.setString(3, bean.getLeq_content());
			pstmt.setString(4, bean.getLeq_ip());
			pstmt.setInt(5, bean.getLeq_conum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
