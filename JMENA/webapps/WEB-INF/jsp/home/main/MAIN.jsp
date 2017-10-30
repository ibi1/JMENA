<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	
 	
	
	<title>JMENA</title>
	<style>
	    .ui-layout-center{ }
	    .ui-layout-east{ }
	    .ui-layout-west{ }
	    .ui-layout-south{ }
	    .ui-layout-north{ }
	</style>
	
	</head>
	<body>
	    <div id="center" class="ui-layout-center ui-layout-content ui-widget-content ui-corner-all" style="OVERFLOW-Y:auto; OVERFLOW-X:auto;width:1220px; padding: 10px"></div>
	    <div id="left" class="ui-layout-west ui-layout-content ui-widget-content ui-corner-all">
	    	<div id="sidetree">
				<div class="treeheader">&nbsp;</div>
				<div id="sidetreecontrol"><a href="?#">Collapse All</a> | <a href="?#">Expand All</a></div>
				<ul id="tree" class="treeview">
				</ul>
			</div>
	    </div>
		<div id="top" class="ui-layout-north">
			<div id="topleft" class="ui-layout-west ui-layout-content ui-widget-content ui-corner-all">
				<center><h3>JMENA</h3></center>
			</div>
			<div id="topright" style="padding-top: 30px; padding-left: 100px" class="ui-layout-center ui-layout-content ui-widget-content ui-corner-all"></div>
		</div>
	</body>
	
	<link rel="stylesheet" href="/resource/css/common.css">
	<link rel="stylesheet" href="/resource/css/jquery.treeview.css" />
		
	<script type="text/javascript" src="/resource/js/jquery.js"></script>
	<script type="text/javascript" src="/resource/js/jquery-1.7.2.min.js"></script>	
	<script type="text/javascript" src="/resource/js/jquery.treeview.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.layout.min.js"></script>
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>
	
	<script type="text/javascript">
	 	$(document).ready(function(){
	 		var TreeMenu = "";
	    	
	        $('body').layout({
	            west__size:250,
	            north__size:100,
	            closable : false
	        });
	        
	        $("#top").layout({
	            west__size:250,
	            north__size:100,
	            closable : false
	        });
	              
	       	//시스템 메뉴 호출
	       	$.ajax({ 
				type: 'POST' ,
				data: $("#loginFrm").serialize(),
				url: "/home/systemMenu.do", 
				dataType : 'json' , 
				success: function(data){
					var inHtml = "";
					data.systemMenu.forEach(function(currentValue, index, array){
						if (index == 0) TreeMenu = currentValue.SYSID;	//첫번째 시스템 메뉴로 트리 메뉴 셋팅
						
						//console.log(TreeMenu + ","+ currentValue.SYSID + ","+ currentValue.SYSNAME + "," + index);
						inHtml += "<a class=\"ui-button ui-widget ui-corner-all\" onclick=\"f_getTreeMenu('" + currentValue.SYSID + "')\">" + currentValue.SYSNAME + "</a>";
					});
					
					$("#topright").html(inHtml);
					
					if (TreeMenu != "") {
						f_getTreeMenu(TreeMenu);
			       	}
					
				},
				error:function(e){  
					alert("[ERROR]System Menu 호출 중 오류가 발생하였습니다.");
				}  
			});
	    });
	    
	  	//시스템 메뉴 중 첫번째 메뉴의 트리 호출
	    function f_getTreeMenu(sysId) {
	    	f_makeTree(sysId);
	  	}
	  	
	  	//트리만들기
	  	function f_makeTree(sysId) {
	  		$(function(){
    		    $.ajax({ 
    				type: "POST",
    				data: "SYSID=" + sysId,
    				url: "/home/treeMenu.do", 
    				dataType : 'json' , 
    				success: function(data){
    					$("#tree").html(data.tree);
    					
    					$("#tree").treeview({
    						collapsed: false,
    						animated: "medium",
    						control:"#sidetreecontrol",
    						persist: "location"
    					});
    					
   						pageView(data.pgmFirst);
    				},
    				error:function(e){  
    					alert("[ERROR]Tree Menu 호출 중 오류가 발생하였습니다");
    				}  
    			});
	    	})
	  	}
	  	
	  	function pageView(pgmId) {
	  		$("#center").load("/home/" + pgmId + ".do");
	  	}
	</script>
</html>