package com.deelon.payform.util.moneymoremore;

import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.json.JSONException;
import org.json.JSONObject;
//import org.json.JSONException;
//import org.json.JSONObject;
/*import org.json.JSONException;
import org.json.JSONObject;*/
import com.google.gson.Gson;

/**
 * 辅助类
 * 
 */
public class Common
{
	//public static final String privateKeyPKCS8 = "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKNnVah2m6THW/Oy78FC9/1sQWtj" + "zHq9LiwEequgpSj95ZZyiKfc+29g/kWKrNCcedV9bswnUDjU5gHnW4I6eqz2IrWTOpCjaYX/ibXZ" + "V5ZVQQAYO4vlxBPbGj+aYsQMy0YiEA4IaUzVsuvpsBUvXXvKm1cKDM5qiIVl3PM40I41AgMBAAEC" + "gYAf3e4xnXf7KboAC9yAFzxf2vXjKKJfKXfQs8rsn7a2CNX2gj2uZwVOEl9kVogfYvTLstuhyuT1" + "QGfe5SzOd/MmaXQ+Od0cKJ7NC3XeYHsaOmA/cbTD/1MJkGcXt2C5DVwD9tusLFX7ZMtBL4T3gsdM" + "JUAN9LVHSmONpXBBWn7oQQJBAOzLCERpl/vgH2Sc+MI47tyl1Ay3Qhg8yOm65+pMNKMPHbNjF+SF" + "XTJG6ZGb5dTP97MNVmdnuzTGWF2MGNVZhdECQQCwqGIYFp0+gGoGZ/HclVDu30bYfy/ITM7j0bW8" + "8DwWczQDFUu1AK8lqYp4e+DXn03M639Ent2oO0Zj6eypH4clAkEApwcAKeGiB1UsT7g58CZgttty" + "HBYYVShrQBNLC4X9ixdah/LaI6O+/XvvvXoOQHMB8hbyX7ZX4v4VzsbHrZacQQJBAJTDp5+rY42f" + "rClq3TUplLcj1VA5gu6FJ/CXyBisoZ0yNImoJFHvmo73wAEIKObLY0P+yPTrZ7Pk/rji5AXj4/UC" + "QDp+7WVUy21Va+6CWuaeOfjnQunEHCOLlS2PxzbexSSdRB5r2bXh4fbXzNsiDJzwkI00kGPXW2fb" + "KFEVEL1ekos=";
	//public static final String publicKey = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCjZ1Wodpukx1vzsu/BQvf9bEFrY8x6vS4sBHqr" + "oKUo/eWWcoin3PtvYP5FiqzQnHnVfW7MJ1A41OYB51uCOnqs9iK1kzqQo2mF/4m12VeWVUEAGDuL" + "5cQT2xo/mmLEDMtGIhAOCGlM1bLr6bAVL117yptXCgzOaoiFZdzzONCONQIDAQAB";
	
	/**
	 * 字符串编码
	 * 
	 * @param sStr
	 * @param sEnc
	 * @return String
	 */
	public final static String UrlEncoder(String sStr, String sEnc)
	{
		String sReturnCode = "";
		try
		{
			sReturnCode = URLEncoder.encode(sStr, sEnc);
		}
		catch (UnsupportedEncodingException ex)
		{
			
		}
		return sReturnCode;
	}
	
	/**
	 * 字符串解码
	 * 
	 * @param sStr
	 * @param sEnc
	 * @return String
	 */
	public final static String UrlDecoder(String sStr, String sEnc)
	{
		String sReturnCode = "";
		try
		{
			sReturnCode = URLDecoder.decode(sStr, sEnc);
		}
		catch (UnsupportedEncodingException ex)
		{
			
		}
		return sReturnCode;
	}
	
	/**
	 * 将模型进行JSON编码
	 * 
	 * @param obModel
	 * @return String
	 */
	public final static String JSONEncode(Object obModel)
	{
		Gson gson = new Gson();
		return gson.toJson(obModel);
	}
	
	/**
	 * 将模型进行JSON解码
	 * 
	 * @param sJson
	 * @param classOfT
	 * @return Object
	 */
	@SuppressWarnings("unchecked")
	public final static Object JSONDecode(String sJson, Class classOfT)
	{
		Gson gson = new Gson();
		return gson.fromJson(sJson, classOfT);
	}
	
	/**
	 * 将模型列表进行JSON解码
	 * 
	 * @param sJson
	 * @return List<Object>
	 */
	@SuppressWarnings("unchecked")
	public final static List<Object> JSONDecodeList(String sJson, Class classOfT)
	{
		if (sJson.equals("[]"))
		{
			return null;
		}
		List<String> lstsfs = dealJsonStr(sJson);
		List<Object> lst = new ArrayList<Object>();
		
		for (String str : lstsfs)
		{
			// 使用JSON作为传输
			Object o = JSONDecode(str, classOfT);
			lst.add(o);
		}
		return lst;
	}
	
	/**
	 * 将json列表转换为字符串列表,每个字符串为一个对象
	 * 
	 * @param json
	 * @return List<String>
	 */
	public static List<String> dealJsonStr(String json)
	{
		List<String> lst = new ArrayList<String>();
		try
		{
			String[] sfs = json.split("\"\\},\\{\"");
			for (String str : sfs)
			{
				if (str.startsWith("["))
				{
					str = str.substring(1);
				}
				else if (str.startsWith("{\""))
				{
					
				}
				else
				{
					str = "{\"" + str;
				}
				if (str.endsWith("\\\"}]"))
				{
					str += "\"}";
				}
				else
				{
					if (str.endsWith("]"))
					{
						str = str.substring(0, str.length() - 1);
					}
					else if (str.endsWith("\"}"))
					{
						
					}
					else
					{
						str += "\"}";
					}
				}
				
				lst.add(str);
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return lst;
	}
	
	/**
	 * 将接收的字符串转换成图片保存
	 * 
	 * @param imgStr
	 *            二进制流转换的字符串
	 * @param imgPath
	 *            图片的保存路径
	 * @param imgName
	 *            图片的名称
	 * @return 1：保存正常 0：保存失败
	 */
	public static int saveToImgByStr(String imgStr, String imgPath, String imgName)
	{
		int stateInt = 1;
		try
		{
			// System.out.println("===imgStr.length()====>" + imgStr.length() + "=====imgStr=====>" + imgStr);
			File savedir = new File(imgPath);
			if (!savedir.exists())
			{
				savedir.mkdirs();
			}
			if (imgStr != null && imgStr.length() > 0)
			{
				// 将字符串转换成二进制，用于显示图片
				// 将上面生成的图片格式字符串 imgStr，还原成图片显示
				byte[] imgByte = hex2byte(imgStr);
				
				InputStream in = new ByteArrayInputStream(imgByte);
				
				File file = new File(imgPath, imgName);// 可以是任何图片格式.jpg,.png等
				FileOutputStream fos = new FileOutputStream(file);
				
				byte[] b = new byte[1024];
				int nRead = 0;
				while ((nRead = in.read(b)) != -1)
				{
					fos.write(b, 0, nRead);
				}
				fos.flush();
				fos.close();
				in.close();
			}
		}
		catch (Exception e)
		{
			stateInt = 0;
			e.printStackTrace();
		}
		
		return stateInt;
	}
	
	/**
	 * 字符串转二进制
	 * 
	 * @param str
	 *            要转换的字符串
	 * @return 转换后的二进制数组
	 */
	public static byte[] hex2byte(String str)
	{ // 字符串转二进制
		if (str == null)
			return null;
		str = str.trim();
		int len = str.length();
		if (len == 0 || len % 2 == 1)
			return null;
		byte[] b = new byte[len / 2];
		try
		{
			for (int i = 0; i < str.length(); i += 2)
			{
				b[i / 2] = (byte) Integer.decode("0X" + str.substring(i, i + 2)).intValue();
			}
			return b;
		}
		catch (Exception e)
		{
			return null;
		}
	}
	
	/**
	 * 将二进制转换成图片保存
	 * 
	 * @param imgStr
	 *            二进制流转换的字符串
	 * @param imgPath
	 *            图片的保存路径
	 * @param imgName
	 *            图片的名称
	 * @return 1：保存正常 0：保存失败
	 */
	public static int saveToImgByBytes(File imgFile, String imgPath, String imgName)
	{
		
		int stateInt = 1;
		if (imgFile.length() > 0)
		{
			try
			{
				File savedir = new File(imgPath);
				if (!savedir.exists())
				{
					savedir.mkdirs();
				}
				File file = new File(imgPath, imgName);// 可以是任何图片格式.jpg,.png等
				FileOutputStream fos = new FileOutputStream(file);
				
				FileInputStream fis = new FileInputStream(imgFile);
				
				byte[] b = new byte[1024];
				int nRead = 0;
				while ((nRead = fis.read(b)) != -1)
				{
					fos.write(b, 0, nRead);
				}
				fos.flush();
				fos.close();
				fis.close();
				
			}
			catch (Exception e)
			{
				stateInt = 0;
				e.printStackTrace();
			}
			finally
			{
			}
		}
		return stateInt;
	}
	
	/**
	 * 将图片转换成字符串
	 * 
	 * @param imgPath
	 * @param imgName
	 * @return
	 */
	public static String saveToStrByImg(File file)
	{
		String result = "";
		try
		{
			byte[] by = saveToBytesByImg(file);
			result = byte2hex(by);
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 将图片转换成二进制
	 * 
	 * @param imgPath
	 * @param imgName
	 * @return
	 */
	public static byte[] saveToBytesByImg(File file)
	{
		byte[] by = null;
		try
		{
			FileInputStream fis = new FileInputStream(file);
			BufferedInputStream bis = new BufferedInputStream(fis);
			by = new byte[fis.available()];
			bis.read(by);
			fis.close();
			bis.close();
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		return by;
	}
	
	/**
	 * 二进制转字符串
	 * 
	 * @param b
	 * @return
	 */
	public static String byte2hex(byte[] b)
	{
		StringBuffer sb = new StringBuffer();
		String stmp = "";
		for (int n = 0; n < b.length; n++)
		{
			stmp = Integer.toHexString(b[n] & 0XFF);
			if (stmp.length() == 1)
			{
				sb.append("0" + stmp);
			}
			else
			{
				sb.append(stmp);
			}
			
		}
		return sb.toString();
	}
	
	public static String getRandomNum(int length)
	{
		try
		{
			if (length <= 0)
			{
				return "";
			}
			Random r = new Random();
			StringBuffer result = new StringBuffer();
			for (int i = 0; i < length; i++)
			{
				result.append(Integer.toString(r.nextInt(10)));
			}
			return result.toString();
		}
		catch (Exception ex)
		{
			ex.printStackTrace();
			return null;
		}
	}
	public static String getResultCodeMsg(String code){
		String msg="成功";
		if("88".equals( code )){
			
		}else if("01".equals( code )){
			msg="开户类型错误";
		}else if("02".equals( code )){
			msg="手机号错误";
		}else if("03".equals( code )){
			msg="邮箱错误";
		}else if("04".equals( code )){
			msg="真实姓名错误";
		}else if("05".equals( code )){
			msg="身份证号错误";
		}else if("06".equals( code )){
			msg="身份证图片错误";
		}else if("07".equals( code )){
			msg="平台乾多多标识错误";
		}else if("08".equals( code )){
			msg="签名验证失败";
		}else if("09".equals( code )){
			msg="手机和邮箱已存在";
		}else if("10".equals( code )){
			msg="邮箱已存在";
		}else if("11".equals( code )){
			msg="手机已存在";
		}else if("12".equals( code )){
			msg="登录密码错误";
		}else if("13".equals( code )){
			msg="支付密码错误";
		}else if("14".equals( code )){
			msg="安保问题错误";
		}else if("15".equals( code )){
			msg="用户网贷平台账号错误";
		}else if("16".equals( code )){
			msg="网贷平台账号已绑定";
		}else if("17".equals( code )){
			msg="随机时间戳错误";
		}else if("18".equals( code )){
			msg="自定义备注错误";
		}else if("19".equals( code )){
			msg="乾多多账号被禁用";
		}else if("20".equals( code )){
			msg="乾多多账号未激活";
		}else if("21".equals( code )){
			msg="暂无";
		}else if("22".equals( code )){
			msg="手机或邮箱验证码输入错误";
		}else if("23".equals( code )){
			msg="提交的身份信息与乾多多的信息不符";
		}else if("24".equals( code )){
			msg="绑定的乾多多账号为平台账号";
		}else if("25".equals( code )){
			msg="乾多多账号已绑定别的平台";
		}else if("26".equals( code )){
			msg="密码、手机或邮箱验证码、安保问题错误次数过多，锁定中";
		}else if("27".equals( code )){
			msg="账户类型错误";
		}else if("28".equals( code )){
			msg="网贷平台账号已绑定，相同网贷平台账号提交过至少两次不同身份信息";
		}else if("29".equals( code )){
			msg="乾多多账号已被平台其他用户绑定";
		}else if("30".equals( code )){
			msg="平台自有账户余额不足";
		}else if("31".equals( code )){
			msg="身份信息认证失败";
		}
		return msg;
	}
	
	/**
     * 将Json对象转换成Map
     * 
     * @param jsonObject
     *            json对象
     * @return Map对象
     * @throws JSONException
     */
    public static Map<String,Object> toMap(String jsonString) throws JSONException {

        JSONObject jsonObject = new JSONObject(jsonString);
        
        Map<String,Object> result = new HashMap<String,Object>();
        Iterator iterator = jsonObject.keys();
        String key = null;
        String value = null;
        
        while (iterator.hasNext()) {

            key = (String) iterator.next();
            value = jsonObject.getString(key);
            result.put(key, value);

        }
        return result;

    }
}
