/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */

package com.deelon.crowdfunding.model.backstage;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;
import com.deelon.core.util.StringUtil;
import com.deelon.platform.util.SysFileHelper;

public class Tcproject extends BaseModel {

	

	// alias
	public static final String TABLE_ALIAS = "Tcproject";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_PNAME = "项目名称";
	public static final String ALIAS_PSTATE_ID = "项目状态ID";
	public static final String ALIAS_PVIEW_LIMIT = "项目星期资料查看权限";
	public static final String ALIAS_PTYPE_ID = "项目类别：1科技创新、2实体经营、3地产投资";
	public static final String ALIAS_PINDUSTRY = "项目所属行业";
	public static final String ALIAS_PCITY_ID = "企业所在城市";
	public static final String ALIAS_PPROVINCES_ID = "企业所在省份";
	public static final String ALIAS_PFOUNDED_YEAR = "企业成立年份";
	public static final String ALIAS_PFOUNDED_MONTH = "企业成立月份";
	public static final String ALIAS_PLABEL = "项目标签";
	public static final String ALIAS_PSTAGE = "项目所属阶段";
	public static final String ALIAS_PIS_HAVE_OTHER = "是否有其他项目";
	public static final String ALIAS_PCOMPANY_NAME = "公司名称";
	public static final String ALIAS_PADDRESS = "公司地址";
	public static final String ALIAS_PDETAIL = "企业项目简介";

	public static final String ALIAS_PFINANCING_AMOUNT = "融资金额（万元）";
	public static final String ALIAS_PINVEST_AMOUNT = "认投金额（万元）";
	public static final String ALIAS_PCOMPLETE = "完成比例%";
	public static final String ALIAS_PPAY_WAY = "投资款拨付方式";
	public static final String ALIAS_PSETUP = "公司是否成立";
	public static final String ALIAS_PVIEW_COUNT = "浏览次数";
	public static final String ALIAS_PFAVORITES_COUNT = "被收藏次数";
	public static final String ALIAS_PINVEST_COUNT = "跟投人数";
	public static final String ALIAS_PASK_PRICE_COUNT = "询价人数";
	public static final String ALIAS_PPIC = "项目图片";
	public static final String ALIAS_PVIDEO = "项目视频";
	public static final String ALIAS_POPEN_DATE = "开标时间";
	public static final String ALIAS_PCLOSE_DATE = "结束时间";
	public static final String ALIAS_PIS_RECOMMENDED = "是否推荐项目";
	public static final String ALIAS_POPEN_DAYS = "开标天数";
	public static final String ALIAS_PINVEST_MAX = "最低投资金额（万元）";
	public static final String ALIAS_PINVEST_MIN = "最大投资金额（万元）";
	public static final String ALIAS_CREATOR = "创建人";
	public static final String ALIAS_CREATE_TIME = "创建时间";
	public static final String ALIAS_IS_DEL = "是否删除";
	public static final String ALIAS_PIS_FULL = "是否满标";
	public static final String ALIAS_PFULL_TIME = "满标时间";
	public static final String ALIAS_PIS_CHECK = "审核是否通过（平台）";
	public static final String ALIAS_PCHECKER = "审核人";
	public static final String ALIAS_PCHECK_TIME = "审核时间";
	public static final String ALIAS_PIS_PAY = "是否放款";
	public static final String ALIAS_PPAY_TIME = "放款时间";
	public static final String ALIAS_PDEAL_RATE = "交易费比例";
	public static final String ALIAS_PDEAL_FEES = "交易费（元）";
	public static final String ALIAS_PFINAL_GET_PAY = "贷款人最后取得金额（扣除各种费用后）（元）";
	public static final String ALIAS_PIS_BREAK = "是否流标";
	public static final String ALIAS_PBREAK_TIME = "流标时间";
	public static final String ALIAS_PBREAK_REMARK = "流标说明";
	public static final String ALIAS_PCHECK_REMARK = "审核说明(台平)";
	public static final String ALIAS_PCHECK_TIMES = "审核次数(平台)";
	public static final String ALIAS_PHAVED_PAY = "已放款金额";
	public static final String ALIAS_PPAY_PERCENT = "已放款比例%";
	public static final String ALIAS_PCITY_INAME = "城市名称";
	public static final String ALIAS_PPROVINCES_NAME = "省份名称";
	public static final String ALIAS_P_PAYER = "放款人";
	// 可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	// columns START
	private java.lang.Long projectId;
	private java.lang.String pname;
	private java.lang.String pstateId;
	private Integer pviewLimit;
	private java.lang.String ptypeId;
	private java.lang.String pindustry;
	private java.lang.Long pcityId;
	private java.lang.Long pprovincesId;
	private java.lang.Integer pfoundedYear;
	private java.lang.Integer pfoundedMonth;
	private java.lang.String plabel;
	private java.lang.String pstage;
	private Integer pisHaveOther;
	private java.lang.String pcompanyName;
	private java.lang.String paddress;
	private java.lang.String pdetail;
	private BigDecimal pfinancingAmount;
	private BigDecimal pinvestAmount;
	private java.lang.Integer pcomplete;
	private java.lang.String ppayWay;
	private Integer psetup;
	private java.lang.Integer pviewCount;
	private java.lang.Integer pfavoritesCount;
	private java.lang.Integer pinvestCount;
	private java.lang.Integer paskPriceCount;
	private java.lang.String ppic;
	private java.lang.String pvideo;
	private java.util.Date popenDate;
	private java.util.Date pcloseDate;
	private Integer pisRecommended;
	private java.lang.Integer popenDays;
	private Long pinvestMax;
	private Long pinvestMin;
	private java.lang.Long creator;
	private java.util.Date createTime;
	private Integer isDel;
	private Integer pisFull;
	private java.util.Date pfullTime;
	private Integer pisCheck;
	private java.lang.Long pchecker;
	private java.util.Date pcheckTime;
	private Integer pisPay;
	private java.util.Date ppayTime;
	private Float pdealRate;
	private Double pdealFees;
	private Double pfinalGetPay;
	private Integer pisBreak;
	private java.util.Date pbreakTime;
	private java.lang.String pbreakRemark;
	private java.lang.String pcheckRemark;
	private Integer pcheckTimes;
	private Long phavedPay;
	private java.lang.Integer ppayPercent;
	private java.lang.String pcityIname;
	private java.lang.String pprovincesName;
	private int pcurrent;
	private Long pleaderId;// 领投人ID P_LeaderID
	private BigDecimal psharesPercent;// P_SharesPercent
	private BigDecimal pinvestMinLeader;// P_InvestMinLeader 最低领头金额
	private BigDecimal pinvestMaxLeader;//最高领投金额
	private BigDecimal pinvestMinFollow;// P_InvestMinFollow 最低跟投金额
	private String fileId;// 创业者照片id
	private int pemployeesCount;
	private Date updateTime;
	private int pPayer;// 放款人,等同于投资人
	private BigDecimal pvaluationFinal;//项目最终估值
	private Timestamp precommendedTime;
	private BigDecimal pvaluationFinalNew;//运营平台人员对创业者项目的重新估值
	private String projectAddress;//项目地址
	// columns END
	// 非持久化
	private java.lang.Long contractId;//项目合同记录id
	private java.lang.Long investId;
	private java.lang.Long attentionId;
	private java.lang.Long msgRemindId;
	private String linkedAction;
	private String createTimestr;

	private String auditTimestr;
	private String realName;
	private String auditName;
	private String leaderName;
	private String loginName;
	private String leaderLoginName;

	private String popenDateStr;
	private String pcloseDateStr;
	private String pcompleateStr;
	private String pstatus;
	private String pupdateTimestr;
	private String yearmonth;

	private String updateTimeStr;
	private String pfullTimeStr;
	
	private Date sendTime;
	
	private int agreeLead;
	private int allLead;
	private int agreeFollow;
	private int allFollow;
	private int agreeView;
	private int allView;
	private String myPhoto;//用户图片路径
	private BigDecimal pivaluation;//項目估值金额
	private Integer piisPay;//项目是否付款
	private Integer piisCheck;//审核状态
	
	private BigDecimal leaderAmount;//领投金额
	private BigDecimal followAmount;//跟投金额
	private BigDecimal myleaderAmount;//我的领投金额
	private BigDecimal myfollowAmount;//我的跟投
	private BigDecimal piinvest;//
	// columns END
	private int aboutNum;//被约谈的次数
	private int piTypeId;
	private String piCancelReason;//被取消的理由
	private String pidenyReason;//被拒绝的理由
	private BigDecimal sumleaderPivaluation;//总的领投的项目估值
	private BigDecimal sumlfollowPivaluation;//总的跟投的项目估值
	private BigDecimal sumPivaluation;//总的项目估值
	
	private String  setValue;//设置项值
	private String piisAskPrice;//是否询价
	private BigDecimal singleMinAmount;//单投资人最低出资金融
	private int lastDays;//众筹的剩余天数
	
	public String getSetValue() {
		return setValue;
	}

	public void setSetValue(String setValue) {
		this.setValue = setValue;
	}

	public String getPidenyReason() {
		return pidenyReason;
	}

	public void setPidenyReason(String pidenyReason) {
		this.pidenyReason = pidenyReason;
	}

	public Integer getPiisPay() {
		return piisPay;
	}

	public void setPiisPay(Integer piisPay) {
		this.piisPay = piisPay;
	}

	public Integer getPiisCheck() {
		return piisCheck;
	}

	public void setPiisCheck(Integer piisCheck) {
		this.piisCheck = piisCheck;
	}

	public BigDecimal getPivaluation() {
		return pivaluation;
	}

	public void setPivaluation(BigDecimal pivaluation) {
		this.pivaluation = pivaluation;
	}

	
	public java.lang.Long getContractId() {
		return contractId;
	}

	public void setContractId(java.lang.Long contractId) {
		this.contractId = contractId;
	}

	public java.lang.Long getMsgRemindId() {
		return msgRemindId;
	}

	public void setMsgRemindId(java.lang.Long msgRemindId) {
		this.msgRemindId = msgRemindId;
	}
	
	public int getpPayer() {
		return pPayer;
	}

	public void setpPayer(int pPayer) {
		this.pPayer = pPayer;
	}

	public java.lang.Long getInvestId() {
		return investId;
	}

	public void setInvestId(java.lang.Long investId) {
		this.investId = investId;
	}

	public Long getPleaderId() {
		return pleaderId;
	}

	public void setPleaderId(Long pleaderId) {
		this.pleaderId = pleaderId;
	}

	public BigDecimal getPsharesPercent() {
		return psharesPercent;
	}

	public void setPsharesPercent(BigDecimal psharesPercent) {
		this.psharesPercent = psharesPercent;
	}

	public BigDecimal getPinvestMinLeader() {
		return pinvestMinLeader;
	}

	public void setPinvestMinLeader(BigDecimal pinvestMinLeader) {
		this.pinvestMinLeader = pinvestMinLeader;
	}

	public BigDecimal getPinvestMinFollow() {
		return pinvestMinFollow;
	}

	public void setPinvestMinFollow(BigDecimal pinvestMinFollow) {
		this.pinvestMinFollow = pinvestMinFollow;
	}

	public Tcproject() {
	}

	public Tcproject(java.lang.Long projectId) {
		this.projectId = projectId;
	}

	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}

	public java.lang.Long getProjectId() {
		return this.projectId;
	}

	public void setPname(java.lang.String value) {
		this.pname = value;
	}

	public java.lang.String getPname() {
		return this.pname;
	}

	public void setPstateId(java.lang.String value) {
		this.pstateId = value;
	}

	public java.lang.String getPstateId() {
		return this.pstateId;
	}

	public void setPviewLimit(Integer value) {
		this.pviewLimit = value;
	}

	public Integer getPviewLimit() {
		return this.pviewLimit;
	}

	public void setPtypeId(java.lang.String value) {
		this.ptypeId = value;
	}

	public java.lang.String getPtypeId() {
		return this.ptypeId;
	}

	public void setPindustry(java.lang.String value) {
		this.pindustry = value;
	}

	public java.lang.String getPindustry() {
		return this.pindustry;
	}

	public void setPcityId(java.lang.Long value) {
		this.pcityId = value;
	}

	public java.lang.Long getPcityId() {
		return this.pcityId;
	}

	public void setPprovincesId(java.lang.Long value) {
		this.pprovincesId = value;
	}

	public java.lang.Long getPprovincesId() {
		return this.pprovincesId;
	}

	public void setPfoundedYear(java.lang.Integer value) {
		this.pfoundedYear = value;
	}

	public java.lang.Integer getPfoundedYear() {
		return this.pfoundedYear;
	}

	public void setPfoundedMonth(java.lang.Integer value) {
		this.pfoundedMonth = value;
	}

	public java.lang.Integer getPfoundedMonth() {
		return this.pfoundedMonth;
	}

	public void setPlabel(java.lang.String value) {
		this.plabel = value;
	}

	public java.lang.String getPlabel() {
		return this.plabel;
	}

	public void setPstage(java.lang.String value) {
		this.pstage = value;
	}

	public java.lang.String getPstage() {
		return this.pstage;
	}

	public void setPisHaveOther(Integer value) {
		this.pisHaveOther = value;
	}

	public Integer getPisHaveOther() {
		return this.pisHaveOther;
	}

	public void setPcompanyName(java.lang.String value) {
		this.pcompanyName = value;
	}

	public java.lang.String getPcompanyName() {
		return this.pcompanyName;
	}

	public void setPaddress(java.lang.String value) {
		this.paddress = value;
	}

	public java.lang.String getPaddress() {
		return this.paddress;
	}

	public void setPdetail(java.lang.String value) {
		this.pdetail = value;
	}

	public java.lang.String getPdetail() {
		return this.pdetail;
	}

	public void setPfinancingAmount(BigDecimal value) {
		this.pfinancingAmount = value;
	}

	public BigDecimal getPfinancingAmount() {
		return this.pfinancingAmount;
	}

	public void setPinvestAmount(BigDecimal value) {
		this.pinvestAmount = value;
	}

	public BigDecimal getPinvestAmount() {
		return this.pinvestAmount;
	}

	public void setPcomplete(java.lang.Integer value) {
		this.pcomplete = value;
	}

	public java.lang.Integer getPcomplete() {
		return this.pcomplete;
	}

	public void setPpayWay(java.lang.String value) {
		this.ppayWay = value;
	}

	public java.lang.String getPpayWay() {
		return this.ppayWay;
	}

	public void setPsetup(Integer value) {
		this.psetup = value;
	}

	public Integer getPsetup() {
		return this.psetup;
	}

	public void setPviewCount(java.lang.Integer value) {
		this.pviewCount = value;
	}

	public java.lang.Integer getPviewCount() {
		return this.pviewCount;
	}

	public void setPfavoritesCount(java.lang.Integer value) {
		this.pfavoritesCount = value;
	}

	public java.lang.Integer getPfavoritesCount() {
		return this.pfavoritesCount;
	}

	public void setPinvestCount(java.lang.Integer value) {
		this.pinvestCount = value;
	}

	public java.lang.Integer getPinvestCount() {
		return this.pinvestCount;
	}

	public void setPaskPriceCount(java.lang.Integer value) {
		this.paskPriceCount = value;
	}

	public java.lang.Integer getPaskPriceCount() {
		return this.paskPriceCount;
	}

	public void setPpic(java.lang.String value) {
		this.ppic = value;
	}

	public java.lang.String getPpic() {
		if (StringUtil.isNotEmpty(ppic)) {
			SysFileHelper.getByIdsFileInfo( ppic, this );
		}
		return ppic;
	}

	public void setPvideo(java.lang.String value) {
		this.pvideo = value;
	}

	public java.lang.String getPvideo() {
		return this.pvideo;
	}

	public void setPopenDate(java.util.Date value) {
		this.popenDate = value;
	}

	public java.util.Date getPopenDate() {
		return this.popenDate;
	}

	public void setPcloseDate(java.util.Date value) {
		this.pcloseDate = value;
	}

	public java.util.Date getPcloseDate() {
		return this.pcloseDate;
	}

	public void setPisRecommended(Integer value) {
		this.pisRecommended = value;
	}

	public Integer getPisRecommended() {
		return this.pisRecommended;
	}

	public void setPopenDays(java.lang.Integer value) {
		this.popenDays = value;
	}

	public java.lang.Integer getPopenDays() {
		return this.popenDays;
	}

	public void setPinvestMax(Long value) {
		this.pinvestMax = value;
	}

	public Long getPinvestMax() {
		return this.pinvestMax;
	}

	public void setPinvestMin(Long value) {
		this.pinvestMin = value;
	}

	
	public BigDecimal getLeaderAmount() {
		return leaderAmount;
	}

	public void setLeaderAmount(BigDecimal leaderAmount) {
		this.leaderAmount = leaderAmount;
	}

	public BigDecimal getFollowAmount() {
		return followAmount;
	}

	public void setFollowAmount(BigDecimal followAmount) {
		this.followAmount = followAmount;
	}

	public Long getPinvestMin() {
		return this.pinvestMin;
	}

	public void setCreator(java.lang.Long value) {
		this.creator = value;
	}

	public java.lang.Long getCreator() {
		return this.creator;
	}

	public void setCreateTime(java.util.Date value) {
		this.createTime = value;
	}

	public java.util.Date getCreateTime() {
		return this.createTime;
	}

	public void setIsDel(Integer value) {
		this.isDel = value;
	}

	public Integer getIsDel() {
		return this.isDel;
	}

	public void setPisFull(Integer value) {
		this.pisFull = value;
	}

	public Integer getPisFull() {
		return this.pisFull;
	}

	public void setPfullTime(java.util.Date value) {
		this.pfullTime = value;
	}

	public java.util.Date getPfullTime() {
		return this.pfullTime;
	}

	public void setPisCheck(Integer value) {
		this.pisCheck = value;
	}

	public Integer getPisCheck() {
		return this.pisCheck;
	}

	public void setPchecker(java.lang.Long value) {
		this.pchecker = value;
	}

	public java.lang.Long getPchecker() {
		return this.pchecker;
	}

	public void setPcheckTime(java.util.Date value) {
		this.pcheckTime = value;
	}

	public java.util.Date getPcheckTime() {
		return this.pcheckTime;
	}

	public void setPisPay(Integer value) {
		this.pisPay = value;
	}

	public Integer getPisPay() {
		return this.pisPay;
	}

	public void setPpayTime(java.util.Date value) {
		this.ppayTime = value;
	}

	public java.util.Date getPpayTime() {
		return this.ppayTime;
	}

	public void setPdealRate(Float value) {
		this.pdealRate = value;
	}

	public Float getPdealRate() {
		return this.pdealRate;
	}

	public void setPdealFees(Double value) {
		this.pdealFees = value;
	}

	public Double getPdealFees() {
		return this.pdealFees;
	}

	public void setPfinalGetPay(Double value) {
		this.pfinalGetPay = value;
	}

	public Double getPfinalGetPay() {
		return this.pfinalGetPay;
	}

	public void setPisBreak(Integer value) {
		this.pisBreak = value;
	}

	public Integer getPisBreak() {
		return this.pisBreak;
	}

	public void setPbreakTime(java.util.Date value) {
		this.pbreakTime = value;
	}

	public java.util.Date getPbreakTime() {
		return this.pbreakTime;
	}

	public void setPbreakRemark(java.lang.String value) {
		this.pbreakRemark = value;
	}

	public java.lang.String getPbreakRemark() {
		return this.pbreakRemark;
	}

	public void setPcheckRemark(java.lang.String value) {
		this.pcheckRemark = value;
	}

	public java.lang.String getPcheckRemark() {
		return this.pcheckRemark;
	}

	public void setPcheckTimes(Integer value) {
		this.pcheckTimes = value;
	}

	public Integer getPcheckTimes() {
		return this.pcheckTimes;
	}

	public void setPhavedPay(Long value) {
		this.phavedPay = value;
	}

	public Long getPhavedPay() {
		return this.phavedPay;
	}

	public void setPpayPercent(java.lang.Integer value) {
		this.ppayPercent = value;
	}

	public java.lang.Integer getPpayPercent() {
		return this.ppayPercent;
	}

	public void setPcityIname(java.lang.String value) {
		this.pcityIname = value;
	}

	public java.lang.String getPcityIname() {
		return this.pcityIname;
	}

	public void setPprovincesName(java.lang.String value) {
		this.pprovincesName = value;
	}

	public java.lang.String getPprovincesName() {
		return this.pprovincesName;
	}

	public int getPcurrent() {
		return pcurrent;
	}

	public void setPcurrent(int pcurrent) {
		this.pcurrent = pcurrent;
	}

	public String getLinkedAction() {
		return linkedAction;
	}

	public void setLinkedAction(String linkedAction) {
		this.linkedAction = linkedAction;
	}

	public String getCreateTimestr() {
		return createTimestr;
	}

	public void setCreateTimestr(String createTimestr) {
		this.createTimestr = createTimestr;
	}

	public String getAuditTimestr() {
		return auditTimestr;
	}

	public void setAuditTimestr(String auditTimestr) {
		this.auditTimestr = auditTimestr;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getAuditName() {
		return auditName;
	}

	public void setAuditName(String auditName) {
		this.auditName = auditName;
	}

	public String getPopenDateStr() {
		return popenDateStr;
	}

	public void setPopenDateStr(String popenDateStr) {
		this.popenDateStr = popenDateStr;
	}

	public String getPcloseDateStr() {
		return pcloseDateStr;
	}

	public void setPcloseDateStr(String pcloseDateStr) {
		this.pcloseDateStr = pcloseDateStr;
	}

	public String getPcompleateStr() {
		return pcompleateStr;
	}

	public void setPcompleateStr(String pcompleateStr) {
		this.pcompleateStr = pcompleateStr;
	}

	public String getPstatus() {
		return pstatus;
	}

	public void setPstatus(String pstatus) {
		this.pstatus = pstatus;
	}

	public String getPupdateTimestr() {
		return pupdateTimestr;
	}

	public void setPupdateTimestr(String pupdateTimestr) {
		this.pupdateTimestr = pupdateTimestr;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public int getPemployeesCount() {
		return pemployeesCount;
	}

	public void setPemployeesCount(int pemployeesCount) {
		this.pemployeesCount = pemployeesCount;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getYearmonth() {
		return yearmonth;
	}

	public void setYearmonth(String yearmonth) {
		this.yearmonth = yearmonth;
	}

	public String getUpdateTimeStr() {
		return updateTimeStr;
	}

	public void setUpdateTimeStr(String updateTimeStr) {
		this.updateTimeStr = updateTimeStr;
	}

	public String getPfullTimeStr() {
		return pfullTimeStr;
	}

	public void setPfullTimeStr(String pfullTimeStr) {
		this.pfullTimeStr = pfullTimeStr;
	}

	public String getLeaderName() {
		return leaderName;
	}

	public void setLeaderName(String leaderName) {
		this.leaderName = leaderName;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getLeaderLoginName() {
		return leaderLoginName;
	}

	public void setLeaderLoginName(String leaderLoginName) {
		this.leaderLoginName = leaderLoginName;
	}
	
	public java.lang.Long getAttentionId() {
		return attentionId;
	}

	public void setAttentionId(java.lang.Long attentionId) {
		this.attentionId = attentionId;
	}
	
	
	public BigDecimal getPvaluationFinal() {
		return pvaluationFinal;
	}

	public void setPvaluationFinal(BigDecimal pvaluationFinal) {
		this.pvaluationFinal = pvaluationFinal;
	}

	
	public BigDecimal getPinvestMaxLeader() {
		return pinvestMaxLeader;
	}

	public void setPinvestMaxLeader(BigDecimal pinvestMaxLeader) {
		this.pinvestMaxLeader = pinvestMaxLeader;
	}
	

	public int getAgreeLead() {
		return agreeLead;
	}

	public void setAgreeLead(int agreeLead) {
		this.agreeLead = agreeLead;
	}

	public int getAllLead() {
		return allLead;
	}

	public void setAllLead(int allLead) {
		this.allLead = allLead;
	}

	public int getAgreeFollow() {
		return agreeFollow;
	}

	public void setAgreeFollow(int agreeFollow) {
		this.agreeFollow = agreeFollow;
	}

	public int getAllFollow() {
		return allFollow;
	}

	public void setAllFollow(int allFollow) {
		this.allFollow = allFollow;
	}

	public int getAgreeView() {
		return agreeView;
	}

	public void setAgreeView(int agreeView) {
		this.agreeView = agreeView;
	}

	public int getAllView() {
		return allView;
	}

	public void setAllView(int allView) {
		this.allView = allView;
	}
	
	

	public String getMyPhoto() {
		return myPhoto;
	}

	public void setMyPhoto(String myPhoto) {
		this.myPhoto = myPhoto;
	}

	public Date getSendTime() {
		return sendTime;
	}

	public void setSendTime(Date sendTime) {
		this.sendTime = sendTime;
	}

	public int getAboutNum() {
		return aboutNum;
	}

	public void setAboutNum(int aboutNum) {
		this.aboutNum = aboutNum;
	}

	public int getPiTypeId() {
		return piTypeId;
	}

	public void setPiTypeId(int piTypeId) {
		this.piTypeId = piTypeId;
	}

	public BigDecimal getMyleaderAmount() {
		return myleaderAmount;
	}

	public void setMyleaderAmount(BigDecimal myleaderAmount) {
		this.myleaderAmount = myleaderAmount;
	}

	public BigDecimal getMyfollowAmount() {
		return myfollowAmount;
	}

	public void setMyfollowAmount(BigDecimal myfollowAmount) {
		this.myfollowAmount = myfollowAmount;
	}

	public String getPiCancelReason() {
		return piCancelReason;
	}

	public void setPiCancelReason(String piCancelReason) {
		this.piCancelReason = piCancelReason;
	}

	

	public BigDecimal getSumleaderPivaluation() {
		return sumleaderPivaluation;
	}

	public void setSumleaderPivaluation(BigDecimal sumleaderPivaluation) {
		this.sumleaderPivaluation = sumleaderPivaluation;
	}

	public BigDecimal getSumlfollowPivaluation() {
		return sumlfollowPivaluation;
	}

	public void setSumlfollowPivaluation(BigDecimal sumlfollowPivaluation) {
		this.sumlfollowPivaluation = sumlfollowPivaluation;
	}

	public BigDecimal getSumPivaluation() {
		return sumPivaluation;
	}

	public void setSumPivaluation(BigDecimal sumPivaluation) {
		this.sumPivaluation = sumPivaluation;
	}
	
	

	public BigDecimal getPiinvest() {
		return piinvest;
	}

	public void setPiinvest(BigDecimal piinvest) {
		this.piinvest = piinvest;
	}
	
	

	public Timestamp getPrecommendedTime() {
		return precommendedTime;
	}

	public void setPrecommendedTime(Timestamp precommendedTime) {
		this.precommendedTime = precommendedTime;
	}
	
	

	public String getPiisAskPrice() {
		return piisAskPrice;
	}

	public void setPiisAskPrice(String piisAskPrice) {
		this.piisAskPrice = piisAskPrice;
	}
	
	

	public BigDecimal getPvaluationFinalNew() {
		return pvaluationFinalNew;
	}

	public void setPvaluationFinalNew(BigDecimal pvaluationFinalNew) {
		this.pvaluationFinalNew = pvaluationFinalNew;
	}
	
	

	public BigDecimal getSingleMinAmount() {
		return singleMinAmount;
	}

	public void setSingleMinAmount(BigDecimal singleMinAmount) {
		this.singleMinAmount = singleMinAmount;
	}

	public int getLastDays() {
		return lastDays;
	}

	public void setLastDays(int lastDays) {
		this.lastDays = lastDays;
	}

	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE)
				.append("ProjectId", getProjectId())
				.append("Pname", getPname()).append("PstateId", getPstateId())
				.append("PviewLimit", getPviewLimit())
				.append("PtypeId", getPtypeId())
				.append("Pindustry", getPindustry())
				.append("PcityId", getPcityId())
				.append("PprovincesId", getPprovincesId())
				.append("PfoundedYear", getPfoundedYear())
				.append("PfoundedMonth", getPfoundedMonth())
				.append("Plabel", getPlabel()).append("Pstage", getPstage())
				.append("PisHaveOther", getPisHaveOther())
				.append("PcompanyName", getPcompanyName())
				.append("Paddress", getPaddress())
				.append("Pdetail", getPdetail())
				.append("PfinancingAmount", getPfinancingAmount())
				.append("PinvestAmount", getPinvestAmount())
				.append("Pcomplete", getPcomplete())
				.append("PpayWay", getPpayWay()).append("Psetup", getPsetup())
				.append("PviewCount", getPviewCount())
				.append("PfavoritesCount", getPfavoritesCount())
				.append("PinvestCount", getPinvestCount())
				.append("PaskPriceCount", getPaskPriceCount())
				.append("Ppic", getPpic()).append("Pvideo", getPvideo())
				.append("PopenDate", getPopenDate())
				.append("PcloseDate", getPcloseDate())
				.append("PisRecommended", getPisRecommended())
				.append("PopenDays", getPopenDays())
				.append("PinvestMax", getPinvestMax())
				.append("PinvestMin", getPinvestMin())
				.append("Creator", getCreator())
				.append("CreateTime", getCreateTime())
				.append("IsDel", getIsDel()).append("PisFull", getPisFull())
				.append("PfullTime", getPfullTime())
				.append("PisCheck", getPisCheck())
				.append("Pchecker", getPchecker())
				.append("PcheckTime", getPcheckTime())
				.append("PisPay", getPisPay())
				.append("PpayTime", getPpayTime())
				.append("PdealRate", getPdealRate())
				.append("PdealFees", getPdealFees())
				.append("PfinalGetPay", getPfinalGetPay())
				.append("PisBreak", getPisBreak())
				.append("PbreakTime", getPbreakTime())
				.append("PbreakRemark", getPbreakRemark())
				.append("PcheckRemark", getPcheckRemark())
				.append("PcheckTimes", getPcheckTimes())
				.append("PhavedPay", getPhavedPay())
				.append("PpayPercent", getPpayPercent())
				.append("PcityIname", getPcityIname())
				.append("PprovincesName", getPprovincesName()).toString();
	}

	public int hashCode() {
		return new HashCodeBuilder().append(getProjectId()).toHashCode();
	}

	public boolean equals(Object obj) {
		if (obj instanceof Tcproject == false)
			return false;
		if (this == obj)
			return true;
		Tcproject other = (Tcproject) obj;
		return new EqualsBuilder().append(getProjectId(), other.getProjectId())
				.isEquals();
	}
}
