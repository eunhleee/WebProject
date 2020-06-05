package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LeteaMgr {
	DBConnectionMgr pool;
	public LeteaMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	
	public LessonBean getLesson(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		LessonBean lebean = new LessonBean();
		try {
			con = pool.getConnection();
			sql = "select name, gender, area, phone, class, student, school_name, etc from lesson les, letea let where les.id=let.id and let.num = ?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				lebean.setName(rs.getString("name"));
				lebean.setGender(rs.getString("gender"));
				lebean.setArea(rs.getString("area"));
				lebean.setPhone(rs.getString("phone"));
				lebean.setLeclass(rs.getString("class"));
				lebean.setStudent(rs.getInt("student"));
				lebean.setSchool_name(rs.getString("school_name"));
				lebean.setEtc(rs.getString("etc"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return lebean;
	}
	
	public LeteaBean getId(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		LeteaBean bean=new LeteaBean();
		
		try {
			con = pool.getConnection();
			sql = "select name,id,class from letea where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				bean.setName(rs.getString("name"));
				bean.setId(rs.getString("id"));
				bean.setLeclass(rs.getString("class"));
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
}
