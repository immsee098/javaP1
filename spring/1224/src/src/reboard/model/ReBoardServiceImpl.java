package com.ez.herb.reboard.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ez.herb.common.SearchVO;

@Service
public class ReBoardServiceImpl implements ReBoardService{
	@Autowired
	private ReBoardDAO reBoardDao;
		
	public int insertReBoard(ReBoardVO vo){
		return reBoardDao.insertReBoard(vo);
	}
	
	public List<ReBoardVO> selectAll(SearchVO searchVo){
		return reBoardDao.selectAll(searchVo);
	}
	
	public int updateReadCount(int no){
		return reBoardDao.updateReadCount(no);
	}
		
	public ReBoardVO selectByNo(int no){
		return reBoardDao.selectByNo(no);
	}
	
	
	public int updateReBoard(ReBoardVO vo){
		return reBoardDao.updateReBoard(vo);
	}

	@Override
	public boolean checkPwd(int no, String pwd) {
		String dbPwd=reBoardDao.selectPwd(no);
		
		if(dbPwd.equals(pwd)) {
			return true;  //비밀번호 일치
		}else {
			return false; //불일치
		}
	}
		
	public int deleteReBoard(int no){
		return reBoardDao.deleteReBoard(no);
	}

	@Override
	public int selectTotalRecord(SearchVO searchVo) {
		return reBoardDao.selectTotalRecord(searchVo);
	}
	
	
	/*
	public List<ReBoardVO> selectMainNotice() throws SQLException{
		return reBoardDao.selectMainNotice();
	}
	*/
}



