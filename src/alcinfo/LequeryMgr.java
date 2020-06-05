
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
	
	//Board Total Count:�� �Խù� ��
	public int getTotalCount(int lq_lnum,String keyField,String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount=0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//�˻��� �ƴѰ��
				sql = "select count(*) from lequery where lq_lnum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, lq_lnum);
				
			}
			else {
			//�˻��� ���
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
	
	//Board List:�������� ������ ������ ����,�˻� ����
	//keyField : ���ÿɼ�(name,title,content)
	//keyWord : �˻���
	//start : ���� ��ȣ
	//cnt : �� �������� ������ �Խù� ����
	public Vector<LequeryBean> getBoardList(int lq_lnum,String keyField,String keyWord,int start,int cnt){
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<LequeryBean> vlist=new Vector<LequeryBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//�˻��� �ƴѰ��
				sql = "select num, lq_lnum,lq_title,lq_subject,lq_content,lq_ip,lq_id,lq_date,lq_count from lequery where lq_lnum=? limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, lq_lnum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
					 
	
			}
			else {
			//�˻��� ���
			sql = "select  num, lq_lnum,lq_title,lq_subject,lq_content,lq_ip,lq_id,lq_date,lq_count from lequery where lq_lnum=? and "+keyField+" like ? "
				+ "limit ?,?";
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
	
}

