<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>项目认投付款确认</title>
	<%@ include file="/crowdfunding/cssorjs.jsp"%>
		<link rel="stylesheet" href="${ctx }/styles/default/css/layout.css">
	<meta name="renderer" content="webkit"/>
	<script type="text/javascript">
	window.onload=function(){document.rongpaysubmit.submit();}
</script>
<style type="text/css"> 

.fong1{
	font-size:14px; color:#3393c9; font-weight: bold; line-height:35px; margin:0px; padding:0px;
}
.fong2{
	font-size:12px; color:#666;  line-height:15px; margin:0px; padding:0px;
}
.sj_inpt{
	border:solid 1px #d2d2d2; width:130px; line-height:18px; height:18px; float:left;
}
</style>

</head>

<body>
		<form id="rongpaysubmit" name="rongpaysubmit" action="https://epay.reapal.com/portal?charset=utf-8" method="get" >
		
            
                  <table align="center" class="" style="width: 700px;">
                  
                    <tr>
                      <td colspan="3">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="bank" style="">
                        
                        	${sHtmlText }
                         
                        </table> 
                      </td>
                      
                    </tr>
                </table>       
          
	</form>
</body>
<script type="text/javascript">
function setvalueFun(n){
	var defaultbank=$("#defaultbank"+n).val();
	$("#defaultbank").val(defaultbank);
	
	doUrlFun();
}

function doUrlFun(){
	var projectId=$("#projectId").val();
	var investId=$("#investId").val();
	var defaultbank=$("#defaultbank").val();
	
	var url="";
	if(projectId==''&&investId==''){//认筹诚意金
		var pinvestAmount=$("#pinvestAmount").val();
		url="${ctx }/crowdfunding/front/tcprojectinvest/toPayment2.ht?defaultbank="+defaultbank+"&pinvestAmount="+pinvestAmount;
		window.parent.parent.target="_blank";
		window.parent.parent.open(url);
	//	window.parent.location = "${ctx }/loan/myAccount/myaccountPage.ht?forwordUrl=investRecord";
		$.dialog.close();
	}else{
		
		url="${ctx }/crowdfunding/front/tcprojectinvest/toPayment.ht?projectId="+projectId+"&investId="+investId+"&defaultbank="+defaultbank;
		window.parent.parent.target="_blank";
		
		window.parent.parent.open(url);
		 window.parent.location = "${ctx }/loan/myAccount/myaccountPage.ht?forwordUrl=ProManger";
		 $.dialog.close();
	}
}

function on_hide()
{
	if(document.getElementById("yesorno").checked == true)
	{
	//	document.getElementById("bank").style.display = "block";
	}
	else
	{
		
	//	document.getElementById("bank").style.display = "none";
		$("#defaultbank").val("");
		doUrlFun();
		
	}
}
</script>
</html>