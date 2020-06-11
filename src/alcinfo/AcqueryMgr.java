package alcinfo;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import com.oreilly.servlet.MultipartRequest;

public class AcqueryMgr {
	private DBConnectionMgr pool;
	public AcqueryMgr(){
		pool=DBConnectionMgr.getInstance();
	}
	
	//Board Total Count:占쏙옙 占쌉시뱄옙 占쏙옙
	public int getTotalCount(int ac_num,String keyField,String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount=0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//占싯삼옙占쏙옙 占싣닌곤옙占�
				sql = "select count(*) from acquery where ac_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ac_num);
			}
			else {
			//占싯삼옙占쏙옙 占쏙옙占�
			sql = "select count(*) from acquery where ac_num=? and "
					+keyField+" like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ac_num);
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
	public Vector<AcqueryBean> getBoardList(int ac_num,String keyField,String keyWord,int start,int cnt){
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AcqueryBean> vlist=new Vector<AcqueryBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//占싯삼옙占쏙옙 占싣닌곤옙占�
				sql = "select num, ac_num,ac_title,ac_subject,ac_content,ac_ip,ac_id,ac_date,ac_count "
						+ "from acquery where ac_num=? order by num desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ac_num);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
					 
	
			}
			else {
			//占싯삼옙占쏙옙 占쏙옙占�
			sql = "select  num, ac_num,ac_title,ac_subject,ac_content,ac_ip,ac_id,ac_date,ac_count "
					+ "from acquery where ac_num=? and "+keyField+" like ? order by num desc "
					+ "limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ac_num);
			pstmt.setString(2, "%"+keyWord+"%");
			pstmt.setInt(3, start);
			pstmt.setInt(4, cnt);
				 
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				AcqueryBean bean = new AcqueryBean();
				bean.setNum(rs.getInt("num"));
				bean.setAc_num(rs.getInt("ac_num"));
				bean.setAc_title(rs.getString("ac_title"));
				bean.setAc_subject(rs.getString("ac_subject"));
				bean.setAc_content(rs.getString("ac_content"));
				bean.setAc_ip(rs.getString("ac_ip"));
				bean.setAc_id(rs.getString("ac_id"));
				bean.setAc_date(rs.getString("ac_date"));
				bean.setAc_count(rs.getInt("ac_count"));
				
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
	public void insertAcq(AcqueryBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert acquery(ac_num,ac_title,ac_subject,ac_content,"
					+ "ac_ip,ac_id,ac_date) values(?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getAc_num());
			pstmt.setString(2, bean.getAc_title());
			pstmt.setString(3, bean.getAc_subject());
			pstmt.setString(4, bean.getAc_content());
			pstmt.setString(5, bean.getAc_ip());
			pstmt.setString(6, bean.getAc_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 글보기 (한 개의 게시물, 모든 컬럼 리턴)
	public AcqueryBean getQuery(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		AcqueryBean bean = new AcqueryBean();
		try {
			con = pool.getConnection();
			sql = "select num,ac_num,ac_title,ac_subject,ac_content,"
					+ "ac_ip,ac_id,ac_date,ac_count from acquery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setAc_num(rs.getInt("ac_num"));
				bean.setAc_title(rs.getString("ac_title"));
				bean.setAc_subject(rs.getString("ac_subject"));
				bean.setAc_content(rs.getString("ac_content"));
				bean.setAc_ip(rs.getString("ac_ip"));
				bean.setAc_id(rs.getString("ac_id"));
				bean.setAc_date(rs.getString("ac_date"));
				bean.setAc_count(rs.getInt("ac_count"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 게시글 조회수 증가
	public void AcQupCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update acquery set ac_count = ac_count +1 where num = ?";
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
	public void deleteAcQ(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from acquery where num=?";
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
	public void updateAnQ(AcqueryBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update acquery set ac_title=?, ac_subject=?, ac_content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getAc_title());
			pstmt.setString(2, bean.getAc_subject());
			pstmt.setString(3, bean.getAc_content());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 하나의 게시글 댓글 갯수
	public int acqccount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int acqccount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from acqcomments where acq_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) acqccount=rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return acqccount;
	}
}
