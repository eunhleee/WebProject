package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AcRcommentsMgr {
	
	private DBConnectionMgr pool;

	public AcRcommentsMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Comment List
	public Vector<AcRcommentsBean> getAcRComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AcRcommentsBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select num,acr_nick,acr_content,acr_regdate,acr_conum,"
					+ "acr_depth, acr_id from acrcomments where acr_num=? order by acr_conum, num";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()){
				AcRcommentsBean bean = new AcRcommentsBean();
				bean.setNum(rs.getInt("num"));
				bean.setAcr_nick(rs.getString("acr_nick"));
				bean.setAcr_content(rs.getString("acr_content"));
				bean.setAcr_regdate(rs.getString("acr_regdate"));
				bean.setAcr_conum(rs.getInt("acr_conum"));
				bean.setAcr_depth(rs.getInt("acr_depth"));
				bean.setAcr_id(rs.getString("acr_id"));

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
	public void insertAcrComment(AcRcommentsBean bean){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert acrcomments(acr_num,acr_nick,acr_id,acr_content,acr_ip,acr_regdate,"
					+ "acr_conum) "
					+ "values(?,?,?,?,?,now(),"
					+ "(select max(acr_conum) from acrcomments a)+1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getAcr_num());
			pstmt.setString(2, memberNick(bean.getAcr_id()));
			pstmt.setString(3, bean.getAcr_id());
			pstmt.setString(4, bean.getAcr_content());
			pstmt.setString(5, bean.getAcr_ip());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Comment Count
	public int getAcrCommentCount(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count  = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from acrcomments where acq_num=?";
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
	public void deleteAcrComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from acrcomments where num=?";
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
	public void deleteAllAcrCReply(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from acrcomments where acr_conum=?";
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
	public void deleteAllAcrComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from acrcomments where acr_num=?";
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
	public void insertAcrCReply(AcRcommentsBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert acrcomments(acr_num,acr_nick,acr_id,acr_content,acr_ip,acr_regdate,"
					+ "acr_conum,acr_depth) value(?,?,?,?,?,now(),?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getAcr_num());
			pstmt.setString(2, memberNick(bean.getAcr_id()));
			pstmt.setString(3, bean.getAcr_id());
			pstmt.setString(4, bean.getAcr_content());
			pstmt.setString(5, bean.getAcr_ip());
			pstmt.setInt(6, bean.getAcr_conum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 濡쒓렇�씤 �맂 �쉶�썝 �땳�꽕�엫
	public String memberNick(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String nick = null;
		try {
			con = pool.getConnection();
			sql = "select nickname from member where id=? "
					+ "union all "
					+ "select nickname from letea where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()) nick=rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return nick;
	}
	
}
