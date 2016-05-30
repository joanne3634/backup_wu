package com.deelon.crowdfunding.common.exception;

/**
 * 无忧愁项目自定义异常，用于Controller
 * <p>
 * Created by jiangzhifei on 15/5/20.
 *
 * @author jiangzhifei
 */
public class CrowdFundException extends RuntimeException {

    /**
     * 错误码
     */
    private String errorCode;

    private String errorMsg;

    public CrowdFundException() {
        super();
    }

    public CrowdFundException(String errorCode, String message, Throwable cause) {
        super(cause);

        this.errorCode = errorCode;
        this.errorMsg = message;

    }

    public CrowdFundException(String message) {
        super(message);
        this.errorMsg = message;
    }

    public CrowdFundException(Throwable cause) {
        super(cause);
    }

    public void setErrorCode(String errorCode) {
        this.errorMsg = errorCode;
    }

    public void setErrorMsg(String errorMsg) {
        this.errorMsg = errorMsg;
    }

    public String getErrorCode() {
        return this.errorCode;
    }

    public String getErrorMsg() {
        return this.errorMsg;
    }

}
