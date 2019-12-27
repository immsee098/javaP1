<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.member.model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberOut_ok.jsp</title>
</head>
<body>
<%@ include file="../login/loginCheck.jsp" %>
<%
	//post
	request.setCharacterEncoding("utf-8");	

	//1		
	String userid=(String)session.getAttribute("userid");	
	String pwd=request.getParameter("pwd");
	
	//2
	MemberService service=new MemberService();
				
	String msg="회원탈퇴 처리중 에러!",url="/member/memberOut.jsp";
	try{
		int result=service.loginCheck(userid, pwd);
		if(result==MemberService.LOGIN_OK){ //비밀번호 일치
			int cnt=service.withdrawMember(userid);
			if(cnt>0){
				msg="회원탈퇴 처리되었습니다.";
				url="/index.jsp";
				
				//session 제거
				session.invalidate();
				
				//cookie 제거
				Cookie ck = new Cookie("ck_userid", userid);
				ck.setPath("/");
				ck.setMaxAge(0);
				response.addCookie(ck);				
			}
		}else if(result==MemberService.DISAGREE_PWD){ //불일치
			msg="비밀번호가 일치하지 않습니다.";
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