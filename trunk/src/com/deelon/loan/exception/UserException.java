package com.deelon.loan.exception;

/**
 * 用户处理异常
 * 
 * @author deelon.hejian
 * 
 */
@SuppressWarnings("serial")
public class UserException extends Exception {

	public UserException() {
		super();
	}

	public UserException(String message, Throwable cause) {
		super(message, cause);
	}

	public UserException(String message) {
		super(message);
	}

	public UserException(Throwable cause) {
		super(cause);
	}
}
