/**
 * 通用实体数据下拉框。
 * 1.entityClassPath:
 * 		 entityCode
 * 3.valueField
 *  	分类对应的字段（为隐藏字段)。
 * 4.isMultiSelect
 * 		是否允许多选。
 * 7.treeLeafOnly
 * 		如果是树形下拉框，只选择叶子节点。 
 * 8.height 下拉框的高度。
 * 
 *  <input class="entityComBo" entityCode="SysOrg" entityFiledId="orgId" entityFiledName="orgName" 
	 entityQuery="Q_orgSupId_S=1" orderField="createtime" orderSeq="desc"
	 idKeyName="orgId" pIdKeyName="orgSupId" valueField="siteOrgId" valueFieldVal="${cmsSiteConfig.siteOrgId }" width="250" />
 */
$(function() {
	var ctx = __ctx;
	/**
	 * 读取配置信息。
	 */
	function readCatProp(entityComBo) {
		//读取配置信息
		var prop = {
			entityCode:$(entityComBo).attr("entityCode"),
			entityClassPath : $(entityComBo).attr("entityClassPath"),
			entityQuery:$(entityComBo).attr("entityQuery"),
			orderField:$(entityComBo).attr("orderField"),
			orderSeq:$(entityComBo).attr("orderSeq"),
			
			entityFiledId:$(entityComBo).attr("entityFiledId"),
			entityFiledName:$(entityComBo).attr("entityFiledName"),
			
			idKeyName:$(entityComBo).attr("idKeyName"),//树型主键ID名称
			pIdKeyName:$(entityComBo).attr("pIdKeyName"),//树型上级ID名称
			
			sqlKey:$(entityComBo).attr("sqlKey"),//需要执行的sql名key
			
			entityClick:$(entityComBo).attr("entityClick"),//点击事件
			width : $(entityComBo).attr("width"),
			height : $(entityComBo).attr("height"),
			
			isMultiSelect : $(entityComBo).attr("isMultiSelect"),
			treeLeafOnly : $(entityComBo).attr("treeLeafOnly"), 
			valueFieldVal:$(entityComBo).attr("valueFieldVal"),
			valueField:$(entityComBo).attr("valueField")
		};
		//entityClassPath 是必须的。
		if (isValueNull(prop.entityCode)) {
			alert('下拉实体控件，entityCode属性必须有!');
			return false;
		}
		//宽度
		if (isValueNull(prop.width)) {
			prop.width = $(entityComBo).width();
		}
		//高度
		if (isValueNull(prop.height)){
			prop.height = 150;
		}	
		//是否多选
		if (isValueNull(prop.isMultiSelect)){
			prop.isMultiSelect = false;
		}
		//页节点选中
		if (isValueNull(prop.treeLeafOnly)){
			prop.treeLeafOnly = false;
		}
		if (isValueNull(prop.idKeyName)){
			prop.idKeyName = prop.entityFiledId;
		}
		return prop;
	}
	
	//判断是否为空。
	function isValueNull(obj){
		if(obj == 'undefined' || obj == null || obj == '')
			return true;
		return false;
	}
	//从服务端加载数据。
	function processCat(entityComBo, prop) {
		var url=ctx + "/platform/system/sysUser/getEntityCombo.ht";   
		var params={entityClassPath:prop.entityClassPath,entityCode:prop.entityCode,entityQuery:prop.entityQuery,orderField:prop.orderField,orderSeq:prop.orderSeq,sqlKey:prop.sqlKey};
		$.post(url,params,function(rtnData){ 
			var comboBox=$(entityComBo).ligerComboBox({
					valueFieldID:prop.valueField,
					width : prop.width,
					treeLeafOnly : prop.treeLeafOnly,
					valueField:prop.entityFiledId,
					textField:prop.entityFiledName,
					tree : {
						nameKey:prop.entityFiledId,
						data : {
							simpleData : {enable : true,idKey:prop.idKeyName,pIdKey:prop.pIdKeyName},
							key : {name : prop.entityFiledName},
							data : rtnData
						},
						callback: {
							onClick: isValueNull(prop.entityClick)==true?null:eval(prop.entityClick)
						},
						selectValue:prop.valueFieldVal,
						view : { selectedMulti : prop.isMultiSelect},
						check : prop.check
					},
					selectBoxWidth : prop.width,
					selectBoxHeight : prop.height
			});
			
			if(!isValueNull(prop.valueFieldVal)){
				var hidCatField=$("#" + prop.valueField);
				//设置隐藏域的分类id
				if(hidCatField.length>0){
					hidCatField.val(prop.valueFieldVal);
				}
			}
		});
	}
	// entityComBo
	$.fn.entityComBo = function(option) {
		$(this).each(function() {
			var prop = readCatProp(this);
			processCat(this, prop);
		});
	};
	
	$('.entityComBo').each(function() {
		$(this).entityComBo();
	});
});
