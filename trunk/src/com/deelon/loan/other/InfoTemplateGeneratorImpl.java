package com.deelon.loan.other;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import com.deelon.core.util.StringUtil;
import com.deelon.loan.model.sysManager.Tinfotemplat;
import com.deelon.loan.service.sysManager.TinfotemplatService;

public class InfoTemplateGeneratorImpl implements IInfoTemplateGenerator {
	private TinfotemplatService tinfotemplatService = new TinfotemplatService();
	public static final int TYPE_HEADER = 1;
	public static final int TYPE_MESSAGE = 2;
	
	/**
	 * 根据模板及参数生成信息
	 * param:tinfoTemplatId 信息模板ID
	 * param:params 参数替换值
	 * return: String 数组，长度为2，index_0为信息标题，index_1为信息内容
	 */
	public String[] generate(Long tinfoTemplatId, Map<String, Object> params) {
		// TODO Auto-generated method stub
		Tinfotemplat tinfotemplat = tinfotemplatService.getById(tinfoTemplatId);
		if(tinfotemplat == null){
			throw new RuntimeException("找不到ID为"+tinfoTemplatId+"的信息模板");
		}
		String header = tinfotemplat.getHeader();
		String message = tinfotemplat.getMessasge();
		String[] result = new String[2];

		if(params == null){
			params = new HashMap<String, Object>();
		}
		Iterator<Entry<String, Object>> iterator = params.entrySet().iterator();
		if(StringUtil.isNotEmpty(message)){
			while(iterator.hasNext()){
				Entry<String, Object> entry = iterator.next();
				String key = entry.getKey();
				String value = entry.getValue()==null ? "":entry.getValue().toString();
				key = "\\{"+key+"\\}";
				message = message.replaceAll(key, value);
			}
		}
		if(StringUtil.isNotEmpty(header)){
			iterator = params.entrySet().iterator();
			while(iterator.hasNext()){
				Entry<String, Object> entry = iterator.next();
				String key = entry.getKey();
				String value = entry.getValue()==null ? "":entry.getValue().toString();
				key = "\\{"+key+"\\}";
				header = header.replaceAll(key, value);
			}
		}
		result[0] = header;
		result[1] = message;
		return result;
	}

}
