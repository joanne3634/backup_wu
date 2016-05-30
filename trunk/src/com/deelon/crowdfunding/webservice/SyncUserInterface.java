package com.deelon.crowdfunding.webservice;

import javax.jws.WebParam;
import javax.jws.WebService;

@WebService
public interface SyncUserInterface {
/*	public String insertUserInfo(//返回结果 添加数据成功返回success字符串，失败返回出错信息
			@WebParam(name="loginName") String loginName,//登录名
			@WebParam(name="loginPwd") String loginPwd,//登陆密码，使用MD5加密
			@WebParam(name="realName") String realName,//真实姓名
			@WebParam(name="email") String email,//用户邮箱
			@WebParam(name="mobile") String mobile,//用户手机
			@WebParam(name="idNumber") String idNumber,//身份证号
			@WebParam(name="groupId") String groupId,//用户类型(1创业者2投资者3综合)
			@WebParam(name="registerTime") String registerTime//注册时间
			);*/
	public String insertUserInfo(//返回结果 添加数据成功返回success字符串，失败返回出错信息
			@WebParam(name="userDatas") String userDatas//xml格式用户数据
			);
	/*xml用户数据格式如下
	   <?xml version="1.0" encoding="UTF-8" ?>
	   <userDatas>
	   <userData>
	   <loginName>登录名</loginName>
	   <loginPwd>登陆密码，使用MD5加密后传过来</loginPwd>
	   <realName>真实姓名</realName>
	   <email>用户邮箱</email>
	   <mobile>用户手机</mobile>
	   <idNumber>身份证号</idNumber>
	   <groupId>用户类型(1创业者2投资者)</groupId>
	   <registerTime>注册时间,格式为2015-01-02 11:12:13</registerTime>
	   </userData>
	  <userData>
	   <loginName>zhangsan</loginName>
	   <loginPwd>e10adc3949ba59abbe56e057f20f883e</loginPwd>
	   <realName>张三</realName>
	   <email>zhangsan@163.com</email>
	   <mobile>15188889999</mobile>
	   <idNumber>423451234512345123</idNumber>
	   <groupId>2</groupId>
	   <registerTime>2015-01-02 11:12:13</registerTime>
	   </userData>
	   </userDatas>
	 */

}
