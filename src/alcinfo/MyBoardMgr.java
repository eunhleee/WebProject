package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class MyBoardMgr {
	private DBConnectionMgr pool;
	
	public MyBoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public Vector<MyBoardBean> MBList(String reid, int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MyBoardBean> vlist = new Vector<MyBoardBean>();
		try {
			con = pool.getConnection();
			sql = "select aq.ac_title as title, aq.ac_date as date, aq.ac_count as count, aq.num as num, "
					+ "aq.ac_num as ac_num, null as ac_serialnum, null as lq_lnum, null as lr_lnum, null as stunum, null as sc_group, null as cc_group "
					+ "from acquery aq "
					+ "where aq.ac_id=? "
					+ "union all "
				+ "select ar.ac_title as title, ar.ac_date as date, ar.ac_count as count, ar.num as num, "
					+ "null as ac_num, ar.ac_serialnum as ac_serialnum, null as lq_lnum, null as lr_lnum, null as stunum, null as sc_group, null as cc_group "
					+ "from acreview ar "
					+ "where ar.ac_id=? "
					+ "union all "
				+ "select lq.lq_title as title, lq.lq_date as date, lq.lq_count as count, lq.num as num, "
					+ "null as ac_num, null as ac_serialnum, lq.lq_lnum as lq_lnum, null as lr_lnum, null as stunum, null as sc_group, null as cc_group "
					+ "from lequery lq "
					+ "where lq.lq_id=? "
					+ "union all "
				+ "select lr.lr_title as title, lr.lr_date as date, lr.lr_count as count, lr.num as num, "
					+ "null as ac_num, null as ac_serialnum, null as lq_lnum, lr.lr_lnum as lr_lnum, null as stunum, null as sc_group, null as cc_group "
					+ "from lereview lr "
					+ "where lr.lr_id=? "
					+ "union all "
				+ "select st.title as title, st.st_date as date, st.count as count, st.num as num, "
					+ "null as ac_num, null as ac_serialnum, null as lq_lnum, null as lr_lnum, st.stunum as stunum, null as sc_group, null as cc_group "
					+ "from stquery st "
					+ "where st.id=? "
					+ "union all "
				+ "select sc.sc_title as title, sc.sc_regdate as date, sc.sc_count as count, sc.num as num, "
					+ "null as ac_num, null as ac_serialnum, null as lq_lnum, null as lr_lnum, null as stunum, sc.sc_group as sc_group, null as cc_group "
					+ "from scommunity sc "
					+ "where sc.sc_id=? "
					+ "union all "
				+ "select cs.cc_title as title, cs.cc_regdate as date, cs.cc_count as count, cs.num as num, "
					+ "null as ac_num, null as ac_serialnum, null as lq_lnum, null as lr_lnum, null as stunum, null as sc_group, cs.cc_group as cc_group "
					+ "from cs cs "
					+ "where cs.cc_id=? "
				+ "order by date desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reid);
			pstmt.setString(2, reid);
			pstmt.setString(3, reid);
			pstmt.setString(4, reid);
			pstmt.setString(5, reid);
			pstmt.setString(6, reid);
			pstmt.setString(7, reid);
			pstmt.setInt(8, start);
			pstmt.setInt(9, cnt);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MyBoardBean bean = new MyBoardBean();
				bean.setTitle(rs.getString(1));
				bean.setDate(rs.getString(2));
				bean.setCount(rs.getString(3));
				bean.setNum(rs.getString(4));
				bean.setAc_num(rs.getString(5));
				bean.setAc_serialnum(rs.getString(6));
				bean.setLq_lnum(rs.getString(7));
				bean.setLr_lnum(rs.getString(8));
				bean.setStunum(rs.getString(9));
				bean.setSc_group(rs.getString(10));
				bean.setCc_group(rs.getString(11));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public int getTotalCount(String reid) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select sum("
					+ "(select count(*) from acquery where ac_id=?) + "
					+ "(select count(*) from acreview where ac_id=?) + "
					+ "(select count(*) from lequery where lq_id=?) + "
					+ "(select count(*) from lereview where lr_id=?) + "
					+ "(select count(*) from stquery where id=?) + "
					+ "(select count(*) from scommunity where sc_id=?) + "
					+ "(select count(*) from cs where cc_id=?)) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, reid);
			pstmt.setString(2, reid);
			pstmt.setString(3, reid);
			pstmt.setString(4, reid);
			pstmt.setString(5, reid);
			pstmt.setString(6, reid);
			pstmt.setString(7, reid);
			rs = pstmt.executeQuery();
			if(rs.next()) totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	public String checkleid(String num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String id = null;
		try {
			con = pool.getConnection();
			sql = "select id from lesson where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) id = rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return id;
	}
}
