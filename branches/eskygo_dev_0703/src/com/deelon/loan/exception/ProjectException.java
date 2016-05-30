package com.deelon.loan.exception;

/**
 * 贷款业务异常类
 * 
 * @author deelon.hejian
 * 
 */
@SuppressWarnings("serial")
public class ProjectException extends Exception {

	public ProjectException() {
		super();
	}

	public ProjectException(String message, Throwable cause) {
		super(message, cause);
	}

	public ProjectException(String message) {
		super(message);
	}

	public ProjectException(Throwable cause) {
		super(cause);
	}
}
