<%@page import="com.herbmall.member.model.MemberVO"%>
<%@page import="com.herbmall.member.model.MemberService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberEdit_ok.jsp</title>
</head>
<body>
	<%@ include file="../login/loginCheck.jsp"%>

	<%
		//post
		request.setCharacterEncoding("utf-8");	
	
		//1		
		String userid=(String)session.getAttribute("userid");
		
		String pwd=request.getParameter("pwd");
		String zipcode=request.getParameter("zipcode");
		String address=request.getParameter("address");
		String addressDetail=request.getParameter("addressDetail");
		String hp1=request.getParameter("hp1");
		String hp2=request.getParameter("hp2");
		String hp3=request.getParameter("hp3");
		String email1=request.getParameter("email1");
		String email2=request.getParameter("email2");
		String email3=request.getParameter("email3");

		String hp="";
		if(hp2!=null && !hp2.isEmpty() && hp3!=null && !hp3.isEmpty()){
			hp=hp1+"-"+hp2+"-"+hp3;
		}
		
		String email="";
		if(email1!=null && !email1.isEmpty()){
			if(email2.equals("etc")){  //직접입력인 경우
				if(email3!=null && !email3.isEmpty()){
					email=email1+"@"+email3;
				}
			}else{
				email=email1+"@"+email2;
			}
		}
		
		MemberService service=new MemberService();
		MemberVO vo = new MemberVO();
		vo.setAddress(address);
		vo.setAddressDetail(addressDetail);
		vo.setEmail(email);
		vo.setHp(hp);
		vo.setUserid(userid);
		vo.setZipcode(zipcode);
				
		String msg="회원정보 수정 처리 중 에러발생!",url="/member/memberEdit.jsp";
		try{
			int result=service.loginCheck(userid, pwd);
			if(result==MemberService.LOGIN_OK){
				int cnt=service.updateMember(vo);
				if(cnt>0){
					msg="회원정보 수정되었습니다.";
				}
			}else if(result==MemberService.DISAGREE_PWD){
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