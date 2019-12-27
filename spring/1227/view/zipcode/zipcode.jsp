<%@page import="com.herbmall.common.PagingVO"%>
<%@page import="com.herbmall.zipcode.model.ZipcodeVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.herbmall.zipcode.model.ZipcodeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//[1] register.jsp에서 우편번호찾기 버튼 클릭하면 새창 띄우기
	//[2] zipcode.jsp에서 찾기버튼 클릭하면 post방식으로 submit
	//[3]
			
	//post
	request.setCharacterEncoding("utf-8");

	//1
	String dong=request.getParameter("dong");
	
	//2
	List<ZipcodeVO> list=null;
	if(dong!=null && !dong.isEmpty()){
		ZipcodeService service=new ZipcodeService();
		
		try{
			list=service.selectZipcode(dong);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}else{
		dong="";
	}
	
	//3
	//페이징 처리 관련 변수
	int currentPage=1;
	
	//zipcode.jsp?currentPage=3
	if(request.getParameter("currentPage")!=null){
		currentPage
			=Integer.parseInt(request.getParameter("currentPage"));		
	}
	
	int totalRecord=0;
	if(dong!=null && !dong.isEmpty()){		
		totalRecord=list.size();
	}
	
	int pageSize=14;
	int blockSize=10;
	
	PagingVO pageVo
		=new PagingVO(currentPage, totalRecord, pageSize, blockSize);
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>zipcode/zipcode.jsp</title>
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css">
<style type="text/css">
	p, label{
		font-size: 0.9em;
	}
	.box2{
		width: 490px;
	}
	#divTable{
		width: 500px;
		margin: 15px 0;
	}
	h1{
		font-size: 1.5em;
		margin-bottom: 25px;
	}
	.error{
		color: red;
		display: none;
	}
	#page{
		margin: 10px 0;
		text-align: center;
	}
</style>
<script type="text/javascript" src="../js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#dong").focus();
		
		$("form[name=frm]").submit(function(){
			if($("#dong").val().length<1){
				$(".error").show();
				$("#dong").focus();
				event.preventDefault();
			}	
		});
		
	});
	
	function setAddress(zipcode, address){
		$(opener.document).find('#zipcode').val(zipcode);
		$(opener.document).find('input[name=address]').val(address);
		
		self.close();
	}
	
</script>
</head>
<body>
	<h1>우편번호 검색</h1>
	<p>찾고 싶으신 주소의 동(읍, 면)을 입력하세요</p>
	<form name="frm" method="post" action="zipcode.jsp">
		<label for="dong">지역명</label>
		<input type="text" name="dong" id="dong" value="<%=dong%>">
		<input type="submit" value="찾기">
		<span class="error">지역명을 입력하세요</span>
	</form>
	<%if(list!=null){ %>
		<div id="divTable">
			<table class="box2" 
			summary="우편번호 검색 결과에 관한 표로써  우편번호, 주소에 대한 정보를 제공합니다.">
				<colgroup>
					<col style="width:20%">
					<col style="width:*">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">우편번호</th>
						<th scope="col">주소</th>
					</tr>	
				</thead>
				<tbody>
					<%if(list==null || list.isEmpty()){ %>
						<tr style="text-align: center">
							<td colspan="2">해당하는 주소가 존재하지 않습니다.</td>
						</tr>
					<%}else{ %>
						<!-- 반복시작 -->
						<%
						  int num=pageVo.getNum();
						  int curPos=pageVo.getCurPos();
						  
						  for(int i=0;i<pageVo.getPageSize();i++){
							if(num<1) break;
							  
							ZipcodeVO vo=list.get(curPos++);
							num--;
							
							String zipcode=vo.getZipcode();
							String address=vo.getSido()+" "
								+vo.getGugun()+" " 
								+vo.getDong();
							String bunji=vo.getStartbunji();
							
							if(vo.getEndbunji()!=null &&
									!vo.getEndbunji().isEmpty()){
								bunji+=" ~ " + vo.getEndbunji();
							}%>
							
							<tr>
								<td><%=zipcode%></td>
								<td>
									<a href="#" 
				onclick="setAddress('<%=zipcode%>','<%=address %>')">
									<%=address %> <%=bunji %>
									</a>
								</td>
							</tr>							
						<%}//for	%>
						<!-- 반복끝 -->
					<%}//if %>				
				</tbody>
			</table>
			<div id="page">
				<!-- 이전블럭으로 이동 -->
				<%if(pageVo.getFirstPage()>1){%>
					<a href="zipcode.jsp?currentPage=<%=pageVo.getFirstPage()-1%>&dong=<%=dong%>">
						<img src="../images/first.JPG" alt="이전 블럭으로">
					</a>
				<%} %>
				
				<!-- 페이지 번호 추가 -->						
				<!-- [1][2][3][4][5][6][7][8][9][10] -->
				<%
					for(int i=pageVo.getFirstPage();i<=pageVo.getLastPage();i++){
						if(i>pageVo.getTotalPage()) break; //1,2  | 2
						
						if(i==currentPage){	%>
							<span style="color:blue;font-weight: bold"><%=i %></span>
						<%}else{ %>
							<a href="zipcode.jsp?currentPage=<%=i%>&dong=<%=dong%>">[<%=i %>]</a>
						<%}//if %>
				<%	}//for %>
				<!--  페이지 번호 끝 -->
				
				<!-- 다음블럭으로 이동 -->
				<%if(pageVo.getLastPage() < pageVo.getTotalPage()){%>
					<a href="zipcode.jsp?currentPage=<%=pageVo.getLastPage()+1%>&dong=<%=dong%>">
						<img src="../images/last.JPG" alt="다음 블럭으로">
					</a>
				<%} %>
			</div>
		</div>	
	<%}//if %>	
</body>
</html>












