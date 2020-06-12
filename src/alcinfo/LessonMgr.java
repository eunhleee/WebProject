package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import org.json.simple.JSONArray;

public class LessonMgr {
	private DBConnectionMgr pool;

	public LessonMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	/*
	 * int num=Lbean.getNum(); 
	 * String name=Lbean.getName(); 
	 * String leclass=Lbean.getLeclass();
	 *  String area=Lbean.getArea();
	 *  float star=Lbean.getStar(); 
	 *  int count=Lbean.getCount();
	 */
	public Vector<LessonBean> getBestBoard(String pageValue,String sort){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<LessonBean> vlist= new Vector<LessonBean>();
			try {
				con = pool.getConnection();
				if(pageValue.equals("top")) {
					sql = "select le.num,le.id,tea.name,tea.class,tea.area,le.star,le.count "
							+ " from lesson le,letea tea where le.id=tea.id order by le.star desc";
				pstmt = con.prepareStatement(sql);
				}
				else {
					sql = "select le.num,le.id,tea.name,tea.class,tea.area,le.star,le.count "
							+ " from lesson le,letea tea where le.id=tea.id and tea.class like ? order by ?  desc";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1,"%"+pageValue+"%");
					pstmt.setString(2, "le."+sort);
					
				}
				
				rs = pstmt.executeQuery();// select ����
				while(rs.next()) {
					LessonBean bean = new LessonBean();
					bean.setNum(rs.getInt("le.num"));
					bean.setId(rs.getString("le.id"));
					bean.setName(rs.getString("tea.name"));
					bean.setLeclass(rs.getString("tea.class"));
					bean.setArea(rs.getString("tea.area"));
					bean.setStar(rs.getFloat("le.star"));
					bean.setCount(rs.getInt("le.count"));
					
					vlist.addElement(bean);
				}
				
			}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	public Vector<LessonBean> getCountBoard(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<LessonBean> vlist= new Vector<LessonBean>();
		try {
			con = pool.getConnection();
			sql = "select le.num,le.id,tea.name,tea.class,tea.area,le.star,le.count "
					+ " from lesson le,letea tea where le.id=tea.id order by le.count desc";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();//select ����
			while(rs.next()) {
				LessonBean bean = new LessonBean();
				bean.setNum(rs.getInt("le.num"));
				bean.setId(rs.getString("le.id"));
				bean.setName(rs.getString("tea.name"));
				bean.setLeclass(rs.getString("tea.class"));
				bean.setArea(rs.getString("tea.area"));
				bean.setStar(rs.getFloat("le.star"));
				bean.setCount(rs.getInt("le.count"));
				vlist.addElement(bean);
			}
			
		}
	catch (Exception e) {
		e.printStackTrace();
	}finally {
		pool.freeConnection(con, pstmt, rs);
	}
		return vlist;
	}
	
	public LessonBean getLesson(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		LessonBean lebean = new LessonBean();
		try {
			con = pool.getConnection();
			sql = "select les.num,let.name,let.gender, let.area, let.phone, let.class, les.student, let.school_name, les.etc from lesson les, letea let where les.id=let.id and les.id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				lebean.setNum(rs.getInt("les.num"));
				lebean.setName(rs.getString("let.name"));
				lebean.setGender(rs.getString("let.gender"));
				lebean.setArea(rs.getString("let.area"));
				lebean.setPhone(rs.getString("let.phone"));
				lebean.setLeclass(rs.getString("let.class"));
				lebean.setStudent(rs.getInt("les.student"));
				lebean.setSchool_name(rs.getString("let.school_name"));
				lebean.setEtc(rs.getString("les.etc"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return lebean;
	}
	
	public Vector<LessonBean> getSearchList(String keyWord){
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<LessonBean> vlist=new Vector<LessonBean>();
		try {
			con = pool.getConnection();
			if(!keyWord.trim().equals("")||keyWord!=null) {
				//�˻��� �ƴѰ��
			
			sql = "select distinct(le.num),le.id,tea.name,tea.class,tea.area,le.star,le.count " + 
					"from lesson le,letea tea where le.id=tea.id and( tea.name like ? or tea.class like ? or tea.area like ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyWord+"%");
			pstmt.setString(2, "%"+keyWord+"%");
			pstmt.setString(3, "%"+keyWord+"%");
		
			
				 
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				LessonBean bean = new LessonBean();
				bean.setNum(rs.getInt("le.num"));
				bean.setId(rs.getString("le.id"));
				bean.setName(rs.getString("tea.name"));
				bean.setLeclass(rs.getString("tea.class"));
				bean.setArea(rs.getString("tea.area"));
				bean.setStar(rs.getFloat("le.star"));
				bean.setCount(rs.getInt("le.count"));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; 
	}
	
	
	public boolean insertStudent(LessonBean lbean,MemberBean mbean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			
			con = pool.getConnection();
			sql = "insert leinsert(l_num,l_teacharid,l_stuid,l_stname,l_staddress,l_state,l_date )"
					+ " values(?,?,?,?,?,'신청접수',now())";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, lbean.getNum());
			pstmt.setString(2, lbean.getId());
			pstmt.setString(3, mbean.getId());
			pstmt.setString(4, mbean.getName());
			pstmt.setString(5, mbean.getAddress());
			
			
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
	
	public boolean deleteStudent(LessonBean lbean,MemberBean mbean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "delete from leinsert where l_teacharid=? and l_stuid=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, lbean.getId());
			pstmt.setString(2, mbean.getId());

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
	
	public boolean getStudent(MemberBean mbean,String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select * from leinsert where l_stuid=? and l_teacharid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mbean.getId());
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	
	@SuppressWarnings("unchecked")
	public JSONArray getCountStudent(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		JSONArray jsonArray = new JSONArray();
		
		try {
			con = pool.getConnection();
			sql = "select l_date,COUNT(*) from leinsert where l_teacharid=? group by l_date";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();

			while(rs.next()){
			JSONArray rowArray = new JSONArray();
			rowArray.add(rs.getString("l_date"));
			rowArray.add(rs.getInt("COUNT(*)"));

			jsonArray.add(rowArray);
			}//while
			} catch (Exception e) {
			e.printStackTrace();
			}finally {
				pool.freeConnection(con, pstmt);

			}

			return jsonArray;
	}
	
	//조회수 증가
		public void upLeCount(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "update lesson set count = count +1 where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	
}
	
	

	

