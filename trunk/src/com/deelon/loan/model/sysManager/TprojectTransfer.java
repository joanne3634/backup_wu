/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.model.sysManager;
import java.math.BigDecimal;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import com.deelon.core.model.BaseModel;
import com.deelon.loan.model.front.TProject;
import com.deelon.loan.model.front.TProjectInvest;
import com.deelon.loan.model.front.TUser;

public class TprojectTransfer extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TprojectTransfer";
	public static final String ALIAS_TRANSFER_ID = "转让ID";
	public static final String ALIAS_PROJECT_ID = "项目ID";
	public static final String ALIAS_INVEST_ID = "投资ID";
	public static final String ALIAS_TRANSFEROR_ID = "转让者";
	public static final String ALIAS_CLAIMS_SUM = "转让债权总额";
	public static final String ALIAS_UPSET_PRICE = "竞拍底价";
	public static final String ALIAS_AUCTION_WAY = "竞拍方式：1.明拍 2.暗拍";
	public static final String ALIAS_AUCTION_COUNT = "竞拍数";
	public static final String ALIAS_TRANSFER_COUNT = "转让次数";
	public static final String ALIAS_VIEW_COUNT = "浏览量";
	public static final String ALIAS_DESCRIPTION = "转让描述";
	public static final String ALIAS_OPEN_DAYS = "开放天数";
	public static final String ALIAS_OPEN_DATE = "开放标日期";
	public static final String ALIAS_CLOSE_DATE = "关闭标日期";
	public static final String ALIAS_TURNOVER_TIME = "成交时间";
	public static final String ALIAS_BID_PRICE = "中标价(最高)";
	public static final String ALIAS_BIDDER = "中标人";
	public static final String ALIAS_BID_TIME = "中标时间";
	public static final String ALIAS_IS_CANCEL = "撤销拍卖";
	public static final String ALIAS_STATE_ID = "状态ID";
	public static final String ALIAS_IS_CHECK = "是否通过审核";
	public static final String ALIAS_CHECKER = "审核人";
	public static final String ALIAS_CHECK_TIME = "审核时间";
	public static final String ALIAS_REMARKS = "备注";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long transferId;
	private java.lang.Long projectId;
	private java.lang.Long investId;
	private java.lang.Long transferorId;
	private BigDecimal claimsSum;
	private BigDecimal upsetPrice;
	private java.lang.String auctionWay;
	private java.lang.Integer auctionCount;
	private java.lang.Integer viewCount;
	private java.lang.String description;
	private java.lang.Integer openDays;
	private java.util.Date openDate;
	private java.util.Date closeDate;
	private java.util.Date turnoverTime;
	private BigDecimal bidPrice;
	private java.lang.Long bidder;
	private java.util.Date bidTime;
	private Integer isCancel;
	private java.lang.String stateId;
	private Integer isCheck;
	private java.lang.Long checker;
	private java.util.Date checkTime;
	private String remarks;
	//columns END
	//附加的字段 begin
	private TProject project;
	private TProjectInvest projectInvest;
	private String lenderName; //借款人姓名
	private String transferorName; //转让人，原投资人姓名
	private java.util.Date recentPayDate; //最近还款日期
	private String bidderName; //当前竞拍最高价者
	private BigDecimal hightestPrice;//当前竞拍最高价格
	private String remainTime; //竞拍剩余时间
	private String finalBidderName; //最终获标者姓名
	private Integer prCurrent;
	private String fileId;
	//附加的字段 end
	public TprojectTransfer(){
	}

	public TprojectTransfer(
		java.lang.Long transferId
	){
		this.transferId = transferId;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public Integer getPrCurrent() {
		return prCurrent;
	}

	public void setPrCurrent(Integer prCurrent) {
		this.prCurrent = prCurrent;
	}

	public void setTransferId(java.lang.Long value) {
		this.transferId = value;
	}
	
	public java.lang.Long getTransferId() {
		return this.transferId;
	}
	public void setProjectId(java.lang.Long value) {
		this.projectId = value;
	}
	
	public java.lang.Long getProjectId() {
		return this.projectId;
	}
	public void setInvestId(java.lang.Long value) {
		this.investId = value;
	}
	
	public java.lang.Long getInvestId() {
		return this.investId;
	}
	public void setTransferorId(java.lang.Long value) {
		this.transferorId = value;
	}
	
	public java.lang.Long getTransferorId() {
		return this.transferorId;
	}
	public void setClaimsSum(BigDecimal value) {
		this.claimsSum = value;
	}
	
	public BigDecimal getClaimsSum() {
		return this.claimsSum;
	}
	public void setUpsetPrice(BigDecimal value) {
		this.upsetPrice = value;
	}
	
	public BigDecimal getUpsetPrice() {
		return this.upsetPrice;
	}
	public void setAuctionWay(java.lang.String value) {
		this.auctionWay = value;
	}
	
	public java.lang.String getAuctionWay() {
		return this.auctionWay;
	}
	public void setAuctionCount(java.lang.Integer value) {
		this.auctionCount = value;
	}
	
	public java.lang.Integer getAuctionCount() {
		return this.auctionCount;
	}
	public void setViewCount(java.lang.Integer value) {
		this.viewCount = value;
	}
	
	public java.lang.Integer getViewCount() {
		return this.viewCount;
	}
	public void setDescription(java.lang.String value) {
		this.description = value;
	}
	
	public java.lang.String getDescription() {
		return this.description;
	}
	public void setOpenDays(java.lang.Integer value) {
		this.openDays = value;
	}
	
	public java.lang.Integer getOpenDays() {
		return this.openDays;
	}
	public void setOpenDate(java.util.Date value) {
		this.openDate = value;
	}
	
	public java.util.Date getOpenDate() {
		return this.openDate;
	}
	public void setCloseDate(java.util.Date value) {
		this.closeDate = value;
	}
	
	public java.util.Date getCloseDate() {
		return this.closeDate;
	}
	public void setTurnoverTime(java.util.Date value) {
		this.turnoverTime = value;
	}
	
	public java.util.Date getTurnoverTime() {
		return this.turnoverTime;
	}
	public void setBidPrice(BigDecimal value) {
		this.bidPrice = value;
	}
	
	public BigDecimal getBidPrice() {
		return this.bidPrice;
	}
	public void setBidder(java.lang.Long value) {
		this.bidder = value;
	}
	
	public java.lang.Long getBidder() {
		return this.bidder;
	}
	public void setBidTime(java.util.Date value) {
		this.bidTime = value;
	}
	
	public java.util.Date getBidTime() {
		return this.bidTime;
	}
	public void setIsCancel(Integer value) {
		this.isCancel = value;
	}
	
	public Integer getIsCancel() {
		return this.isCancel;
	}
	public void setStateId(java.lang.String value) {
		this.stateId = value;
	}
	
	public java.lang.String getStateId() {
		return this.stateId;
	}
	public void setIsCheck(Integer value) {
		this.isCheck = value;
	}
	
	public Integer getIsCheck() {
		return this.isCheck;
	}
	public void setChecker(java.lang.Long value) {
		this.checker = value;
	}
	
	public java.lang.Long getChecker() {
		return this.checker;
	}
	public void setCheckTime(java.util.Date value) {
		this.checkTime = value;
	}
	
	public java.util.Date getCheckTime() {
		return this.checkTime;
	}

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("TransferId",getTransferId())
			.append("ProjectId",getProjectId())
			.append("InvestId",getInvestId())
			.append("TransferorId",getTransferorId())
			.append("ClaimsSum",getClaimsSum())
			.append("UpsetPrice",getUpsetPrice())
			.append("AuctionWay",getAuctionWay())
			.append("AuctionCount",getAuctionCount())
			.append("ViewCount",getViewCount())
			.append("Description",getDescription())
			.append("OpenDays",getOpenDays())
			.append("OpenDate",getOpenDate())
			.append("CloseDate",getCloseDate())
			.append("TurnoverTime",getTurnoverTime())
			.append("BidPrice",getBidPrice())
			.append("Bidder",getBidder())
			.append("BidTime",getBidTime())
			.append("IsCancel",getIsCancel())
			.append("StateId",getStateId())
			.append("IsCheck",getIsCheck())
			.append("Checker",getChecker())
			.append("CheckTime",getCheckTime())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getTransferId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TprojectTransfer == false) return false;
		if(this == obj) return true;
		TprojectTransfer other = (TprojectTransfer)obj;
		return new EqualsBuilder()
			.append(getTransferId(),other.getTransferId())
			.isEquals();
	}

	public TProject getProject() {
		return project;
	}

	public void setProject(TProject project) {
		this.project = project;
	}

	public TProjectInvest getProjectInvest() {
		return projectInvest;
	}

	public void setProjectInvest(TProjectInvest projectInvest) {
		this.projectInvest = projectInvest;
	}

	public String getLenderName() {
		return lenderName;
	}

	public void setLenderName(String lenderName) {
		this.lenderName = lenderName;
	}

	public String getTransferorName() {
		return transferorName;
	}

	public void setTransferorName(String transferorName) {
		this.transferorName = transferorName;
	}

	public java.util.Date getRecentPayDate() {
		return recentPayDate;
	}

	public void setRecentPayDate(java.util.Date recentPayDate) {
		this.recentPayDate = recentPayDate;
	}

	public String getBidderName() {
		return bidderName;
	}

	public void setBidderName(String bidderName) {
		this.bidderName = bidderName;
	}

	public BigDecimal getHightestPrice() {
		return hightestPrice;
	}

	public void setHightestPrice(BigDecimal hightestPrice) {
		this.hightestPrice = hightestPrice;
	}

	public String getRemainTime() {
		return remainTime;
	}

	public void setRemainTime(String remainTime) {
		this.remainTime = remainTime;
	}

	public String getFinalBidderName() {
		return finalBidderName;
	}

	public void setFinalBidderName(String finalBidderName) {
		this.finalBidderName = finalBidderName;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	
}

