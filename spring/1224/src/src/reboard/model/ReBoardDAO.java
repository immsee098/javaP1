package com.ez.herb.reboard.model;

import java.util.List;

import com.ez.herb.common.SearchVO;

public interface ReBoardDAO {
	public int insertReBoard(ReBoardVO vo);
	public List<ReBoardVO> selectAll(SearchVO searchVo);
	public int updateReadCount(int no);
	public ReBoardVO selectByNo(int no);
	public int updateReBoard(ReBoardVO vo);
	public String selectPwd(int no);
	public int deleteReBoard(int no);
	public int selectTotalRecord(SearchVO searchVo);
	
}
