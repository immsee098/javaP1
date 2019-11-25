<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
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
	//delete.jsp에서 post방식으로 submit
	//=> 파라미터 읽어서 삭제 처리
	
	//post
	request.setCharacterEncoding("utf-8");
	
	//1
	String no=request.getParameter("no");
	String pwd=request.getParameter("pwd");
	
	//2
	ReBoardDAO dao=new ReBoardDAO();
		
	try{
		int cnt=dao.deleteReBoard(Integer.parseInt(no), pwd);
		
		//3
		if(cnt>0){ %>
			<script type="text/javascript">
				alert("글 삭제되었습니다.");
				location.href="list.jsp";
			</script>
		<%}else{%>
			<script type="text/javascript">
				alert("글 삭제 실패!");
				history.go(-1);
			</script>
		<%}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	
%>
</body>
</html>