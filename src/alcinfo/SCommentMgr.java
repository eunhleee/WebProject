package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class SCommentMgr {
	
private DBConnectionMgr pool;
	
	public SCommentMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	//Comment List
	public Vector<SCommentBean> getSComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<SCommentBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			sql = "select num, stuc_nick, stuc_content, stuc_regdate, stuc_conum, stuc_depth "
					+ "from scomment where stuc_pnum=? order by stuc_conum, num";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()){
				SCommentBean bean = new SCommentBean();
				bean.setNum(rs.getInt("num"));
				bean.setStuc_nick(rs.getString("stuc_nick"));
				bean.setStuc_content(rs.getString("stuc_content"));
				bean.setStuc_regdate(rs.getString("stuc_regdate"));
				bean.setStuc_conum(rs.getInt("stuc_conum"));
				bean.setStuc_depth(rs.getInt("stuc_depth"));
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
	public void insertSComment(SCommentBean bean){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String nick = bean.getStuc_nick();
		try {
			con = pool.getConnection();
			sql = "insert scomment(stuc_nick,stuc_content,stuc_regdate,stuc_pnum,"
					+ "stuc_id,stuc_ip,stuc_conum) "
					+ "values(?,?,now(),?,"
					+ "(select id from member where nickname=? union all "
					+ "select id from letea where nickname=?),?,"
					+ "(select max(stuc_conum) from scomment s)+1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nick);
			pstmt.setString(2, bean.getStuc_content());
			pstmt.setInt(3, bean.getNum());
			pstmt.setString(4, nick);
			pstmt.setString(5, nick);
			pstmt.setString(6, bean.getStuc_ip());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	//Comment Count
	public int getSCommentCount(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count  = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from scomment where stuc_pnum=?";
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
	public void deleteSComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from scomment where num=?";
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
	public void deleteAllSCReply(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from scomment where stuc_conum=?";
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
	public void deleteAllSComment(int num){
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from scomment where stuc_pnum=?";
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
	public void insertSCReply(SCommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String nick = bean.getStuc_nick();
		try {
			con = pool.getConnection();
			sql = "insert scomment(stuc_pnum,stuc_nick,stuc_id,stuc_content,stuc_ip,"
					+ "stuc_regdate,stuc_conum,stuc_depth) value(?,?,"
					+ "(select id from member where nickname=? union all "
					+ "select id from letea where nickname=?)"
					+ ",?,?,now(),?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, nick);
			pstmt.setString(3, nick);
			pstmt.setString(4, nick);
			pstmt.setString(5, bean.getStuc_content());
			pstmt.setString(6, bean.getStuc_ip());
			pstmt.setInt(7, bean.getStuc_conum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 로그인 된 회원 닉네임
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
