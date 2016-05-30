package com.deelon.crowdfunding.common.constants;

/**
 * Created by jiang on 15/5/20.
 */
public enum WuyouchouErrorCode {

    //01开头为基础服务类异常，例如注册、登陆
    USR_REG_ERROR("010000", "注册异常"),
    USR_LOGIN_ERROR("010001", "登陆异常"),
    USR_NOT_FOUND_ERROR("010002","丢失用户信息"),

    //02开头为投资人服务类异常，如申请领投资格，跟投等等
    INVST_APPLY_LEADER_ERROR("020000", "申请领投人资格异常"),
    INVST_CONTINUE_IVST_ERROR("020001", "跟投资金异常"),
    INVST_GENTOU_LIST_ERROR("020002", "跟投人列表异常"),

    //03开头为项目类异常，如保存项目信息异常等等
    PRJ_INFO_SAVE_ERROR("030000", "项目信息保存异常"),
    PRJ_MODEL_SAVE_ERROR("030001","项目模型保存异常"),
    PRJ_HISTORY_SAVE_ERROR("030002","项目历史和未来信息保存异常"),
    PRJ_TEAM_SAVE_ERROR("030003","项目团队成员信息保存异常"),
    PRJ_SEARCH_LIST_ERROR("030004","项目列表异常"),
    PRJ_BASIC_SAVE_ERROR("030005","项目基本信息保存异常"),
    PRJ_DETAIL_QUERY_ERROR("030006","项目详情查询异常"),
    PRJ_COMMENT_ADD_ERROR("030007","发表项目评论异常"),
    PRJ_COMMENT_REPLAY_ERROR("030008","回复项目评论异常"),
    PRJ_MODEL_UPDATE_ERROR("030009","回复项目评论异常"),
    PRJ_BACKAGE_UPDATE_ERROR("0300010","后台修改项目信息异常"),
    //04前端显示
    PRJ_HOME_PAGE_ERROR("040000","homepageService异常"),
    //05线下支付异常(后台管理)
    INVEST_TOASKPAY_BACKSTAGE_ERROR("050000","线下支付诚意金异常"),
    INVEST_ASKPAY_BACKSTAGE_ERROR("050001","线下支付诚意金提交异常"),
    INVEST_ADDPAY_BACKSTAGE_ERROR("050002","线下支付投资金额异常"),
    INVEST_TOPAY_BACKSTAGE_ERRORTO("050003","线下支付投资金额提交异常"),
    INVEST_GETDETAIL_BACKSTAGE_ERROR("050004","线下支付投资金额提交异常"),

    //06支付类异常
    PAYMENT_ASKPAY_ADD_ERROR("060000","新增诚意金记录异常"),
    PAYMENT_INVST_ADD_ERROR("060001","新增投资金记录异常");

    private WuyouchouErrorCode(String errorCode, String errorMsg) {
        this.errorCode = errorCode;
        this.errorMsg = errorMsg;
    }

    private String errorCode;

    private String errorMsg;

    public String getErrorCode() {
        return this.errorCode;
    }

    public String getErrorMsg() {
        return this.errorMsg;
    }
}
