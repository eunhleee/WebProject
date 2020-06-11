
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
	
	//Board Total Count:占쏙옙 占쌉시뱄옙 占쏙옙
	public int getTotalCount(int lq_lnum,String keyField,String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount=0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//占싯삼옙占쏙옙 占싣닌곤옙占�
				sql = "select count(*) from lequery where lq_lnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, lq_lnum);
				
			}
			else {
			//占싯삼옙占쏙옙 占쏙옙占�
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
	
	//Board List:占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙,占싯삼옙 占쏙옙占쏙옙
	//keyField : 占쏙옙占시옵쇽옙(name,title,content)
	//keyWord : 占싯삼옙占쏙옙
	//start : 占쏙옙占쏙옙 占쏙옙호
	//cnt : 占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쌉시뱄옙 占쏙옙占쏙옙
	public Vector<LequeryBean> getBoardList(int lq_lnum,String keyField,String keyWord,int start,int cnt){
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<LequeryBean> vlist=new Vector<LequeryBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//占싯삼옙占쏙옙 占싣닌곤옙占�
				sql = "select num, lq_lnum,lq_title,lq_subject,lq_content,lq_ip,lq_id,lq_date,"
						+ "lq_count from lequery where lq_lnum=? order by num desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, lq_lnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
					 
	
			}
			else {
			//占싯삼옙占쏙옙 占쏙옙占�
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
	
	// 학원 문의 글쓰기
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
	
	// 글보기 (한 개의 게시물, 모든 컬럼 리턴)
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
	
	// 게시글 조회수 증가
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
	
	// 게시글 삭제
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
	
	// 게시글 수정
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
	
	// 하나의 게시글 댓글 갯수
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
}

