<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<title>JMENA</title>
	
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.base.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.light.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.bootstrap.css" type="text/css" />
	<link rel="stylesheet" href="/resource/jqwidgets-ver5.4.0/jqwidgets/styles/jqx.energyblue.css" type="text/css" />
	
	<style>
        html, body
        {
            width: 100%;
            height: 100%;
            padding: 3px;
            box-sizing: border-box;
            margin: 0;
        }
        th
        {
        	height : 22px;
			text-align: center;
			font-weight: bold;
			border: 1px solid #CCC;
        }
        select
        {
		    min-height: 25px;
		    min-width: 16px;
		    margin: 0px;
		    border-width: 1px;
		    border-style: solid;
		    font-size: 13px;
		    padding: 0px;
		    padding-left: 3px;
		    padding-right: 3px;
		    border-color: #a4bed4;
		    -webkit-border-radius: 3px;
		}
        
    </style>
	<script type="text/javascript" src="/resource/js/jquery.js"></script>
	<script type="text/javascript" src="/resource/js/jquery-1.7.2.min.js"></script>	
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxcore.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxnotification.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxtabs.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxsplitter.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxbuttons.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxbuttongroup.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxinput.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxmaskedinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxformattedinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxnumberinput.js"></script>
 	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxlistbox.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxcombobox.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxtree.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.sort.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.pager.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.edit.js"></script> 
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxdata.export.js"></script> 
    <script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.export.js"></script> 
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.grouping.js"></script> 
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.aggregates.js"></script>
	<script type="text/javascript" src="/resource/jqwidgets-ver5.4.0/jqwidgets/jqxgrid.columnsresize.js"></script> 
	<script type="text/javascript" src="/resource/js/common.js"></script>
	
	<script type="text/javascript" src="/resource/js/i18n/grid.locale-kr.js"></script>
	<script type="text/javascript" src="/resource/js/jquery.jqGrid.min.js"></script>
	
	<script type="text/javascript">
		function f_selectPgmAuth(PGMID) {
			$.ajax({ 
				type: 'POST' ,
				data: "PGMID=" + PGMID,
				url: "/home/selectPgmAuth.do", 
				dataType : 'json' , 
				success: function(data){
					if (data.returnCode == "FAILED") {
						alert("[ERROR-SCRIPT]권한 조회 중 오류가 발생하였습니다.");
					}
					
					$("#center").load("/home/" + PGMID + ".do");
				},
				error:function(e){  
					alert("[ERROR]프로그램 권한 호출 중 오류가 발생하였습니다.");
				}  
			});
		}
		
	 	$(document).ready(function(){
	 		$("#logoutButton").jqxButton({theme: 'light', width: 60, height: 25 });
	 		
	 		/* $("#messageNotification").jqxNotification({ theme: 'bootstrap',
                width: 400, position: "top-right", opacity: 0.9,
                autoOpen: true, animationOpenDelay: 800, autoClose: true, autoCloseDelay: 10000, template: "info"
            }); */
	 		
	 		var TreeMenu = "";

			//트리 선택 시 마다 수행
	 		$('#tree').on('itemClick',function (event) {
	 			
	 			var args = event.args;
				var item = $('#tree').jqxTree('getItem', args.element);
				var value = item.value; 

				//권한가져오기 후 화면이동
	 			f_selectPgmAuth(value);
	 			
				// $("#center").load("/home/" + value + ".do");
		  	});
	 		
	 		$('#tabs').on('tabclick', function (event) { 
	 			 var ids = event.args.item;
	 			 var item = $("#tabs").jqxTabs('getContentAt', ids);
	 			
	 			f_getTreeMenu(item.id);
		 	}); 
	 		
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
	       	*/
	       	
	       	$('#mainLayout').jqxSplitter({ theme: 'bootstrap',height: '100%', width: '100%', orientation: 'horizontal', resizable: false, splitBarSize: 0, showSplitBar: false, panels: [{ size: '103px', collapsible: false }] });
            $('#topLayout').jqxSplitter({  theme: 'bootstrap',height: '100%', width: '100%', orientation: 'vertical', resizable: false, splitBarSize: 0, showSplitBar: false, panels: [{ size: '250px', collapsible: false}] });
            $('#centerLayout').jqxSplitter({ theme: 'bootstrap',orientation: 'vertical', resizable: false, splitBarSize: 0, showSplitBar: false, panels: [{ size: '250px', collapsible: false}] });
            
            //시스템 메뉴 호출
	       	$.ajax({ 
				type: 'POST' ,
				data: $("#loginFrm").serialize(),
				url: "/home/systemMenu.do", 
				dataType : 'json' , 
				success: function(data){
					var liHtml = "";
					var divHtml = "";
					
					liHtml += "<ul>";
					
					data.systemMenu.forEach(function(currentValue, index, array){
						if (index == 0) TreeMenu = currentValue.SYSID;	//첫번째 시스템 메뉴로 트리 메뉴 셋팅

						liHtml += "<li>"+currentValue.SYSNAME+"</li>";
						
		            	divHtml += "<div id=\"" + currentValue.SYSID + "\" style=\"visibility: hidden;\"></div>";
		            });
					
					liHtml += "</ul>"
					liHtml += divHtml;
					
					$("#tabs").html(liHtml);
					
					$('#tabs').jqxTabs({theme: 'bootstrap', autoHeight: false, width:'100%'});
		            
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
    					var jsonValue = $.parseJSON(data.tree).treeData;

						var source = {
    	                    datatype: "json",
    	                    datafields: [
    	                        { name: 'id' },
    	                        { name: 'parentid' },
    	                        { name: 'text' },
    	                        { name: 'value' }
    	                    ],
    	                    id: 'id',
    	                    localdata: jsonValue
    	                };

    					// create data adapter.
    	                var dataAdapter = new $.jqx.dataAdapter(source);

    	                // perform Data Binding.
    	                dataAdapter.dataBind();

    	                // get the tree items. The first parameter is the item's id. The second parameter is the parent item's id. The 'items' parameter represents 
    	                // the sub items collection name. Each jqxTree item has a 'label' property, but in the JSON data, we have a 'text' field. The last parameter 
    	                // specifies the mapping between the 'text' and 'label' fields.  
    	                var records = dataAdapter.getRecordsHierarchy('id', 'parentid', 'items', [{ name: 'text', map: 'label'}]);
    	                
    	                $('#tree').jqxTree({ theme: 'bootstrap', source: records });
    	                $("#tree").jqxTree('expandAll');
    	                $('#tree').jqxTree('selectItem', $("#2")[0]);
    	                
    	                var item = $('#tree').jqxTree('getSelectedItem');
    	                
    	                f_selectPgmAuth(item.value);
    	                
    	               // $("#center").load("/home/" + item.value + ".do");
    				},
    				error:function(e){  
    					alert("[ERROR]Tree Menu 호출 중 오류가 발생하였습니다");
    				}  
    			});
	    	})
	  	}
	  	
		$(function() {
			$("#logoutButton").click(function() {
				if (confirm("로그아웃 하시겠습니까?") == true) {
					alert("안전하게 로그아웃되었습니다.\n감사합니다.");
					
					location.href = "/";
				}
			});
		})
	</script>
	</head>
	<body class="default">
		<div id="mainDiv" style="width: 100%; height: 100%;">
		    <div id="mainLayout">
		    	<div>
		    		<div id="topLayout">
	 	            	<div>
	 	            		<span>
	 	            			<div id="topLeft">
	 	            				<img alt="CI" src="/resource/img/ci/JMCI.jpg" width="250" height="101">
	 	            			</div>
	 	            		</span>
	 	            	</div>
	                    <div>
	                    	<span>
	                    		<div id="topright">
	                    			<div id="info" style="height: 40px; padding: 5px;" align="right">
	                    				<strong>[<%=session.getAttribute("userName")%>]</strong> 님! 환영합니다.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="로그아웃" id="logoutButton" />
	                    			</div>
	                    			<div id="tabs" style="font-size: 28px; !important; border: none;"></div>
	                    		</div>
							</span>
						</div>
	                </div>
				</div>
	            <div>
	                <div id="centerLayout">
	                	<div style="border-top: 1px solid #ccc;">
	                		<span>
	                			<div id="left">
							    	<div id="tree" style="border: none;"></div>
								</div>
							</span>
						</div>
	                	<div style="border-left: 1px solid #ccc; overflow: auto;">
	                		<span>
								<div id="center"></div>
							</span>
						</div>
	            	</div>
	            </div>
	    	</div>
		</div>
		<!--Notifications-->
		<!-- <div id="messageNotification">
	        <div>
            	현재 작업 중에 있습니다. <br/>
            	빠른 시일 내에 모든 페이지가 오픈될 예정입니다.<br/>
            	감사합니다.<br/>
            	* 이 메시지는 10초 뒤 자동으로 사라집니다.
        	</div>
    	</div> -->
	</body>
</html>
