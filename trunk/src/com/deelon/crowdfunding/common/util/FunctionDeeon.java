package com.deelon.crowdfunding.common.util;

public class FunctionDeeon {
	
	 public static String substrdot(String moneny){
		String result = "";
		if(moneny!=null && !moneny.equals("")){
			Float monenyf=(Float.valueOf(moneny))/10000;
			String monenystr=String.valueOf(monenyf);
			if(String.valueOf(monenystr).indexOf(".")>0){
				result=monenystr.substring(0,monenystr.lastIndexOf("."));
			}else{
				result=monenystr;
			}
		}
		return result;
	}

}
