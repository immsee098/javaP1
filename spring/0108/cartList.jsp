<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../inc/top.jsp" %>
<style type="text/css">
	#divCart{
		width: 700px;
	}
	#divCart table{
		width: 700px;
	}
</style>
<script type="text/javascript">
	
</script>

<h2>장바구니</h2>
<div id="divCart">
<table class="box2" 
	summary="장바구니 목록에 관한 표로써 상품명,가격,수량,금액 등의 정보를 제공합니다.">
	<colgroup>
		<col style="width:40%">
		<col style="width:13%">
		<col style="width:20%">
		<col style="width:13%">
		<col style="width:*">		
	</colgroup>
	
	<thead>
		<tr>
			<th scope="col">상품명</th>
			<th scope="col">가격</th>
			<th scope="col">수량</th>
			<th scope="col">금액</th>
			<th scope="col">삭제</th>
		</tr>	
	</thead>
	<tbody>
		
		<!--반복 시작 -->

		<!--반복 끝 -->

			<tr>
				<td colspan="4" class="align_right" style="border-right: none">
					총 구매금액 : <br>
					배송비 : <br>
					총 주문합계 : 
				</td>
				<td class="align_right" style="border-left: none">
					
				</td>
			</tr>
		
	</tbody>
</table>

	<div class="align_center" style="margin:10px 0">
		<a href="">[주문하기]</a>
		
		<a href="">[계속 쇼핑하기]</a>
	</div>	
</div>

<%@ include file="../../inc/bottom.jsp" %>















