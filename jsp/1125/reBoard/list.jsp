<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.herbmall.board.model.ReBoardVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.ReBoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	//[1] write.jsp에서 글목록 클릭하면 get방식으로 이동
	//[2] write_ok.jsp에서 글쓰기 성공하면 get방식으로 이동	
	//[3] list.jsp에서 검색 버튼 클릭하면 post방식으로 submit
	//[4] list.jsp에서 페이지번호 클릭하면 get방식으로 이동
	
	//=> 글 전체 조회해서 출력
	//=> 검색어를 이용해서 검색
	//=> 페이지번호에 해당하는 글 조회
	
	//1. 요청 파라미터 읽어오기 [ - 검색의 경우 ]
	//post
	request.setCharacterEncoding("utf-8");
	
	String condition=request.getParameter("searchCondition");
	String keyword=request.getParameter("searchKeyword");
	
	//2.
	ReBoardDAO dao=new ReBoardDAO();
	
	List<ReBoardVO> list=null;
	try{
		list=dao.selectAll(condition, keyword);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3.
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

	//페이징 처리 관련 변수
	int currentPage=1;
	
	//list.jsp?currentPage=3
	if(request.getParameter("currentPage")!=null){
		currentPage
			=Integer.parseInt(request.getParameter("currentPage"));		
	}
	
	//현재 페이지와 무관한 변수
	int totalRecord=list.size(); //전체 레코드 개수  예)17
	int pageSize=5;  //한 페이지에 보여줄 레코드 개수
	int blockSize=10; //블럭 사이즈  [1]~[10]
	int totalPage = (int)Math.ceil((float)totalRecord/pageSize);
		//=> 4
	
	//현재 페이지를 이용해서 계산하는 변수
	int firstPage=currentPage-((currentPage-1)% blockSize);
	//=> 블럭의 시작번호, 1,11,21,..
	
	int lastPage=firstPage+(blockSize-1); //블럭의 마지막 번호, 10,20,30..
	int curPos=(currentPage-1)*pageSize; //ArrayList에서 시작 위치
	//=> 0, 5, 10, ...
	int num=totalRecord-curPos; //페이지당 글 리스트 시작 번호
	//17, 12, 7, 2
%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<title>답변형게시판 글 목록 - 허브몰</title>
<meta charset="utf-8">
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>

<script type="text/javascript">	
	$(function(){
		$(".box2 tbody tr").hover(function(){
			$(this).css("background","lightblue");
		}, function(){
			$(this).css("background","");
		});	
	});
	
</script>
<style type="text/css">
	body{
		padding:5px;
		margin:5px;
	 }	
</style>	
</head>	
<body>
<h2>답변형 게시판</h2>
<%
	if(keyword!=null && !keyword.isEmpty()){%>
		<p>검색어 : <%=keyword %>, <%=list.size() %>건 검색되었습니다.</p>	
<%	}else{
		keyword="";
	}
%>

<div class="divList">
<table class="box2"
	 	summary="답변형 게시판에 관한 표로써, 번호, 제목, 작성자, 작성일, 조회수에 대한 정보를 제공합니다.">
	<caption>답변형 게시판</caption>
	<colgroup>
		<col style="width:10%;" />
		<col style="width:50%;" />
		<col style="width:15%;" />
		<col style="width:15%;" />
		<col style="width:10%;" />		
	</colgroup>
	<thead>
	  <tr>
	    <th scope="col">번호</th>
	    <th scope="col">제목</th>
	    <th scope="col">작성자</th>
	    <th scope="col">작성일</th>
	    <th scope="col">조회수</th>
	  </tr>
	</thead> 
	<tbody>  
	  <!--게시판 내용 반복문 시작  -->	
	  <%for(int i=0;i<pageSize;i++){
		    if(num<1) break;
		  
			ReBoardVO vo=list.get(curPos++);
			num--;
	  %>	
		<tr  style="text-align:center">
			<td><%=vo.getNo() %></td>
			<td style="text-align:left">
				<a href="countUpdate.jsp?no=<%=vo.getNo()%>">
					<%=vo.getTitle() %>
				</a></td>
			<td><%=vo.getName() %></td>
			<td><%=sdf.format(vo.getRegdate()) %></td>
			<td><%=vo.getReadcount() %></td>		
		</tr> 
	  <%}//for %>	
	  <!--반복처리 끝  -->
	  </tbody>
</table>	   
</div>
<div class="divPage">
	<!-- 이전블럭으로 이동 -->
	<%if(firstPage>1){%>
		<a href="list.jsp?currentPage=<%=firstPage-1%>">
			<img src="../images/first.JPG" alt="이전 블럭으로">
		</a>
	<%} %>
	
	<!-- 페이지 번호 추가 -->						
	<!-- [1][2][3][4][5][6][7][8][9][10] -->
	<%
		for(int i=firstPage;i<=lastPage;i++){
			if(i>totalPage) break; //1,2  | 2
			
			if(i==currentPage){	%>
				<span style="color:blue;font-weight: bold"><%=i %></span>
			<%}else{ %>
				<a href="list.jsp?currentPage=<%=i%>">[<%=i %>]</a>
			<%}//if %>
	<%	}//for %>
	<!--  페이지 번호 끝 -->
	
	<!-- 다음블럭으로 이동 -->
	<%if(lastPage < totalPage){%>
		<a href="list.jsp?currentPage=<%=lastPage+1%>">
			<img src="../images/last.JPG" alt="다음 블럭으로">
		</a>
	<%} %>
</div>
<div class="divSearch">
   	<form name="frmSearch" method="post" action='list.jsp'>
        <select name="searchCondition">
            <option value="title" 
            	<%if("title".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >제목</option>
            <option value="content" 
            	<%if("content".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >내용</option>
            <option value="name" 
            	<%if("name".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >작성자</option>
        </select>   
        <input type="text" name="searchKeyword" title="검색어 입력"
        	value="<%=keyword%>">   
		<input type="submit" value="검색">
    </form>
</div>

<div class="divBtn">
    <a href='write.jsp' >글쓰기</a>
</div>

</body>
</html>

