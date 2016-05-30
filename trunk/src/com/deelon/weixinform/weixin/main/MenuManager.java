package com.deelon.weixinform.weixin.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.deelon.core.util.StringUtil;
import com.deelon.loan.model.front.TUser;
import com.deelon.weixinform.weixin.pojo.AccessToken;
import com.deelon.weixinform.weixin.pojo.Button;
import com.deelon.weixinform.weixin.pojo.CommonButton;
import com.deelon.weixinform.weixin.pojo.ComplexButton;
import com.deelon.weixinform.weixin.pojo.Menu;
import com.deelon.weixinform.weixin.pojo.ViewButton;
import com.deelon.weixinform.weixin.util.WeixinUtil;

/**
 * 菜单管理器类

 */
public class MenuManager {
	private static Logger log = LoggerFactory.getLogger(MenuManager.class);
	private static boolean flag = false;
	public static String rootUrl = "http://www.deelon.com/p2p";

	public static void main(String[] args) {
		// 第三方用户唯一凭证
		String appId = "wx69fba4e737a69dfb";
		// 第三方用户唯一凭证密钥
		String appSecret = "d78ee776e2000437d4bbee77f1d10290";

		// 调用接口获取access_token
		AccessToken at = WeixinUtil.getAccessToken(appId, appSecret);

		/*if (null != at) {
			//调用接口创建菜单
			int result = WeixinUtil.createMenu(getMenu(request,response), at.getToken());

			// 判断菜单创建结果
			if (0 == result)
				log.info("菜单创建成功！");
			else
				log.info("菜单创建失败，错误码：" + result);
		}*/
	}

	public static void start(HttpServletRequest request, HttpServletResponse response)
	{
		// 第三方用户唯一凭证
		String appId = "wx69fba4e737a69dfb";
		// 第三方用户唯一凭证密钥
		String appSecret = "d78ee776e2000437d4bbee77f1d10290";

		// 调用接口获取access_token
		AccessToken at = WeixinUtil.getAccessToken(appId, appSecret);

		if (null != at) {
			//调用接口创建菜单
			int result = WeixinUtil.createMenu(getMenu(request,response), at.getToken());

			// 判断菜单创建结果
			if (0 == result){
				log.info("菜单创建成功！");
				
			}
			else
				log.info("菜单创建失败，错误码：" + result);
		}
	}
	
	
	/**
	 * 组装菜单数据
	 * 
	 * @return
	 */
	private static Menu getMenu(HttpServletRequest request, HttpServletResponse response) {
		ViewButton btn11 = new ViewButton();
		btn11.setName("投资流程");
		btn11.setType("view");
		btn11.setUrl(rootUrl + "/weixin/wxfinancing/wxinvestPage.ht");

		ViewButton btn12 = new ViewButton();
		btn12.setName("本金保障");
		btn12.setType("view");
		btn12.setUrl(rootUrl + "/weixin/wxfinancing/safeguardPage.ht");

		ViewButton btn13 = new ViewButton();
		btn13.setName("可投资项目");
		btn13.setType("view");
		btn13.setUrl(rootUrl + "/weixin/wxfinancing/wxfinancingPage.ht");

		ViewButton btn21 = new ViewButton();
		btn21.setName("借款流程");
		btn21.setType("view");
		btn21.setUrl(rootUrl + "/weixin/wxproductsloan/borrowFlowPage.ht");

		ViewButton btn22 = new ViewButton();
		btn22.setName("借款费用");
		btn22.setType("view");
		btn22.setUrl(rootUrl + "/weixin/wxproductsloan/borrowCosts.ht");

		ViewButton btn23 = new ViewButton();
		btn23.setName("借款申请");
		btn23.setType("view");
		btn23.setUrl(rootUrl + "/weixin/wxproductsloan/productsLoanList.ht");

		
		/*ViewButton btn31 = new ViewButton();
		btn31.setName("我的账户");
		btn31.setType("click");
		btn31.setKey("31");*/
		
		ViewButton btn31 = new ViewButton();
		btn31.setName("我的账户");
		btn31.setType("view");
		btn31.setUrl(rootUrl + "/weixin/wxmyaccount/wxmyaccountPage.ht");

		ViewButton btn32 = new ViewButton();
		btn32.setName("我的理财");
		btn32.setType("view");
		btn32.setUrl(rootUrl + "/weixin/wxmyfinancing/myFinancingPage.ht");
		
		ViewButton btn33 = new ViewButton();
		btn33.setName("我的借款");
		btn33.setType("view");
		btn33.setUrl(rootUrl + "/weixin/wxmyborrow/myborrowPage.ht");
		
		ViewButton btn34 = new ViewButton();
		btn34.setName("帮助中心");
		btn34.setType("view");
		btn34.setUrl(rootUrl + "/weixin/wxaboutus/aboutHelp.ht");
		
		CommonButton btn35 = new CommonButton();
		btn35.setName("关于我们");
		btn35.setType("click");
		btn35.setKey("35");


		ComplexButton mainBtn1 = new ComplexButton();
		mainBtn1.setName("我要理财");
		mainBtn1.setSub_button(new Button[] { btn11, btn12 , btn13 });

		ComplexButton mainBtn2 = new ComplexButton();
		mainBtn2.setName("我要借款");
		mainBtn2.setSub_button(new Button[] { btn21, btn22, btn23 });

		ComplexButton mainBtn3 = new ComplexButton();
		mainBtn3.setName("我的账户");
		mainBtn3.setSub_button(new Button[] { btn31, btn32, btn33, btn34, btn35});
		/*TUser u=(TUser)request.getSession().getAttribute("user");
		if(null == u){
			mainBtn3.setSub_button(new Button[] { btn31, btn32, btn33, btn34, btn35});
		}else if(StringUtil.isNotEmpty(u.getGroupID())){
			if(u.getGroupID().equals("2")){
				mainBtn3.setSub_button(new Button[] { btn31, btn32, btn34, btn35});
			}else if(u.getGroupID().equals("1")){
				mainBtn3.setSub_button(new Button[] { btn31, btn33, btn34, btn35});
			}else if(u.getGroupID().equals("3")){
				mainBtn3.setSub_button(new Button[] { btn31, btn32, btn33, btn34, btn35});
			}
		}*/
		

		/**
		 * 
		 * 在某个一级菜单下没有二级菜单的情况，menu该如何定义呢？<br>
		 * 比如，第三个一级菜单项不是“更多体验”，而直接是“幽默笑话”，那么menu应该这样定义：<br>
		 * menu.setButton(new Button[] { mainBtn1, mainBtn2, btn33 });
		 */
		Menu menu = new Menu();
		menu.setButton(new Button[] { mainBtn1, mainBtn2, mainBtn3 });

		return menu;
	}
}