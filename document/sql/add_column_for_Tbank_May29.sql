/*
银行列表增加一个字段，区分记录是否支持机构付款
Date: 2015-05-18 
*/
ALTER TABLE t_bank ADD COLUMN IS_Company_Pay INT(5) DEFAULT 0 COMMENT "是否开通了企业网银支付"