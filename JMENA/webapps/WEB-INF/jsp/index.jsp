<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% session.invalidate(); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.base.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.light.css" type="text/css" />
	
	<script type="text/javascript" src="/resource/js/jquery-1.11.0.min.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxinput.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxpasswordinput.js"></script>
    
	<script type="text/javascript">
		$(document).ready(function(){
			$("#USERID").jqxInput({theme: 'light', placeHolder: "Enter a UserID", height: 25, width: 200, minLength: 1});
			$("#PASSWORD").jqxPasswordInput({theme: 'light', width: 200, height: 25 });
			$("#loginButton").jqxButton({theme: 'light', width: 120, height: 40 });

			$("#USERID").focus();
		})
		
		$(function(){
			  $("#loginButton").on('click', function () {
				 login(); 
			  });

			           
			//$("#loginButton").click(function(){
		      //  login();
			//}) 
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
<body class='default'>
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
						<input type="text" name="USERID" id="USERID" tabindex="1"/>
					</td>
					<td rowspan="2">
					<div>
       					<input type="button" value="로그인" id="loginButton" tabindex="3"/>
					</div>
					</td>
				</tr>
				<tr>
					<td>PASSWORD</td>
					<td><input type="password" name="PASSWORD" id="PASSWORD" tabindex="2" onkeydown="onEnterSubmit();" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>