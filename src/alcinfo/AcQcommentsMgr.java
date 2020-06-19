package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AcQcommentsMgr {
private DBConnectionMgr pool;
	
	public AcQcommentsMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	//Comment List
	public Vector<AcQcommentsBean> getAcQComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AcQcommentsBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select num,acq_id,acq_content,acq_ip,acq_regdate,acq_conum,acq_depth "
					+ "from acqcomments where acq_num=? order by acq_conum, num";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()){
				AcQcommentsBean bean = new AcQcommentsBean();
				bean.setNum(rs.getInt("num"));
				bean.setAcq_id(rs.getString("acq_id"));
				bean.setAcq_content(rs.getString("acq_content"));
				bean.setAcq_regdate(rs.getString("acq_regdate"));
				bean.setAcq_conum(rs.getInt("acq_conum"));
				bean.setAcq_depth(rs.getInt("acq_depth"));
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
	public void insertAcQComment(AcQcommentsBean bean){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert acqcomments(acq_num,acq_id,acq_content,acq_ip,acq_regdate,"
					+ "acq_conum,acq_depth) "
					+ "values(?,?,?,?,now(),"
					+ "coalesce((select max(acq_conum) from acqcomments a)+1,0),0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getAcq_num());
			pstmt.setString(2, bean.getAcq_id());
			pstmt.setString(3, bean.getAcq_content());
			pstmt.setString(4, bean.getAcq_ip());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Comment Count
	public int getAcQCommentCount(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count  = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from acqcomments where acq_num=?";
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
	public void deleteAcQComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from acqcomments where num=?";
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
	public void deleteAllAcQCReply(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from acqcomments where acq_conum=?";
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
	public void deleteAllAcQComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from acqcomments where acq_num=?";
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
	public void insertAcQCReply(AcQcommentsBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert acqcomments(acq_num,acq_id,acq_content,acq_ip,"
					+ "acq_regdate,acq_conum,acq_depth) "
					+ "value(?,?,?,?,now(),?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getAcq_num());
			pstmt.setString(2, bean.getAcq_id());
			pstmt.setString(3, bean.getAcq_content());
			pstmt.setString(4, bean.getAcq_ip());
			pstmt.setInt(5, bean.getAcq_conum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
}
