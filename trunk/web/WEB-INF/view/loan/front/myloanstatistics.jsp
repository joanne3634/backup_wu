<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
</head>
<body>
        <div class="tit-box element-box bd-color-main bg-color-s"><span class="tit-xxl color-main">贷款统计</span></div>
        <div class="con-box con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main">
        <table>
          <tr>
            <th colspan="2">您在P2P贷总计借款<span class="color-main">${projects.ploanReal}</span>元，总计需支付<span>${projects.psumLate+projects.psumFee+projects.pprepay+projects.psumInterest}</span>元的利息和费用</th>
          </tr>
          <tr>
            <td>借款利息：<span class="color-main">${projects.psumInterest}</span>元</td>
            <td>逾期费用：<span class="color-main">${projects.psumLate}</span>元</td>
          </tr>
          <tr>
            <td>提前还款违约金：<span class="color-main">${projects.pprepay}</span>元</td>
            <td>借款管理费：<span class="color-main">${projects.psumFee}</span>元</td>
          </tr>
          <tr>
            <td colspan="2">总计：<span class="color-main">${projects.psumLate+projects.psumFee+projects.pprepay+projects.psumInterest}</span>元</td>
          </tr>
        </table>
        <table>
          <tr>
            <th colspan="2">您在P2P贷的借贷待还总额为<span class="color-main">${projects.psumLate+projects.psumPayBack-projects.psumHavedPay}</span>元</th>
          </tr>
          <tr>
            <td>待还本金：<span class="color-main">${projects.psumPayBack-projects.psumInterest-projects.psumHavedPayPrincipal}</span>元</td>
            <td>待还利息：<span class="color-main">${projects.psumInterest-projects.psumHavedPayInterest}</span>元</td>
          </tr>
          <tr>
            <td>待还逾期费用：<span class="color-main">${projects.psumLate-projects.psumLateHavedPay}</span>元</td>
            <td>待还借款管理费：<span class="color-main">${projects.psumFee-projects.pfee}</span>元</td>
          </tr>
          <tr>
            <td colspan="2">总计：<span class="color-main">${projects.psumLate+projects.psumPayBack-projects.psumHavedPay}</span>元</td>
          </tr>
        </table>
        <table>
          <tr>
            <th colspan="2">您在P2P贷的借贷已还总额为<span class="color-main">${projects.psumHavedPay+projects.pprepay+projects.psumLateHavedPay}</span>元</th>
          </tr>
          <tr>
            <td>已还本金：<span class="color-main">${projects.psumHavedPayPrincipal}</span>元</td>
            <td>已还利息：<span class="color-main">${projects.psumHavedPayInterest}</span>元</td>
          </tr>
          <tr>
            <td>已交逾期费用：<span class="color-main">${projects.psumLateHavedPay}</span>元</td>
            <td>已交提前还款违约金：<span class="color-main">${projects.pprepay}</span>元</td>
          </tr>
          <tr>
            <td colspan="2">已交借款管理费用：<span class="color-main">${projects.pfee}</span>元</td>
          </tr>
          <tr>
            <td colspan="2">总计：<span class="color-main">${projects.psumHavedPay+projects.pfee+projects.pprepay+projects.psumLateHavedPay}</span>元</td>
          </tr>
        </table>
        </div>
</body>
</html>