package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AcqueryMgr {
	private DBConnectionMgr pool;
	public AcqueryMgr(){
		pool=DBConnectionMgr.getInstance();
	}
	
	//Board Total Count:�� �Խù� ��
	public int getTotalCount(int ac_num,String keyField,String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount=0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//�˻��� �ƴѰ��
				sql = "select count(*) from acquery where ac_num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ac_num);
			}
			else {
			//�˻��� ���
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
	
	//Board List:�������� ������ ������ ����,�˻� ����
	//keyField : ���ÿɼ�(name,title,content)
	//keyWord : �˻���
	//start : ���� ��ȣ
	//cnt : �� �������� ������ �Խù� ����
	public Vector<AcqueryBean> getBoardList(int ac_num,String keyField,String keyWord,int start,int cnt){
		 Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AcqueryBean> vlist=new Vector<AcqueryBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//�˻��� �ƴѰ��
				sql = "select num, ac_num,ac_title,ac_subject,ac_content,ac_ip,ac_id,ac_date,ac_count from acquery where ac_num=? limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ac_num);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
					 
	
			}
			else {
			//�˻��� ���
			sql = "select  num, ac_num,ac_title,ac_subject,ac_content,ac_ip,ac_id,ac_date,ac_count from acquery where ac_num=? and "+keyField+" like ? "
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
	public void insert(int i) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String subject="math";
		if(i%2==0) {
			subject="korean";
		}
		try {
			con = pool.getConnection();
			sql = "insert acquery(ac_num,ac_title,ac_subject,ac_id,ac_date,ac_count) "
					+ "values(256,?,?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, i+"");
			pstmt.setString(2, subject);
			pstmt.setString(3, i+"");
			pstmt.setInt(4, i);
			
			

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public static void main(String[] args) {
		AcqueryMgr s=new AcqueryMgr();
		for(int i=0;i<10;i++) {
			s.insert(i+1);
		}
	}
	
}
