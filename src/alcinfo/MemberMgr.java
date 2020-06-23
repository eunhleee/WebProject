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
	public MemberBean getGrade(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		String a="";
		try {
			con = pool.getConnection();
			sql = "select id, grade from member where id='"+id+"'"
					+ " union"
					+ " select id, grade from letea where id='"+id+"'";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				bean.setGrade(rs.getInt("grade"));
				System.out.println(rs.getString("grade"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	public boolean upMember(MemberBean bean, int grade) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		System.out.println("그레이드는"+grade);
		try {
			con = pool.getConnection();
			if(grade==1) {
			sql = "update member set name=?,gender=?,passwd=?,email=?,nickname=?,birth=?,phone=?"
					+ ",address=?,school_name=?,school_grade=? where id=?";
			}
			else {
				sql = "update letea set name=?,gender=?,passwd=?,email=?,"//4
						+ "nickname=?,birth=?,phone=?,"//3
						+ "address=?,school_name=?,school_grade=?"//3
						+ " where id=?";//1
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,bean.getName());
			pstmt.setString(2,bean.getGender());
			pstmt.setString(3,bean.getPasswd());
			pstmt.setString(4,bean.getEmail());
			
			pstmt.setString(5,bean.getNickname());
			pstmt.setString(6,bean.getBirth());
			pstmt.setString(7,bean.getPhone());
			
			pstmt.setString(8,bean.getAddress());
			pstmt.setString(9,bean.getSchool_name());
			pstmt.setString(10,bean.getSchool_grade());
			pstmt.setString(11,bean.getId());
			if(pstmt.executeUpdate()==1) {
				flag=true;	
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//upMember.jsp select
		public MemberBean getUpMember(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MemberBean bean = new MemberBean();
			String a="";
			try {
				con = pool.getConnection();
				sql = "SELECT DISTINCT(a.id),a.name,a.email,a.gender,a.passwd,a.nickname,a.birth," + 
						" a.phone,a.address,a.school_name,a.school_grade,a.imgname,a.grade"
						+" FROM "
						+" (SELECT name,id,email,gender,passwd,nickname,birth,"
						+" phone,address,school_name,school_grade,imgname,grade"
						+" FROM member"
						+" union" 
						+" SELECT name,id,email,gender,passwd,nickname,birth," 
						+" phone,address,school_name,school_grade,imgname,grade"
						+" FROM letea) a" 
						+" WHERE a.id='"+id+"'";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();

				if(rs.next()) {
					bean.setId(rs.getString("a.id"));
					bean.setName(rs.getString("a.name"));
					bean.setEmail(rs.getString("a.email"));
					bean.setGender(rs.getString("a.gender"));
					bean.setPasswd(rs.getString("a.passwd"));
					bean.setNickname(rs.getString("a.nickname"));
					bean.setBirth(rs.getString("a.birth"));
					bean.setPhone(rs.getString("a.phone"));
					bean.setAddress(rs.getString("a.address"));
					bean.setSchool_name(rs.getString("a.school_name"));
					bean.setSchool_grade(rs.getString("a.school_grade"));
					bean.setGrade(rs.getInt("a.grade"));


				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
	//占쎈린占쎄문占쎌젟癰귨옙 揶쏉옙占쎌죬占쎌궎疫뀐옙
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean mbean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "SELECT imgname, name, gender, substr(address,1,instr(address,'援� ')+1) address, phone, school_name, school_grade, grade from member where id = ?;";
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
	public MemberBean getMlist(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean mbean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "SELECT imgname, name, gender, substr(address,1,instr(address,'援� ')+1) address, phone, school_name, school_grade, grade from member where id = ?;";
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
	
	//占쎈린占쎄문 占쎌젟癰귨옙 占쎈쾻嚥≪빜釉�疫뀐옙
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
