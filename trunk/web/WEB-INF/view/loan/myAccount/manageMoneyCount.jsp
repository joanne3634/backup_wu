<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="/commons/includeFront/javascripts.jsp"%>
</head>
<body>
        <div class="tit-box element-box bd-color-main bg-color-s"><span class="tit-xxl color-main">理财统计</span></div>
        <div class="con-box con-box-wodejiekuan bd-b-color-main bd-l-color-main bd-r-color-main">
          <table>
            <tr>
              <th>资金</th>
            </tr>
            <tr>
              <td>总计：<span class="color-main">${TProjectInvest.sm_Balance }</span>元</td>
            </tr>
          </table>
          <table>
            <tr>
              <th colspan="3">回报统计</th>
            </tr>
            <tr>
              <td>已赚利息</td>
              <td>奖励收入总额</td>
              <td>已赚逾期罚息</td>
            </tr>
            <tr>
              <td><span class="color-main">
              <c:if test="${ empty TProjectInvest.sm_t_PA_Interest }">0</c:if>
              <c:if test="${ not empty TProjectInvest.sm_t_PA_Interest }"> ${TProjectInvest.sm_t_PA_Interest }</c:if>
             
              </span>元</td>
              <td><span class="color-main">0</span>元</td>
              <td><span class="color-main">
               <c:if test="${ empty TProjectInvest.sm_t_PA_Late }">0</c:if>
              <c:if test="${ not empty TProjectInvest.sm_t_PA_Late }"> ${TProjectInvest.sm_t_PA_Late }</c:if>
              </span>元</td>
            </tr>
          </table>
          <table>
            <tr>
              <th colspan="6">个人理财统计</th>
            </tr>
            <tr>
              <td>总借出金额</td>
              <td>总借出笔数</td>
              <td>已回收本息</td>
              <td>已回收笔数</td>
              <td>待回收本息</td>
              <td>待回收笔数</td>
            </tr>
            <tr>
              <td><span class="color-main">
               <c:if test="${ empty TProjectInvest.sm_PI_EffectAmount }">0</c:if>
              <c:if test="${ not empty TProjectInvest.sm_PI_EffectAmount }"> ${TProjectInvest.sm_PI_EffectAmount }</c:if>
              </span>元</td>
              <td><span class="color-main">
              
               <c:if test="${ empty TProjectInvest.sm_totOutnum }">0</c:if>
              <c:if test="${ not empty TProjectInvest.sm_totOutnum }"> ${TProjectInvest.sm_totOutnum }</c:if>
              </span></td>
              <td><span class="color-main">
               <c:if test="${ empty TProjectInvest.sm_benxi }">0</c:if>
              <c:if test="${ not empty TProjectInvest.sm_benxi }"> ${TProjectInvest.sm_benxi }</c:if>
              </span>元</td>
              <td> <span class="color-main">
              	 <c:if test="${ empty TProjectInvest.sm_totIn }">0</c:if>
             ${TProjectInvest.sm_totIn }</span>
              </td>
              <td><span class="color-main">
               <c:if test="${ empty TProjectInvest.sm_daihuanbenxi }">0</c:if>
              <c:if test="${ not empty TProjectInvest.sm_daihuanbenxi }"> ${TProjectInvest.sm_daihuanbenxi }</c:if>
              </span>元</td>
              <td><span class="color-main">
                <c:if test="${ empty TProjectInvest.sm_totIn_ing }">0</c:if>
              <c:if test="${ not empty TProjectInvest.sm_totIn_ing }"> ${TProjectInvest.sm_totIn_ing }</c:if>
              </span></td>
            </tr>
          </table>
          <table class="xiangmu-tab">
            <tr>
              <th>项目</th>
            </tr>
            <tr>
              <td>申请中：<span class="color-main">${TProjectInvest.sm_applying }</span></td>
            </tr>
            <tr>
              <td>持有中：<span class="color-main">
               <c:if test="${ empty TProjectInvest.sm_totIn_ing }">0&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
              <c:if test="${ not empty TProjectInvest.sm_totIn_ing }"> ${TProjectInvest.sm_totIn_ing }&nbsp;&nbsp;&nbsp;&nbsp;</c:if>
               </span>其中<span style="padding-right:20px;"></span>
               	逾期：<span class="color-main">${TProjectInvest.sm_expect }&nbsp;&nbsp;&nbsp;&nbsp;
               </span>代偿：<span class="color-main">${TProjectInvest.sm_daichang }&nbsp;&nbsp;&nbsp;&nbsp;
               </span>正常还款：<span class="color-main">${TProjectInvest.sm_Natural_repayMent }</span></td>
            </tr>
            <tr>
              <td>已结束：<span class="color-main">${TProjectInvest.sm_compleate_repayMent }&nbsp;&nbsp;&nbsp;&nbsp;</span>
              	其中<span style="padding-right:20px;"></span>
              	已代偿：<span class="color-main">${TProjectInvest.sm_yidaichang }&nbsp;&nbsp;&nbsp;&nbsp;</span>
              	正常还款：<span class="color-main">${TProjectInvest.sm_zhengchangPayment }&nbsp;&nbsp;&nbsp;&nbsp;</span>
              	提前还款：<span class="color-main">${TProjectInvest.sm_tiqianPayMent }&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
            </tr>
          </table>
        </div>
        </body>
        </html>