<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.member.model.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//[1]register.jsp에서 중복확인 버튼 클릭하면 새창 띄움
	//=> http://localhost:9090/herbmall/member/checkUserid.jsp?userid=hh
	
	//[2]checkUserid.jsp에서 아이디확인 버튼 클릭하면 post방식으로 submit
	//=> 해당 아이디가 이미 존재하는지, 사용가능한지 조회
	
	//post
	request.setCharacterEncoding("utf-8");
	
	//1
	String userid=request.getParameter("userid");
	
	//2
	int result=0;
	if(userid!=null && !userid.isEmpty()){
		MemberService service=new MemberService();
		
		try{
			result=service.duplicateUserid(userid);			
		}catch(SQLException e){
			e.printStackTrace();
		}
	}//if
	
	//3
	
%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkUserid.jsp</title>
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css">
<style type="text/css">
	.error{
		color:red;
		font-size: 1.0em;
		display: none;
	}
</style>
<script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#userid").focus();
		
		$("form[name=frm]").submit(function(){
			if($("#userid").val().length<1){
				$(".error").show();
				$("#userid").focus();
				event.preventDefault();
			}
		});
		
		//사용하기
		$("#btUse").click(function(){
			<%-- 
			opener.document.frm1.userid.value="<%=userid%>";
			opener.document.frm1.chkId.value="Y";
			 --%>
			
			$(opener.document).find("#userid").val("<%=userid%>");
			$(opener.document).find("#chkId").val("Y");
			$(opener.document).find("#userid")
				.attr("readonly","readonly");
			
			self.close();
		});
		
	});
</script>
</head>
<body>
	<h1>아이디 중복검사</h1>
	<form name="frm" method="post" action="checkUserid.jsp">
		<label for="userid">아이디</label>
		<input type="text" name="userid" id="userid"
			value="<%=userid%>">
		<input type="submit" value="아이디 확인">
		<span class="error">아이디를 입력하세요</span>
		
		<%if(result==MemberService.EXIST_ID){ %>
			<p>이미 등록된 아이디입니다. 다른 아이디를 입력하세요</p>
		<%}else if(result==MemberService.USEFUL_ID){ %>
			<button id="btUse" type="button">사용하기</button>
			<p>사용가능한 아이디입니다. [사용하기]버튼을 클릭하세요</p>
		<%} %>
		
	</form>
</body>
</html>






