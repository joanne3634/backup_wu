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
			<h2><img src="${ctx }/crowdfunding/Skin/Default/images/headportrait4.png">编辑股东及管理团队</h2>
			<div class="steps">
				<div class="step">
					<span>基本资料</span>
				</div>
				<div class="step">
					<span>市场定位与商业模式</span>
				</div>
				<div class="active step">
					<span>股东及管理团队</span>
				</div>
				<div class="step">
					<span>项目历史执行资料</span>
				</div>
				<div class="step">
					<span>项目未来计划</span>
				</div>
			</div>
			<div class="hint">温馨提示：本页内容一旦审核通过，将不再允许修改，请依照事实诚信填写，珍惜自己诚信信用！</div>
			<div class="TagContent">
			<div class="clear addyourprojectList">
				<div id="InPrlistparent">
				<div class="InPrlist" id="InPrlistA">
					<h3 class="InPrlistH3"><span>1</span>股东团队说明</h3>
					<div class="InPrlistTable">
						<table class="tableouts" border="0" cellspacing="1" cellpadding="0">
							<tr>
								<th width="90">姓名</th>
								<th width="120">职务</th>
								<th width="90">是否全职</th>
								<th width="105">所占股份(%)</th>
								<th width="150">实际出资金额</th>
								<th width="200">与其他股东历史关系描述</th>
								<th width="60">操作</th>
							</tr>
							<c:forEach items="${listT }" var="vo">
								<c:if test="${vo.pttypeId eq '1' }">
									<tr>
										<td><div><input type="text" value="${vo.ptname}" /></div></td>
										<td><div><input type="text" value="${vo.ptduty}" /></div></td>
										<td><select><option value="1" <c:if test="${vo.ptmisFullTime==1}">selected="selected" </c:if>>是</option><option value="0"  <c:if test="${vo.ptmisFullTime==0}">selected="selected"</c:if>>否</option></select></td>
										<td><div><input type="text"  onblur="numRate(this)" value="${vo.pttheShare}" /></div></td>
										<td><div><input type="text"  onkeyup="num(this)" value="${vo.ptrealPay}" /></div></td>
										<td><div><input type="text" value="${vo.ptrelationship}" /></div></td>
										<td><input type="hidden" value="${vo.teamId}" /><img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png"></td>
									</tr>
								</c:if>
							</c:forEach>
							<!--<tr>
								<td><div><input type="text"  /></div></td>
								<td><div><input type="text"  /></div></td>
								<td><select><option value="1">是</option><option value="0">否</option></select></td>
								<td><div><input type="text"  onblur="numRate(this)" /></div></td>
								<td><div><input type="text"  onkeyup="num(this)" /></div></td>
								<td><div><input type="text"  /></div></td>
								<td><img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png"></td>
							</tr>
							<tr>
								<td><div><input type="text"  /></div></td>
								<td><div><input type="text"  /></div></td>
								<td><select><option value="1">是</option><option value="0">否</option></select></td>
								<td><div><input type="text"   onblur="numRate(this)" /></div></td>
								<td><div><input type="text"   onkeyup="num(this)" /></div></td>
								<td><div><input type="text"  /></div></td>
								<td><img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png"></td>
							</tr>-->
							<tr class="InPrlistTr InPrlistTrA">
								<td colspan="7"><a href="javascript:void(0);">增加一行</a></td>
							</tr>
						</table>
					</div>
					<c:forEach items="${listT }" var="vo">
								<c:if test="${vo.pttypeId eq '1' }">
									<div class="PrHiDataList">
										<form>
										<h5>▌股东团队成员<span>${vo.ptorderId}</span>简介：</h5>
										<div class="ckeditorDiv"><textarea >${vo.ptmemberInfo}</textarea> </div>
										</form>
									</div>
								</c:if>
					</c:forEach>
					<!--<div class="PrHiDataList">
						<form>
						<h5>▌股东团队成员<span>1</span>简介：</h5>
						<div class="ckeditorDiv"><textarea ></textarea> </div>
						</form>
					</div>
					<div class="PrHiDataList">
						<form>
						<h5>▌股东团队成员<span>2</span>简介：</h5>
						<div class="ckeditorDiv"><textarea ></textarea> </div>
						</form>
					</div>  -->
				</div>
				<div class="InPrlist" id="InPrlistB">
					<h3 class="InPrlistH3"><span>2</span>非股东管理团队（<input type="radio" name="shareholder" value="0" <c:if test="${not empty has}">checked="checked"</c:if>/>有<input type="radio" name="shareholder" value="1" <c:if test="${empty has}">checked="checked"</c:if>  />无）</h3>
					<div class="InPrlistTable">
						<table  class="tableins" border="0" cellspacing="1" cellpadding="0">
							<tr>
								<th width="90">姓名</th>
								<th width="120">职务</th>
								<th width="90">是否全职</th>
								<th width="120">入职时间</th>
								<th width="220">与创始团队成员历史关系</th>
								<th width="60">操作</th>
							</tr>
							<c:forEach items="${listT }" var="vo">
								<c:if test="${vo.pttypeId eq '0' }">
									<tr>
										<td><div><input type="text" value="${vo.ptname}" /></div></td>
										<td><div><input type="text" value="${vo.ptduty}" /></div></td>
										<td><select><option value="1" <c:if test="${vo.ptmisFullTime==1}">selected="selected" </c:if>>是</option><option value="0"  <c:if test="${vo.ptmisFullTime==0}">selected="selected"</c:if>>否</option></select></td>
										<td><div><input type="text" value="${vo.ptentryTime}" /></div></td>
										<td><div><input type="text" value="${vo.ptrelationship}" /></div></td>
										<td><input type="hidden" value="${vo.teamId}" /><img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png"></td>
									</tr>
								</c:if>
							</c:forEach>
							<tr>
								<td><div><input type="text"  /></div></td>
								<td><div><input type="text"  /></div></td>
								<td><select><option value="1">是</option><option value="0">否</option></select></td>
								<td><div><input type="text"  /></div></td>
								<td><div><input type="text"  /></div></td>
								<td><img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png"></td>
							</tr>
							<tr>
								<td><div><input type="text"  /></div></td>
								<td><div><input type="text"  /></div></td>
								<td><select><option value="1">是</option><option value="0">否</option></select></td>
								<td><div><input type="text"  /></div></td>
								<td><div><input type="text"  /></div></td>
								<td><img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png"></td>
							</tr>
							<tr class="InPrlistTr InPrlistTrB">
								<td colspan="6"><a href="javascript:void(0);">增加一行</a></td>
							</tr>
						</table>
					</div>
					<c:forEach items="${listT }" var="vo">
								<c:if test="${vo.pttypeId eq '0' }">
									<div class="PrHiDataList">
										<form>
										<h5>▌股东团队成员<span>${vo.ptorderId}</span>简介：</h5>
										<div class="ckeditorDiv"><textarea >${vo.ptmemberInfo}</textarea> </div>
										</form>
									</div>
								</c:if>
					</c:forEach>
					<div class="PrHiDataList">
						<form>
						<h5>▌非股东团队成员<span>1</span>简介：</h5>
						<div class="ckeditorDiv"><textarea ></textarea> </div>
						</form>
					</div>
					<div class="PrHiDataList">
						<form>
						<h5>▌非股东团队成员<span>2</span>简介：</h5>
						<div class="ckeditorDiv"><textarea ></textarea> </div>
						</form>
					</div>
				</div>
				</div>
					<div class="cumulativeButton">
						<form id="hpinfo" method="post" action="${ctx}/crowdfunding/tcproject/savepartners.ht">
							<input type="hidden"  id="projectId" name="projectId" value="${projectId}"  /> 
							<input type="hidden" id="next" name="next"/><input type="hidden" id="datas" name="datas"/>
							<input type="hidden" id="totalPercents" name="totalPercents"/>
							<div class="cumulativeButton1" onclick="savetcprojecthp(1)">下一步</div>
							<div class="cumulativeButton1" onclick="savetcprojecthp(2)">返回</div>
						</form>	
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			window.onload=function(){
				//window.location.href="#";
				var interval = setTimeout(window.parent.iFrameHeight, "1000");
			}
			 function num(th){
				  var reg = /^[0-9]{0}([0-9]|[.])+$/;
			      if(reg.test(th.value)!=true){th.value="";}
			  }
			 function numRate(th){
				  var reg = /^[0-9]{0}([0-9]|[.])+$/;
			      if(reg.test(th.value)!=true){th.value="";}
			      if(th.value<=0 || th.value>100){th.value="";}
			  }
			function savetcprojecthp(val){
				$(".addyourproject").showLoading(); 
				var datas = "[";
				$("#InPrlistA .PrHiDataList form").each(function (index, domEle){
					var data = formToJsonData($(domEle),index+1);
					datas += JSON.stringify(saveData(0,data,index+1))+",";
				});
				$("#InPrlistB .PrHiDataList form").each(function (index, domEle){
					var data = formToJsonData($(domEle),index+1);
					datas += JSON.stringify(saveData(1,data,index+1))+",";
				});
				if (datas.lastIndexOf(",")){  
					datas = datas.substring(0,datas.length -1);  
	                datas += "]";
	            } 
				var total = $('#totalPercents').val();
				 if(total>100){
            		 art.dialog('股东股份总大小不可以超过100。').lock().time(2);
            		 $('#totalPercents').val(0)
            		 $(".addyourproject").hideLoading(); 
            		 return;
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
						   	if(this['name']=='ptmemberInfo'+(index1)){
						   		o['ptmemberInfo']=this['value'];
						   	}else{
						   		o[this['name']]=this['value'];
						   	}
					   }
				   });
				   return o ;
			}
			//创建编辑器
				function createEditor() {
					$( '.ckeditorDiv textarea' ).ckeditor();
				} 
			$(function(){
				window.parent.scrollTo(1200, 300);
				<c:if test="${empty has}">$(".InPrlistH3 input[type='radio']").parent().siblings().css("display","none");</c:if>
				<c:if test="${not empty has}">$(".InPrlistH3 input[type='radio']").parent().siblings().css("display","block");</c:if>
				createEditor();
				listIndex();
				var _tr='<tr><td><div><input type="text"  /></div></td><td><div><input type="text"  /></div></td><td><select><option value="1">是</option><option value="0">否</option></select></td><td><div><input type="text"  /></div></td><td><div><input type="text"  /></div></td><td><img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png"></td></tr>';
				var _tr2='<tr><td><div><input type="text"  /></div></td><td><div><input type="text"  /></div></td><td><select><option value="1">是</option><option value="0">否</option></select></td><td><div><input type="text" onblur="numRate(this)"  /></div></td><td><div><input type="text" onkeyup="num(this)"  /></div></td><td><div><input type="text"  /></div></td><td><img src="${ctx }/crowdfunding/Skin/Default/images/deleteIcont.png"></td></tr>';
				var _div='<div class="PrHiDataList"><form><h5>股东团队成员<span>1</span>简介：</h5><div class="ckeditorDiv"><textarea ></textarea> </form></div></div>';
				var _div2='<div class="PrHiDataList"><form><h5>▌非股东团队成员<span>1</span>简介：</h5><div class="ckeditorDiv"><textarea ></textarea> </form> </div></div>';
				// $("#InPrlistparent .InPrlistH3 a").eq(0).css("display","none");//去除第一阶段删除按钮
				$(".InPrlistTrB a").click(function(){
					var _index=$(this).parent().parent().index();
					$(this).parent().parent().parent().find("tr").eq(_index-1).after(_tr);
					$(".InPrlist").eq(1).append(_div2);
					createEditor();
					var interval = setTimeout(window.parent.iFrameHeight, "1000");
					listIndex();
				});
				$(".InPrlistTrA a").click(function(){
					var _index=$(this).parent().parent().index();
					$(this).parent().parent().parent().find("tr").eq(_index-1).after(_tr2);
					$(".InPrlist").eq(0).append(_div);
					var interval = setTimeout(window.parent.iFrameHeight, "1000");
					createEditor();
					listIndex();
				});
				$(".InPrlistTable").on('click','img',function(){
					var _index=$(this).parent().parent().index();
					$(this).parent().parent().parent().parent().parent().parent().find('.PrHiDataList').eq(_index-1).remove();
					$(this).parent().parent().remove();
					listIndex();
				});
				$(".InPrlistH3").on('click','input[type="radio"]',function(){
					if($(this).val()==0){
						var interval = setTimeout(window.parent.iFrameHeight, "1000");
						$(this).parent().siblings().css("display","block");
					}else{
						$(this).parent().siblings().css("display","none");
					}
				});
			});
			function listIndex(){
				$("#InPrlistA .PrHiDataList").each(function(index,e){
					$(this).find('h5').find("span").html(index+1);
					$(this).find('textarea').attr("name","ptmemberInfo"+(index+1));
				});
				$("#InPrlistB .PrHiDataList").each(function(index,e){
					$(this).find('h5').find("span").html(index+1);
					$(this).find('textarea').attr("name","ptmemberInfo"+(index+1));
				});
			}
			
			function saveData(type,data,indexNum){
	             var ptname = "";   
	             var ptduty = "";  
	             var ptmisFullTime = "";  
	             var pttheShare = "";   
	             var ptrealPay = ""; 
	             var ptrelationship = ""; 
	             var ptentryTime="";
	             var teamId = "";  
	             if(type==0){
	            	 var totalPercents = 0;
	            	 $(".tableouts tr").each(function (index, domEle){// 非股东成员tr  
		                 if(index == indexNum){//遍历除去第一行的之外的所有input作为json数据传入后台  
		                     $(domEle).find("input").each(function(index,data){  
		                         if(index == 0){  
		                        	 ptname = $(data).val();  
		                         }else if(index == 1){  
		                        	 ptduty = $(data).val();  
		                         }else if(index == 2){  
		                        	 pttheShare = $(data).val();  
		                        	 totalPercents = totalPercents+parseFloat(pttheShare);
		                         }else if(index == 3){  
		                        	 ptrealPay = $(data).val();  
		                         }else if(index == 4){  
		                        	 ptrelationship = $(data).val();  
		                         }else{  
		                        	 teamId = $(data).val(); 
		                         }  
		                     }); 
		                     $(domEle).find("select").each(function(index,data){  
		                         if(index == 0){  
		                        	 ptmisFullTime = $(data).val();   
		                         } 
		                     }); 
		                 	
		                 	if(teamId!=""){
		                 		data['pttypeId']= 1;
		                 		data['ptname']= ptname;
		                 		data['ptduty']= ptduty;
		                 		data['ptmisFullTime']= ptmisFullTime;
		                 		data['pttheShare']= pttheShare;
		                 		data['ptrealPay']= ptrealPay;
		                 		data['ptrelationship']= ptrelationship;
		                 		data['ptentryTime']= ptentryTime;
		                 		data['teamId']= teamId;
		                 	}else if(pttheShare!=""&&ptrealPay!=""&&ptname!=""){
		                 		data['pttypeId']= 1;
		                 		data['ptname']= ptname;
		                 		data['ptduty']= ptduty;
		                 		data['ptmisFullTime']= ptmisFullTime;
		                 		data['pttheShare']= pttheShare;
		                 		data['ptrealPay']= ptrealPay;
		                 		data['ptrelationship']= ptrelationship;
		                 		data['ptentryTime']= ptentryTime;
		                 		data['teamId']= 0;
		                 	}else{
				            	 data['teamId']= "";
				              }
		                 }  
		             });  
	            	 var s = 0;
	            	 if(!isNaN(parseFloat($("#totalPercents").val()))){
	            		 s = parseFloat($("#totalPercents").val());
	            	 }
	            	 if(!isNaN(totalPercents)){
	            		 $("#totalPercents").val(totalPercents+s);
	            	 }
	             }else{
	            	 $(".tableins tr").each(function (index, domEle){// 非股东成员tr  
	            		 //alert(index+"=="+indexNum);
		                 if(index == indexNum){//遍历除去第一行的之外的所有input作为json数据传入后台  
		                     $(domEle).find("input").each(function(index,data){  
		                    	 if(index == 0){  
		                        	 ptname = $(data).val();  
		                         }else if(index == 1){  
		                        	 ptduty = $(data).val();  
		                         }else if(index == 2){  
		                        	 ptentryTime = $(data).val();  
		                         }else if(index == 3){  
		                        	 ptrelationship = $(data).val();  
		                         }else{  
		                        	 teamId = $(data).val(); 
		                         }  
		                     }); 
		                     $(domEle).find("select").each(function(index,data){  
		                         if(index == 0){  
		                        	 ptmisFullTime = $(data).val();   
		                         } 
		                     }); 
			                 if(teamId!=""){
			                	 data['pttypeId']= 0;
				                 data['ptname']= ptname;
				                 data['ptduty']= ptduty;
				                 data['ptmisFullTime']= ptmisFullTime;
				                 data['pttheShare']= 0;
				                 data['ptrealPay']= 0;
				                 data['ptrelationship']= ptrelationship;
				                 data['ptentryTime']= ptentryTime;
			                 	 data['teamId']= teamId;
			                 }else if(ptduty!=""&&ptname!=""){
				                 data['pttypeId']= 0;
				                 data['ptname']= ptname;
				                 data['ptduty']= ptduty;
				                 data['ptmisFullTime']= ptmisFullTime;
				                 data['pttheShare']= 0;
				                 data['ptrealPay']= 0;
				                 data['ptrelationship']= ptrelationship;
				                 data['ptentryTime']= ptentryTime;
				                 data['teamId']= 0;
				              }else{
				            	 data['teamId']= "";
				              }
		                 }  
		             });  
	             }
	             return data;
	        }
			
		</script>
</body>
</html>