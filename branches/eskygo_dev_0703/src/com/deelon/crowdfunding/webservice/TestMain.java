package com.deelon.crowdfunding.webservice;

import org.apache.cxf.jaxws.JaxWsProxyFactoryBean;

public class TestMain {
	public static void main(String[] args) {
		
		try{
			
		
		//同步数据测试类
	     JaxWsProxyFactoryBean svr = new JaxWsProxyFactoryBean();
         svr.setServiceClass(SyncUserInterface.class);
         svr.setAddress("http://localhost:8080/zcb/service/syncUserService?wsdl");
         SyncUserInterface hw = (SyncUserInterface) svr.create();
         String syncUserDatas = "<?xml version='1.0' encoding='UTF-8'?>"+
         "<userDatas>"+
         "<userData>" +
         "<loginName>wuji67</loginName>" +
         "<loginPwd>4297f44b13955235245b2497399d7a93</loginPwd>" +
         "<realName>张三</realName>" +
         "<email>zhangsan@126.com</email>"+
         "<mobile>13166667777</mobile>" +
         "<idNumber>123451234512345123</idNumber>" +
         "<groupId>1</groupId>" +
         "<registerTime>2015-01-02 11:12:13</registerTime>" +
         "</userData>"+
         
         "<userData>" +
         "<loginName>wuji68</loginName>" +
         "<loginPwd>4297f44b13955235245b2497399d7a93</loginPwd>" +
         "<realName>hhh</realName>" +
         "<email>zhangsan@126.com</email>"+
         "<mobile>13166667777</mobile>" +
         "<idNumber>123451234512345123</idNumber>" +
         "<groupId>1</groupId>" +
         "<registerTime>abc</registerTime>" +
         "</userData>"+
         
         "</userDatas>";
         System.out.println("-----------------aaaaa");
         String info = hw.insertUserInfo(syncUserDatas);
         System.out.println(info+"-----------------jk");
		}
		catch(Exception e){
			System.out.println(e.getMessage()+"---------client");
		}
	}

}
