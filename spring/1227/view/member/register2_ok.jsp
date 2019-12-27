<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");		
	%>
	
	<jsp:useBean id="memVo" class="com.herbmall.member.model.MemberVO" 
		scope="page"></jsp:useBean>
	<jsp:useBean id="memDao" class="com.herbmall.member.model.MemberDAO" 
		scope="session"></jsp:useBean>
	<jsp:setProperty property="*" name="memVo"/>	
	
	<%
		//2
		String msg="회원가입 실패!", url="/member/register.jsp";
		try{
			int cnt=memDao.insertMember(memVo);
			if(cnt>0){
				msg="회원가입되었습니다.";
				url="/index.jsp";
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
	
		//3
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);		
	%>
	<jsp:forward page="../common/message.jsp"></jsp:forward>
	<!-- forward 액션태그로 포워드시키면 request를 공유함
		현재 페이지와 message.jsp는 동일한 request 이용
	 -->
		
</body>
</html>







