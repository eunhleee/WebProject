package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import org.json.simple.JSONArray;

public class StudentMgr {
	private DBConnectionMgr pool;
	public StudentMgr(){
		pool=DBConnectionMgr.getInstance();
	}
	
	//��ȸ������ ��ȸ
		public Vector<StudentBean> getBestBoard(String pageValue){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<StudentBean> vlist= new Vector<StudentBean>();
			try {
				con = pool.getConnection();
				if(pageValue.equals("count")) {
				sql = "select st.num,me.imgname,me.name,st.class,me.school_name,me.school_grade,st.count from student st,member me "
						+ "where st.id=me.id order by st.count desc";
				pstmt = con.prepareStatement(sql);
				}
				else {
					sql = "select st.num,me.imgname,me.name,st.class,me.school_name,me.school_grade,st.count from student st,member me "
							+ "where st.id=me.id and st.class like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+pageValue+"%");
				}
				
				rs = pstmt.executeQuery();//select ����
				while(rs.next()) {
					StudentBean bean = new StudentBean();
					bean.setNum(rs.getInt("num"));
					bean.setImgname(rs.getString("me.imgname"));
					bean.setName(rs.getString("me.name"));
					bean.setStclass(rs.getString("st.class"));
					bean.setSchool_name(rs.getString("me.school_name"));
					bean.setSchool_grade(rs.getString("me.school_grade"));
					bean.setCount(rs.getInt("st.count"));
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
		
		public StudentBean getStudent(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			StudentBean stbean = new StudentBean();
			try {
				con = pool.getConnection();
				sql = "select name,st.id, gender, substr(address,1,instr(address,'로 ')+1) address, phone, class, school_name, school_grade, etc from student st, member me where st.id=me.id and num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					stbean.setName(rs.getString("name"));
					stbean.setId(rs.getString("st.id"));
					stbean.setGender(rs.getString("gender"));
					stbean.setAddress(rs.getString("address"));
					stbean.setPhone(rs.getString("phone"));
					stbean.setStclass(rs.getString("class"));
					stbean.setSchool_name(rs.getString("school_name"));
					stbean.setSchool_grade(rs.getString("school_grade"));
					stbean.setEtc(rs.getString("etc"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return stbean;
		}
		
		
		
		public Vector<StudentBean> getSearchList(String keyWord){
			 Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<StudentBean> vlist=new Vector<StudentBean>();
			try {
				con = pool.getConnection();
				if(!keyWord.trim().equals("")||keyWord!=null) {
					//�˻��� �ƴѰ��
				
				sql = "select st.num,me.imgname,me.name,st.class,me.school_name,me.school_grade,st.count from student st,member me " + 
						" where st.id=me.id and ( me.name like ? or st.class like ? or school_name like ?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setString(2, "%"+keyWord+"%");
				pstmt.setString(3, "%"+keyWord+"%");
				
					 
				}

				rs = pstmt.executeQuery();
				while(rs.next()) {
					StudentBean bean = new StudentBean();
					bean.setNum(rs.getInt("num"));
					bean.setImgname(rs.getString("me.imgname"));
					bean.setName(rs.getString("me.name"));
					bean.setStclass(rs.getString("st.class"));
					bean.setSchool_name(rs.getString("me.school_name"));
					bean.setSchool_grade(rs.getString("me.school_grade"));
					bean.setCount(rs.getInt("st.count"));
					
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist; 
		}
		public boolean insertTea(StudentBean sbean,LeteaBean lbean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag=false;
			try {
				con = pool.getConnection();
				sql = "insert stinsert(num,stid,teaid,teaname,stclass,state,date )"
						+ "values(?,?,?,?,?,'신청접수',now())";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, sbean.getNum());
				pstmt.setString(2, sbean.getId());
				pstmt.setString(3, lbean.getId());
				pstmt.setString(4, lbean.getName());
				pstmt.setString(5, lbean.getLeclass());

				
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
		
		public boolean deleteTea(StudentBean sbean,LeteaBean lbean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag=false;
			try {
				con = pool.getConnection();
				sql = "delete from stinsert where stid=? and teaid=? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, sbean.getId());
				pstmt.setString(2, lbean.getId());

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
		
		public boolean getTea(String id,int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			boolean flag=false;
			try {
				con = pool.getConnection();
				sql = "select * from stinsert where teaid=? and num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setInt(2, num);

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
		
		public JSONArray getCountTeachar(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = "";
			JSONArray jsonArray = new JSONArray();
			JSONArray colNameArray = new JSONArray(); // 컬 타이틀 설정
			colNameArray.add("날짜");
			colNameArray.add("인원수");
			jsonArray.add(colNameArray);
			try {
				con = pool.getConnection();
				sql = "select date,COUNT(*) from stinsert where num=? group by date";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();

				while(rs.next()){
				JSONArray rowArray = new JSONArray();
				rowArray.add(rs.getString("date"));
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
		
		//Count Up : 조회수 증가
				public void upStCount(int num) {
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					try {
						con = pool.getConnection();
						sql = "update student set count = count +1 where num = ?";
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
