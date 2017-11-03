<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>JMENA</title>
	</head>
	<body class="default">
	    <div id="mainLayout">
	    	<div>
	    		<div id="topLayout">
 	            	<div>
 	            		<span>
 	            			<div id="topLeft"><center><h3>JMENA</h3></center></div>
 	            		</span>
 	            	</div>
                    <div>
                    	<span>
                    		<div id="topright"></div>
						</span>
					</div>
                </div>
			</div>
            <div>
                <div id="centerLayout">
                	<div>
                		<span>
                			<div id="left">
						    	<div id="sidetree">
									<div class="treeheader">&nbsp;</div>
									<div id="sidetreecontrol"><a href="?#">Collapse All</a> | <a href="?#">Expand All</a></div>
									<ul id="tree" class="treeview">
									</ul>
								</div>
							</div>
						</span>
					</div>
                	<div>
                		<span>
							<div id="center"></div>
						</span>
					</div>
            	</div>
            </div>
		</div>
	</body>
	
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.base.css" type="text/css" />
	<link rel="stylesheet" href="/resource/css/common.css">
	<link rel="stylesheet" href="/resource/css/jquery.treeview.css" />
		<style type="text/css">
.hiddenClass {
	display : none;
    height: 0;
    min-height: 0;
}
.moveContentClass { margin-top: -15px; }

    </style>
	<script type="text/javascript" src="/resource/js/jquery.js"></script>
	<script type="text/javascript" src="/resource/js/jquery-1.7.2.min.js"></script>	
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxsplitter.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxlayout.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxribbon.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.treeview.js"></script>
	<!-- script type="text/javascript" src="/resource/js/jquery.layout.min.js"></script-->
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>
	
	<script type="text/javascript">
	 	$(document).ready(function(){
	 		var TreeMenu = "";
	 		
	 		
	 	// the 'layout' JSON array defines the internal structure of the layout
/*
            var layout = [{
                type: 'layoutGroup',
                orientation: 'vertical',
                width: '100%',
                items: [{
					type: 'documentGroup',
                    height: '10%',
                    items: [{
                    	type: 'documentPanel',
                    	contentContainer: 'topPanel'
               		}]
                }, {
	            	type: 'layoutGroup',
	            	orientation: 'horizontal',
	                width: '100%',
	                height: '90%',
	                items: [{
	                    type: 'documentGroup',
	                    width: '15%',
	                    height: '90%',
	                    items: [{
	                        type: 'documentPanel',
	                        contentContainer: 'leftPanel'
	                    }]
	                }, {
	                	type: 'documentGroup',
	                    width: '85%',
	                    height: '90%',
	                    pinnedHeight: 30,
	                    items: [{
	                        type: 'documentPanel',
	                        contentContainer: 'centerPanel'
	                    }] 
	                }]
	            }]
            }];
	 		
            $('#jqxLayout').jqxLayout({ width: '100%', height: '100%', layout: layout, resizable : false, contextMenu : false  });
            //$("#jqxLayout ul.jqx-widget-header").toggleClass('hiddenClass')
            //$("#jqxLayout .jqx-widget-content").toggleClass('moveContentClass')
	       	*/
	       	
	       	$('#mainLayout').jqxSplitter({ width: '95%', height: '95%', orientation: 'horizontal', resizable: false, splitBarSize: 0, showSplitBar: false, panels: [{ size: '10%', collapsible: false }] });
            $('#topLayout').jqxSplitter({ orientation: 'vertical', resizable: false, splitBarSize: 0, showSplitBar: false, panels: [{ size: '15%', collapsible: false}] });
            $('#centerLayout').jqxSplitter({ orientation: 'vertical', resizable: false, splitBarSize: 0, showSplitBar: false, panels: [{ size: '15%', collapsible: false}] });
            
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