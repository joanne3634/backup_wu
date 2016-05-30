<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>资费说明</title>
  <link rel="stylesheet" href="${ctx }/styles/p2p/Skin/Default/style.css">
  <%@ include file="/commons/includeFront/javascripts.jsp"%>
   <script type="text/javascript" src="${ctx}/js/p2p/applyLimit.js"></script>
  <title>帝隆 P2P ONE - 资费说明</title>
</head>

<body>
<%@ include file="/commons/includeFront/head.jsp"%>
 <div class="window text-gray">
    <h2 class="text-orange2">资费说明</h2>
    <div class="RatesList text-left">
        <h3 class="text-left">P2P贷网站的功能包括了借款信息的发布，竞标管理，成功借款管理，电子借条，法务支持等等，目前大多数服务保持免费。</h3>
        <div class="tagname text-white background7">常规收费</div>
        <div class="triangle"></div>
        <div class="knockdown">
        <div class="text-orange2" ><span>▍</span>成交服务费</div>
        <div class="knockdownleft">
            <div class="text-black2">借出者</div>
            <div>
            <img src="${ctx}/images/Ratesicont.png">
                <span>免费</span>
            </div>
        </div>
        <div class="knockdownright">
            <div class="text-black2">借入者</div>
            <div>
                <ul>
                    <li><span class="text-orange2">.</span>充值手续费：<%=application.getAttribute("RECHARGE_FEES") %>%</li>
                    <li><span class="text-orange2">.</span>提现手续费：<%=application.getAttribute("CASH_POUNDAGE") %>%</li>
                    <li><span class="text-orange2">.</span>申请贷款，扣除担保金的比例是<%=application.getAttribute("POUNDAGE_RATIO") %>%</li>
                    <li><span class="text-orange2">.</span>投资成功交易费：<%=application.getAttribute("INVESTMENT_SUCCESS_FEES") %>%</li>
                    <li><span class="text-orange2">.</span>借款成功交易费：<%=application.getAttribute("BORROWING_SUCCESS_FEES") %>%</li>
                    <li><span class="text-orange2">.</span>逾期还款，罚息比例：<%=application.getAttribute("PENALTY_INTEREST_RATE") %>%</li>
                </ul>
            </div>
        </div>
        <div class="clear"></div>
        </div>
        
        <div class="thirdly">
            <div class="thirdlyleft">
                <div class="text-orange2" ><span>▍</span>第三方平台充值服务费</div>
                 <ul>
                    <li><span class="text-orange2">.</span>即时到账：充值金额的1%</li>
                    <li><span class="text-orange2">.</span>非即时到账：充值金额超过1000（含），单笔10元</li>
                </ul>
            </div>
            <div class="thirdlyright">
                <div class="text-orange2" ><span>▍</span>第三方平台提现服务费</div>
                 <ul>
                    <li><span class="text-orange2">.</span>30,000元（不含）以下：1~3工作日到账3元/笔，工作日当天到账10元/笔</li>
                    <li><span class="text-orange2">.</span>30,000~49,999元：1~3工作日到账6元/笔，工作日当天到账20元/笔</li>
                   
                </ul>
            </div>
            <div class="clear"></div>
        </div>
        <div class="tagname text-white background7">逾期费用和补偿</div>
        <div class="triangle"></div>
        <p>1. 如果借入者逾期，借出者收回全额罚息、利息、本金后，帝隆 P2P网贷再按照逾期本金0.6%/日收取催收费用，由帝隆 P2P网贷奖励积极参与催收的借出者或者补贴催收成本。</p>
        <p>2. 如果借入者逾期超过60天，帝隆 P2P网贷把对该笔借款所收的成交服务费按比例如数补偿借出者。一旦借入者还款后，网站将从借出者收回这笔费用。 </p>
    </div>
  </div>
</body>
</html>