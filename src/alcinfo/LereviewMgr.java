
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
					sql = "select count(*) from lereview ";
					pstmt = con.prepareStatement(sql);
				}
				else {
				//�˻��� ���
				sql = "select count(*) from lereview where "
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
					sql = "select num,lr_lnum,lr_nick,lr_id,lr_content,lr_ip,lr_star,lr_date "
							+ "from lereview "
							+ " where num=? limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setInt(2, start);
					pstmt.setInt(3, cnt);
						 
		
				}
				else {
				//�˻��� ���
				sql = "select num,lr_lnum,lr_nick,lr_id,lr_content,lr_ip,lr_star,lr_date "
						+ " from lereview where num=? and "+keyField+" like ? "
					+ " limit ?,?";
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
