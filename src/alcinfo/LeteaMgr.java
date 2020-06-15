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
			sql = "select name, gender, area, phone, student, school_name, etc from lesson les, letea let where les.id=let.id and let.num = ?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				lebean.setName(rs.getString("name"));
				lebean.setGender(rs.getString("gender"));
				lebean.setArea(rs.getString("area"));
				lebean.setPhone(rs.getString("phone"));
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
			sql = "select name,id from letea where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				bean.setName(rs.getString("name"));
				bean.setId(rs.getString("id"));
				
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//선생님 정보 확인
	public LeteaBean getLetea(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		LeteaBean lebean = new LeteaBean();
		try {
			con = pool.getConnection();
			sql = "SELECT imgname, name, gender, substr(address,1,instr(address,'구 ')+1) address, phone,school_name, school_grade, grade from letea where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				lebean.setImgname(rs.getString("imgname"));
				lebean.setName(rs.getString("name"));
				lebean.setGender(rs.getString("gender"));
				lebean.setAddress(rs.getString("address"));
				lebean.setPhone(rs.getString("phone"));
				lebean.setSchool_name(rs.getString("school_name"));
				lebean.setSchool_grade(rs.getString("school_grade"));
				lebean.setGrade(rs.getInt("grade"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return lebean;
	}	
	
	//선생님 정보 등록하기
	public boolean insertLetea(String id, int student, String etc) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert lesson(id, student, etc) value(?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, student);
			pstmt.setString(3, etc);
			if(pstmt.executeUpdate()==1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	// 사용자 정보 가지고 오기
			public LeteaBean getInfo(String id) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				LeteaBean bean=new LeteaBean();
				try {
					con = pool.getConnection();
					sql = "select name,email,phone,address,mpoint from letea where id=? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					
					rs = pstmt.executeQuery();
					if(rs.next()) {
						bean.setName(rs.getString("name"));
						bean.setEmail(rs.getString("email"));
						bean.setPhone(rs.getString("phone"));
						bean.setAddress(rs.getString("address"));
						bean.setMpoint(rs.getString("mpoint"));
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt);
				}
				return bean;
			}
}
