/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.front;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.core.util.StringUtil;
import com.deelon.crowdfunding.webservice.client.cardValidate.QueryValidatorServices;
import com.deelon.crowdfunding.webservice.client.cardValidate.QueryValidatorServicesService;
import com.deelon.loan.dao.front.TUserSafeDao;
import com.deelon.loan.model.front.TUser;
import com.deelon.loan.model.front.TUserSafe;
import com.deelon.loan.model.sysManager.XmlData;
import com.deelon.loan.model.sysManager.XmlMessage;
import com.deelon.loan.model.sysManager.XmlPoliceCheckInfo;
import com.deelon.loan.model.sysManager.XmlPoliceCheckInfos;
import com.deelon.loan.util.ContextUtil;
import com.deelon.loan.util.CreateAuthUrl;
import com.deelon.loan.util.EncryptDesUtil;
import com.deelon.loan.util.XmlBeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.namespace.QName;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ Service
public class TuserSafeService extends BaseService<TUserSafe>{
	public final Log log = LogFactory.getLog(this.getClass());
	
	@ Resource
	private TUserSafeDao tuserSafeDao;
	
	protected IEntityDao<TUserSafe, Long> getEntityDao()
	{
		return this.tuserSafeDao;
	}

	/**
	 * 根据email查询记录
	 * @param emailAdd
	 * @return
	 */
	public TUserSafe queryTUserSafeByEmail(String emailAdd){
		return tuserSafeDao.queryTUserSafeByEmail(emailAdd);
	}
	/**
	 * 验证邮箱
	 * @param email
	 * @return
	 */
	public TUserSafe valiTUserSafeByEmail(String email){
		return tuserSafeDao.valiTUserSafeByEmail(email);
	}
	
	/**
	 * 验证手机
	 * @param mobile
	 * @return
	 */
	public TUserSafe valiTUserSafeByMobile(String mobile){
		return tuserSafeDao.valiTUserSafeByMobile(mobile);
	}
	
	/**
	 * 验证安全问题
	 * @param mobile
	 * @return
	 */
	public TUserSafe valiTUserSafeByQuesion(long userId){
		return tuserSafeDao.valiTUserSafeByQuesion(userId);
	}
	
	/**
	 * 根据主键更新记录
	 * @param tUserSafe
	 */
	public void updateTUserSafeByPk(TUserSafe tUserSafe){
		tuserSafeDao.updateTUserSafeByPk(tUserSafe);
	}

	public TUserSafe getUserSafeByUserId(long userId){
		List<TUserSafe> userSafes = tuserSafeDao.getUserSafeByColumn("user_id", userId);
		if(userSafes == null || userSafes.size()==0){
			return null;
		}
		return userSafes.get(0);
	}
	
	/**
	 * 根据校验码查询
	 * @param tUserSafe
	 * @return
	 */
	public TUserSafe queryTUserSafeByValidateKey(TUserSafe tUserSafe){
		return tuserSafeDao.queryTUserSafeByValidateKey(tUserSafe);
	}
	
	/**
	 * 根据用户id查询记录
	 * @param userId
	 * @return
	 */
	public TUserSafe queryTUserSafeByuserId(String userId){
		return tuserSafeDao.queryTUserSafeByuserId(userId);
	}
	
	public void updateUserSafeSecurityByUserId(TUserSafe tuserSafe){
		tuserSafeDao.update("updateUserSafeSecurityByUserId", tuserSafe);
	}
	
	
	/**
	 * 验证手机是否存在
	 * 
	 * @param email
	 * @return
	 */
	public boolean existPhone(String phone ) {
		if ((tuserSafeDao.getUserSafeByColumn("Mobile", phone).size() > 0)) {
			return true;
		}
		return false;
	}
	
	/**
	 * 验证身份证是否存在
	 * 
	 * @param idNo
	 * @return
	 */
	public boolean existIdNo(String idNo ) {
		if ((tuserSafeDao.getUserSafeByColumn("id_no", idNo).size() > 0)) {
			return true;
		}
		return false;
	}
	
	
	/**
	 * 验证邮箱是否存在
	 * 
	 * @param email
	 * @return
	 */
	public boolean existEmail(String email) {
		if ((tuserSafeDao.getUserSafeByColumn("EMail", email).size() > 0)) {
			return true;
		}
		return false;
	}
	/**
	 * 取当前用户的安全等级
	 * @return 0:无登陆用户或低 1：低 2：中 3：高 
	 */
	public int getUserSafeLevel(TUser user){
		if(user==null){
			return 0;
		}
		long userId = user.getUserId();
		
		TUserSafe userSafe = this.getUserSafeByUserId(userId);
		int level = 0;
		if(userSafe!=null){
			if(userSafe.getBindEmail()==1){//身份证
				level++;
			}
			if(userSafe.getBindIdNo()==1){//邮箱
				level++;
			}
			if(userSafe.getBindMobile()==1){//手机
				level++;
			}
		}
		return level;
	}
	
	/**
	 * 修改用户的邮箱
	 * 
	 * @param email
	 * @return
	 */
//	public void updateSafe(TUserSafe tUserSafe){
//		System.out.println("---begin---");
//		tuserSafeDao.updateSafe(tUserSafe);
//		System.out.println("---end---");
//	}
	
	
	/**
	 * 调用国政通检查用户名和身份证号是否存在
	 * @param mobile
	 * @return
	 */
	
	public Map<String,Object> idcardIsReal(HttpServletRequest request,HttpServletResponse response,
			String realName,String idNo) {
		Map<String,Object>  map = new HashMap<String,Object>();
		String resultMessage = "";
		if(StringUtil.isNotEmpty(realName) && StringUtil.isNotEmpty(idNo)){
			//URL wsdlLoation =  null;
//			String wsdl_Loation = "";
//			try {
//			    try {
//					wsdl_Loation = (String)AppUtil.getServletContext().getAttribute("WSDL");
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//				URL baseUrl = com.deelon.loan.webservice.client.cardValidate.QueryValidatorServicesService.class
//						.getResource(".");
//				wsdlLoation = new URL(baseUrl,wsdl_Loation);
//
//			} catch (MalformedURLException e) {
//				log.error("Failed to create URL for the wsdl Location: '"
//						+ wsdl_Loation + "', retrying as a local file", e);
//			}
			try {
				EncryptDesUtil des = new EncryptDesUtil();
				//调用国政通身份认证接口
				//String userName = (String)AppUtil.getServletContext().getAttribute("USERNAME");//用户名
				//String password = (String)AppUtil.getServletContext().getAttribute("PASSWORD"); //密码
				//String datasource = (String)AppUtil.getServletContext().getAttribute("DATASOURCE");//数据类型(实名认证):1A020201
				String wsdlLoationStr = ContextUtil.getPropertyByName("webservice.wsdlLoation");
				URL wsdlLoation = new URL(wsdlLoationStr);
				//URLConnection urlConnection = wsdlLoation.openConnection();
				//urlConnection.setConnectTimeout(15000);
				String userName =  ContextUtil.getPropertyByName("webservice.userName");
				String password =  ContextUtil.getPropertyByName("webservice.password");
				String datasource =  ContextUtil.getPropertyByName("webservice.datasource");
				QueryValidatorServicesService services = new QueryValidatorServicesService(wsdlLoation,
						new QName("http://app.service.validator.businesses.gboss.id5.cn","QueryValidatorServicesService"));
				QueryValidatorServices service = services.getQueryValidatorServices();
				String resultXML = "";
				String param = realName+","+idNo;
				if(service != null)
			       resultXML = service.querySingle(des.encode("12345678", userName), des.encode("12345678", password), des.encode("12345678", datasource), des.encode("12345678", param));
				//resultXML = "<data><message><status>0</status><value>处理成功</value></message><policeCheckInfos><policeCheckInfo name=\"刘静\" id=\"110107197111011528\"><message><status>0</status><value>处理成功</value></message><name desc=\"姓名 \">刘静</name><identitycard desc=\"身份证号\">110107197111011528</identitycard><compStatus desc=\"比对状态\">2</compStatus><compResult desc=\"比对结果\">不一致</compResult></policeCheckInfo></policeCheckInfos></data>";
				//System.out.println(resultXML+"-----------------------------------------------------idcardxml");
				System.out.println(param+"---------------------------姓名和身份证号");
				
				if(StringUtil.isNotEmpty(resultXML)){
			    	//解密resultXML
			    	resultXML = des.decodeValue("12345678", resultXML);
			    	System.out.println(resultXML+"------------------------------------------------idcardxmldec");
				    XmlData data = XmlBeanUtils.getBeanByAnnotations(resultXML, XmlData.class,  new Class[]{XmlPoliceCheckInfo.class,XmlData.class});
					List<XmlPoliceCheckInfos>  policeCheckInfosList;
					//接口调用成功
					if(data != null && data.getPoliceCheckInfos() != null){
						XmlMessage message = data.getMessage();
						System.out.println("status==="+message.getStatus()+"----value==="+message.getValue());
						policeCheckInfosList = data.getPoliceCheckInfos();
						if(null != message && "0".equals(message.getStatus())){//0：查询处理成功
							if(null != policeCheckInfosList && policeCheckInfosList.size() > 0){
								for(XmlPoliceCheckInfos obj:policeCheckInfosList){
									XmlPoliceCheckInfo policeCheckInfo = obj.getPoliceCheckInfo();
									if(policeCheckInfo != null){
										if(resultMessage == ""){
											//resultMessage = policeCheckInfo.getName()+","+policeCheckInfo.getIdentitycard()+",比对结果:"+policeCheckInfo.getCompResult();
											resultMessage = " 姓名和身份证号不一致,请检查 ";
										}else{
											//resultMessage += ";"+policeCheckInfo.getName()+","+policeCheckInfo.getIdentitycard()+",比对结果:"+policeCheckInfo.getCompResult();
											resultMessage += " 姓名和身份证号不一致，请检查 ";
										}
										if("3".equals(policeCheckInfo.getCompStatus())){//3:一致,2:不一致,1:库中无此号，请到户籍所在地进行核实
											//更新认证信息
											map.put("same","1");
										}
										//System.out.println(policeCheckInfo.getName()+"---"+policeCheckInfo.getIdentitycard()+"--"+policeCheckInfo.getCompStatus()+"---"+policeCheckInfo.getCompResult());
									}
								}
							}
						}else{
							//查询失败
							if(null != message){
								resultMessage = message.getValue();
							}
						}
						map.put("msg",resultMessage);
					}else{
						map.put("msg","您的用户信息错误");
					}
			    }
			} catch (Exception e) {
				e.printStackTrace();
				log.error("查询身份认证失败");
				map.put("msg",e.getMessage());
			}
		}
	  return map;
	}
	
	
	/**
	 * 调用检查用户名和身份证号是否存在
	 * @param mobile
	 * @return
	 */
	public Map verifyIdNo(HttpServletRequest request,HttpServletResponse response,
		String realName,String idNo) {
		String urlStr=ContextUtil.getPropertyByName("webservice.wsdlLoation");
		String userId=ContextUtil.getPropertyByName("webservice.userId");
		String ts =System.currentTimeMillis()+"";
		String orderNo =ts;
		String mKey=ContextUtil.getPropertyByName("webservice.mKey");//MD5密钥
		String dateString ="";
		String name=realName;
		String idCode=idNo;
		CreateAuthUrl.strDefaultKey=ContextUtil.getPropertyByName("webservice.strDefaultKey");//DES密钥
		Map map = new HashMap();
		Document doc = null;
		try {
			name=URLEncoder.encode(name,"Utf-8");
			Date currentTime = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			dateString=formatter.format(currentTime);
//			dateString=URLEncoder.encode(dateString,"GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String nameDes=CreateAuthUrl.Encode(name);
		String idCodeDes=CreateAuthUrl.Encode(idCode);
		String md5Str = "userId" + userId + "coopOrderNo" + orderNo + "auName" + name + "auId" + idCode + "ts" + ts + mKey;
		md5Str = CreateAuthUrl.md5Sign(md5Str);
		
		System.out.println("解密前："+nameDes+"----"+idCodeDes);
		String nameDec=CreateAuthUrl.Decode(nameDes);
		String idCodeDec=CreateAuthUrl.Decode(idCodeDes);
		System.out.println("解密后："+nameDec+"----"+idCodeDec);
		
		Map<String, String> params=new HashMap<String, String>();
		params.put("userId", userId);
		params.put("coopOrderNo", orderNo);
		params.put("auName", nameDes);
		params.put("auId", idCodeDes);
		params.put("reqDate", dateString);
		params.put("ts", ts);
		params.put("sign", md5Str);
		try {
				System.out.println(urlStr+"?userId="+userId+"&coopOrderNo="+orderNo+"&auName="+nameDes+"&auId="
						+idCodeDes+"&reqDate="+dateString+"&ts="+ts+"&sign="+md5Str);
			System.out.println(CreateAuthUrl.sendHttpRequest(urlStr,params));
			String xml = CreateAuthUrl.sendHttpRequest(urlStr,params);
			
			SAXReader reader = new SAXReader();   
			Document doc1 = DocumentHelper.parseText(xml);    
			//Document doc = reader.read(ffile); //读取一个xml的文件   
			Element root = doc1.getRootElement();   
			String usId = root.element("userId").getTextTrim();
			String coopOrderNo = root.element("coopOrderNo").getTextTrim();
			String auOrderNo = root.element("auOrderNo").getTextTrim();
			String auResultCode = root.element("auResultCode").getTextTrim();
			String auResultInfo = root.element("auResultInfo").getTextTrim();
			String auSuccessTime = root.element("auSuccessTime").getTextTrim();
			String img = root.element("img").getTextTrim();
			map.put("userId", usId);
			map.put("coopOrderNo", coopOrderNo);
			map.put("auOrderNo", auOrderNo);
			map.put("auResultCode", auResultCode);
			map.put("auResultInfo", auResultInfo);
			map.put("auSuccessTime", auSuccessTime);
			map.put("img", img);      
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return map;
	}
}