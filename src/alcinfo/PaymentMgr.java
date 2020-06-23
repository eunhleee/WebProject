package alcinfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import org.json.simple.JSONArray;

public class PaymentMgr {
	DBConnectionMgr pool;
	public PaymentMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	@SuppressWarnings("resource")
	public boolean insertPayment(PaymentBean bean, int applynum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String mpoint=null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			
			switch(bean.getPrice()) {
			case 500:
				mpoint="INTERVAL 1 DAY";
				break;
			case 10000:
				mpoint="INTERVAL 1 MONTH";
				break;
			case 50000:
				mpoint="INTERVAL 6 MONTH";
				break;
			case 90000:
				mpoint="INTERVAL 12 MONTH";
				break;
			
			}
			
			sql = "insert payment(id,name,grade,product_name,price,paydate,applynum)"
					+ "values(?,?,?,?,?,now(),?); ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getName());
			pstmt.setInt(3, bean.getGrade());
			pstmt.setString(4, bean.getProduct_name());
			pstmt.setInt(5, bean.getPrice());
			pstmt.setInt(6, applynum);
			
			pstmt.executeUpdate();
			
			if(bean.getGrade()==0||bean.getGrade()==1) {
				sql="update member set mpoint=date_format(date_add(now(),"+mpoint+"),'%y-%m-%d') where id=? ";
			}
			else if(bean.getGrade()==2||bean.getGrade()==3){
				sql="update letea set mpoint=date_format(date_add(now(),"+mpoint+"),'%y-%m-%d') where id=? ";
			}
			System.out.println(bean.getId());
			pstmt = con.prepareStatement(sql);
			//pstmt.setString(1, mpoint);
			pstmt.setString(1, bean.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if (keyWord.trim().equals("") || keyWord == null) {

				sql = "select count(*) from payment ";
				pstmt = con.prepareStatement(sql);
				
			} else {

				sql = "select count(*) from payment where " + keyField + " like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				totalCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	public Vector<PaymentBean> getBoardList(String keyField, String keyWord, int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<PaymentBean> vlist = new Vector<PaymentBean>();
		try {
			con = pool.getConnection();
			if (keyWord.trim().equals("") || keyWord == null) {

				sql = "select * from payment order by num desc limit ?,?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);

			} else {

				sql = "select * from payment where " + keyField
						+ " like ? order by num desc " + "limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);

			}

			rs = pstmt.executeQuery();
			while (rs.next()) {
				PaymentBean bean = new PaymentBean();
				bean.setNum(rs.getInt("num"));
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setGrade(rs.getInt("grade"));
				bean.setProduct_name(rs.getString("product_name"));
				bean.setPrice(rs.getInt("price"));
				bean.setDate(rs.getString("date"));
				bean.setApplynum(rs.getInt("applynum"));

				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public int totalSales() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int total=0;
		try {
			con = pool.getConnection();
			sql = "SELECT SUM(price) FROM payment";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			if(rs.next()) {
				total=rs.getInt("SUM(price)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return total;
	}
	
	//월별 매출 합계
	@SuppressWarnings("unchecked")
	public JSONArray getMonthSales(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		JSONArray jsonArray = new JSONArray();
		JSONArray colArray = new JSONArray();
		colArray.add("Month");
		colArray.add("매출");
		jsonArray.add(colArray);
		try {
			con = pool.getConnection();
			sql = " SELECT  left(paydate,7),sum(price) from alcinfo.payment GROUP BY (left(paydate,7))";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				JSONArray rowArray = new JSONArray();
				rowArray.add(rs.getString("left(paydate,7)"));
				rowArray.add(rs.getInt("sum(price)"));
				jsonArray.add(rowArray);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return jsonArray;
	}
	
	//주간별 매출 합계
	@SuppressWarnings("unchecked")
	public JSONArray getWeekSales(int month){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		JSONArray jsonArray=new JSONArray();
		int start=202001,end=202048;
		JSONArray colArray = new JSONArray();
		colArray.add("Weeks");
		colArray.add("매출");
		jsonArray.add(colArray);
		
		switch(month) {
		case 1:
			start=202001;
			end =202004;
			break;
		case 2:
			start=202005;
			end =202008;
			break;
		case 3:
			start=202009;
			end =202012;
			break;
		case 4:
			start=202013;
			end =202016;
			break;
		case 5:
			start=202017;
			end =202020;
			break;
		case 6:
			start=202021;
			end =202024;
			break;
		case 7:
			start=202025;
			end =202028;
			break;
		case 8:
			start=202029;
			end =202032;
			break;
		case 9:
			start=202033;
			end =202036;
			break;
		case 10:
			start=202037;
			end =202040;
			break;
		case 11:
			start=202041;
			end =202044;
			break;
		case 12:
			start=202045;
			end =202048;
			break;
		}
		
		
		try {
			con = pool.getConnection();
			
			for(int i=start;i<=end;i++) {
			sql = " SELECT 	ifnull(DATE_FORMAT(paydate, '%Y%U'),"+i+") weekdate , ifnull(sum(price),0) 'sum(price)' " + 
					"FROM payment " + 
					"WHERE DATE_FORMAT(paydate, '%Y%U')=" +i ;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				JSONArray rowArray = new JSONArray();
				
				rowArray.add(rs.getString("weekdate"));
				rowArray.add(rs.getInt("sum(price)"));
			
				jsonArray.add(rowArray);
			}
			
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return jsonArray;
	}
	
	//상품별 주문건수
		@SuppressWarnings("unchecked")
		public JSONArray countPoint(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			JSONArray jsonArray = new JSONArray();
			JSONArray colArray = new JSONArray();
			colArray.add("포인트별");
			colArray.add("주문건수");
			jsonArray.add(colArray);
			try {
				con = pool.getConnection();
				sql = " SELECT product_name,COUNT(id) " + 
						"FROM payment " + 
						"GROUP BY product_name " + 
						"ORDER BY price ";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					JSONArray rowArray = new JSONArray();
					rowArray.add(rs.getString("product_name"));
					rowArray.add(rs.getInt("COUNT(id)"));
					jsonArray.add(rowArray);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return jsonArray;
		}
		
	

}
