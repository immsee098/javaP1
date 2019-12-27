<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>
<%
	String ck_userid="";

	Cookie[] ckArr=request.getCookies();
	if(ckArr!=null){
		for(int i=0;i<ckArr.length;i++){
			if(ckArr[i].getName().equals("ck_userid")){
				ck_userid=ckArr[i].getValue();
				break;
			}
		}//for
	}
	
%>

<style type="text/css">
	.error{
		color: red;
		display: none;
	}
</style>
<script type="text/javascript">
	$(function(){
		$("#userid").focus();
		
		$(".simpleForm form[name=frmLogin]").submit(function(){
			$(".infobox").each(function(){
				if($(this).val().length<1){
					$(this).next().show();
					$(this).focus();
					event.preventDefault();
				}else{
					$(this).next().hide();
				}
			});
		});
	});
</script>
<article class="simpleForm">
	<form name="frmLogin" method="post" action="login_ok.jsp">
		<fieldset>
			<legend>로그인</legend>
			<div>
				<label for="userid" class="label">아이디</label>
				<input type="text" name="userid" id="userid" 
					class="infobox" value="<%=ck_userid%>">
				<span class="error">아이디를 입력하세요</span>
			</div>			
			<div>
				<label for="pwd" class="label">비밀번호</label>
				<input type="password" name="pwd" id="pwd"
					class="infobox">
				<span class="error">비밀번호를 입력하세요</span>
			</div>
			<div class="align_center">
				<input type="submit" value="로그인">
				<input type="checkbox" name="chkSave" id="chkSave"
					<%if(ck_userid!=null && !ck_userid.isEmpty()){ %>
						checked="checked"
					<%} %>
				>
				<label for="chkSave">아이디 저장하기</label>
			</div>
		</fieldset>
	</form>
</article>
<%@ include file="../inc/bottom.jsp" %>