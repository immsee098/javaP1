<%@page import="com.herbmall.board.model.BoardVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.board.model.BoardService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//1
	
	//2
	BoardService service = new BoardService();

	List<BoardVO> list=null;
	try{
		list=service.selectMainNotice();	
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3
	
%>    
<style type="text/css">
	#divNotice{
		width: 310px;
	}
	#divNotice span{
		margin: 0 0 0 160px;
	}
	#divNotice .line img{
		width:310px;
		height: 6px;
	}
	.tblNotice{
		width: 300px;
	}
</style>

<div id="divNotice">
	<div>
		<img src="<%=request.getContextPath() %>/images/notice2.JPG" 
			alt="공지사항 이미지">
		<span>
			<a href="<%=request.getContextPath()%>/board/list.jsp">
				<img src="<%=request.getContextPath() %>/images/more.JPG" 
					alt="more이미지">
			</a>	
		</span>
	</div>
	<div class="line">
		<img src="<%=request.getContextPath() %>/images/Line.JPG" 
			alt="line 이미지">
	</div>
	<div>
		<table class="tblNotice" summary="최근 공지사항 6건을 보여주는 표입니다.">
			<tbody>
				<%if(list==null || list.isEmpty()){ %>
					<tr>
						<td>공지사항이 없습니다.</td>
					</tr>
				<%}else{ %>
					<!-- 반복 시작 -->		
					<%/* for(int i=0;i<list.size();i++){ 
						BoardVO vo=list.get(i); */
						for(BoardVO vo : list){	
					%>	
						<tr>
							<td>
								<img src="<%=request.getContextPath()%>/images/dot.JPG">
								<a href
="<%=request.getContextPath()%>/board/detail.jsp?no=<%=vo.getNo()%>">
									<%=vo.getTitle() %></a>
							</td>	
						</tr>
					<!-- 반복 끝 -->
					<%}//for %>
				<%}//if %>	
			</tbody>			
		</table>
	</div>
</div>
