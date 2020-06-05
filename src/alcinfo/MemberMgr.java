package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


import member.DBConnectionMgr;

public class MemberMgr {
	DBConnectionMgr pool;

	public MemberMgr() {
		pool = new DBConnectionMgr();
	}
	
	public MemberBean getId(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean=new MemberBean();
		
		try {
			con = pool.getConnection();
			sql = "select name,address from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				
				bean.setName(rs.getString(1));
				bean.setAddress(rs.getString(2));
				
			} 
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
}
