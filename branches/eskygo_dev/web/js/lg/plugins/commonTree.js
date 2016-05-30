Namespace.register("com.deelon.form");

com.deelon.form.commonTree = function(obj){	
	var treeObj;
	var rightMenu;
	//选中节点
	var selectNode;
	var idKey;
	var pIdKey;
	var listFrame; 
	loadTree();
	rightMenu=rightMenu();
	function loadTree(){
		$.ajax({
			type: 'POST',
			url: __ctx+obj.dataUrl,
			data: obj.param,
			success: function(result){
				if(false==obj.setting.onRightClick){
					apply(obj.setting.callback,{onClick:zTreeOnLeftClick});
				}else{	
					apply(obj.setting.callback,{onRightClick: zTreeOnRightClick,onClick:zTreeOnLeftClick});
				}
				
				if(obj.setting.data.key.nameArr){
					var nameArrObj=obj.setting.data.key.nameArr.split(",");
					for(var j=0;j<result.length;j++){							
							var n=result[j];
							var nameObj="";
							for(var i=0;i<nameArrObj.length;i++){
								nameObj=nameObj+n[nameArrObj[i]]+"_";
							}
							nameObj=nameObj+n[obj.setting.data.key.name]; 
							n[obj.setting.data.key.name]=nameObj;
					}
					
					
				}
				
				treeObj=$.fn.zTree.init($("#"+obj.treeName), obj.setting,eval(result));
				idKey=treeObj.setting.data.simpleData.idKey;
				pIdKey=treeObj.setting.data.simpleData.pIdKey; 
				treeObj.setting.async.enable=true;
				//treeObj.expandAll(true);
			}
		}); 
	}
	this.loadTree=function(){
		loadTree();
	}
	//外部对像调用
	this.addOrEditNode=function(menuSupId,menuId){	
		addOrEditNode(menuSupId,menuId);
	};
	function addOrEditNode(menuSupId,menuId){	
		if($.isEmpty(menuId)){
			menuId=0;
		}
		var nodeUrl=null;
		if(obj.addOrEditNodeUrl){
			
			if(obj.addOrEditNodeUrl.indexOf("?")!=-1){
				nodeUrl=obj.addOrEditNodeUrl+"&";
			}else{
				nodeUrl=obj.addOrEditNodeUrl+"?";
			}
		}
		var url=__ctx+nodeUrl+treeObj.setting.data.simpleData.pIdKey+"="+menuSupId+"&"+treeObj.setting.data.simpleData.idKey+"="+menuId;
	    var a;
		if(obj.treeNodeAttrName){
			var nodeArrN=obj.treeNodeAttrName.split(",");
			for(var i=0;i<nodeArrN.length;i++){
				var str=encodeURI(encodeURI(selectNode[nodeArrN[0]]));
				if(str=="XCGL"||str=="XSRM"||str=="BZZX"||str=="WYLC"||str=="WYJK2"||str=="AQBZ"||str=="ZRLCYS"
					||str=="CJWT"||str=="HYCZ"||str=="XMJS"||str=="XMCZYS"||str=="TZCZYS"||str=="JKCZYS"){ 
					 a=1;
				} 
				url=url+"&"+nodeArrN[i]+"="+encodeURI(encodeURI(selectNode[nodeArrN[i]]));
			}
		} 
		if(a==1){ 
		}else{
			$("#"+obj.listFrame).attr("src",url);
		}
		
	};
	//左键
	function zTreeOnLeftClick(event, treeId, treeNode, clickFlag){
		idKey=treeObj.setting.data.simpleData.idKey; 
		pIdKey=treeObj.setting.data.simpleData.pIdKey;  
		selectNode=treeNode; 
		addOrEditNode(treeNode[pIdKey],treeNode[idKey]);
	}
	//右键
	function zTreeOnRightClick(event, treeId, treeNode) {
		if (treeNode&&!treeNode.notRight) { 
			treeObj.selectNode(treeNode);
			rightMenu.show({ top: event.pageY, left: event.pageX});
			selectNode=treeNode;
		}
	};
	function rightMenu(){
		var rightMenu = $.ligerMenu({ top: 100, left: 100, width: 120, items:
	        [
	       /* { text: '增加节点',icon:'add', click: function(item, i){
	        	addOrEditNode(selectNode[idKey],0);
	        } },*/
	        { text: '编辑节点',icon:'modify', click: function(item, i){
	        	addOrEditNode(selectNode[pIdKey],selectNode[idKey]);
	        }  },
	       /* { text: '删除节点',icon:'delete', click: function(item, i){
	    		var menuId=selectNode[idKey];
	    		var delUrl=null;
	    		if(obj.delNodeUrl){
	    			if(obj.delNodeUrl.indexOf("?")!=-1){
	    				delUrl=obj.delNodeUrl+"&";
	    			}else{
	    				delUrl=obj.delNodeUrl+"?";
	    			}
	    		}
	    	 	var callback = function(rtn) {
	    			if(rtn){
	    				$.ajax({
	    					type: 'POST',
	    					url:__ctx+delUrl+idKey+"="+menuId,
	    					success: function(result){
	    						$.ligerMessageBox.success("提示信息","数据删除成功!");
	    						loadTree();
	    						var parentNode=selectNode.getParentNode();
	    						if(parentNode){
	    							treeObj.updateNode(parentNode);
	    						}else{
	    						loadTree();
	    						}
	    					}
	    				});
	    			}
	    		};
	    		$.ligerMessageBox.confirm('提示信息','确认删除吗？',callback);
	        } },*/
	        { text: '刷新',icon:'refresh', click: function(item, menuId){
	        	var parentNode=selectNode.getParentNode();
				if(parentNode){
					treeObj.reAsyncChildNodes(parentNode, "refresh", false);
				}else{
					loadTree();
				}
	        }}
	        ]
	        });
		return rightMenu;
	};
	//展开收起
	this.treeExpandAll=function(type){
		treeObj.expandAll(type);
	};
	//给外部调用,返回选中节点	 
	this.getSelectNode=function(){		
		return selectNode;
	};
	this.getTreeObj=function(){
		return treeObj;
	};
	/**
	 * 合并数组
	 * @returns
	 */	
	apply=function apply(){
	    var l=arguments.length;
	    if(l<1)return null; //无参数
	    if(l>2){ //多于两个
		    apply(arguments[0],arguments[l-1]); //从最后一个开始继承
		    arguments.length=l-1; //去掉最后一个参数然后递归
		    apply(arguments);
	    }
	    //两个参数
	    if(arguments[0]&&arguments[1]&&typeof arguments[1]=="object"){
		    for(var A in arguments[1]){
		    	arguments[0][A]=arguments[1][A];
		    }
	    }
	    return arguments[0];
	}
	

}; 

com.deelon.form.commonTree.prototype.onLeftClick=function(){
	alert(2);
};
