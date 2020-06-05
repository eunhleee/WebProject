package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class LoginMgr {
	DBConnectionMgr pool;
	public LoginMgr() {
		pool=DBConnectionMgr.getInstance();
	}

	// 로그인 db insert
		public boolean insertLogin(MemberBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert login(id, passwd, name, grade) value(?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getId());
				pstmt.setString(2, bean.getPasswd());
				pstmt.setString(3, bean.getName());
				pstmt.setInt(4, bean.getGrade());
				if(bean.getId()==null || bean.getPasswd()==null || bean.getName()==null) {
					flag = false;
				}
				else if(pstmt.executeUpdate()==1) flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
		public boolean deleteLogin(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag=false;
			try {
				con = pool.getConnection();
				sql = "delete from login where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);

				if(pstmt.executeUpdate()>0) {
					flag=true;
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		
}
