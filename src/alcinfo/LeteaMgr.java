package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;

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
	
	
	
	public LeteaBean getLetea(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		LeteaBean lebean = new LeteaBean();
		try {
			con = pool.getConnection();

			sql = "SELECT imgname, name, gender, substr(address,1,instr(address,'구 ')+1) address, phone, school_name, school_grade, grade from letea where id = ?";

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
	
	
	public boolean insertLetea(String id, String leclass, int student, String etc) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert lesson(id, class, student, etc) value(?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, leclass);
			pstmt.setInt(3, student);
			pstmt.setString(4, etc);
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
	public int[] countTea() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count[]=new int[2];
		try {
			con = pool.getConnection();
			sql = "SELECT (SELECT COUNT(id) FROM letea WHERE grade=2) tea1 , (SELECT COUNT(id) FROM letea WHERE grade=3) tea2";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				count[0]=rs.getInt("tea1");
				count[1]=rs.getInt("tea2");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	
	@SuppressWarnings("unchecked")
	public JSONArray getAge() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		JSONArray jsonArray=new JSONArray();
		JSONArray colArray=new JSONArray();
		colArray.add("연령별");
		colArray.add("사람 수");
		jsonArray.add(colArray);
		String[] title= {"10대","20대","30대","40대","50대","60대","70대 이상"};
		int[] age= {0,0,0,0,0,0,0};
		try {
			con = pool.getConnection();
			sql = "SELECT FLOOR( (CAST(REPLACE(CURRENT_DATE,'-','') AS UNSIGNED) - " + 
					"     CAST(REPLACE(birth,'-','') AS UNSIGNED)) / 10000 ) age " + 
					"FROM letea";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				if(rs.getInt("age")>=70) {
					age[6]++;
				}else if(rs.getInt("age")>=60) {
					age[5]++;
				}else if(rs.getInt("age")>=50) {
					age[4]++;
				}else if(rs.getInt("age")>=40) {
					age[3]++;
				}else if(rs.getInt("age")>=30) {
					age[2]++;
				}else if(rs.getInt("age")>=20) {
					age[1]++;
				}
				else age[0]++;
			}
			
			for(int i=0;i<7;i++) {
				JSONArray rowArray=new JSONArray();
				rowArray.add(title[i]);
				rowArray.add(age[i]);
				jsonArray.add(rowArray);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return jsonArray;
	} 
}
