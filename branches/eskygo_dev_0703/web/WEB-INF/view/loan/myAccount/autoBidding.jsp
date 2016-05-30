<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8" %>
<%@taglib prefix="f" uri="http://www.deelon.com/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>自动投标</title> 
		<f:link href="Aqua/css/ligerui-all.css"></f:link>
	<f:link href="jquery/plugins/rowOps.css"></f:link>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
   <script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/jquery.js"></script>
	 <script type="text/javascript" src="${ctx}/js/dynamic.jsp"></script>
<script type="text/javascript" src="${ctx}/js/util/json2.js"></script>
<script type="text/javascript" src="${ctx}/js/util/util.js"></script>
<script type="text/javascript" src="${ctx}/js/util/dialog.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/ligerui.min.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerComboBox.js"></script>
<script type="text/javascript" src="${ctx}/js/lg/plugins/htDicCombo.js"></script>  
<script type="text/javascript" src="${ctx}/js/lg/plugins/ligerResizable.js" ></script> 
<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.htselect.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery/plugins/jquery.rowOps.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/displaytag.js" ></script>
<script type="text/javascript" src="${ctx}/js/deelon/foldBox.js" ></script>
<script type="text/javascript" src="${ctx}/js/calendar/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/deelon/absoulteInTop.js" ></script>
<script type="text/javascript" src="${ctx}/js/tree/jquery.ztree.js"></script>

   <script type="text/javascript">
   
   $(function(){
	   $("input[class^='text-input']").keydown(function () {  
		    var e = $(this).event || window.event;  
		    var code = parseInt(e.keyCode);  
		    if (code >= 96 && code <=105 || code >=48 && code <=57 || code ==100 || code ==110|| code ==190) {  
		        return true;  
		    } else {  
		        return false;  
		    }  
		});
   });
   
   
   function tabShowCon(showid){
		
		  $("#con-box1,#con-box2").hide();
		  if(showid=='con-box2'){
		
			 var eachTable="<table width=\"730\" border=\"0\" align=\"center\" cellpadding=\"3\" cellspacing=\"1\" class=\"tableList\">";
			  
			 eachTable+="<tr >";
			 eachTable+="<th bgcolor=\"#FFFFFF\" style=\"width:35%\">标题</th>";
			 eachTable+="<th bgcolor=\"#FFFFFF\" style=\"width:15%\">年利率</th>";
			 eachTable+="<th bgcolor=\"#FFFFFF\" style=\"width:20%\">有效金额</th>";
			 eachTable+="<th bgcolor=\"#FFFFFF\" style=\"width:15%\">状态</th>";
			 eachTable+="<th bgcolor=\"#FFFFFF\" style=\"width:15%\">投标时间</th>";
			 eachTable+="</tr>";
			
			  $.ajax({
				    type:"get",
				    async:false,
				    url:'${ctx }/loan/myAccount/getBiddingHistory.ht',
				    success:function(data){
				    	 if (data) {
								for(var i=0,c;c=data[i++];){
				    				 eachTable+="<tr>";
				    				 eachTable+="<td bgcolor=\"#FFFFFF\">"+c.pname+"</td>";
				    				 eachTable+=" <td bgcolor=\"#FFFFFF\">"+c.prateOut+"%</td>";
				    				 eachTable+=" <td bgcolor=\"#FFFFFF\">"+c.piEffectAmount+"</td>";
				    				 eachTable+="  <td bgcolor=\"#FFFFFF\">"+c.piHavedPayStr+"</td>";
				    				 eachTable+="  <td bgcolor=\"#FFFFFF\">"+c.piBidTimeStr+"</td>";
				    				 eachTable+=" </tr>";
				    				 
							 }
				    	 }
					}
				}); 
			  eachTable+="</table>";
			  
			 
			  document.getElementById("tableGrid").innerHTML =eachTable;
		  }
		  $("#"+showid).show();
	  }
 
   
	   //1.投标金额
	   //点击选中按钮 则 给按钮赋值，按钮对应的文本框激活,
	   //按钮失去焦点,则按钮值付空值,对应文本框值清空,并不可用.
	   //当先点击文本框时,对应的按钮选中
	   //   当文本失去焦点时,判断 文本是否为空,提示文本必填
	   
	   function transactionEevent1(){
		   var amountType_1=$("#amountType_1").attr("checked");
		   if(amountType_1){
			   
			   document.getElementById("amountType_2").checked=false;
			   document.getElementById("amountType_3").checked=false;
			   
			   document.getElementById("amountType_1").value='1';
			   document.getElementById("amountType_2").value='';
			   document.getElementById("amountType_3").value='';
			   
			  
			   $("#amountTypeValue_id_2").val("");
		   }
	   }
	   function transactionEevent2(){
		   var amountType_2=$("#amountType_2").attr("checked");
		   if(amountType_2){

			   document.getElementById("amountType_1").checked=false;
			   document.getElementById("amountType_3").checked=false;
			   
			   document.getElementById("amountType_1").value='';
			   document.getElementById("amountType_2").value='2';
			   document.getElementById("amountType_3").value='';
			   
			  
			   
			   $("#amountTypeValue_id_1").val("");
		   }
	   }
	   function transactionEevent3(){
		   var amountType_3=$("#amountType_3").attr("checked");
		   if(amountType_3){
			   document.getElementById("amountType_1").checked=false;
			   document.getElementById("amountType_2").checked=false;
			   
			   document.getElementById("amountType_1").value='';
			   document.getElementById("amountType_2").value='';
			   document.getElementById("amountType_3").value='3';
			   
			   
			   
			   $("#amountTypeValue_id_1").val("");
			   $("#amountTypeValue_id_2").val("");
		   }
	   }
   //如果先选择文本
   		
		
   
   
	   
	   //2.关于借款 
	   //a.按钮选中后 则给按钮赋值,如果是下拉框的  则下列框 激活(初始应不可用),
	   //按钮选中后 则给按钮赋值,
	   //当按钮失去焦点时,则应把按钮对应的值付空,另外对应的文本框值 清空.
	   //当先点击文本框时,对应的按钮选中
	//   当文本失去焦点时,判断 文本是否为空,提示文本必填
	   //3.其他
	   //同 2.
   
  	 function textClick1(){
  	//	if($("#amountTypeValue_id_1").val()){
  			document.getElementById("amountType_1").checked=true;
  	   		 document.getElementById("amountType_1").value='1';
  	   		 
  	   		 document.getElementById("amountType_2").checked=false;
  			 document.getElementById("amountType_2").value='';
  			 $("#amountTypeValue_id_2").val("");
  			 
  			 document.getElementById("amountType_3").checked=false;
  			 document.getElementById("amountType_3").value='';
  			 
  			var amountTypeValue_id_1=$("#amountTypeValue_id_1").val();
			var lessThan_id=$("#lessThan_id").val();
			if(lessThan_id!=''){
				if(eval(amountTypeValue_id_1)>eval(lessThan_id)){
					alert("固定金额大于单日投标金额限制!");
					return;
				}
			}
  	//	}
   		 
   		}
		function textClick2(){
			 document.getElementById("amountType_2").checked=true;
			 document.getElementById("amountType_2").value='2';
			 
			 document.getElementById("amountType_1").checked=false;
			 document.getElementById("amountType_1").value='';
			 $("#amountTypeValue_id_1").val("");
			 
			 document.getElementById("amountType_3").checked=false;
			 document.getElementById("amountType_3").value='';
		}
		
		
		//3.关于借款
		/*
		*1.当点击按钮时,给按钮赋值,按钮失去焦点时,将按钮值清空,同时对应的文本值 也清空
		2.当点击文本框时,对应的按钮 应选中,同时按钮赋值
		3.当文本失去焦点时,判断 文本是否为空,提示文本必填
		*/
		
		function checkBtn1(){
			var isRepayWay_id=$("#isRepayWay_id").attr("checked");
		
			if(isRepayWay_id){
				$("#isRepayWay_id").val("1");	
			}else{
				$("#isRepayWay_id").val("");	
				$("#repayWay_id").val("1");
			}
			
		}
		
		function checkBtn2(){
			
			var isDeadline_id=$("#isDeadline_id").attr("checked");
		
			if(isDeadline_id){
				$("#isDeadline_id").val("1");
			}else{
				$("#isDeadline_id").val("");
				$("#deadline_id").val("");
			}
			
		}
		
		function checkBtn3(){
			
			var isRateOut_id=$("#isRateOut_id").attr("checked");
			
			if(isRateOut_id){
				$("#isRateOut_id").val("1");
			}else{
				$("#isRateOut_id").val("");
				$("#rateOut_id").val("");
				
			}
		}
		
		function checkBtn4(){
			var isLessThan_id=$("#isLessThan_id").attr("checked");
			if(isLessThan_id){
				$("#isLessThan_id").val("1");
			}else{
				$("#isLessThan_id").val("");
				$("#lessThan_id").val("");
				
			}
		}
		function checkBtn5(){
			var isAutoDate_id=$("#isAutoDate_id").attr("checked");
			if(isAutoDate_id){
				$("#isAutoDate_id").val("1");
			}else{
				$("#isAutoDate_id").val("");
				$("#beginDate").val("");
				$("#endDate").val("");
				
			}
		}
		 
		function textEventTra1(){
			$("#isRepayWay_id").attr("checked",true);
		//	document.getElementById("isRepayWay_id").checked=true;
			$("#isRepayWay_id").val("1");
		}
		
		function textEventTra2(){
			$("#isDeadline_id").attr("checked",true);
			//	document.getElementById("isRepayWay_id").checked=true;
				$("#isDeadline_id").val("1");
		}
		function textEventTra3(){
			$("#isRateOut_id").attr("checked",true);
			//	document.getElementById("isRepayWay_id").checked=true;
				$("#isRateOut_id").val("1");
		}
		function textEventTra4(){
			$("#isLessThan_id").attr("checked",true);
			//	document.getElementById("isRepayWay_id").checked=true;
				$("#isLessThan_id").val("1");
				
				var amountTypeValue_id_1=$("#amountTypeValue_id_1").val();
				var lessThan_id=$("#lessThan_id").val();
				if(amountTypeValue_id_1!=''){
					if(eval(lessThan_id)<eval(amountTypeValue_id_1)){
						alert("固定金额大于单日投标金额限制!");
						return;
					}
				}
		}
		function textEventTra5(){
			$("#isAutoDate_id").attr("checked",true);
			//	document.getElementById("isRepayWay_id").checked=true;
				$("#isAutoDate_id").val("1");
				var beginDate=$("#beginDate").val();
				var endDate=$("#endDate").val();
				if(beginDate==''&&endDate==''){
					$("#isAutoDate_id").attr("checked",false);
					$("#isAutoDate_id").val("");
				}
		}
		function textEventTra6(){
			$("#isAutoDate_id").attr("checked",true);
			//	document.getElementById("isRepayWay_id").checked=true;
				$("#isAutoDate_id").val("1");
				
				var beginDate=$("#beginDate").val();
				var endDate=$("#endDate").val();
				if(beginDate==''&&endDate==''){
					$("#isAutoDate_id").attr("checked",false);
					$("#isAutoDate_id").val("");
				}
		}
		
		
   	
   </script>
   
</head>
<body>
        <div class="tit-box element-box bg-color-s bd-color-main"><span class="tit-xxl color-main">自动投标</span></div>
        <div class="con-box con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main">
        <!--切换按钮-->
        <div style="clear:both;height: 0px;"></div>
        <div class="con-box-btn">
        <div class="con-box-btn1" onClick="tabShowCon('con-box1');"></div>
        <div class="con-box-btn2" onClick="tabShowCon('con-box2');"></div>
        </div>
        <div style="clear:both;height: 0px;"></div>
        
        <div class="con-box1" id="con-box1">
        
        <!---------------投标金额------------------>
        <form id="autoBidForm_id" action="${ctx }/loan/myAccount/saveToUserSetAuto.ht" method="post">
        <input type="hidden" name="setAutoId" value="${TuserSetauto.setAutoId }"/>
        	<div class="con-box-title">投标金额</div>
          <div class="con-box-sub con-table-right">自动投标的最大金额不能超过借款金额的20%<br>
     
            <input type="radio" onclick="transactionEevent1();" <c:if test="${not empty TuserSetauto.amountType_1 }">checked  </c:if> name="amountType_1" id="amountType_1" value="${TuserSetauto.amountType_1 }" >
            按固定金额数值元
            <input class="text-input" type="text"  onchange="textClick1();" name="amountTypeValue_1" id="amountTypeValue_id_1" class="con-box-sub-input" value="${TuserSetauto.amountTypeValue_1 }" style="width:106px">(最少100元)<br>
             <input type="radio" onclick="transactionEevent2();" <c:if test="${TuserSetauto.amountType_2 eq 2 }">checked </c:if> name="amountType_2" id="amountType_2" value="${TuserSetauto.amountType_2 }">
            按借款金额比例 %
            <input  class="text-input" type="text"  onchange="textClick2();" name="amountTypeValue" id="amountTypeValue_id_2" value="${TuserSetauto.amountTypeValue_2 }" class="con-box-sub-input" style="width:106px">(1%~20%)<br>
             <input type="radio" onclick="transactionEevent3();" <c:if test="${not empty TuserSetauto.amountType_3 }">checked  </c:if> name="amountType_3" id="amountType_3" value="${TuserSetauto.amountType_3 }">
            可用余额全部投标
          </div>
          <!---------------关于借款------------------>
            <div class="con-box-title">关于借款</div>
         <div class="con-box-sub con-table-right">
         <div class="con-box-items">
         <div style="float:left;line-height:32px">
             <input type="checkbox" onclick="checkBtn1();" <c:if test="${not empty TuserSetauto.isRepayWay }">checked  </c:if> name="isRepayWay" id="isRepayWay_id" value="${TuserSetauto.isRepayWay }">
            还款方式必须为</div>
            <dd class="select-box" style="line-height:32px;">
<!--             <select name="repayWay" onchange="textEventTra1();"  id="repayWay_id" > -->
<%--             <option value="1" <c:if test="${TuserSetauto.repayWay eq 1}">selected="selected" </c:if>>一次性还本付息</option> --%>
<%--             <option value="2" <c:if test="${TuserSetauto.repayWay eq 2}">selected="selected" </c:if>>先息后本</option> --%>
<%--             <option value="3" <c:if test="${TuserSetauto.repayWay eq 3}">selected="selected" </c:if>>等额本息,每月还款</option> --%>
<%--             <option value="4" <c:if test="${TuserSetauto.repayWay eq 4}">selected="selected" </c:if>>等额本金,每月还款</option> --%>
<!--             </select> -->
            <f:select onChange="textEventTra1();" nodeKey="hkfs" id="audit" name="audit"/>
            </dd>
            </div>
             <input type="checkbox" onclick="checkBtn2();" <c:if test="${not empty TuserSetauto.isDeadline }">checked  </c:if> name="isDeadline" id="isDeadline_id" value="${TuserSetauto.isDeadline }">
            借款期限不大于<input class="text-input" type="text" onchange="textEventTra2();" name="deadline" id="deadline_id" style="width:53px" value="${TuserSetauto.deadline }">月&nbsp;&nbsp;&nbsp;&nbsp;(大于0)<br>
             <input type="checkbox" onclick="checkBtn3();" <c:if test="${not empty TuserSetauto.isRateOut }">checked  </c:if> name="isRateOut" id="isRateOut_id" value="${TuserSetauto.isRateOut }">
            借款利率不小于<input class="text-input" type="text" onchange="textEventTra3();" name="rateOut" id="rateOut_id" style="width:53px" value="${TuserSetauto.rateOut }">%&nbsp;&nbsp;&nbsp;&nbsp;(0.1%~24.00%)
            </div>
            
            <!---------------------借款类型--------------->
            <div class="con-box-title">借款类型</div>
             <div class="con-box-sub">
            <div class="con-box-items con-table-right">
            <dd class="select-box" style="line-height:32px;">
<!--             <select name="productsLoanId" id="productsLoanId_id" > -->
<!--             <option value="1">普通借款标</option> -->
<!--             </select> -->
            <f:select nodeKey="JKLX" id="audit" name="audit"/>
            </dd>
            </div>
            </div>
            <!---------------------其它--------------->
            <div class="con-box-title">其它</div>
            <div class="con-box-sub con-table-right">
            	 <input class="input-text" type="checkbox" onclick="checkBtn4();" <c:if test="${not empty TuserSetauto.isLessThan }">checked  </c:if> name="isLessThan" id="isLessThan_id" value="${TuserSetauto.isLessThan }">
            单日自动投标金额不能大于<input class="text-input" type="text" onchange="textEventTra4();" name="lessThan" id="lessThan_id" class="con-box-sub-input" style="width:114px" value="${TuserSetauto.lessThan }">(不能小于50)<br>
             <input type="checkbox"  onclick="checkBtn5();" <c:if test="${not empty TuserSetauto.isAutoDate }">checked  </c:if> name="isAutoDate" id="isAutoDate_id" value="${TuserSetauto.isAutoDate }">
            自动投标仅在该时间段进行<br><input type="text"  onchange="textEventTra5();" id="beginDate" name="beginDate"  class="inputText Wdate text-input" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'beginDate\');}'})" value="${TuserSetauto.beginDate }"/>
             至<input type="text" id="endDate" onchange="textEventTra6();" name="endDate"  class="inputText Wdate text-input" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'endDate\');}'})"  value="${TuserSetauto.endDate }"/>
            </div>

    
            <!----保存---->
			<div style="margin-top:30px;padding-bottom:30px;text-align:center;">
              <input type="submit" name="BtnSave" onclick="document.getElementById('autoBidForm_id').submit();" class="SetAuto_btnSave" id="BtnSave" value="保存设置">
            </div>
           </form>

               
                ${htmlStr }
                 
			
        </div>
        
        
        <div class="con-box2" id="con-box2">
       <%--  <c:if test="${not empty eachTable }">
        	${eachTable }
        </c:if> --%>
        <div id="tableGrid"></div>
      
       
  		<%-- <deelon:paging tableId="investId"></deelon:paging> --%>
	
        </div>
        
        
        <div class="con-box-list-bottom"></div>
        </div>
        </body>
        </html>
     