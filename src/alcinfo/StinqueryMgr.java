
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
				sql = "select num,stunum,title,content,id,ip,st_date,count from stquery where stunum=? limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, stunum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
					 
	
			}
			else {
			//�˻��� ���
			sql = "select num,stunum,title,content,id,ip,st_date,count from stquery where stunum=? and "+keyField+" like ? "
				+ "limit ?,?";
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
	
	public void insert(int i) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert stquery(stunum,title,content,id,st_date,count) "
					+ "values(2,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, i+"");
			pstmt.setString(2, i+"");
			pstmt.setString(3, i+"");
			pstmt.setString(4, i+"");
			

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public static void main(String[] args) {
		StinqueryMgr s=new StinqueryMgr();
		for(int i=0;i<10;i++) {
			s.insert(i+11);
		}
	}
	
}
