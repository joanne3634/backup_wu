package com.deelon.crowdfunding.common.util;

import java.util.Random;

public class CodeUtil {

	public static String createCode() {
		Random rd = new Random();

		return String.valueOf(rd.nextInt(5));
	}
	
	public static void main(String[] args) {
		System.out.println(CodeUtil.createCode());
	}
}
