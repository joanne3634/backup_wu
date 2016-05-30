package com.deelon.loan.other;

import java.util.Map;

public interface IInfoTemplateGenerator {
	/**
	 * 根据模板及参数生成信息
	 * param:tinfoTemplatId 信息模板ID
	 * param:params 参数替换值
	 * return: String 数组，长度为2，index_0为信息标题，index_1为信息内容
	 */
	public String[] generate(Long tinfoTemplatId,Map<String,Object> params);
}
