package com.herbmall.member.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.herbmall.db.ConnectionPoolMgr;

public class MemberDAO {
	private ConnectionPoolMgr pool;
	
	public MemberDAO(){
		pool=new ConnectionPoolMgr();
	}
	
	public int insertMember(MemberVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="insert into member(no, userid, name, pwd, "
					+ "email, hp, zipcode, address,addressDetail )" + 
					" values(member_seq.nextval, ?,?,?,?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getUserid());
			ps.setString(2, vo.getName());
			ps.setString(3, vo.getPwd());
			ps.setString(4, vo.getEmail());
			ps.setString(5, vo.getHp());
			ps.setString(6, vo.getZipcode());
			ps.setString(7, vo.getAddress());
			ps.setString(8, vo.getAddressDetail());
			
			//4
			int cnt=ps.executeUpdate();
			System.out.println("회원가입 결과 cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	/**
	 * 아이디 중복확인
	 * @param userid
	 * @return
	 * @throws SQLException 
	 */
	public int duplicateUserid(String userid) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
				
		try {
			con=pool.getConnection();
		
			String sql="select count(*) from member" + 
					" where userid=?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, userid);
			
			rs=ps.executeQuery();
			
			int result=0;
			if(rs.next()) {
				int count=rs.getInt(1);
				if(count>0) {  //해당 아이디 이미 존재
					result=MemberService.EXIST_ID;
				}else { //사용가능
					result=MemberService.USEFUL_ID;
				}
			}
			System.out.println("아이디 중복확인 결과 result="+result);
			
			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public int loginCheck(String userid, String pwd) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		try {
			con=pool.getConnection();
			
			String sql="select pwd from member" + 
					" where userid=? and outdate is null";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			
			int result=0;
			rs=ps.executeQuery();
			if(rs.next()) {
				String dbPwd=rs.getString(1);
				if(dbPwd.equals(pwd)) { //로그인 성공
					result=MemberService.LOGIN_OK;
				}else { //비밀번호 불일치
					result=MemberService.DISAGREE_PWD;
				}
			}else { //해당아이디 존재하지 않음
				result=MemberService.NONE_USERID;
			}
			System.out.println("로그인 처리 결과, result="+result
				+", 매개변수 userid="+userid+", pwd="+pwd);
			
			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public MemberVO selectMember(String userid) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		MemberVO memberVo=new MemberVO();
		try {
			con=pool.getConnection();
			
			String sql="select * from member" + 
					" where userid=? and outdate is null";
			ps=con.prepareStatement(sql);
			ps.setString(1, userid);
			
			rs=ps.executeQuery();
			if(rs.next()) {
				memberVo.setAddress(rs.getString("address"));
				memberVo.setAddressDetail(rs.getString("addressDetail"));
				memberVo.setEmail(rs.getString("email"));
				memberVo.setHp(rs.getString("hp"));
				memberVo.setMileage(rs.getInt("mileage"));
				memberVo.setNo(rs.getInt("no"));
				memberVo.setName(rs.getString("name"));
				memberVo.setPwd(rs.getString("pwd"));
				memberVo.setZipcode(rs.getString("zipcode"));
				memberVo.setUserid(userid);
				memberVo.setOutdate(rs.getTimestamp("outdate"));
				memberVo.setRegdate(rs.getTimestamp("regdate"));					
			}
			System.out.println("회원정보 조회 결과 vo="+memberVo
					+",매개변수 userid="+userid);
			
			return memberVo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
		
	}
	
	public int updateMember(MemberVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="update member"
					+ " set email=?, hp=?, zipcode=?, address=?,"
					+ " addressDetail=?" + 
					" where userid=?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getEmail());
			ps.setString(2, vo.getHp());
			ps.setString(3, vo.getZipcode());
			ps.setString(4, vo.getAddress());
			ps.setString(5, vo.getAddressDetail());
			ps.setString(6, vo.getUserid());
			
			//4
			int cnt=ps.executeUpdate();
			System.out.println("회원정보 수정 결과 cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public int withdrawMember(String userid) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="update member"
					+ " set outdate=sysdate" + 
					" where userid=?";
			ps=con.prepareStatement(sql);
						
			ps.setString(1, userid);
			
			//4
			int cnt=ps.executeUpdate();
			System.out.println("회원탈퇴 결과 cnt="+cnt+", 매개변수 userid="
					+userid);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
}




