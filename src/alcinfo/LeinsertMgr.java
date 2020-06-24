package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class LeinsertMgr {
	DBConnectionMgr pool;
	
	public LeinsertMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	
	public boolean insertStudent(LessonBean lbean,MemberBean mbean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			
			con = pool.getConnection();
			sql = "insert leinsert(l_num,l_teacharid,l_stuid,l_stname,l_stphone,l_staddress,l_state,l_date )"
					+ " values(?,?,?,?,?,?,'신청접수',now())";
			pstmt = con.prepareStatement(sql);

			pstmt.setInt(1, lbean.getNum());
			pstmt.setString(2, lbean.getId());
			pstmt.setString(3, mbean.getId());
			pstmt.setString(4, mbean.getName());
			pstmt.setString(5, mbean.getPhone());
			pstmt.setString(6, mbean.getAddress());
			
			
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
		int count=0;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select * from leinsert where l_stuid=? and l_teacharid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mbean.getId());
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count++;
			}
			if(count>1) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	//학생의 내가 신청한 과외 
	public Vector<LeinsertBean> getMyLessonList(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<LeinsertBean> vlist=new Vector<LeinsertBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT tea.name,le.class,lein.l_state,lein.l_date " + 
					"FROM leinsert lein,lesson le,letea tea " + 
					"WHERE lein.l_teacharid=le.id AND tea.id=le.id and lein.l_stuid=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				LeinsertBean bean=new LeinsertBean();
				bean.setL_teaname(rs.getString("tea.name"));
				bean.setL_teaclass(rs.getString("le.class"));
				bean.setL_state(rs.getString("lein.l_state"));
				bean.setL_date(rs.getString("lein.l_date"));
				
				vlist.add(bean);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//선생의 내가 신청한 과외
		public Vector<LeinsertBean> getReceiveLessonList(String id){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<LeinsertBean> vlist=new Vector<LeinsertBean>();
			try {
				con = pool.getConnection();
				sql = "SELECT l_stuid,l_stname,l_stphone,l_staddress,l_state,l_date " + 
						"FROM leinsert WHERE l_teacharid=? order by l_date desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);

				rs = pstmt.executeQuery();
				while(rs.next()) {
					LeinsertBean bean=new LeinsertBean();
					bean.setL_stuid(rs.getString("l_stuid"));
					bean.setL_stname(rs.getString("l_stname"));
					bean.setL_stphone(rs.getString("l_stphone"));
					bean.setL_staddress(rs.getString("l_staddress"));
					bean.setL_state(rs.getString("l_state"));
					bean.setL_date(rs.getString("l_date"));
					
					vlist.add(bean);
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		public boolean changeState(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag=false;
			try {
				con = pool.getConnection();
				sql = "update leinsert set l_state='신청완료' where l_stuid=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);

				if(pstmt.executeUpdate()>=1) {
					flag=true;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
}
