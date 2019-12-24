package com.ez.herb.reboard.model;

import java.util.List;

import com.ez.herb.common.SearchVO;

public interface ReBoardService {
	public int insertReBoard(ReBoardVO vo);
	public List<ReBoardVO> selectAll(SearchVO searchVo);
	public int updateReadCount(int no);
	public ReBoardVO selectByNo(int no);
	public int updateReBoard(ReBoardVO vo);
	public boolean checkPwd(int no, String pwd);
	public int deleteReBoard(int no);
	public int selectTotalRecord(SearchVO searchVo);
	
}
