package com.herbmall.member.model;

import java.sql.SQLException;

/*
 jsp -> DAO
 jsp -> Service -> DAO 
*/

//DB작업 이외의 로직을 담는 클래스
public class MemberService {
	//아이디 중복확인
	public static final int EXIST_ID=1;  //아이디가 이미 존재하는 경우
	public static final int USEFUL_ID=2;  //아이디가 사용 가능한 경우
	
	//로그인 처리
	public static final int LOGIN_OK=1;  //로그인 성공
	public static final int DISAGREE_PWD=2; //비밀번호 불일치
	public static final int NONE_USERID=3; //해당 아이디 존재하지 않음
	
	private MemberDAO memberDao;
	
	public MemberService() {
		memberDao=new MemberDAO();
	}
	
	public int insertMember(MemberVO vo) throws SQLException {
		int cnt=memberDao.insertMember(vo);
		return cnt;
	}
	
	public int duplicateUserid(String userid) throws SQLException {
		return memberDao.duplicateUserid(userid);
	}
	
	public int loginCheck(String userid, String pwd) throws SQLException {
		return memberDao.loginCheck(userid, pwd);
	}
		
	public MemberVO selectMember(String userid) throws SQLException {
		return memberDao.selectMember(userid);
	}
		
	public int updateMember(MemberVO vo) throws SQLException {
		return memberDao.updateMember(vo);
	}
		
	public int withdrawMember(String userid) throws SQLException {
		return memberDao.withdrawMember(userid);
	}
		
}









