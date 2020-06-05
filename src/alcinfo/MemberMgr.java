package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import member.DBConnectionMgr;

public class MemberMgr {
	DBConnectionMgr pool;

	public MemberMgr() {
		pool = new DBConnectionMgr();
	}
	
	public MemberBean getId(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean=new MemberBean();
		
		try {
			con = pool.getConnection();
			sql = "select name,address from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				bean.setName(rs.getString(1));
				bean.setAddress(rs.getString(2));
				
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	//학생정보 가져오기
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean mbean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "SELECT imgname, name, gender, substr(address,1,instr(address,'구 ')+1) address, phone, school_name, school_grade, grade from member where id = ?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mbean.setImgname(rs.getString("imgname"));
				mbean.setName(rs.getString("name"));
				mbean.setGender(rs.getString("gender"));
				mbean.setAddress(rs.getString("address"));
				mbean.setPhone(rs.getString("phone"));
				mbean.setSchool_name(rs.getString("school_name"));
				mbean.setSchool_grade(rs.getString("school_grade"));
				mbean.setGrade(rs.getInt("grade"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mbean;
	}	
	
	//학생 정보 등록하기
	public boolean insertStudent(String id, String stclass, String stetc) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert student(id, class, etc) value(?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, stclass);
			pstmt.setString(3, stetc);
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
}
