package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;

import alcinfo.LeteaBean;
import alcinfo.MemberBean;
import alcinfo.ReportBean;

public class MemberMgr {
	DBConnectionMgr pool;
	
	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	
	public MemberBean loginMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select id, passwd, name, grade from member where id=? and passwd=? "
					+ "union all "
					+ "select id, passwd, name, grade from letea where id=? and passwd=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			pstmt.setString(3, id);
			pstmt.setString(4, pwd);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setId(rs.getString(1));
				bean.setPasswd(rs.getString(2));
				bean.setName(rs.getString(3));
				bean.setGrade(rs.getInt(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return bean;
	}
	
	
	
	
	public String idSearch(String name, String phone) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String id = null;
		try {
			con = pool.getConnection();
			sql = "select id from member where name=? and phone=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, phone);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return id;
	}
	
	
	public boolean pwdSearch(String id, String name, String phone) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select passwd from member where id=? and name=? and phone=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, phone);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	
	public boolean pwdChange(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update member set passwd=? where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pwd);
			pstmt.setString(2, id);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	

	public boolean checkId(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from member where id=? union all "
					+ "select id from letea where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	public boolean checkNickname(String nickname) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select nickname from member where nickname=? union all "
					+ "select nickname from letea where nickname=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nickname);
			pstmt.setString(2, nickname);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	public boolean insertMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert member(id,name,gender,passwd,"
					+ "email,nickname,birth,phone,address,school_name,school_grade,grade)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getGender());
			pstmt.setString(4, bean.getPasswd());
			pstmt.setString(5, bean.getEmail());
			pstmt.setString(6, bean.getNickname());
			pstmt.setString(7, bean.getBirth());
			pstmt.setString(8, bean.getPhone());
			pstmt.setString(9, bean.getAddress());
			pstmt.setString(10, bean.getSchool_name());
			pstmt.setString(11, bean.getSchool_grade());
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	
	public boolean insertLetea(LeteaBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert letea(id,name,gender,passwd,"
					+ "email,nickname,birth,phone,address,school_name,school_grade,area,grade)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?,2)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getGender());
			pstmt.setString(4, bean.getPasswd());
			pstmt.setString(5, bean.getEmail());
			pstmt.setString(6, bean.getNickname());
			pstmt.setString(7, bean.getBirth());
			pstmt.setString(8, bean.getPhone());
			pstmt.setString(9, bean.getAddress());
			pstmt.setString(10, bean.getSchool_name());
			pstmt.setString(11, bean.getSchool_grade());
			pstmt.setString(12, bean.getArea());
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}

	public MemberBean getInfo(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean=new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select name,nickname,email,phone,address,mpoint from member where id=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setName(rs.getString("name"));
				bean.setNickname(rs.getString("nickname"));
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
	
	public MemberBean getGrade(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		String a="";
		try {
			con = pool.getConnection();
			sql = "select id, grade from member where id="+"'"+id+"'"
					+ " union "
					+ " select id, grade from letea where id="+"'"+id+"'";
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

	public int checkM(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int grade = 5;
		try {
			con = pool.getConnection();
			sql = "select grade from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) grade = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return grade;
	}
	@SuppressWarnings("unchecked")
	public JSONArray getRatio(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		JSONArray jsonArray=new JSONArray();
		JSONArray colArray=new JSONArray();
		colArray.add("성별");
		colArray.add("사람 수");
		jsonArray.add(colArray);
		try {
			con = pool.getConnection();
			sql = "SELECT m.gender,COUNT(m.gender) " + 
					"FROM member m left OUTER JOIN letea t ON m.gender=t.gender " + 
					"GROUP BY m.gender ORDER BY m.gender";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				JSONArray rowArray = new JSONArray();
				rowArray.add(rs.getString("m.gender"));
				rowArray.add(rs.getInt("COUNT(m.gender)"));

				jsonArray.add(rowArray);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return jsonArray;
	}
	public int countMember() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count=0;
		try {
			con = pool.getConnection();
			sql = "select count(id) from member where grade=1 ";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				count=rs.getInt("count(id)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	@SuppressWarnings("unchecked")
	public JSONArray countSchool_grade() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		JSONArray jsonArray=new JSONArray();
		JSONArray colArray=new JSONArray();
		colArray.add("학교구분");
		colArray.add("사람 수");
		jsonArray.add(colArray);
		String[] school= {"초등학생","중학생","고등학생","대학생"};
		try {
			con = pool.getConnection();
			for(int i=0;i<4;i++) {
			sql = "SELECT COUNT(id) " + 
					"FROM member " + 
					"WHERE school_grade='"+school[i]+"'";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				JSONArray rowArray=new JSONArray();
				rowArray.add(school[i]);
				rowArray.add(rs.getInt("COUNT(id)"));
				
				jsonArray.add(rowArray);
			}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return jsonArray;
	}
}
