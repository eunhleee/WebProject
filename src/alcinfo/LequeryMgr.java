
package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class LequeryMgr {
	private DBConnectionMgr pool;
	public LequeryMgr(){
		pool=DBConnectionMgr.getInstance();
	}
	
	//Board Total Count:
	public int getTotalCount(int lq_lnum,String keyField,String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount=0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//
				sql = "select count(*) from lequery where lq_lnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, lq_lnum);
				
			}
			else {
			//
			sql = "select count(*) from lequery where lq_lnum=? and "
					+keyField+" like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, lq_lnum);
			pstmt.setString(2, "%"+keyWord+"%");
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				totalCount=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	//Board List:
	//keyField :(name,title,content)
	//keyWord :
	//start :
	//cnt :
	public Vector<LequeryBean> getBoardList(int lq_lnum,String keyField,String keyWord,int start,int cnt){
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<LequeryBean> vlist=new Vector<LequeryBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//
				sql = "select num, lq_lnum,lq_title,lq_subject,lq_content,lq_ip,lq_id,lq_date,"
						+ "lq_count from lequery where lq_lnum=? order by num desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, lq_lnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
					 
	
			}
			else {
			//
			sql = "select  num, lq_lnum,lq_title,lq_subject,lq_content,lq_ip,lq_id,lq_date,"
					+ "lq_count from lequery where lq_lnum=? and "+keyField+" like ? "
				+ "order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, lq_lnum);
			pstmt.setString(2, "%"+keyWord+"%");
			pstmt.setInt(3, start);
			pstmt.setInt(4, cnt);
				 
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				LequeryBean bean = new LequeryBean();
				bean.setNum(rs.getInt("num"));
				bean.setLq_lnum(rs.getInt("lq_lnum"));
				bean.setLq_title(rs.getString("lq_title"));
				bean.setLq_subject(rs.getString("lq_subject"));
				bean.setLq_content(rs.getString("lq_content"));
				bean.setLq_ip(rs.getString("lq_ip"));
				bean.setLq_id(rs.getString("lq_id"));
				bean.setLq_date(rs.getString("lq_date"));
				bean.setLq_count(rs.getInt("lq_count"));
				
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
	public void insertLeq(LequeryBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert lequery(lq_lnum,lq_title,lq_subject,lq_content,"
					+ "lq_ip,lq_id,lq_date) values(?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getLq_lnum());
			pstmt.setString(2, bean.getLq_title());
			pstmt.setString(3, bean.getLq_subject());
			pstmt.setString(4, bean.getLq_content());
			pstmt.setString(5, bean.getLq_ip());
			pstmt.setString(6, bean.getLq_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 
	public LequeryBean getQuery(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		LequeryBean bean = new LequeryBean();
		try {
			con = pool.getConnection();
			sql = "select num,lq_lnum,lq_title,lq_subject,lq_content,"
					+ "lq_ip,lq_id,lq_date,lq_count from lequery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setLq_lnum(rs.getInt("lq_lnum"));
				bean.setLq_title(rs.getString("lq_title"));
				bean.setLq_subject(rs.getString("lq_subject"));
				bean.setLq_content(rs.getString("lq_content"));
				bean.setLq_ip(rs.getString("lq_ip"));
				bean.setLq_id(rs.getString("lq_id"));
				bean.setLq_date(rs.getString("lq_date"));
				bean.setLq_count(rs.getInt("lq_count"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 
	public void LeQupCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update lequery set lq_count = lq_count +1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 
	public void deleteLeQ(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from lequery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 
	public void updateLeQ(LequeryBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update lequery set lq_title=?, lq_subject=?, lq_content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getLq_title());
			pstmt.setString(2, bean.getLq_subject());
			pstmt.setString(3, bean.getLq_content());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 
	public int leqccount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int leqccount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from leqcomments where leq_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) leqccount=rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return leqccount;
	}
	
	public int checkM(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int grade = 1;
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
}

