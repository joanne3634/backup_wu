package com.deelon.loan.util;

import java.io.StringWriter;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.jfree.util.Log;

import com.deelon.loan.model.sysManager.XmlData;
import com.deelon.loan.model.sysManager.XmlMessage;
import com.deelon.loan.model.sysManager.XmlPoliceCheckInfo;
import com.deelon.loan.model.sysManager.XmlPoliceCheckInfos;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.StaxDriver;
import com.thoughtworks.xstream.io.xml.StaxWriter;
import com.thoughtworks.xstream.mapper.MapperWrapper;
/**
 * XML解析工具类
 * @author zhangjianjun
 * @version 1.0
 */
public abstract class XmlBeanUtils {
	private static String opDetail = "<opDetail>";
	private static String opDetailTail = "</opDetail>";
	private static String recordInfo = "<recordInfo>";
	private static String recordInfoTail = "</recordInfo>";
	private static String fieldInfo = "<fieldInfo>";
	private static String fieldInfoTail = "</fieldInfo>";
	private static String fieldEnName = "<fieldEnName>";
	private static String fieldEnNameTail = "</fieldEnName>";
	private static String fieldContent = "<fieldContent>";
	private static String fieldContentTail = "</fieldContent>";
	private static String fieldContentEmpty = "<fieldContent/>";
	
	/**
	 * 将javabean对象转换为xml字符串
	 * 
	 * @param obj
	 *            javabean对象
	 * @return
	 */
	public static String getXml(Object obj) {
		String xml = null;
		XStream xstream = new XStream(new DomDriver());
		xstream.alias(obj.getClass().getSimpleName(), obj.getClass());
		xml = xstream.toXML(obj);
		return xml;
	}

	/**
	 * 将javabean对象转换为xml字符串
	 * 
	 * @param obj
	 *            javabean对象
	 * @return
	 */
	public static String getXml(Object obj, String mainTypeAlias) {
		String xml = null;
		XStream xstream = new XStream(new DomDriver());
		xstream.alias(mainTypeAlias, obj.getClass());
		xml = xstream.toXML(obj);
		return xml;
	}
	/**
	 * 将javabean对象转换为xml字符串
	 * @param obj  对象
	 * @param classes 注解类型
	 * @return
	 */
	public static String getXmlByAnnotations(Object obj, Class[] classes) throws Exception{
		String xml = null;
		try {
			StaxDriver drv = new StaxDriver();
			XStream xstream = new XStream(drv);
			xstream.autodetectAnnotations(true);
			xstream.processAnnotations(classes);
			StringWriter strWriter = new StringWriter();
			StaxWriter sw = new StaxWriter(drv.getQnameMap(), drv.getOutputFactory().createXMLStreamWriter(strWriter),
			   false, // don't do startDocument
			   true); // do repair namespaces
			xstream.marshal(obj, sw);
			sw.close();
			xml = strWriter.toString();
		} catch (Exception e) {
			throw e;
		}
		return xml;
	}
	
	


	/**
	 * 将xml文件转化为javabean
	 * 
	 * @param xml
	 *            字符串形式的xml文档
	 * @param type
	 *            javabean的类型
	 * @return
	 */
	public static <T extends Object> T getBean(String xml, Class<T> type) {
		Object obj = null;
		XStream xstream = new XStream(new DomDriver()){
			@Override
			protected MapperWrapper wrapMapper(MapperWrapper next) {
				return new MapperWrapper(next) {
					@Override
					public boolean shouldSerializeMember(Class definedIn,
							String fieldName) {
						if (definedIn == Object.class) {
							try {
								return this.realClass(fieldName) != null;
							} catch (Exception e) {
								Log.warn(definedIn + " 不存在字段：" + fieldName);
								return false;
							}
						} else {
							return super.shouldSerializeMember(definedIn,
									fieldName);
						}
					}
				};
			}
		};
		xstream.alias(type.getSimpleName(), type);
		obj = xstream.fromXML(xml);
		return type.cast(obj);
	}
	
	/**
	 * 通过注解 将xml 转换成javaBean 如果xml属性比java bean的多，则会忽略
	 * @param xml
	 * @param type
	 * @param classes
	 * @return
	 */
	public static <T extends Object> T getBeanByAnnotations(String xml,
			Class<T> type, Class[] classes) {
		Object obj = null;
		// XStream xstream = new XStream(new StaxDriver());//如果xml属性比java
		// bean的多，则会出异常
		XStream xstream = new XStream(new StaxDriver()) {// 如果xml属性比java
															// bean的多，则会忽略
			@Override
			protected MapperWrapper wrapMapper(MapperWrapper next) {
				return new MapperWrapper(next) {
					@Override
					public boolean shouldSerializeMember(Class definedIn,
							String fieldName) {
						if (definedIn == Object.class) {
							try {
								return this.realClass(fieldName) != null;
							} catch (Exception e) {
								Log.warn(definedIn + " 不存在字段：" + fieldName);
								return false;
							}
						} else {
							return super.shouldSerializeMember(definedIn,
									fieldName);
						}
					}
				};
			}
		};
		xstream.autodetectAnnotations(true);
		xstream.processAnnotations(classes);
		// xstream.registerConverter(new MyConverter(xstream.getMapper(),
		// xstream.getReflectionProvider()), 999);
		// System.out.println(xstream.getConverterLookup().lookupConverterForType(type));
		obj = xstream.fromXML(xml);
		return type.cast(obj);
	}
	
	/**
	 * 将xml文件转化为javabean
	 * 
	 * @param xml
	 *            字符串形式的xml文档
	 * @param type
	 *            javabean的类型
	 * @param typeAlias
	 *            javabean的类型的别名
	 * @return
	 */
	public static <T extends Object> T getBean(String xml, Class<T> type, String typeAlias) {
		Object obj = null;
		XStream xstream = new XStream(new DomDriver()){
			@Override
			protected MapperWrapper wrapMapper(MapperWrapper next) {
				return new MapperWrapper(next) {
					@Override
					public boolean shouldSerializeMember(Class definedIn,
							String fieldName) {
						if (definedIn == Object.class) {
							try {
								return this.realClass(fieldName) != null;
							} catch (Exception e) {
								Log.warn(definedIn + " 不存在字段：" + fieldName);
								return false;
							}
						} else {
							return super.shouldSerializeMember(definedIn,
									fieldName);
						}
					}
				};
			}
		};
		xstream.alias(typeAlias, type);
		obj = xstream.fromXML(xml);
		return type.cast(obj);
	}
     /**
      * 通过正则表达式将xml节点名称统一转换成小写
      * @param xmlStr
      * @return
      */
	 public static String getXmlNodeToLowerCase(String xmlStr) {
        Pattern pattern = Pattern.compile("<.+?>");
        StringBuilder res = new StringBuilder();
        int lastIdx = 0;
        Matcher matchr = pattern.matcher(xmlStr);
        while (matchr.find()) {
            String str = matchr.group();
            res.append(xmlStr.substring(lastIdx, matchr.start()));
            res.append(str.toLowerCase());
            lastIdx = matchr.end();
        }
        res.append(xmlStr.substring(lastIdx));
        return res.toString();
    }   
	
	 
	/**
	 * 设定bean中集合内子元素的别名
	 * 
	 * @param aliasName
	 *            别名
	 * @param type
	 *            子元素的类型
	 */
	public static void setSubElementAlias(String aliasName, Class type) {
		XStream xstream = new XStream(new DomDriver());
		xstream.alias(aliasName, type);
	}


	public static List xmlStringToBean(String xml, Class type) {		
		int recordInfoIndex = 0;
		int recordInfoTailIndex = 0;
		int fieldInfoIndex = 0;
		int fieldInfoTailIndex = 0;
		int fieldEnNameIndex = 0;
		int fieldEnNameTailIndex = 0;
		int fieldContentIndex = 0;
		int fieldContentTailIndex = 0;
		int fieldContentEmptyIndex = 0;
		
		List<Object> listreturn = new ArrayList();
		try {
			//文件尾
			int end = xml.indexOf(opDetailTail);
			//找到每一对<recordInfo></recordInfo>，这是一条记录的标识
			while ((recordInfoIndex != -1) && (recordInfoTailIndex != -1)) {
				recordInfoIndex = xml.indexOf(recordInfo, recordInfoIndex);
				recordInfoTailIndex = xml.indexOf(recordInfoTail, recordInfoTailIndex);
				
				Object obj = type.newInstance();
				
				//找到每一对<fieldInfo></fieldInfo>，这是某一条记录的某一个属性的标识
				fieldInfoIndex = recordInfoIndex;
				fieldInfoTailIndex = recordInfoIndex;
				while ((fieldInfoIndex != -1) && (fieldInfoTailIndex != -1)) {
					fieldInfoIndex = xml.indexOf(fieldInfo, fieldInfoIndex);
					fieldInfoTailIndex = xml.indexOf(fieldInfoTail, fieldInfoTailIndex);
					
					if ((fieldInfoIndex < recordInfoTailIndex)
							&& (fieldInfoIndex != -1) && (fieldInfoTailIndex != -1)) {
						fieldEnNameIndex = fieldInfoIndex;
						fieldEnNameTailIndex = fieldInfoIndex;
						while ((fieldInfoIndex != -1) && (fieldInfoTailIndex != -1)) {
							
							fieldEnNameIndex = xml.indexOf(fieldEnName, fieldEnNameIndex);
							//System.out.println("fieldEnNameTailIndex " + fieldEnNameTailIndex );
							fieldEnNameTailIndex = xml.indexOf(fieldEnNameTail, fieldEnNameTailIndex);
							if ((fieldEnNameIndex < fieldInfoTailIndex)
									&& (fieldEnNameIndex != -1) && (fieldEnNameTailIndex != -1)){
								String fieldEnNameValue = xml.substring(fieldEnNameIndex 
										+ fieldEnName.length(), fieldEnNameTailIndex);
								if (!StringUtils.isBlank(fieldEnNameValue)) {
									
									fieldContentIndex = fieldEnNameIndex;
									fieldContentTailIndex = fieldEnNameIndex;
									fieldContentIndex = xml.indexOf(fieldContent, fieldContentIndex);
									fieldContentTailIndex = xml.indexOf(fieldContentTail, fieldContentTailIndex);
									fieldContentEmptyIndex = xml.indexOf(fieldContentEmpty, fieldContentIndex);
									if (fieldContentEmptyIndex != -1) {
										fieldContentEmptyIndex += fieldContentEmpty.length();
										fieldContentIndex += fieldContentEmpty.length();
										fieldContentTailIndex += fieldContentEmpty.length();
									} else {
										String fieldContentValue = xml.substring(fieldContentIndex 
												+ fieldContent.length(), fieldContentTailIndex);
										if (!StringUtils.isBlank(fieldContentValue)) {
											Field field = obj.getClass().getDeclaredField(fieldEnNameValue);
											String type1 = field.getType().toString();
											//如果该属性是Date类型
											if (field.getType().toString().contains("Date")) {
												SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
												Date date = sdf.parse(fieldContentValue);
												//因为是private属性，因此需要设置访问权限
												field.setAccessible(true);
												field.set(obj, date);
												field.setAccessible(false);
											} else {										
												//因为是private属性，因此需要设置访问权限
												field.setAccessible(true);
												field.set(obj, fieldContentValue);
												field.setAccessible(false);
											}
										}
										fieldContentIndex += fieldContentValue.length();
										fieldContentTailIndex += fieldContentValue.length();
									}
								}
								fieldEnNameIndex += fieldEnName.length();
								fieldEnNameTailIndex += fieldEnNameTail.length();
							} else {
								break;
							}
						}
						fieldInfoIndex += fieldInfo.length();
						fieldInfoTailIndex += fieldInfoTail.length();						
					} else {
						break;
					}
				}
				
				if ((recordInfoIndex == -1) || (recordInfoTailIndex == -1)
						|| (recordInfoTailIndex == end)) {
					break;
				}
				recordInfoIndex += recordInfo.length();
				recordInfoTailIndex += recordInfoTail.length();
				
				listreturn.add(obj);				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (listreturn.size() > 0) {
			return listreturn;
		} else {
			return null;
		}
	}
	
	public static void main(String[] args) {
		String result = "<data><message><status>0</status><value>处理成功</value></message><policeCheckInfos><policeCheckInfo name=\"刘静静11\" id=\"110107197111011528111\"><message><status>0</status><value>处理成功</value></message><name desc=\"姓名 \">刘静静11</name><identitycard desc=\"身份证号\">110107197111011528111</identitycard><compStatus desc=\"比对状态\">3</compStatus><compResult desc=\"比对结果\">一致</compResult></policeCheckInfo></policeCheckInfos><policeCheckInfos><policeCheckInfo name=\"刘静静\" id=\"110107197111011528\"><message><status>0</status><value>处理成功</value></message><name desc=\"姓名 \">刘静静</name><identitycard desc=\"身份证号\">110107197111011528</identitycard><compStatus desc=\"比对状态\">2</compStatus><compResult desc=\"比对结果\">不一致</compResult></policeCheckInfo></policeCheckInfos></data>";
		XmlData data = XmlBeanUtils.getBeanByAnnotations(result, XmlData.class,  new Class[]{XmlPoliceCheckInfo.class,XmlData.class});
		List<XmlPoliceCheckInfos>  policeCheckInfosList;
		if(data != null && data.getPoliceCheckInfos() != null){
			XmlMessage message = data.getMessage();
			System.out.println("status==="+message.getStatus()+"----value==="+message.getValue());
			policeCheckInfosList = data.getPoliceCheckInfos();
			if(null != policeCheckInfosList && policeCheckInfosList.size() > 0){
				for(XmlPoliceCheckInfos obj:policeCheckInfosList){
					XmlPoliceCheckInfo policeCheckInfo = obj.getPoliceCheckInfo();
					if(policeCheckInfo != null)
					    System.out.println(policeCheckInfo.getName()+"---"+policeCheckInfo.getIdentitycard()+"--"+policeCheckInfo.getCompStatus()+"---"+policeCheckInfo.getCompResult());
				}
			}
		}
	}
}
