package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class LeRcommentsMgr {
	
	private DBConnectionMgr pool;

	public LeRcommentsMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Comment List
	public Vector<LeRcommentsBean> getLeRComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<LeRcommentsBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select num,ler_nick,ler_content,ler_regdate,ler_conum,"
					+ "ler_depth,ler_id from lercomments where ler_num=? order by ler_conum, num";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()){
				LeRcommentsBean bean = new LeRcommentsBean();
				bean.setNum(rs.getInt("num"));
				bean.setLer_nick(rs.getString("ler_nick"));
				bean.setLer_content(rs.getString("ler_content"));
				bean.setLer_regdate(rs.getString("ler_regdate"));
				bean.setLer_conum(rs.getInt("ler_conum"));
				bean.setLer_depth(rs.getInt("ler_depth"));
				bean.setLer_id(rs.getString("ler_id"));

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
	public void insertLerComment(LeRcommentsBean bean){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert lercomments(ler_num,ler_nick,ler_id,ler_content,ler_ip,ler_regdate,"
					+ "ler_conum) "
					+ "values(?,?,?,?,?,now(),"
					+ "(select max(ler_conum) from lercomments a)+1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getLer_num());
			pstmt.setString(2, memberNick(bean.getLer_id()));
			pstmt.setString(3, bean.getLer_id());
			pstmt.setString(4, bean.getLer_content());
			pstmt.setString(5, bean.getLer_ip());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Comment Count
	public int getLerCommentCount(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count  = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from lercomments where leq_num=?";
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
	public void deleteLerComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from lercomments where num=?";
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
	public void deleteAllLerCReply(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from lercomments where ler_conum=?";
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
	public void deleteAllLerComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from lercomments where ler_num=?";
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
	public void insertLerCReply(LeRcommentsBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert lercomments(ler_num,ler_nick,ler_id,ler_content,ler_ip,ler_regdate,"
					+ "ler_conum,ler_depth) value(?,?,?,?,?,now(),?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getLer_num());
			pstmt.setString(2, memberNick(bean.getLer_id()));
			pstmt.setString(3, bean.getLer_id());
			pstmt.setString(4, bean.getLer_content());
			pstmt.setString(5, bean.getLer_ip());
			pstmt.setInt(6, bean.getLer_conum());
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
