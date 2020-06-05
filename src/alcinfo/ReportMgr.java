package alcinfo;

import java.sql.Connection;




import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import alcinfo.DBConnectionMgr;
import alcinfo.ReportMgr;


public class ReportMgr {
	private DBConnectionMgr pool;
	
	public ReportMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//<!-- 7p 4. -->
	//<!-- MypeportList.jsp -->
	//
	public Vector<ReportBean> MRList(String reid){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReportBean> vlist = new Vector<ReportBean>();
		try {
			System.out.println("reid"+reid);

			con = pool.getConnection();
			sql = "select renum, regroup, retitle, recontent, restate, reid"
					+ " from report where reid ='"+reid+"'";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReportBean bean = new ReportBean();
				bean.setRenum(rs.getInt(1));
				bean.setRegroup(rs.getString(2));
				bean.setRetitle(rs.getString(3));
				bean.setRecontent(rs.getString(4));
				bean.setRestate(rs.getString(5));
				bean.setReid(rs.getString(6));

				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	
	///////////////////////////////
	
	//<!-- 13p 7.-->
	//<!-- reportReceipt.jsp -->
	//
	public void SendReport(ReportBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into report(regroup,retitle,recontent,reid,stopid,reip,restate,olddate)"
								+"values(?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getRegroup());
			pstmt.setString(2, bean.getRetitle());
			pstmt.setString(3, bean.getRecontent());
			pstmt.setString(4, bean.getReid());
			pstmt.setString(5, bean.getStopid());
			pstmt.setString(6, bean.getReip());
			pstmt.setString(7, bean.getRestate());
			pstmt.executeUpdate();		
			} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
			}
	}
	
	//<!-- 18p 12. -->
	//<!-- MGMemberContol.jsp -->
	//
	
	//
	public boolean MGMUpdate(ReportBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			System.out.println(bean.getRenum());
			System.out.println(bean.getRestate());
			try {
				con = pool.getConnection();
				sql = "update report set restate=? where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,bean.getRestate());
				pstmt.setInt(2,bean.getNum());
				if(pstmt.executeUpdate()==1) 
					flag=true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
	
	
	// MGMemberControl.jsp
	public Vector<ReportBean> mGMList(String keyField, 
			String keyWord){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReportBean> vlist = new Vector<ReportBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//
				sql = "select num,regroup, reid, stopid ,  retitle, recontent, restate"
						+ " from report";
				pstmt = con.prepareStatement(sql);
			}else {
				//
				sql = sql = "select num,regroup, reid, stopid ,  retitle, recontent, restate"
						+ " from report"
						+ " where " + keyField 
						+" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}
			rs = pstmt.executeQuery();
			while(rs.next()) { 
				ReportBean bean = new ReportBean();
				bean.setNum(rs.getInt(1));
				bean.setRegroup(rs.getString(2));
				bean.setReid(rs.getString(3));
				bean.setStopid(rs.getString(4));
				bean.setRetitle(rs.getString(5));
				bean.setRecontent(rs.getString(6));
				bean.setRestate(rs.getString(7));
				vlist.addElement(bean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	/////////////////////////////////////////////////
	//<!-- 19p 12. -->
	//<!--StateManagement.jsp -->

	//

	public boolean sMupdate(ReportBean bean,int plusdate,String stopid, int grade) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			if(grade==1) {
			sql = "update member set mdate=date_add(now(), interval "+plusdate+" day) "
					+ "where id=?";
			}else {
				sql = "update letea set mdate=date_add(now(), interval "+plusdate+" day) "
						+ "where id=?";
			}
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,bean.getStopid());
			if(pstmt.executeUpdate()==1) 
				flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	////
		public Vector<ReportBean> SMList(String keyField, 
			String keyWord){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReportBean> vlist = new Vector<ReportBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//
				sql = "SELECT DISTINCT(a.id),a.name,a.email,report.newdate,report.renum"
						+",report.num"
						+" FROM report,"
						+" (SELECT NAME,id,email"
						+" FROM member"
						+" UNION"
						+" SELECT NAME,id,email"
						+" FROM letea) a"
						+" WHERE report.stopid=a.id";
						
				pstmt = con.prepareStatement(sql);
			}else {
				//
				
				sql = 	"SELECT DISTINCT(a.id),a.name,a.email,report.newdate,report.renum"
						+",report.num"
						+" FROM report,"
						+" (SELECT NAME,id,email"
						+" FROM member"
						+" UNION"
						+" SELECT NAME,id,email"
						+" FROM letea) a"
						+" WHERE report.stopid=a.id and " + keyField 
						+" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReportBean bean = new ReportBean();
				bean.setStopid(rs.getString(1));
				bean.setName(rs.getString(2));				
				bean.setEmail(rs.getString(3));
				bean.setNewdate(rs.getString(4));
				bean.setRenum(rs.getInt(5));
				bean.setNum(rs.getInt(6));

				vlist.addElement(bean);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//
	public ReportBean getEmail(String stopid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ReportBean bean = new ReportBean();
		String a="";
		try {
			con = pool.getConnection();
			sql = "SELECT DISTINCT(a.id),a.email"
					+" FROM report,"
					+" (SELECT NAME,id,email"
					+" FROM member"
					+" UNION"
					+" SELECT NAME,id,email"
					+" FROM letea) a"
					+" WHERE a.id="+stopid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if(rs.next()) {
				bean.setEmail(rs.getString("email"));
				System.out.println(rs.getString("email"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//
	public ReportBean getGrade(String stopid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ReportBean bean = new ReportBean();
		String a="";
		try {
			con = pool.getConnection();
			sql = "select id, grade from member where id="+stopid
					+ " union "
					+ " select id, grade from letea where id="+stopid;
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
	//
	public void deleteSM(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from report where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	/////////////////////////
	public ReportBean comedate(int grade,String stopid) {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	ReportBean bean = new ReportBean();
	String date="";
	try {
		con = pool.getConnection();
		if(grade==1) {
		sql = "select mdate from member where id="+stopid;
		}
		else {
		sql = "select mdate from letea where id="+stopid;
			
		}
		pstmt = con.prepareStatement(sql);

		rs = pstmt.executeQuery();

		if(rs.next()) {
			bean.setMdate(rs.getString("mdate"));
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		pool.freeConnection(con, pstmt, rs);
	}
	return bean;
	}
}
