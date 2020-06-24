package alcinfo;

import java.sql.Connection;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class AcademyMgr {
	private DBConnectionMgr pool;
	private static final String UPLOAD = "C:/WerPro4/WebProject/WebContent/authority/";
	private static final String ENCTYPE = "UTF-8";
	private static final int MAXSIZE = 10*1024*1024;
	
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
			
			rs = pstmt.executeQuery();//select 占쏙옙占쏙옙
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
			
			rs = pstmt.executeQuery();//select 占쏙옙占쏙옙
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
				if(keyWord.equals("怨쇳븰")) {
					sql = "select num,imgname, ac_name,group2, ac_tel,star,count from academy "
							+" where ac_name like '%怨쇳븰%' and ac_name not in	 ( select ac_name  from academy where ac_name like '%�떒怨쇳븰�썝')";
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
		
		//議고쉶�닔 利앷�
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
				public ArrayList geAcInfo(String id) throws Exception {

					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					ArrayList res=new ArrayList();
						con = pool.getConnection();
						sql = "select num,ac_name,ac_address from academy";
								if(!id.equals("")) {
									sql+=" where ac_name like '%"+id+"%'";
									}
								sql+=" order by num";
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()) {
							res.add(rs.getInt(1));
							res.add(rs.getString(2));
							res.add(rs.getString(3));

							}
						return res;
					
				}
				//academy state insert
				public boolean insertProduct(HttpServletRequest req) {
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					boolean flag = false;
					try {
						MultipartRequest multi = 
								new MultipartRequest(req, UPLOAD, MAXSIZE, ENCTYPE,
										new DefaultFileRenamePolicy());
						con = pool.getConnection();
						sql = "insert acapply(aca_num,aca_name,aca_identity,aca_business,aca_id)"+
								  "values(?,?,?,?,?)";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, multi.getParameter("num"));
						pstmt.setString(2,multi.getParameter("name"));
						if(multi.getFilesystemName("identity")!=null)
							pstmt.setString(3, multi.getFilesystemName("identity"));
						else
							pstmt.setString(3,"no_image.jpg");
						if(multi.getFilesystemName("business")!=null)
							pstmt.setString(4, multi.getFilesystemName("business"));
						else
							pstmt.setString(4,"no_image.jpg");
						pstmt.setString(5,multi.getParameter("ac_id"));

						if(pstmt.executeUpdate()==1) flag = true;
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt);
					}
					return flag;
				}
				// requestAclist.jsp
				public Vector<AcademyBean> mGMList(){
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					Vector<AcademyBean> vlist = new Vector<AcademyBean>();
					try {
						con = pool.getConnection();
							//
							sql = "select num,aca_num, aca_name, aca_identity , aca_business, aca_state,aca_id"
									+ " from acapply where aca_state='진행중'";
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while(rs.next()) { 
							AcademyBean bean = new AcademyBean();
							bean.setNum(rs.getInt(1));
							bean.setAca_num(rs.getInt(2));
							bean.setAca_name(rs.getString(3));
							bean.setAca_identity(rs.getString(4));
							bean.setAca_business(rs.getString(5));
							bean.setAca_state(rs.getString(6));
							bean.setAca_id(rs.getString(7));

							vlist.addElement(bean);
						}
						
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return vlist;
				}
				public boolean upAcstate(String id) {
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					boolean flag=false;
					try {
						con = pool.getConnection();
						sql = "INSERT INTO alcinfo.letea"
								+ "(id, name,gender,passwd,email,nickname,birth,phone,address,school_name,school_grade,state,mpoint,grade,mdate,imgname)"
								+ " SELECT id, name,gender,passwd,email,nickname,birth,phone,address,school_name,school_grade,state,mpoint,3,mdate,imgname"
								+ " FROM alcinfo.member WHERE id='"+id+"'";
						
						pstmt = con.prepareStatement(sql);
						if(pstmt.executeUpdate()==1) flag = true;
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt);
					}
					return flag;
				}	
				public boolean delAcstate(String id) {
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					boolean flag=false;
					try {
						con = pool.getConnection();
						sql = "DELETE FROM member WHERE id ='"+id+"'";
						
						pstmt = con.prepareStatement(sql);
					//	pstmt.setString(1, id);
						if(pstmt.executeUpdate()==1) flag = true;
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt);
					}
					return flag;
				}	
				public MemberBean getPhone(String id) {
					Connection con = null;
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					String sql = null;
					MemberBean bean = new MemberBean();
					try {
						con = pool.getConnection();
						sql = "SELECT DISTINCT(a.id),a.phone"
								+" FROM"
								+" (SELECT NAME,id,phone"
								+" FROM member"
								+" UNION"
								+" SELECT NAME,id,phone"
								+" FROM letea) a"
								+" WHERE a.id='"+id+"'";
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();

						if(rs.next()) {
							bean.setPhone(rs.getString("phone"));
						}
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt, rs);
					}
					return bean;
				}
				public void Upstate(String id,String aca_state) {
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					try {
						con = pool.getConnection();
						sql = "update acapply set aca_state='"+aca_state+"'where aca_id='"+id+"'";
						pstmt = con.prepareStatement(sql);
						//pstmt.setString(1, id);
						pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt);
					}
				}	
				public void Uptea(String id) {
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					
					try {
						con = pool.getConnection();
						sql = "update letea set grade=2 where id='"+id+"'";
						pstmt = con.prepareStatement(sql);
						pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt);
					}
				}	
				public void Upac(String id) {
					Connection con = null;
					PreparedStatement pstmt = null;
					String sql = null;
					
					try {
						con = pool.getConnection();
						sql = "update letea set grade=3 where id='"+id+"'";
						pstmt = con.prepareStatement(sql);
						pstmt.executeUpdate();
					} catch (Exception e) {
						e.printStackTrace();
					} finally {
						pool.freeConnection(con, pstmt);
					}
				}
				
	}

