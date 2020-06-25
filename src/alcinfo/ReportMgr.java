package alcinfo;

import java.sql.Connection;

import java.io.File;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import alcinfo.DBConnectionMgr;
import alcinfo.ReportMgr;
import javax.servlet.http.HttpServletRequest;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ReportMgr {
	private DBConnectionMgr pool;
	File file = new File("");
	private final String  SAVEFOLDER = "C:/WerPro4/WebProject/WebContent/img";
	private final String ENCTYPE = "UTF-8";
	private int MAXSIZE = 5*1024*1024;
	 public ReportMgr() {
		pool = DBConnectionMgr.getInstance();

	}
	// img update : 
		public void insertPBlog(HttpServletRequest req) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			MemberBean bean = new MemberBean();

			try {
				con = pool.getConnection();
				MultipartRequest multi = 
						new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE,
								new DefaultFileRenamePolicy());
				//DefaultFileRenamePolicy() -> 
				String photo = null;
				//post.jsp
				if(multi.getFilesystemName("photo")!=null) {
					photo = multi.getFilesystemName("photo");
				}
				con = pool.getConnection();
				sql = "update member set imgname=? where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1,photo);
				pstmt.setString(2,multi.getParameter("id"));
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	
	//<!-- 7p 4. -->
	//<!-- MypeportList.jsp -->
	//
	public Vector<ReportBean> MRList(String keyField, 
			String keyWord, String reid,int start, int cnt){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReportBean> vlist = new Vector<ReportBean>();
		try {
			System.out.println("reid"+reid);

			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//
			sql = "select renum, regroup, retitle, recontent, restate, reid,olddate"
					+ " from report where reid ='"+reid+"' order by olddate desc,recontent limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, cnt);
			}else {
				sql = "select renum, regroup, retitle, recontent, restate, reid"
						+ " from report where reid ='"+reid+"'"
								+ " and " +keyField+" like ? order by olddate desc,recontent limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReportBean bean = new ReportBean();
				bean.setRenum(rs.getInt(1));
				bean.setRegroup(rs.getString(2));
				bean.setRetitle(rs.getString(3));
				bean.setRecontent(rs.getString(4));
				bean.setRestate(rs.getString(5));
				bean.setReid(rs.getString(6));
				bean.setOlddate(rs.getString(7));

				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//Board Total Count : �룯占� 野껊슣�뻻�눧�눘�땾
	public int getTotalCount(String keyField, String keyWord, String reid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//野껓옙占쎄퉳占쎌뵠 占쎈툡占쎈빒野껋럩�뒭
				sql = "select count(*) from report where reid ="+"'"+reid+"'";
				pstmt = con.prepareStatement(sql);
				
			}else {
				//野껓옙占쎄퉳占쎌뵥 野껋럩�뒭
				sql = "select count(*) from report where " 
				+ keyField +" like ? and reid = "+"'"+reid+"'";;
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}
			rs = pstmt.executeQuery();
			if(rs.next()) totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	/*
	public Vector<ReportBean> MRList(String keyField, 
			String keyWord, String reid,int start, int cnt){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReportBean> vlist = new Vector<ReportBean>();
		try {
			System.out.println("reid"+reid);

			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//
			sql = "select renum, regroup, retitle, recontent, restate, reid"
					+ " from report where reid ='"+reid+"'";
			pstmt = con.prepareStatement(sql);

			}else {
				sql = "select renum, regroup, retitle, recontent, restate, reid"
						+ " from report where reid ='"+reid+"'"
								+ " and " +keyField+" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}

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
	*///占쎌뿫占쎈뻻獄쏄퉮毓�
	
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
	//
	public void rePortSI(ReportBean bean,String url) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into report(regroup,retitle,recontent,reid,stopid,reip,restate,olddate,kind,stopurl)"
								+"values(?,?,?,?,?,?,?,now(),?,"+"'"+ url+"'" +")";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getRegroup());
			pstmt.setString(2, bean.getRetitle());
			pstmt.setString(3, bean.getRecontent());
			pstmt.setString(4, bean.getReid());
			pstmt.setString(5, bean.getStopid());
			pstmt.setString(6, bean.getReip());
			pstmt.setString(7, bean.getRestate());
			pstmt.setString(8, bean.getKind());

			pstmt.executeUpdate();		
			} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
			}
	}
	//
	public void rePortAI(ReportBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into report(regroup,retitle,recontent,reid,stopid,reip,restate,olddate,kind,stopurl)"
								+"values(?,?,?,?,?,?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getRegroup());
			pstmt.setString(2, bean.getRetitle());
			pstmt.setString(3, bean.getRecontent());
			pstmt.setString(4, bean.getReid());
			pstmt.setString(5, bean.getStopid());
			pstmt.setString(6, bean.getReip());
			pstmt.setString(7, bean.getRestate());
			pstmt.setString(8, bean.getKind());
			pstmt.setString(9, bean.getStopurl());

			pstmt.executeUpdate();		
			} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
			}
	}
	//report bulletin board 
	public void reportBoard(ReportBean bean,String stopurl) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into report(regroup,retitle,recontent,reid,stopid,reip,restate,olddate,kind,renum,stopurl)"
								+"values(?,?,?,?,?,?,?,now(),?,?,"+"'"+stopurl+"'"+")";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getRegroup());
			pstmt.setString(2, bean.getRetitle());
			pstmt.setString(3, bean.getRecontent());
			pstmt.setString(4, bean.getReid());
			pstmt.setString(5, bean.getStopid());
			pstmt.setString(6, bean.getReip());
			pstmt.setString(7, bean.getRestate());
			pstmt.setString(8, bean.getKind());
			pstmt.setInt(9, bean.getRenum());
			pstmt.executeUpdate();		
			} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
			}
	}
	
	
	
	///
	
	public void reportBoardcom(ReportBean bean,String stopurl) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into report(regroup,retitle,recontent,reid,stopid,reip,restate,olddate,kind,renum,conum,depth,stopurl)"
								+"values(?,?,?,?,?,?,?,now(),?,?,?,?,'"+stopurl+"'"+")";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getRegroup());
			pstmt.setString(2, bean.getRetitle());
			pstmt.setString(3, bean.getRecontent());
			pstmt.setString(4, bean.getReid());
			pstmt.setString(5, bean.getStopid());
			pstmt.setString(6, bean.getReip());
			pstmt.setString(7, bean.getRestate());
			pstmt.setString(8, bean.getKind());
			pstmt.setInt(9, bean.getRenum());
			pstmt.setInt(10,bean.getConum());
			pstmt.setInt(11,bean.getDepth());

			pstmt.executeUpdate();		
			} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
			}
	}
	//<!-- reportReceiptLInf.jsp -->
	//lesson - False Information Reporting
	public void lISendReport(ReportBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into report(regroup,retitle,recontent,reid,stopid,reip,restate,kind,olddate)"
								+"values(?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getRegroup());
			pstmt.setString(2, bean.getRetitle());
			pstmt.setString(3, bean.getRecontent());
			pstmt.setString(4, bean.getReid());
			pstmt.setString(5, bean.getStopid());
			pstmt.setString(6, bean.getReip());
			pstmt.setString(7, bean.getRestate());
			pstmt.setString(8, bean.getKind());
			
			pstmt.executeUpdate();		
			} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
			}
	}
	
		//<!-- reportReceiptAInf.jsp -->
		//
		public void aISendReport(ReportBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "insert into report(regroup,retitle,recontent,reid,stopid,reip,restate,kind,olddate)"
									+"values(?,?,?,?,?,?,?,?,now())";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getRegroup());
				pstmt.setString(2, bean.getRetitle());
				pstmt.setString(3, bean.getRecontent());
				pstmt.setString(4, bean.getReid());
				pstmt.setString(5, bean.getStopid());
				pstmt.setString(6, bean.getReip());
				pstmt.setString(7, bean.getRestate());
				pstmt.setString(8, bean.getKind());
				
				pstmt.executeUpdate();		
				} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
				}
		}
		
		
		//student id get
		public MemberBean getStuId(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MemberBean bean = new MemberBean();
			String a="";
			try {
				con = pool.getConnection();
				sql = "SELECT id from student where num="+num;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();

				if(rs.next()) {
					bean.setId(rs.getString(1));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
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
				sql = "update report set restate=?, newdate=now() where num=?";
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
			String keyWord, int start, int cnt){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReportBean> vlist = new Vector<ReportBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//
				sql = "select num,regroup, reid, stopid , retitle, recontent, restate,kind,stopurl"
						+ " from report limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			}else {
				//
				sql = sql = "select num,regroup, reid, stopid ,  retitle, recontent, restate,kind,stopurl"
						+ " from report "
						+ " where " + keyField 
						+" like ? limit ?,?";
				pstmt = con.prepareStatement(sql);

				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
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
				bean.setKind(rs.getString(8));
				bean.setStopurl(rs.getString(9));

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
	public boolean rMupdate(ReportBean bean,int plusdate,String stopid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update report set newdate=now(), restate='완료'"
					+ "where stopid=?";
			
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
	public int rgetTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				
				sql = "select count(*) from report";
				pstmt = con.prepareStatement(sql);
				
			}else {
				sql = "select count(*) from report where " 
				+ keyField +" like ?";;
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
			}
			rs = pstmt.executeQuery();
			if(rs.next()) totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	////
	public Vector<ReportBean> SMList(String keyField, String keyWord,int start, int cnt){
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
						+" WHERE report.stopid=a.id"
						+ " limit ?,?";
						
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
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
						+" WHERE report.stopid=a.id and a." + keyField 
						+" like ? "
						+ "limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
			
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
