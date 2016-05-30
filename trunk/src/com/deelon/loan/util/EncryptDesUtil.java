package com.deelon.loan.util;

import java.security.Key;
import java.security.SecureRandom;
import java.security.spec.AlgorithmParameterSpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.fr.util.Base64;

/**
 * 国政通身份认证接口加密解密算法工具类
 * @author zhangjianjun
 *
 */
public class EncryptDesUtil {
    public static final String ALGORITHM_DES = "DES/CBC/PKCS5Padding";
    private static Log log = LogFactory.getLog(EncryptDesUtil.class);

    /**
     * DES算法，加密
     *
     * @param data 待加密字符串
     * @param key  加密私钥，长度不能够小于8位
     * @return 加密后的字节数组，一般结合Base64编码使用
     * @throws CryptException 异常
     */
    public static String encode(String key,String data) throws Exception
    {
        return encode(key, data.getBytes("GB18030"));
    }
    /**
     * DES算法，加密
     *
     * @param data 待加密字符串
     * @param key  加密私钥，长度不能够小于8位
     * @return 加密后的字节数组，一般结合Base64编码使用
     * @throws CryptException 异常
     */
    public static String encode(String key,byte[] data) throws Exception
    {
        try
        {
	    	DESKeySpec dks = new DESKeySpec(key.getBytes());
	    	
	    	SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            //key的长度不能够小于8位字节
            Key secretKey = keyFactory.generateSecret(dks);
            Cipher cipher = Cipher.getInstance(ALGORITHM_DES);
            IvParameterSpec iv = new IvParameterSpec("12345678".getBytes());
            AlgorithmParameterSpec paramSpec = iv;
            cipher.init(Cipher.ENCRYPT_MODE, secretKey,paramSpec);
            
            byte[] bytes = cipher.doFinal(data);
            return Base64.encode(bytes);
        } catch (Exception e)
        {
            throw new Exception(e);
        }
    }

    /**
     * DES算法，解密
     *
     * @param data 待解密字符串
     * @param key  解密私钥，长度不能够小于8位
     * @return 解密后的字节数组
     * @throws Exception 异常
     */
    public static byte[] decode(String key,byte[] data) throws Exception
    {
        try
        {
        	SecureRandom sr = new SecureRandom();
	    	DESKeySpec dks = new DESKeySpec(key.getBytes());
	    	SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            //key的长度不能够小于8位字节
            Key secretKey = keyFactory.generateSecret(dks);
            Cipher cipher = Cipher.getInstance(ALGORITHM_DES);
            IvParameterSpec iv = new IvParameterSpec("12345678".getBytes());
            AlgorithmParameterSpec paramSpec = iv;
            cipher.init(Cipher.DECRYPT_MODE, secretKey,paramSpec);
            return cipher.doFinal(data);
        } catch (Exception e)
        {
            throw new Exception(e);
        }
    }
    
    /**
     * 获取编码后的值
     * @param key
     * @param data
     * @return
     * @throws Exception
     */
    public static String decodeValue(String key,String data) 
    {
    	byte[] datas;
    	String value = null;
		try {
			if(System.getProperty("os.name") != null && (System.getProperty("os.name").equalsIgnoreCase("sunos") || System.getProperty("os.name").equalsIgnoreCase("linux")))
	        {
	    		log.debug("os.name(true)=" + System.getProperty("os.name"));
	    		datas = decode(key, Base64.decode(data));
	    		log.debug("ddd=" + new String(datas));
	        }
	    	else
	    	{
	    		log.debug("os.name(false)=" + System.getProperty("os.name"));
	    		datas = decode(key, Base64.decode(data));
	    		log.debug("ddd=" + new String(datas,"GB18030"));
	    	}
			
			value = new String(datas,"GB18030");
		} catch (Exception e) {
			e.printStackTrace();
			log.warn("解密失败");
			value = "";
		}
    	return value;
    }

    public static void main(String[] args) throws Exception
    {
      //System.out.println("明：abc ；密：" + Des2.encode("12345678","abc"));
  	 // System.out.println("明：ABC ；密：" + Des2.encode("12345678","ABC"));
  	 // //System.out.println("明：中国人 ；密：" + Des2.encode("12345678","中国人"));
  	 //明：中国人 ；密： qMeKyoDWvsE=
    	//明：在那遥远的地方 ；密： 6rtTnrF34mPkJ5SO3RiaaQ==
  	  System.out.println("加密：" + EncryptDesUtil.encode("12345678", new String("gzdlweb")));
  	  System.out.println("解密:" + EncryptDesUtil.decodeValue("12345678", "7z6RngQQ3Aw="));
    }
}
