package com.herbmall.zipcode.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.herbmall.board.model.BoardVO;
import com.herbmall.db.ConnectionPoolMgr;

public class ZipcodeDAO {
	private ConnectionPoolMgr pool;
	
	public ZipcodeDAO() {
		pool=new ConnectionPoolMgr();
	}
	
	public List<ZipcodeVO> selectZipcode(String dong) throws SQLException{
		/*select * from zipcode
		where dong like '%개포%'
		order by seq
		*/
		
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<ZipcodeVO> list=new ArrayList<ZipcodeVO>();
		try {
			//1,2
			con=pool.getConnection();
			
			//3.
			String sql="select * from zipcode"
				+ " where dong like '%' || ? || '%'"
				+ " order by seq";
			
			ps=con.prepareStatement(sql);			
			ps.setString(1, dong);
			
			//4
			rs=ps.executeQuery();
			while(rs.next()) {
				int seq=rs.getInt("seq");
				String zipcode=rs.getString("zipcode");
				String sido=rs.getString("sido");
				String gugun=rs.getString("gugun");
				String dong2=rs.getString("dong");
				String startbunji=rs.getString("startbunji");
				String endbunji=rs.getString("endbunji");
				
				ZipcodeVO vo = new ZipcodeVO(zipcode, sido, gugun, 
						dong2, startbunji, endbunji, seq);
				list.add(vo);
			}
			System.out.println("우편번호 조회 결과 list.size="+list.size()
				+", 매개변수 dong="+dong);
			
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
}







