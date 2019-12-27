<%@page import="com.herbmall.member.model.MemberVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.member.model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login_ok.jsp</title>
</head>
<body>
<%
	//post
	request.setCharacterEncoding("utf-8");

	//1
	String userid=request.getParameter("userid");
	String pwd=request.getParameter("pwd");
	String chkSave=request.getParameter("chkSave");
	
	//2
	MemberService service=new MemberService();
	
	String msg="로그인 처리 실패", url="/login/login.jsp";
	try{
		int result=service.loginCheck(userid, pwd);
		
		//3
		if(result==MemberService.LOGIN_OK){
			MemberVO memberVo=service.selectMember(userid);
			
			//[1] 세션에 저장 userid, userName			
			session.setAttribute("userid", userid);
			session.setAttribute("userName", memberVo.getName());
			
			//[2] 아이디 저장하기가 체크되어 있으면 쿠키에 저장 ck_userid, 1000일
			Cookie ck = new Cookie("ck_userid", userid);
			ck.setPath("/");
			if(chkSave!=null){
				ck.setMaxAge(1000*24*60*60);  //유효기간 : 1000일
				response.addCookie(ck);
			}else{
				ck.setMaxAge(0); //쿠키 삭제
				response.addCookie(ck);
			}
			
			msg=memberVo.getName() +"님 로그인되었습니다.";
			url="/index.jsp";
		}else if(result==MemberService.DISAGREE_PWD){
			msg="비밀번호가 일치하지 않습니다.";			
		}else if(result==MemberService.NONE_USERID){
			msg="해당 아이디가 존재하지 않습니다.";			
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>





