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
	//Board Total Count:�� �Խù� ��
		public int getTotalCount(String keyField,String keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount=0;
			try {
				con = pool.getConnection();
				if(keyWord.trim().equals("")||keyWord==null) {
					//�˻��� �ƴѰ��
					sql = "select count(*) from acreview ";
					pstmt = con.prepareStatement(sql);
				}
				else {
				//�˻��� ���
				sql = "select count(*) from acreview where "
						+keyField+" like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
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
		public Vector<AcreviewBean> getBoardList(int ac_serialnum,String keyField,String keyWord,int start,int cnt){
			 Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<AcreviewBean> vlist=new Vector<AcreviewBean>();
			try {
				con = pool.getConnection();
				if(keyWord.trim().equals("")||keyWord==null) {
					//�˻��� �ƴѰ��
					sql = "select num,ac_serialnum,ac_title,ac_content,ac_ip,ac_star,ac_nickname,ac_id,ac_date from acreview where ac_serialnum=? limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, ac_serialnum);
					pstmt.setInt(2, start);
					pstmt.setInt(3, cnt);
						 
		
				}
				else {
				//�˻��� ���
				sql = "select num,ac_serialnum,ac_title,ac_content,ac_ip,ac_star,ac_nickname,ac_id,ac_date from acreview where ac_serialnum=? and "+keyField+" like ? "
					+ "limit ?,?";
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
					bean.setAc_star(rs.getFloat("ac_star"));
					bean.setAc_nickname(rs.getString("ac_content"));
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
	
}
