<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% session.invalidate(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/resource/css/jquery-ui.css" />
    <link rel="stylesheet" href="/resource/css/common.css">


	<script type="text/javascript" src="/resource/js/jquery-3.2.1.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){
			$("#USERID").focus();
		})
		
		$(function(){
			$("#loginButton").click(function(){
		        login();
			}) 
		})

		function login() {
			$(function(){
			    $.ajax({ 
					type: 'POST' ,
					data: $("#loginFrm").serialize(),
					url: "/login.do" , 
					dataType : 'json' , 
					success: function(data){
						if (data.ReturnMsg == "FAILED") {
							alert("[MSG]아이디와 패스워드를 확인해 주시기 바랍니다.");
							location.href = "/";
						} else {
							location.href = "/home/main.do";
						}
					},
					error:function(e){  
						alert("[ERROR]로그인 도중 오류가 발생하였습니다.");
						location.href = "/";
					}  
				}); 
			}) 
		}
		
		function onEnterSubmit() {
			var keyCode = window.event.keyCode;
			if(keyCode==13) login();
		}
	</script>
<title>JMENA</title>
</head>
<body>
	<div id="loginDiv" style="width:100%; padding-top: 100px;" align="center">
		<form id="loginFrm" method="post">
			<table>
				<tr>
					<td>
						<img alt="CI" src="/resource/images/ci.jpg">
					</td>
			</table>
			<br />
			<table  class="blueone">
				<tr>
					<td>
						ID
					</td>
					<td>
						<input type="text" name="USERID" id="USERID" />
					</td>
					<td rowspan="2">
						<a class="ui-button ui-widget ui-corner-all" id="loginButton" name="loginButton">로그인</a>
					</td>
				</tr>
				<tr>
					<td>PASSWORD</td>
					<td><input type="password" name="PASSWORD" id="PASSWORD" onkeydown="onEnterSubmit();" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>