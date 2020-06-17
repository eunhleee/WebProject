package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class AcademyMgr {
	private DBConnectionMgr pool;
	public AcademyMgr(){
		pool=DBConnectionMgr.getInstance();
	}
	
	
	
	public Vector<AcademyBean> getBestBoard(String pageValue,String sort){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AcademyBean> vlist= new Vector<AcademyBean>();
		try {
			con = pool.getConnection();
			if(pageValue.equals("top")) {
			sql = "select num,imgname, ac_name,group2, ac_tel,star,count from academy order by star desc";
			pstmt = con.prepareStatement(sql);
			}
			else {
				sql = "select num,imgname, ac_name,group2, ac_tel,star,count from academy "
						+ " where group1 like ? order by ? desc";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, pageValue+"%");
				pstmt.setString(2, sort);
				
			}
			
			rs = pstmt.executeQuery();//select ����
			while(rs.next()) {
				AcademyBean bean = new AcademyBean();
				bean.setNum(rs.getInt("num"));
				bean.setImgname(rs.getString("imgname"));
				bean.setAc_name(rs.getString("ac_name"));
				bean.setGroup2(rs.getString("group2"));
				bean.setAc_tel(rs.getString("ac_tel"));
				bean.setStar(rs.getInt("star"));
				bean.setCount(rs.getInt("count"));
				
				vlist.addElement(bean);
			}
			
		}
	catch (Exception e) {
		e.printStackTrace();
	}finally {
		pool.freeConnection(con, pstmt, rs);
	}
	return vlist;
}
	
	
	
	public Vector<AcademyBean> getCountBoard(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AcademyBean> vlist= new Vector<AcademyBean>();
		try {
			con = pool.getConnection();
			sql = "select num,imgname, ac_name,group2, ac_tel,star,count from academy order by count desc";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();//select ����
			while(rs.next()) {
				AcademyBean bean = new AcademyBean();
				bean.setNum(rs.getInt("num"));
				bean.setImgname(rs.getString("imgname"));
				bean.setAc_name(rs.getString("ac_name"));
				bean.setGroup2(rs.getString("group2"));
				bean.setAc_tel(rs.getString("ac_tel"));
				bean.setStar(rs.getInt("star"));
				bean.setCount(rs.getInt("count"));
				
				vlist.addElement(bean);
			}
			
		}
	catch (Exception e) {
		e.printStackTrace();
	}finally {
		pool.freeConnection(con, pstmt, rs);
	}
	return vlist;
}
	
		public AcademyBean getAcademy(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			AcademyBean bean = new AcademyBean();
			try {
				con = pool.getConnection();
				sql = "select * from academy where num = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setNum(rs.getInt("num"));
					bean.setAc_name(rs.getString("ac_name"));
					bean.setGroup1(rs.getString("group1"));
					bean.setGroup2(rs.getString("group2"));
					bean.setAc_address(rs.getString("ac_address"));
					bean.setAc_tel(rs.getString("ac_tel"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
		public Vector<AcademyBean> getSearchList(String keyWord){
			 Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<AcademyBean> vlist=new Vector<AcademyBean>();
			try {
				con = pool.getConnection();
				if(keyWord.equals("과학")) {
					sql = "select num,imgname, ac_name,group2, ac_tel,star,count from academy "
							+" where ac_name like '%과학%' and ac_name not in	 ( select ac_name  from academy where ac_name like '%단과학원')";
					pstmt = con.prepareStatement(sql);
				}
				else if(!keyWord.trim().equals("")||keyWord!=null) {
					
				
				sql = "select num,imgname, ac_name,group2, ac_tel,star,count from academy "
					+ " where ac_name like ? or ac_address like ? or group1 like ? or group2 like ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setString(2, "%"+keyWord+"%");
				pstmt.setString(3, "%"+keyWord+"%");
				pstmt.setString(4, "%"+keyWord+"%");
				}
				
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					AcademyBean bean = new AcademyBean();
					bean.setNum(rs.getInt("num"));
					bean.setImgname(rs.getString("imgname"));
					bean.setAc_name(rs.getString("ac_name"));
					bean.setGroup2(rs.getString("group2"));
					bean.setAc_tel(rs.getString("ac_tel"));
					bean.setStar(rs.getFloat("star"));
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
		
		//조회수 증가
				public void upAcCount(int num) {
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					try {
						con = pool.getConnection();
						sql = "update academy set count = count +1 where num = ?";
						pstmt = con.prepareStatement(sql);
						pstmt.setInt(1, num);
						pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt);
					}
				}	
	
	
	}

