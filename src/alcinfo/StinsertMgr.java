package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class StinsertMgr {
	DBConnectionMgr pool;
	
	public StinsertMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	public boolean insertTea(StudentBean sbean,LessonBean lbean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "insert stinsert(num,stid,teaid,teaname,teaphone,stclass,state,date )"
					+ "values(?,?,?,?,?,?,'신청접수',now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, sbean.getNum());
			pstmt.setString(2, sbean.getId());
			pstmt.setString(3, lbean.getId());
			pstmt.setString(4, lbean.getName());
			pstmt.setString(5, lbean.getPhone());
			pstmt.setString(6, lbean.getLeclass());
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
	
	//선생의 내가 신청한 과외
	public Vector<StinsertBean> getReceiveLessonList(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<StinsertBean> vlist=new Vector<StinsertBean>();
		try {
			con = pool.getConnection();
			sql = "select teaid,teaname,teaphone,stclass,state,date from stinsert where stid=? order by date desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				StinsertBean bean=new StinsertBean();
				bean.setTeaid(rs.getString("teaid"));
				bean.setTeaname(rs.getString("teaname"));
				bean.setTeaphone(rs.getString("teaphone"));
				bean.setStclass(rs.getString("stclass"));
				bean.setState(rs.getString("state"));
				bean.setDate(rs.getString("date"));
				
				vlist.add(bean);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public Vector<StinsertBean> getMyLessonList(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<StinsertBean> vlist=new Vector<StinsertBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT mem.name,stin.stclass,stin.state,stin.date " + 
					"FROM stinsert stin,student st,member mem " + 
					"WHERE stin.stid=st.id AND st.id=mem.id and stin.stid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();
			while(rs.next()) {
				StinsertBean bean=new StinsertBean();
				bean.setStname(rs.getString("mem.name"));
				bean.setStclass(rs.getString("stin.stclass"));
				bean.setState(rs.getString("stin.state"));
				bean.setDate(rs.getString("stin.date"));
				
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
			sql = "update stinsert set state='신청완료' where teaid=?";
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
