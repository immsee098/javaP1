package com.ez.herb.reboard.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ez.herb.common.PaginationInfo;
import com.ez.herb.common.SearchVO;
import com.ez.herb.common.Utility;
import com.ez.herb.reboard.model.ReBoardService;
import com.ez.herb.reboard.model.ReBoardVO;

@Controller
@RequestMapping("/reBoard")
public class ReBoardController {
	private static final Logger logger
	=LoggerFactory.getLogger(ReBoardController.class); 

	@Autowired
	private ReBoardService reBoardService;

	@RequestMapping(value="/write.do", method=RequestMethod.GET)
	public String write_get() {
		logger.info("글쓰기 화면");

		return "reBoard/write";
	}

	@RequestMapping(value="/write.do", method = RequestMethod.POST)
	public String write_post(@ModelAttribute ReBoardVO reBoardVo, Model model) {
		//1
		logger.info("글등록, 파라미터 vo={}",reBoardVo);

		//2
		String msg="", url="";
		int cnt=reBoardService.insertReBoard(reBoardVo);
		logger.info("글등록 결과, cnt={}", cnt);

		if(cnt>0) {
			msg="글등록되었습니다.";
			url="/reBoard/list.do";
		}else {
			msg="글등록 실패!";
			url="/reBoard/write.do";
		}

		//3		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "common/message";
	}

	@RequestMapping("/list.do")
	public String list(@ModelAttribute SearchVO searchVo, 
				Model model) {
		//1
		logger.info("글 목록, 파라미터 searchVo={}",searchVo);
		
		//[1] 먼저 PaginationInfo객체를 생성하여 firstRecordIndex 값을 구한다
		PaginationInfo pagingInfo=new PaginationInfo();
		pagingInfo.setBlockSize(Utility.BLOCK_SIZE);
		pagingInfo.setRecordCountPerPage(Utility.RECORD_COUNT);
		pagingInfo.setCurrentPage(searchVo.getCurrentPage());
		
		//[2] searchVo에 recordCountPerPage와 firstRecordIndex를 셋팅한다
		searchVo.setRecordCountPerPage(Utility.RECORD_COUNT);
		searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		
		logger.info("값 셋팅 후 searchVo={}", searchVo);
		
		//2
		List<ReBoardVO> list=reBoardService.selectAll(searchVo);
		logger.info("글목록 결과, list.size={}", list.size());
		
		//[3] 레코드 개수 조회후 셋팅
		int totalRecord=reBoardService.selectTotalRecord(searchVo);
		logger.info("totalRecord={}", totalRecord);
		
		pagingInfo.setTotalRecord(totalRecord);
		
		//3
		model.addAttribute("list", list);
		model.addAttribute("pagingInfo", pagingInfo);
		
		return "reBoard/list";
	}
	
	@RequestMapping("/countUpdate.do")
	public String countUpdate(@RequestParam(defaultValue = "0") int no,
			Model model) {
		logger.info("조회수 증가, 파라미터 no={}", no);
		
		if(no==0) {
			model.addAttribute("msg", "잘못된 url입니다.");
			model.addAttribute("url", "/reBoard/list.do");
			
			return "common/message";
		}
		
		int cnt=reBoardService.updateReadCount(no);
		logger.info("조회수 증가 결과, cnt={}", cnt);
		
		return "redirect:/reBoard/detail.do?no="+no;		
	}
	
	@RequestMapping("/detail.do")
	public String detail(@RequestParam(defaultValue = "0") int no,
			Model model) {
		logger.info("상세보기 파라미터, no={}", no);
		if(no==0) {
			model.addAttribute("msg", "잘못된 url입니다.");
			model.addAttribute("url", "/reBoard/list.do");
			
			return "common/message";
		}
		
		ReBoardVO reBoardVo=reBoardService.selectByNo(no);
		logger.info("상세보기 결과, vo={}", reBoardVo);
		
		model.addAttribute("vo", reBoardVo);
		
		return "reBoard/detail";
	}
	
	@RequestMapping(value="/edit.do", method =RequestMethod.GET)
	public String edit_get(@RequestParam(defaultValue = "0") int no,
			Model model) {
		logger.info("수정화면 파라미터 no={}", no);		
		if(no==0) {
			model.addAttribute("msg", "잘못된 url입니다.");
			model.addAttribute("url", "/reBoard/list.do");
			
			return "common/message";
		}
		
		ReBoardVO reBoardVo=reBoardService.selectByNo(no);
		logger.info("수정화면 결과, reBoardVo={}", reBoardVo);
		
		model.addAttribute("reBoardVo", reBoardVo);
		
		return "reBoard/edit";
	}
	
	@RequestMapping(value="/edit.do", method = RequestMethod.POST)
	public String edit_post(@ModelAttribute ReBoardVO reBoardVo, Model model) {
		//1
		logger.info("글 수정 처리, 파라미터 vo={}", reBoardVo);
		
		//2
		String msg="", url="/reBoard/edit.do?no="+reBoardVo.getNo();
		if(reBoardService.checkPwd(reBoardVo.getNo(), reBoardVo.getPwd())) {
			int cnt=reBoardService.updateReBoard(reBoardVo);
			if(cnt>0) {
				msg="글 수정되었습니다.";
				url="/reBoard/detail.do?no="+reBoardVo.getNo();
			}else {
				msg="글 수정 실패!";
			}
		}else {
			msg="비밀번호가 일치하지 않습니다.";
		}
		
		//3
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
	
	@RequestMapping(value="/delete.do", method = RequestMethod.GET)
	public String delete_get(@RequestParam(defaultValue = "0") int no,
			Model model) {
		//1
		logger.info("글 삭제 화면, 파라미터 no={}", no);
		if(no==0) {
			model.addAttribute("msg","잘못된 url입니다.");
			model.addAttribute("url","/reBoard/list.do");
			
			return "common/message";
		}
		
		//2
		
		//3
		return "reBoard/delete";
	}
	
	@RequestMapping(value="/delete.do", method = RequestMethod.POST)
	public String delete_post(@RequestParam(defaultValue = "0") int no,
			@RequestParam String pwd, Model model) {
		//1
		logger.info("글 삭제 처리, 파라미터 no={}, pwd={}", no, pwd);
		
		//2
		String msg="", url="/reBoard/delete.do?no="+no;
		if(reBoardService.checkPwd(no, pwd)) {
			int cnt=reBoardService.deleteReBoard(no);
			if(cnt>0) {
				msg="글 삭제되었습니다.";
				url="/reBoard/list.do";
			}else {
				msg="글 삭제 실패!";
			}
		}else {
			msg="비밀번호가 일치하지 않습니다.";
		}
		
		//3
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "common/message";
	}
}
