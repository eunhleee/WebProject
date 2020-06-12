
package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class StinqueryMgr {
	private DBConnectionMgr pool;
	public StinqueryMgr(){
		pool=DBConnectionMgr.getInstance();
	}
	
	//Board Total Count:�� �Խù� ��
	public int getTotalCount(int stunum,String keyField,String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount=0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//�˻��� �ƴѰ��
				sql = "select count(*) from stquery where stunum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, stunum);
			}
			else {
			//�˻��� ���
			sql = "select count(*) from stquery where stunum=? and "
					+keyField+" like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, stunum);
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
	
	//Board List:�������� ������ ������ ����,�˻� ����
	//keyField : ���ÿɼ�(name,title,content)
	//keyWord : �˻���
	//start : ���� ��ȣ
	//cnt : �� �������� ������ �Խù� ����
	public Vector<StinqueryBean> getBoardList(int stunum,String keyField,String keyWord,int start,int cnt){
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<StinqueryBean> vlist=new Vector<StinqueryBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//�˻��� �ƴѰ��
				sql = "select num,stunum,title,content,id,ip,st_date,count from stquery "
						+ "where stunum=? order by num desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, stunum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
					 
	
			}
			else {
			//�˻��� ���
			sql = "select num,stunum,title,content,id,ip,st_date,count from stquery "
					+ "where stunum=? and "+keyField+" like ? "
					+ "order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, stunum);
			pstmt.setString(2, "%"+keyWord+"%");
			pstmt.setInt(3, start);
			pstmt.setInt(4, cnt);
				 
			}

			rs = pstmt.executeQuery();
			while(rs.next()) {
				StinqueryBean bean = new StinqueryBean();
				bean.setNum(rs.getInt("num"));
				bean.setStunum(rs.getInt("stunum"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				bean.setIp(rs.getString("ip"));
				bean.setId(rs.getString("id"));
				bean.setSt_date(rs.getString("st_date"));
				bean.setCount(rs.getInt("count"));
				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist; 
	}
	
	// 학생 문의 글쓰기
	public void insertStq(StinqueryBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert stquery(stunum,title,content,id,ip,st_date,count) "
					+ "values(?,?,?,?,?,now(),0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getStunum());
			pstmt.setString(2, bean.getTitle());
			pstmt.setString(3, bean.getContent());
			pstmt.setString(4, bean.getId());
			pstmt.setString(5, bean.getIp());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 글보기 (한 개의 게시물, 모든 컬럼 리턴)
	public StinqueryBean getQuery(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		StinqueryBean bean = new StinqueryBean();
		try {
			con = pool.getConnection();
			sql = "select num,stunum,title,content,id,ip,st_date,count "
					+ "from stquery where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setNum(rs.getInt("num"));
				bean.setStunum(rs.getInt("stunum"));
				bean.setTitle(rs.getString("title"));
				bean.setContent(rs.getString("content"));
				bean.setId(rs.getString("id"));
				bean.setIp(rs.getString("ip"));
				bean.setSt_date(rs.getString("st_date"));
				bean.setCount(rs.getInt("count"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	// 게시글 조회수 증가
	public void StQupCount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update stquery set count = count +1 where num = ?";
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
	public void deleteStQ(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from stquery where num=?";
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
	public void updateStQ(StinqueryBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "update stquery set title=?, content=? where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getTitle());
			pstmt.setString(2, bean.getContent());
			pstmt.setInt(3, bean.getNum());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	// 하나의 게시글 댓글 갯수
	public int stqccount(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int stqccount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(num) from stqcomments where stq_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) stqccount=rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return stqccount;
	}
	
}
