<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="java.sql.SQLException"%>
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
	//edit.jsp에서 post방식으로 submit
	//=> 파라미터 읽어서 수정 처리
	
	//post
	request.setCharacterEncoding("utf-8");
	
	//1
	String no=request.getParameter("no");
	String title=request.getParameter("title");
	String name=request.getParameter("name");
	String pwd=request.getParameter("pwd");
	String email=request.getParameter("email");
	String content=request.getParameter("content");
	
	//2
	ReBoardDAO dao=new ReBoardDAO();
	ReBoardVO vo=new ReBoardVO();
	vo.setNo(Integer.parseInt(no));
	vo.setContent(content);
	vo.setEmail(email);
	vo.setName(name);
	vo.setPwd(pwd);
	vo.setTitle(title);
	
	try{
		int cnt=dao.updateReBoard(vo);
		
		//3
		if(cnt>0){ %>
			<script type="text/javascript">
				alert("글 수정되었습니다.");
				location.href="detail.jsp?no=<%=no%>";
			</script>
		<%}else{%>
			<script type="text/javascript">
				alert("글 수정 실패!");
				history.go(-1);
			</script>
		<%}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	
%>
</body>
</html>