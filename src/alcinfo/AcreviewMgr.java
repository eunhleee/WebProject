package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AcreviewMgr {
	private DBConnectionMgr pool;

	public AcreviewMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//Board Total Count:占쏙옙 占쌉시뱄옙 占쏙옙
	public int getTotalCount(String keyField,String keyWord, int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount=0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//占싯삼옙占쏙옙 占싣닌곤옙占�
				sql = "select count(*) from acreview where ac_serialnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
			}
			else {
			//占싯삼옙占쏙옙 占쏙옙占�
			sql = "select count(*) from acreview where "
					+keyField+" like ? and ac_serialnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyWord+"%");
			pstmt.setInt(2, num);
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
	public Vector<AcreviewBean> getBoardList(int ac_serialnum,String keyField,String keyWord,int start,int cnt){
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AcreviewBean> vlist=new Vector<AcreviewBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//占싯삼옙占쏙옙 占싣닌곤옙占�
				sql = "select num,ac_serialnum,ac_title,ac_content,ac_ip,ac_star,ac_nickname,ac_id,"
						+ "ac_date,ac_count from acreview where ac_serialnum=? order by num desc "
						+ "limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ac_serialnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
					 
	
			}
			else {
			//占싯삼옙占쏙옙 占쏙옙占�
			sql = "select num,ac_serialnum,ac_title,ac_content,ac_ip,ac_star,ac_nickname,ac_id,"
					+ "ac_date,ac_count from acreview where ac_serialnum=? and "+keyField+" like ? "
					+ "order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ac_serialnum);
			pstmt.setString(2, "%"+keyWord+"%");
			pstmt.setInt(3, start);
			pstmt.setInt(4, cnt);
				 
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				AcreviewBean bean = new AcreviewBean();
				bean.setNum(rs.getInt("num"));
				bean.setAc_serialnum(rs.getInt("ac_serialnum"));
				bean.setAc_title(rs.getString("ac_title"));
				bean.setAc_content(rs.getString("ac_content"));
				bean.setAc_ip(rs.getString("ac_ip"));
				bean.setAc_star(rs.getDouble("ac_star"));
				bean.setAc_nickname(rs.getString("ac_nickname"));
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
	
	// 리뷰 글쓰기
	public void insertAcr(AcreviewBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int avg=0;
		try {
			con = pool.getConnection();
			sql = "insert acreview(ac_serialnum,ac_title,ac_content,ac_ip,ac_star,"
					+ "ac_nickname,ac_id,ac_date) "
					+ "values(?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getAc_serialnum());
			pstmt.setString(2, bean.getAc_title());
			pstmt.setString(3, bean.getAc_content());
			pstmt.setString(4, bean.getAc_ip());
			pstmt.setDouble(5, bean.getAc_star());
			pstmt.setString(6, memberNick(bean.getAc_id()));
			pstmt.setString(7, bean.getAc_id());
			pstmt.executeUpdate();
			
			
			  sql = "SELECT AVG(ac_star) FROM acreview WHERE ac_serialnum=?"; 
			  pstmt =  con.prepareStatement(sql); 
			  pstmt.setInt(1, bean.getAc_serialnum());
			  rs=pstmt.executeQuery(); 
			  if(rs.next()) { 
				  avg=rs.getInt(1);
				  }
			  sql = "update academy set star=? where num=?";
			  pstmt = con.prepareStatement(sql);
			  pstmt.setInt(1, avg); 
			  pstmt.setInt(2, bean.getAc_serialnum());
			  pstmt.executeUpdate();
			 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 한 개의 리뷰 가져오기(모든 컬럼 리턴)
	public AcreviewBean getReview(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		AcreviewBean bean = new AcreviewBean();
		try {
			con = pool.getConnection();
			sql = "select num,ac_serialnum,ac_title,ac_content,ac_ip,ac_star,ac_nickname,"
					+ "ac_id,ac_date,ac_count from acreview where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setAc_serialnum(rs.getInt("ac_serialnum"));
				bean.setAc_title(rs.getString("ac_title"));
				bean.setAc_content(rs.getString("ac_content"));
				bean.setAc_ip(rs.getString("ac_ip"));
				bean.setAc_star(rs.getDouble("ac_star"));
				bean.setAc_nickname(rs.getString("ac_nickname"));
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
	
	// 조회수 증가
	public void AcrupCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update acreview set ac_count = ac_count +1 where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 리뷰 삭제
	public void deleteAcr(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from acreview where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 리뷰 수정
	public void updateAcr(AcreviewBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update acreview set ac_title=?, ac_star=?, ac_content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getAc_title());
			pstmt.setDouble(2, bean.getAc_star());
			pstmt.setString(3, bean.getAc_content());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 한 개의 리뷰 댓글 갯수
	public int acrccount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int acrccount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from acrcomments where acr_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) acrccount=rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return acrccount;
	}
	
	// 닉네임 찾기
	public String memberNick(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String nick = null;
		try {
			con = pool.getConnection();
			sql = "select nickname from member where id=? "
					+ "union all "
					+ "select nickname from letea where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			rs = pstmt.executeQuery();
			if(rs.next()) nick=rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return nick;
	}
	
	public int checkM(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int grade = 5;
		try {
			con = pool.getConnection();
			sql = "select grade from member where id=? "
					+ "union "
					+ "select grade from letea where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
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
