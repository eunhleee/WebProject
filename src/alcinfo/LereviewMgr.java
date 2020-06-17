
package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class LereviewMgr {
	private DBConnectionMgr pool;

	public LereviewMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//Board Total Count:�� �Խù� ��
	public int getTotalCount(String keyField,String keyWord, int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount=0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//�˻��� �ƴѰ��
				sql = "select count(*) from lereview where lr_lnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
			}
			else {
			//�˻��� ���
			sql = "select count(*) from lereview where "
					+keyField+" like ? and lr_lnum=?";
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
	
	//Board List:�������� ������ ������ ����,�˻� ����
	//keyField : ���ÿɼ�(name,title,content)
	//keyWord : �˻���
	//start : ���� ��ȣ
	//cnt : �� �������� ������ �Խù� ����
	public Vector<LereviewBean> getBoardList(int num,String keyField,String keyWord,int start,int cnt){
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<LereviewBean> vlist=new Vector<LereviewBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//�˻��� �ƴѰ��
				sql = "select num,lr_lnum,lr_nick,lr_id,lr_content,lr_ip,lr_star,lr_date,lr_count,lr_title "
						+ "from lereview "
						+ " where lr_lnum=? order by num desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
					 
	
			}
			else {
			//�˻��� ���
			sql = "select num,lr_lnum,lr_nick,lr_id,lr_content,lr_ip,lr_star,lr_date,lr_count,lr_title "
					+ " from lereview where lr_lnum=? and "+keyField+" like ? "
				+ " order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, "%"+keyWord+"%");
			pstmt.setInt(3, start);
			pstmt.setInt(4, cnt);
				 
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				LereviewBean bean = new LereviewBean();
				bean.setNum(rs.getInt("num"));
				bean.setLr_lnum(rs.getInt("lr_lnum"));
				bean.setLr_nick(rs.getString("lr_nick"));
				bean.setLr_id(rs.getString("lr_id"));
				bean.setLr_content(rs.getString("lr_content"));
				bean.setLr_ip(rs.getString("lr_ip"));
				bean.setLr_star(rs.getFloat("lr_star"));
				bean.setLr_date(rs.getString("lr_date"));
				bean.setLr_count(rs.getInt("lr_count"));
				bean.setLr_title(rs.getString("lr_title"));
				
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
	public void insertLer(LereviewBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert lereview(lr_lnum,lr_title,lr_content,lr_ip,lr_star,"
					+ "lr_nick,lr_id,lr_date) "
					+ "values(?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getLr_lnum());
			pstmt.setString(2, bean.getLr_title());
			pstmt.setString(3, bean.getLr_content());
			pstmt.setString(4, bean.getLr_ip());
			pstmt.setDouble(5, bean.getLr_star());
			pstmt.setString(6, memberNick(bean.getLr_id()));
			pstmt.setString(7, bean.getLr_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 한 개의 리뷰 가져오기(모든 컬럼 리턴)
	public LereviewBean getReview(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		LereviewBean bean = new LereviewBean();
		try {
			con = pool.getConnection();
			sql = "select num,lr_lnum,lr_title,lr_content,lr_ip,lr_star,lr_nick,"
					+ "lr_id,lr_date,lr_count from lereview where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setLr_lnum(rs.getInt("lr_lnum"));
				bean.setLr_title(rs.getString("lr_title"));
				bean.setLr_content(rs.getString("lr_content"));
				bean.setLr_ip(rs.getString("lr_ip"));
				bean.setLr_star(rs.getDouble("lr_star"));
				bean.setLr_nick(rs.getString("lr_nick"));
				bean.setLr_id(rs.getString("lr_id"));
				bean.setLr_date(rs.getString("lr_date"));
				bean.setLr_count(rs.getInt("lr_count"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 조회수 증가
	public void LerupCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update lereview set lr_count = lr_count +1 where num = ?";
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
	public void deleteLer(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from lereview where num=?";
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
	public void updateLer(LereviewBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update lereview set lr_title=?, lr_star=?, lr_content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getLr_title());
			pstmt.setDouble(2, bean.getLr_star());
			pstmt.setString(3, bean.getLr_content());
			pstmt.setInt(4, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 한 개의 리뷰 댓글 갯수
	public int lerccount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int lerccount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from lercomments where ler_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) lerccount=rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return lerccount;
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
