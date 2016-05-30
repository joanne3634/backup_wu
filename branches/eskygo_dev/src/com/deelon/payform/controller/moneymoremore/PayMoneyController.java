/*
 * Copyright (c) 2008 Asiainfo Technologies(China),Inc.
 *
 * FileName: PayController.java
 *
 * Description:
 *
 * Created: Allen 2014-12-17
 * 
 * |--------------------------------------------------History---------------------------------------------------|
 * |                                                                                                            |
 * |-----Author-----|-----Date-----|----Version----|----------------------------Desc----------------------------| 
 * || 
 * |------------------------------------------------------------------------------------------------------------|
 */
package com.deelon.payform.controller.moneymoremore;

import com.deelon.core.annotion.Action;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.ContextUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.core.util.UniqueIdUtil;
import com.deelon.core.web.controller.BaseController;
import com.deelon.crowdfunding.common.util.TUserUtil;
import com.deelon.crowdfunding.model.backstage.Tcproject;
import com.deelon.crowdfunding.model.backstage.TcprojectInvest;
import com.deelon.crowdfunding.service.backstage.TcprojectInvestService;
import com.deelon.crowdfunding.service.backstage.TcprojectService;
import com.deelon.loan.model.front.TMoneymove;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserFunds;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.sysManager.Tsmsinformation;
import com.deelon.loan.service.front.TUserService;
import com.deelon.loan.service.front.TmoneymoveService;
import com.deelon.loan.service.front.TuserSafeService;
import com.deelon.loan.service.sysManager.TsmsinformationService;
import com.deelon.loan.service.sysManager.TuserFundsService;
import com.deelon.payform.common.PayCommon;
import com.deelon.payform.common.moneymoremore.RongpayConfig;
import com.deelon.payform.common.moneymoremore.RongpayFunction;
import com.deelon.payform.util.moneymoremore.Common;
import com.deelon.platform.model.system.SysUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * PayController
 * <p>
 * <p>
 * </P>
 *
 * @author Administrator 2014-12-17
 * @version 0.0.1
 */
@Controller
@RequestMapping({"/payform/pay/"})
public class PayMoneyController extends BaseController {

    private static final  Logger LOGGER = LoggerFactory.getLogger(PayMoneyController.class);

    private static final String SUCCESS_RESPONSE="success";

    private static final String FAILED_RESPONSE="fail";

    private static final String REAPAL_SUCCESS="TRADE_FINISHED";

    private static final String REAPAL_FAIL="TRADE_FAILURE";

    private static final String REAPAL_WAITE="WAIT_BUYER_PAY";

    @Autowired
    private TmoneymoveService tmoneymoveService;
    /**
     * <P>
     *     响应荣宝支付公司后台通知.成功则返回success
     * </p>
     *
     * @return
     */
    @RequestMapping(value="notify",method = RequestMethod.POST)
    @ResponseBody
    public String backGroundPayNotify(HttpServletRequest request,HttpServletResponse response){
        String result=SUCCESS_RESPONSE;

        String key = RongpayConfig.key;
        String trade_status = request.getParameter("trade_status");//TRADE_FINISHED
        String order_no = request.getParameter("order_no");
        LOGGER.debug("payment return call:orderNo={},tradeStatus={}", new Object[]{order_no, trade_status});
        LOGGER.debug("--------------------------handle call back:begin--------------------------");

        try{
            request.setCharacterEncoding(RongpayConfig.charset);
            //获取融宝支付GET过来反馈信息
            Map params = RongpayFunction.transformRequestMap(request.getParameterMap());
            String body=(String)params.get("body");
            String title = (String)params.get("title");
            LOGGER.info("original body={}",body);
            LOGGER.info("original title={}",title);
//
//            body=new String(body.getBytes(RongpayConfig.charset), RongpayConfig.charset);
//            title=new String(title.getBytes(RongpayConfig.charset), RongpayConfig.charset);
//            LOGGER.info("body={}",body);
//            LOGGER.info("title={}",title);
//
//            params.put("body",body);
//            params.put("title",title);

            String mysign = RongpayFunction.BuildMysign(params, key);
            String responseTxt = RongpayFunction.Verify(request.getParameter("notify_id"));
            String sign = request.getParameter("sign");

            if (mysign.equals(sign) && responseTxt.equals("true")) {
                TMoneymove tmoneymove = tmoneymoveService
                        .getByIdFlowCode(order_no);

                if(REAPAL_SUCCESS.equals(trade_status)){
                    if ("3".equals(tmoneymove.getTypeId())) {

                        tmoneymove.setRemark("投资金额支付成功");
                        tmoneymove.setResultId("1");
                        tmoneymoveService.modifyInvestStatus(tmoneymove);

                    } else if ("12".equals(tmoneymove.getTypeId())) {
                        tmoneymove.setRemark("诚意金支付成功");
                        tmoneymove.setResultId("1");
                        tmoneymoveService.modifyQulifiedStatus(tmoneymove);
                    }
                }else{
                    LOGGER.warn("payment return call:payment failed.orderNo={},trade_statue={}",order_no,trade_status);
                    result=FAILED_RESPONSE;

                    if ("3".equals(tmoneymove.getTypeId())) {
                        tmoneymove.setRemark("投资金额支付失败");
                        tmoneymove.setResultId("2");
                        tmoneymoveService.update(tmoneymove);

                    } else if ("12".equals(tmoneymove.getTypeId())) {
                        tmoneymove.setRemark("诚意金支付失败");
                        tmoneymove.setResultId("2");
                        tmoneymoveService.update(tmoneymove);

                    }
                }
            }
            else {
                LOGGER.warn("payment return call:msg from rongPay is invalid");
                LOGGER.warn("mySign={},notifyId={},sign={},notifyId verify result={}", new Object[]{mysign, request.getParameter("notify_id"), sign,responseTxt});
                result=FAILED_RESPONSE;
            }
        }
        catch(Exception e){
            LOGGER.error("callback handling error",e);
            result=FAILED_RESPONSE;
        }
        LOGGER.info("--------------------------handle call back:end.result={}--------------------------",result);
        return result;
    }

    @RequestMapping({"returnUrl"})
    @Action(description = "支付返回后台通知网址")
    public ModelAndView returnUrl(HttpServletRequest request,
                                  HttpServletResponse response) {
        String retUrl = "/payform/moneymoremore/returnUrl.jsp";
        ModelAndView mv = new ModelAndView(retUrl);
        if ("1".equals(PayCommon.payformType)) {// 钱多多支付
            String MoneymoremoreId = request.getParameter("MoneymoremoreId");
            String ResultCode = request.getParameter("ResultCode");
            String Message = request.getParameter("Message");

            mv = new ModelAndView(retUrl).addObject("ResultCode", ResultCode)
                    .addObject("Message", Message).addObject("returnType", "1");
            if (StringUtil.isNotEmpty(MoneymoremoreId)) {
                TuserFundsService tuserFundsService = (TuserFundsService) AppUtil
                        .getBean("tuserFundsService");
                TUser tuser = TUserUtil.getLogUser(request);
                TUserFunds tuserFunds = tuserFundsService.getByUserId(tuser
                        .getUserId()); // 资金
                tuserFunds.setPayMark(MoneymoremoreId);
                tuserFundsService.update(tuserFunds);
                mv.addObject("tuserFunds", tuserFunds);

            }

        }
        return mv;
    }

    @RequestMapping({"return_url"})
    @Action(description = "支付成功通知页面")
    public ModelAndView return_url(HttpServletRequest request,
                                   HttpServletResponse response) {
        String retUrl = "/payform/moneymoremore/return_url.jsp";
        ModelAndView mv = new ModelAndView(retUrl);

        String key = RongpayConfig.key;
        String ResultCode = "0";
        String Message = "";
        try {
            request.setCharacterEncoding(RongpayConfig.charset);
            //获取融宝支付GET过来反馈信息
            Map params = RongpayFunction.transformRequestMap(request.getParameterMap());
            //判断responsetTxt是否为ture，生成的签名结果mysign与获得的签名结果sign是否一致
            //responsetTxt的结果不是true，与服务器设置问题、合作身份者ID、notify_id一分钟失效有关
            //mysign与sign不等，与安全校验码、请求时的参数格式（如：带自定义参数等）、编码格式有关
            String mysign = RongpayFunction.BuildMysign(params, key);

            String responseTxt = RongpayFunction.Verify(request.getParameter("notify_id"));

//            System.out.println(responseTxt + "******");
            String sign = request.getParameter("sign");
            String trade_status = request.getParameter("trade_status");//TRADE_FINISHED
            String order_no = request.getParameter("order_no");
            LOGGER.info("payment return call:orderNo={},tradeStatus={}, response={}",new Object[]{ order_no, trade_status,responseTxt});
            String verifyStatus = "";

            //建议校验responseTxt，判读该返回结果是否由融宝发出
            if (mysign.equals(sign) && responseTxt.equals("true")) {

                //支付成功，修改资金记录 为支付成功
//                TmoneymoveService tmoneymoveService = (TmoneymoveService) AppUtil
//                        .getBean("tmoneymoveService");
                TMoneymove tmoneymove = tmoneymoveService
                        .getByIdFlowCode(order_no);

                //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                if (trade_status.equals("TRADE_FINISHED")) {

                    if ("3".equals(tmoneymove.getTypeId())) {

                        tmoneymove.setRemark("投资金额支付成功");
                        tmoneymove.setResultId("1");
                        tmoneymoveService.modifyInvestStatus(tmoneymove);

                    } else if ("12".equals(tmoneymove.getTypeId())) {
                        tmoneymove.setRemark("诚意金支付成功");
                        tmoneymove.setResultId("1");
                        tmoneymoveService.modifyQulifiedStatus(tmoneymove);
                    }
                    ResultCode = "1";
                } else {
                    LOGGER.warn("payment call back: 支付失败,orderNo={}",order_no);
                    Message = "支付失败!";
                    //支付失败处理相关订单

                    if ("3".equals(tmoneymove.getTypeId())) {

                        tmoneymove.setRemark("投资金额支付失败");
                        tmoneymove.setResultId("2");
                        tmoneymoveService.update(tmoneymove);
                        ResultCode = "2";

                    } else if ("12".equals(tmoneymove.getTypeId())) {
                        tmoneymove.setRemark("诚意金支付失败");
                        tmoneymove.setResultId("2");
                        tmoneymoveService.update(tmoneymove);
                        ResultCode = "2";

                    }
                }
//                verifyStatus = "验证成功";
                //——请根据您的业务逻辑来编写程序、（以上代码仅作参考）——

            } else {
                logger.warn("payment call back:回调报文验证失败。mysign={},request sign={}",mysign,sign);
//                verifyStatus = "验证失败";
            }

        } catch (Exception e) {
            // TODO Auto-generated catch block
            logger.error("payment call back error:orderNo={}", request.getParameter("order_no"),e);
//            e.printStackTrace();
        }


        mv = new ModelAndView(retUrl).addObject("ResultCode", ResultCode)
                .addObject("Message", Message).addObject("returnType", "4");

        return mv;
    }

    @RequestMapping({"rechargeReturnUrl"})
    @Action(description = "充值支付返回后台通知网址")
    public ModelAndView rechargeReturnUrl(HttpServletRequest request,
                                          HttpServletResponse response) {
        String retUrl = "/payform/moneymoremore/returnUrl.jsp";
        ModelAndView mv = new ModelAndView(retUrl);
        if ("1".equals(PayCommon.payformType)) {// 钱多多支付
            String OrderNo = request.getParameter("OrderNo");
            String ResultCode = request.getParameter("ResultCode");
            String Message = request.getParameter("Message");
            if ("88".equals(ResultCode)) {
                TmoneymoveService tmoneymoveService = (TmoneymoveService) AppUtil
                        .getBean("tmoneymoveService");
                TMoneymove tmoneymove = tmoneymoveService
                        .getByIdFlowCode(OrderNo);
                tmoneymove.setAudit(1);
                tmoneymove.setResultId("1");
                tmoneymove.setRemark("充值成功");
                TUser u = (TUser) request.getSession().getAttribute("user");// 当前用户id
                // 当前账户余额 为充值额 减去手续费
                tmoneymove.setMoneyCurrent(tmoneymove.getMoneyCurrent().add(
                        tmoneymove.getMoneyInOut().subtract(
                                tmoneymove.getGetFee())));
                tmoneymove.setChecker(u.getUserId());
                tmoneymove.setCheckTime(new Timestamp(System
                        .currentTimeMillis()));
                tmoneymoveService.update(tmoneymove);

                // 修改用户资金账户
                TuserFundsService tuserFundsService = (TuserFundsService) AppUtil
                        .getBean("tuserFundsService");
                TUserFunds uf = tuserFundsService.getByUserId(tmoneymove
                        .getUserId());
                uf.setAvailable(uf.getAvailable().add(
                        tmoneymove.getMoneyInOut().subtract(
                                tmoneymove.getGetFee())));
                uf.setBalance(uf.getAvailable().add(uf.getFreeze()));
                tuserFundsService.update(uf);

            }
            mv.addObject("returnType", "2").addObject("ResultCode", ResultCode)
                    .addObject("Message", Message);
        }
        return mv;
    }

    @RequestMapping({"withdrawsReturnUrl"})
    @Action(description = "提现支付返回后台通知网址")
    public ModelAndView withdrawsReturnUrl(HttpServletRequest request,
                                           HttpServletResponse response) {
        String retUrl = "/payform/moneymoremore/returnUrl.jsp";
        ModelAndView mv = new ModelAndView(retUrl);
        if ("1".equals(PayCommon.payformType)) {// 钱多多支付
            String OrderNo = request.getParameter("OrderNo");
            String ResultCode = request.getParameter("ResultCode");
            String Message = request.getParameter("Message");

            String FeeMax = request.getParameter("FeeMax");// 用户承担的最高手续费
            String FeeWithdraws = request.getParameter("FeeWithdraws");// 用户实际承担的手续费

            if ("88".equals(ResultCode)) {
                TuserFundsService tuserFundsService = (TuserFundsService) AppUtil
                        .getBean("tuserFundsService");
                TmoneymoveService tmoneymoveService = (TmoneymoveService) AppUtil
                        .getBean("tmoneymoveService");

                TMoneymove tmoneymove = tmoneymoveService
                        .getByIdFlowCode(OrderNo);
                TUserFunds uf = tuserFundsService.getByUserId(tmoneymove
                        .getUserId());

                // 体现成功后 修改资金记录中的相应字段 为成功,充值手续费
                tmoneymove.setAudit(1);
                tmoneymove.setResultId("1");
                tmoneymove.setRemark("提现成功");
                tmoneymove.setCheckTime(new Date());
                tmoneymove.setChecker(tmoneymove.getUserId());
                if (StringUtil.isNotEmpty(FeeWithdraws)) {
                    tmoneymove.setGetFee(new BigDecimal(FeeWithdraws));// 手续费
                }
                tmoneymove.setMoneyCurrent(uf.getBalance().subtract(
                        tmoneymove.getMoneyInOut().abs()));// 加上体现的金额
                tmoneymoveService.update(tmoneymove);

                // 更新用户资金账户 减去用户体现的金额
                uf.setAvailable(uf.getAvailable().subtract(
                        tmoneymove.getMoneyInOut().abs()));// 可用金额- 提现金额元
                uf.setBalance(uf.getAvailable().add(uf.getFreeze()));//
                if (uf.getFundsOut() != null) {// 提现总额
                    uf.setFundsOut(uf.getFundsOut().add(
                            tmoneymove.getMoneyInOut().multiply(
                                    new BigDecimal(-1))));
                } else {
                    uf.setFundsOut(tmoneymove.getMoneyInOut().multiply(
                            new BigDecimal(-1)));//
                }

                tuserFundsService.update(uf);

                // String
                // mio=tmoneymove.getMoneyInOut().toString().substring(1,tmoneymove.getMoneyInOut().toString().length());
                // tuserFundsService.drawBackMoney(tmoneymove.getUserId(),mio,String.valueOf(tmoneymove.getCardId()),true,OrderNo);
            }
            mv.addObject("returnType", "3").addObject("ResultCode", ResultCode)
                    .addObject("Message", Message);
        }
        return mv;
    }

    @RequestMapping({"loanTransReturnUrl"})
    @Action(description = "转帐支付返回后台通知网址")
    public ModelAndView loanTransReturnUrl(HttpServletRequest request,
                                           HttpServletResponse response) {
        String retUrl = "/payform/moneymoremore/returnUrl.jsp";
        ModelAndView mv = new ModelAndView(retUrl);
        if ("1".equals(PayCommon.payformType)) {// 钱多多支付

            String OrderNo = request.getParameter("OrderNo");
            String ResultCode = request.getParameter("ResultCode");
            String Message = request.getParameter("Message");
            if ("88".equals(ResultCode)) {
                String LoanJsonList = request.getParameter("LoanJsonList");
                LoanJsonList = Common.UrlDecoder(LoanJsonList, "utf-8");
                List<Object> hm = Common.JSONDecodeList(LoanJsonList,
                        HashMap.class);
                if (hm != null && hm.size() > 0) {
                    for (int i = 0; i < hm.size(); i++) {
                        HashMap h = (HashMap) hm.get(i);
                        OrderNo = (String) h.get("OrderNo");
                    }
                }
                TuserFundsService tuserFundsService = (TuserFundsService) AppUtil
                        .getBean("tuserFundsService");
                TmoneymoveService tmoneymoveService = (TmoneymoveService) AppUtil
                        .getBean("tmoneymoveService");

                // List<TMoneymove>
                // listMove=tmoneymoveService.getListByIdFlowCode(OrderNo);

                TMoneymove tmoneymove = tmoneymoveService
                        .getByIdFlowCode(OrderNo);
                /*
                 * if(listMove!=null&&listMove.size()>0){
				 * tmoneymove=listMove.get(0);
				 * 
				 * }
				 */
                tmoneymove.setAudit(1);
                tmoneymove.setResultId("1");
                tmoneymove.setCheckTime(new Timestamp(System
                        .currentTimeMillis()));

                TUser u = (TUser) request.getSession().getAttribute("user");// (网站登录用户)当前用户id

                TUserFunds tf = null;

                if ("12".equals(tmoneymove.getTypeId())) {
                    tmoneymove.setChecker(u.getUserId());
                    tmoneymove.setRemark("支付询价诚意金成功");
                    tmoneymove.setMoneyCurrent(tmoneymove.getMoneyCurrent()
                            .subtract(tmoneymove.getMoneyInOut().abs()));
                    tmoneymoveService.update(tmoneymove);
                    tf = tuserFundsService.getTUserFundsByUserId(u.getUserId());
                    if (tf != null) {
                        tf.setAvailable(tf.getAvailable().subtract(
                                tmoneymove.getMoneyInOut().abs()));// 可用金额-
                        // 询价诚意金
                        tf.setBalance(tf.getBalance().subtract(
                                tmoneymove.getMoneyInOut().abs()));// 账户余额 -
                        // 询价诚意金
                        tuserFundsService.update(tf);
                    }
                    // 更新tuser表中的isAskPrice
                    TUserService tuserService = (TUserService) AppUtil
                            .getBean(TUserService.class);
                    TUser tuser = tuserService.getById(u.getUserId());
                    if (tuser != null) {
                        tuser.setIsAskPrice(1);
                        tuserService.update(tuser);
                    }
                } else if ("3".equals(tmoneymove.getTypeId())) {// 投资付款
                    // 修改资金记录状态为成功
                    tmoneymove.setChecker(u.getUserId());
                    tmoneymove.setRemark("支付投资金额成功");
                    String mio = tmoneymove
                            .getMoneyInOut()
                            .toString()
                            .substring(
                                    1,
                                    tmoneymove.getMoneyInOut().toString()
                                            .length());
                    BigDecimal m = new BigDecimal(mio);
                    tmoneymove.setMoneyCurrent(tmoneymove.getMoneyCurrent()
                            .subtract(m));
                    tmoneymoveService.update(tmoneymove);

                    // 修改 用户资金 将支付金额减掉
                    tf = tuserFundsService.getTUserFundsByUserId(u.getUserId());

                    // tf.setFreeze(new BigDecimal(tf.getFreeze().doubleValue()
                    // +m.doubleValue()));
                    tf.setAvailable(tf.getAvailable().subtract(m));
                    tf.setBalance(tf.getAvailable().add(tf.getFreeze()));
                    tuserFundsService.update(tf);

                    // 修改投资表 是否已经付款 为1(已付款)，

                    // 查询出当前投资人的投资
                    TcprojectInvestService tcprojectInvestService = (TcprojectInvestService) AppUtil
                            .getBean(TcprojectInvestService.class);

                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("projectId", tmoneymove.getProjectId());
                    map.put("userId", tmoneymove.getUserId());
                    map.put("ispay", 0);// 未付款
                    map.put("piisCancel", 0);
                    List<TcprojectInvest> list = tcprojectInvestService
                            .getInvestforPro(map, null);
                    if (list != null && list.size() > 0) {
                        for (TcprojectInvest tpi : list) {
                            tpi.setPiisPay(1);// 已付款
                            tpi.setPipayTime(new Date());
                            tcprojectInvestService.update(tpi);
                        }
                    }

                } else if ("8".equals(tmoneymove.getTypeId())) {// 平台放款

                    SysUser sysUser = ContextUtil.getCurrentUser();// 当前系统后台审核放款用户
                    tmoneymove.setChecker(sysUser.getUserId());
                    tmoneymove.setRemark("平台放款成功");
                    // 当前余额 为 增加
                    tmoneymove.setMoneyCurrent(tmoneymove.getMoneyCurrent()
                            .add(tmoneymove.getMoneyInOut())); // 已经减去手续费
                    tmoneymoveService.update(tmoneymove);

                    // 修改用户资金记录 可用余额增加
                    tf = tuserFundsService.getTUserFundsByUserId(tmoneymove
                            .getUserId());

                    tf.setFundsIn(tf.getFundsIn().add(
                            tmoneymove.getMoneyInOut()));// 充值总额
                    tf.setAvailable(tf.getAvailable().add(
                            tmoneymove.getMoneyInOut()));// 可用金额 = 可用金额 + 充值金额
                    tf.setBalance(tf.getBalance().add(
                            tmoneymove.getMoneyInOut()));// 账户余额=账户余额+充值金额
                    // tuserFundsService.update(tf);//修改 放到service层修改 方便异常回滚
                    // 1/26日

                    // 修改tcproject表数据
                    TcprojectService pc = (TcprojectService) AppUtil
                            .getBean(TcprojectService.class);
                    Tcproject c = pc.getById(Long.valueOf(tmoneymove
                            .getProjectId()));
                    // 设置项目平台拨付筹集资金款费用 手续费
                    if (null == c.getPdealFees() || c.getPdealFees() <= 0) {// 属于分批拨付款的情况，将费用设置为0，因为第一次已经收取所有平台处理费用
                        c.setPdealFees(tmoneymove.getGetFee().doubleValue());// 手续费
                    }

                    // 设置项目创建人目前收到款项
                    if (null != c.getPfinalGetPay()) {
                        c.setPfinalGetPay(c.getPfinalGetPay()
                                + tmoneymove.getMoneyInOut().doubleValue());
                    } else {
                        c.setPfinalGetPay(tmoneymove.getMoneyInOut()
                                .doubleValue());
                    }

                    c.setPisPay(1);
                    c.setPpayTime(new Date());

                    try {
                        pc.confirmPayProject(c, tf);
                    } catch (Exception e) {
                        // TODO Auto-generated catch block
                        logger.error("众筹项目放款异常。", e);
                    }
                    // pc.update(c);// 放到service 层修改 方便异常回滚

                    // 发信息给用户
                    TsmsinformationService smsServie = (TsmsinformationService) AppUtil
                            .getBean(TsmsinformationService.class);
                    TuserSafeService safe = (TuserSafeService) AppUtil
                            .getBean(TuserSafeService.class);
                    TUserSafe usafe = safe.queryTUserSafeByuserId(tmoneymove
                            .getUserId().toString());
                    Tsmsinformation s = new Tsmsinformation();
                    s.setInfoId(UniqueIdUtil.genId());
                    s.setServiceType(2);// 系统
                    s.setMobileNum(usafe.getMobile());
                    s.setMessasge("尊敬的会员你好,你在我平台的创业项目,融资资金已经转入您的双乾账户,请注意查收!");
                    s.setCreator(sysUser.getUserId());
                    s.setStatus(0);
                    s.setCreateTime(new Date());
                    smsServie.add(s);// 保存

                } else if ("9".equals(tmoneymove.getTypeId())) {// 满标审核中的流标
                    // 将资金流动记录修改为 归还资金成功
                    Map<String, Object> map1 = new HashMap<String, Object>();
                    map1.put("projectId", tmoneymove.getProjectId());
                    map1.put("typeId", "9");
                    map1.put("remark", "满标审核,流标操作 资金归还给投资者失败");
                    map1.put("resultId", "2");
                    map1.put("flowCode", tmoneymove.getFlowCode());
                    List<TMoneymove> listMove = tmoneymoveService
                            .getListByMap(map1);

                    SysUser sysUser = ContextUtil.getCurrentUser();// 当前系统后台审核放款用户
                    if (listMove != null && listMove.size() > 0) {
                        for (TMoneymove n : listMove) {
                            n.setAudit(1);
                            n.setResultId("1");
                            n.setCheckTime(new Timestamp(System
                                    .currentTimeMillis()));

                            n.setChecker(sysUser.getUserId());
                            n.setRemark("满标审核,流标操作 资金归还给投资者成功");
                            // 当前余额 为 增加
                            n.setMoneyCurrent(n.getMoneyCurrent().add(
                                    n.getMoneyInOut()));
                            tmoneymoveService.update(n);

                            // 修改 t_user_funds 中的余额
                            TUserFunds tfo = tuserFundsService
                                    .getTUserFundsByUserId(n.getUserId());
                            // 冻结资金减去 已返回的流动资金
                            // 可用资金加上可 返回的资金
                            // 总金额 冻结资金+可用资金
                            // tfo.setFreeze(tfo.getFreeze().subtract(n.getMoneyInOut()));
                            tfo.setAvailable(tfo.getAvailable().add(
                                    n.getMoneyInOut()));
                            tfo.setBalance(tfo.getFreeze().add(
                                    tfo.getAvailable()));
                            tuserFundsService.update(tfo);
                        }
                    }

                    // 修改项目表tcproject 字段值
                    TcprojectService tcprojectService = (TcprojectService) AppUtil
                            .getBean(TcprojectService.class);
                    Tcproject t = tcprojectService.getById(tmoneymove
                            .getProjectId());
                    t.setPstateId("7");// 流标

                    t.setPisBreak(1);// 流标
                    t.setPbreakTime(new Date());// 流标时间
                    tcprojectService.update(t);

                    // 找出项目下的所有投资
                    // 查询出同一个项目的所有投资
                    TcprojectInvestService tcprojectInvestService = (TcprojectInvestService) AppUtil
                            .getBean(TcprojectInvestService.class);

                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("projectId", tmoneymove.getProjectId());
                    // invest.put("userId", userId);
                    // map.put("ispay",1);
                    map.put("piisCancel", 0);
                    List<TcprojectInvest> list = tcprojectInvestService
                            .getInvestforPro(map, null);
                    if (list != null && list.size() > 0) {
                        for (TcprojectInvest tpi : list) {
                            tpi.setPiinvest(new BigDecimal(0));
                            tpi.setPiisCancel(1);// 取消投标
                            tcprojectInvestService.update(tpi);
                        }
                    }
                }

            }
            mv.addObject("returnType", "4").addObject("ResultCode", ResultCode)
                    .addObject("Message", Message);
        }
        return mv;
    }

}
