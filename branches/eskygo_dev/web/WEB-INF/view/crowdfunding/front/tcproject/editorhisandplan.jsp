<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/commons/includeFront/taglibs.jsp"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit"/>
<title><%=application.getAttribute("PLATFORM_NAME")%> - 历史和未来计划情况</title>
<%@ include file="/crowdfunding/cssorjs.jsp"%>
 <%@include file="/commons/include/form.jsp" %> 	
	  <script type="text/javascript" src="${ctx }/crowdfunding/js/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${ctx}/crowdfunding/js/ckeditor/adapters/jquery.js"></script>
	
	 <script type="text/javascript" src="${ctx }/js/jquery/plugins/jquery.showLoading.js"></script>
	<script type="text/javascript" src="${ctx }/js/jquery/plugins/jquery.showLoading.min.js"></script>
   <link href="${ctx }/styles/default/css/jquery/showLoading.css" rel="stylesheet" type="text/css" />
	
     <link rel="stylesheet" href="${ctx }/crowdfunding/Skin/Default/css/Userbackground.css">
</head>
<body>
   <div class="addyourproject f_l">
   			<input type="hidden" id="editorType" value="${type }" />
			<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png"><c:if test="${type==2 }">项目未来计划资料</c:if><c:if test="${type==1 }">项目历史执行资料</c:if></h2>
			<div class="steps">
				<div class="step">
					<span>基本资料</span>
				</div>
				<div class="step">
					<span>市场定位与商业模式</span>
				</div>
				<div class="step">
					<span>股东及管理团队</span>
				</div>
				<div id="historydoc" class="step">
					<span>项目历史执行资料</span>
				</div>
				<div id="futuredoc" class="step">
					<span>项目未来计划</span>
				</div>
			</div>
			<div class="hint">温馨提示：本页内容一旦审核通过，将不再允许修改，请依照事实诚信填写，珍惜自己诚信信用！</div>
			<div class="TagContent">
			<div class="clear addyourprojectList">
				<div id="InPrlistparent">
				<c:forEach items="${list}" var="vo" varStatus="i">
						<div class="InPrlist">
							<h3 class="InPrlistH3"><span>${i.count }</span>第${i.count }阶段 </h3>
							<div class="PrHiDataList">
								<form >
									<ul>
										<li> <input type="hidden" name="historyPlanId" value="${vo.historyPlanId }" class="PrHiDataListinput" /></li>
										<li><span>1、阶段名称：</span><input type="text" name="phpname" value="${vo.phpname }" class="PrHiDataListinput" /></li>
										<li class="PrHiDataListSelect"><span>2、起止时间：</span><select name="phpstartYear" > <c:forEach items="${years }" var="year"><option <c:if test="${vo.phpstartYear == year }">selected</c:if>>${year}</option></c:forEach></select>年<select  name="phpstartMonth" > <c:forEach items="${months }" var="month"><option <c:if test="${vo.phpstartMonth == month }">selected</c:if>>${month}</option> </c:forEach></select>月至<select  name="phpendYear" > <c:forEach items="${years }" var="year"><option <c:if test="${vo.phpendYear == year }">selected</c:if>>${year}</option></c:forEach></select>年<select  name="phpendMonth" > <c:forEach items="${months }" var="month"><option <c:if test="${vo.phpendMonth == month }">selected</c:if> >${month}</option></c:forEach></select>月</li>
										<li><span>3、阶段达成目标描述：</span>
											<div class="ckeditorDiv"><textarea class="ckeditor1" >${vo.phptargetDesc }</textarea> </div>
										</li>
										<li><span>4、完成阶段目标的主要措施、方法、手段：</span>
											<div class="ckeditorDiv"><textarea class="ckeditor2" >${vo.phptargetWay }</textarea> </div>
										</li>
										<li><span>5、阶段收入： </span>		
										
											<input type="radio" name="income" value="0"/>有
											<input type="radio" name="income" checked="checked" value="1"/>无 
											<div id="income" class="InPrlistTable"  style="display:none"> 
												<table class="tableins1" border="0" cellspacing="1" cellpadding="0">
													<tr>
														<th width="25%">收入类别</th>
														<th width="25%">收入金额￥</th>
														<th width="50%">备注</th>
													</tr>
													<c:forEach items="${vo.listHpPayMent }" var="payM">
													<c:if test="${payM.hpptypeId eq '1' }">
														<tr class="InPrlistTr">
															<td><div><input type="text" value="${payM.hppkindName }" /></div></td>
															<td><div><input  onkeyup="num(this)" type="text" value="${payM.hpppayment }" /></div></td>
															<td><div><input type="text" value="${payM.hppremarks }" /><input type="hidden" value="${payM.paymentsId }" /></div></td>
														</tr>
													</c:if>
													</c:forEach>
													 <tr class="InPrlistTr">
														<td> </td>
														<td> </td>
														<td><a href="javascript:void(0);">继续添加开支类别</a></td>
													</tr> 
												</table>
											</div>
										</li>
										<li><span>6、阶段开支：  </span> 
									
									
											<input type="radio" name="outcome"  value="0"/>有
											<input type="radio" name="outcome" checked="checked" value="1"/>无 
											<div id="outcome" class="InPrlistTable"  style="display:none"> 
							
												<table class="tableouts1" border="0" cellspacing="1" cellpadding="0">
													<tr>
														<th width="25%">开支类别</th>
														<th width="25%">开支金额￥</th>
														<th width="50%">备注</th>
													</tr>
													<c:forEach items="${vo.listHpPayMent }" var="payM">
													<c:if test="${payM.hpptypeId eq '2' }">
														<tr class="InPrlistTr">
															<td><div><input type="text" value="${payM.hppkindName }" /></div></td>
															<td><div><input type="text"  onkeyup="num(this)" value="${payM.hpppayment }" /></div></td>
															<td><div><input type="text" value="${payM.hppremarks }" /><input type="hidden" value="${payM.paymentsId }" /></div></td>
														</tr>
													</c:if>
													</c:forEach>
												  	<tr class="InPrlistTr">
														<td> </td>
														<td> </td>
														<td><a href="javascript:void(0);">继续添加开支类别</a></td>
													</tr> 
												</table>
											</div>
										</li>
									</ul>
									</form>
							</div>
						</div>
						</c:forEach>
				</div>

				<div class="Addphase"><span>+添加阶段</span></div>
				<div class="cumulative">
					<span>累计盈亏：</span>
					<div class="InPrlistTable">
						<table border="0" cellspacing="1" cellpadding="0">
							<tr>
								<th width="33%">累计收入金额￥</th>
								<th width="33%">累计开支金额￥</th>
								<th width="33%">累计盈亏金额￥</th>
							</tr>
							<tr class="InPrlistTr">
								<td><fmt:formatNumber value="${moneyIn }" pattern="###,###.##"   minFractionDigits="2" /></td>
								<td><fmt:formatNumber value="${moneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
								<td><fmt:formatNumber value="${moneyIn-moneyOut }" pattern="###,###.##"   minFractionDigits="2" /></td>
							</tr>
						</table>
					</div>
					<div class="cumulativeButton">
					<form id="hpinfo" method="post" action="${ctx}/crowdfunding/tcproject/savehplans.ht">
						<input type="hidden" id="projectId" name="projectId" value="${projectId}"  /> 
						<input type="hidden" id="next" name="next"/><input type="hidden" id="datas" name="datas"/>
						<input type="hidden" id="type" name="type" value="${type}" />
						<div class="cumulativeButton1" onclick="savetcprojecthp(1)"><c:if test="${type==2 }">保存</c:if><c:if test="${type==1 }">下一步</c:if></h2></div>
						<div class="cumulativeButton1" onclick="savetcprojecthp(2)">返回</div>
					</form>	
					</div>
				</div>
			</div>
			</div>
		</div>
		<script type="text/javascript">
		  jQuery(document).ready(function($) {
		      //阶段收入面版判斷
		      //有資料時，顯示表格
		      if($("#income table tbody tr.InPrlistTr").length > 0){
		        $("input[name='income'][value='0']").attr('checked','checked');
		        $("input[name='income'][value='1']").attr('checked',null).attr("disabled","disabled"); 
		        $("#income").show();
		      }
		      //阶段开支：  面版判斷
		      //有資料時，顯示表格
		      if($("#outcome table tbody tr.InPrlistTr").length > 0){
		        $("input[name='outcome'][value='1']").attr('checked',null).attr("disabled","disabled");
		        　$("input[name='outcome'][value='0']").attr('checked','checked');
		        　$("#outcome").show();
		      }
		    });
		window.onload=function(){
			//window.location.href="#";
			var interval = setTimeout(window.parent.iFrameHeight, "1000");
		}
		 function num(th){
			  var reg = /^[0-9]{0}([0-9]|[.])+$/;
		      if(reg.test(th.value)!=true){th.value="";}
		  }
		//var _phase;
			//window.onload=function(){
			//	var interval = setTimeout(chat, "1000");
			//	window.parent.iFrameHeight();
			//}
			//function chat(){
			//	_phase=$("#InPrlistparent").html();
			//}
			function savetcprojecthp(val){
				//var data = $(".PrHiDataList form").serializeArray();
				//console.log(data);
				$(".addyourproject").showLoading(); 
				var datas = "[";
				$(".PrHiDataList form").each(function (index, domEle){
					var data = formToJsonData($(domEle),index+1);
					datas += JSON.stringify(saveData(data,index+1))+",";
				});
				if (datas.lastIndexOf(",")){  
					datas = datas.substring(0,datas.length -1);  
	                datas += "]";
	            }  
				$('#datas').val(datas);
				$('#next').val(val);
				$("#hpinfo").submit();
				
			}
			function formToJsonData(from,index1){
				   var o ={};
				   $.each(from.serializeArray(),function(index){
					   if(o[this['name']]){
					  		o[this['name']]=o[this['name']]+','+this['value'];
					   }else{
						   	//alert(index1+this['name']+this['value']);
						   	if(this['name']=='phptargetDesc'+(index1)){
						   		o['phptargetDesc']=CKEDITOR.instances[this['name']].getData();
						   	}else if(this['name']=='phptargetWay'+(index1)){
						   		o['phptargetWay']=CKEDITOR.instances[this['name']].getData();
						   	}else{
						   		o[this['name']]=this['value'];
						   	}
					   }
				   });
				   return o ;
			}
			//创建编辑器
			function createEditor() {
				//$( '.ckeditorDiv textarea' ).ckeditor();
				$(".InPrlist").each(function(index,e){
					var id1 = "phptargetDesc"+(index+1);
					var id2 = "phptargetWay"+(index+1);
					 if(!CKEDITOR.instances[id1]){  //判定content2是否存在
						 CKEDITOR.replace(id2);  
						 CKEDITOR.replace(id1); 
					 }else{
						 var value1='';
						 var value2='';
							 var editor2 = CKEDITOR.instances[id2]; 
							 var editor1 = CKEDITOR.instances[id1]; 
							 if(editor2){ 
								 value2=CKEDITOR.instances[id2].getData();
								 editor2.destroy(true);//销毁编辑器 content2,然后新增一个
								 CKEDITOR.replace(id2);  
								 CKEDITOR.instances[id2].setData(value2);
							 }
						 	if(editor1){
						 		value1=CKEDITOR.instances[id1].getData()
						 		editor1.destroy(true);//销毁编辑器 content1,然后新增一个
						 		CKEDITOR.replace(id1); 
							 	CKEDITOR.instances[id1].setData(value1);
						 	}
						 	
				 	 }   
				});
			} 
			$(function(){
				var type = $("#editorType").val();
				if(type==="1"){
					$("#futuredoc").removeClass("active");
					$("#historydoc").addClass("active");
				}else if(type==="2"){
					$("#historydoc").removeClass("active");
					$("#futuredoc").addClass("active");
				}
				//window.parent.scrollTo(1200, 300);
              window.parent.scrollTo(0, 0);
              window.parent.parent.scroll(0, 0);
				var _phase=$("#InPrlistparent").html();
				listIndex();
				createEditor();
				var _tr='<tr><td><div><input type="text"/></div></td><td><div><input type="text"  onkeyup="num(this)"  /></div></td><td><div><input type="text"/></div></td></tr>';
				// $("#InPrlistparent .InPrlistH3 a").eq(0).css("display","none");//去除第一阶段删除按钮
				$(".addyourprojectList").on('click','.InPrlistTr a',function(){
					var _index=$(this).parent().parent().index();
					$(this).parent().parent().parent().find("tr").eq(_index-1).after(_tr);
					var interval = setTimeout(window.parent.iFrameHeight, "1000");
				});
				$(".Addphase span").click(function(){
					$("#InPrlistparent").append(_phase);
					var interval = setTimeout(window.parent.iFrameHeight, "1000");
					listIndex();
					createEditor();
				});
				$("#InPrlistparent").on('click','.InPrlistH3 a',function(){
					$(this).parent().parent().remove();
					listIndex();
				});
				$("#InPrlistparent").on('click','input[type="radio"]',function(){
					if($(this).val()==0){
						var interval = setTimeout(window.parent.iFrameHeight, "1000");
						$(this).parent().find(".InPrlistTable").css("display","block");
					}else{
						$(this).parent().find(".InPrlistTable").css("display","none");
					}
				});
			});
			function listIndex(){
				$(".InPrlist").each(function(index,e){
					$(this).find('.InPrlistH3').find("span").html(index+1);
					$(this).find('.InPrlistH3').find("em").html(index+1);
					$(this).find('.tableins1').attr("class","tableins"+(index+1));
					$(this).find('.tableouts1').attr("class","tableouts"+(index+1));
					$(this).find('.ckeditor1').attr("name","phptargetDesc"+(index+1));
					$(this).find('.ckeditor1').attr("id","phptargetDesc"+(index+1));
					$(this).find('.ckeditor2').attr("name","phptargetWay"+(index+1));
					$(this).find('.ckeditor2').attr("id","phptargetWay"+(index+1));
				});
			}
			function saveData(data,index){
	        	 var dataJson="[";  
	             var hppkindName = "";  
	             var hpppayment = "";   
	             var hppremarks = "";  
	             var paymentsId = "";  
	             $(".tableins"+index+" tr").each(function (index, domEle){// mainTable 下的tr  
	            	  hppkindName = "";  
		              hpppayment = "";   
		              hppremarks = "";   
		              paymentsId = "";  
	                 if(index != 0){//遍历除去第一行的之外的所有input作为json数据传入后台  
	                     $(domEle).find("input").each(function(index,data){  
	                         if(index == 0){  
	                        	 hppkindName = $(data).val();  
	                         }else if(index == 1){  
	                        	 hpppayment = $(data).val();  
	                         }else if(index == 2){  
	                        	 hppremarks = $(data).val();  
	                         }else{  
	                        	 paymentsId = $(data).val(); 
	                         }  
	                     }); 
	                 	if(paymentsId!=""){
	                 		dataJson += "{"+"\"paymentsId\":\""+paymentsId+"\","+"\"hppkindName\":\""+hppkindName+"\","+"\"hpppayment\":\""+hpppayment+"\","+"\"hppremarks\":\""+hppremarks+"\"},";
	                 	}else if(hppkindName!=""&&hpppayment!=""){
	                 		dataJson += "{"+"\"paymentsId\":\"0\","+"\"hppkindName\":\""+hppkindName+"\","+"\"hpppayment\":\""+hpppayment+"\","+"\"hppremarks\":\""+hppremarks+"\"},";
	                 	}
	                 }  
	             });  
	             if (dataJson.lastIndexOf(",")) {  
	                 dataJson = dataJson.substring(0,dataJson.length -1);  
	                 dataJson += "]";  
	             }  
	             if(dataJson!=']'){
		             data['income']=dataJson;
	             }else{
	            	 data['income']="";
	             }
	             dataJson="[";  
	             $(".tableouts"+index+" tr").each(function (index, domEle){// mainTable 下的tr  
	            	  hppkindName = "";  
		              hpppayment = "";   
		              hppremarks = "";   
		              paymentsId = "";
	                 if(index != 0){//遍历除去第一行的之外的所有input作为json数据传入后台  
	                     $(domEle).find("input").each(function(index,data){  
	                         if(index == 0){  
	                        	 hppkindName = $(data).val();  
	                         }else if(index == 1){  
	                        	 hpppayment = $(data).val();  
	                         }else if(index == 2){  
	                        	 hppremarks = $(data).val();  
	                         }else{  
	                        	 paymentsId = $(data).val(); 
	                         }  
	                     }); 
		                 if(paymentsId!=""){
		                 		dataJson += "{"+"\"paymentsId\":\""+paymentsId+"\","+"\"hppkindName\":\""+hppkindName+"\","+"\"hpppayment\":\""+hpppayment+"\","+"\"hppremarks\":\""+hppremarks+"\"},";
		                 }else if(hppkindName!=""&&hpppayment!=""){
		                 		dataJson += "{"+"\"paymentsId\":\"0\","+"\"hppkindName\":\""+hppkindName+"\","+"\"hpppayment\":\""+hpppayment+"\","+"\"hppremarks\":\""+hppremarks+"\"},";
		                 }
	                 }  
	             });  
	             if (dataJson.lastIndexOf(",")) {  
	                 dataJson = dataJson.substring(0,dataJson.length -1);  
	                 dataJson += "]";  
	             }  
	             if(dataJson!=']'){
	            	 data['outcome']=dataJson;
	             }else{
	            	 data['outcome']="";
	             }
	            return data;
	        }
		</script> 
</body>
</html>