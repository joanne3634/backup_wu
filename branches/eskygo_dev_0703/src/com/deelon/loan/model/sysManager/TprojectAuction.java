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

public class TprojectAuction extends BaseModel {
	
	//alias
	public static final String TABLE_ALIAS = "TprojectAuction";
	public static final String ALIAS_AUCTION_ID = "报价记录ID";
	public static final String ALIAS_TRANSFER_ID = "转让ID";
	public static final String ALIAS_USER_ID = "报价人";
	public static final String ALIAS_HIGHEST_PRICE = "已出最高价";
	public static final String ALIAS_OFFER_PRICE = "我的报价";
	public static final String ALIAS_OFFER_TIME = "报价时间";
	public static final String ALIAS_IS_BID = "中标";
	public static final String ALIAS_BID_TIME = "中标时间";
	public static final String ALIAS_IS_CANCEL = "撤销竞拍";
	 
	//可以直接使用: @Length(max=50,message="用户名长度不能大于50")显示错误消息
	//columns START
	private java.lang.Long auctionId;
	private java.lang.Long transferId;
	private java.lang.Long userId;
	private BigDecimal highestPrice;
	private BigDecimal offerPrice;
	private java.util.Date offerTime;
	private Integer isBid;
	private java.util.Date bidTime;
	private Integer isCancel;
	//columns END

	public TprojectAuction(){
	}

	public TprojectAuction(
		java.lang.Long auctionId
	){
		this.auctionId = auctionId;
	}

	public void setAuctionId(java.lang.Long value) {
		this.auctionId = value;
	}
	
	public java.lang.Long getAuctionId() {
		return this.auctionId;
	}
	public void setTransferId(java.lang.Long value) {
		this.transferId = value;
	}
	
	public java.lang.Long getTransferId() {
		return this.transferId;
	}
	public void setUserId(java.lang.Long value) {
		this.userId = value;
	}
	
	public java.lang.Long getUserId() {
		return this.userId;
	}
	public void setHighestPrice(BigDecimal value) {
		this.highestPrice = value;
	}
	
	public BigDecimal getHighestPrice() {
		return this.highestPrice;
	}
	public void setOfferPrice(BigDecimal value) {
		this.offerPrice = value;
	}
	
	public BigDecimal getOfferPrice() {
		return this.offerPrice;
	}
	public void setOfferTime(java.util.Date value) {
		this.offerTime = value;
	}
	
	public java.util.Date getOfferTime() {
		return this.offerTime;
	}
	public void setIsBid(Integer value) {
		this.isBid = value;
	}
	
	public Integer getIsBid() {
		return this.isBid;
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

	public String toString() {
		return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
			.append("AuctionId",getAuctionId())
			.append("TransferId",getTransferId())
			.append("UserId",getUserId())
			.append("HighestPrice",getHighestPrice())
			.append("OfferPrice",getOfferPrice())
			.append("OfferTime",getOfferTime())
			.append("IsBid",getIsBid())
			.append("BidTime",getBidTime())
			.append("IsCancel",getIsCancel())
			.toString();
	}
	
	public int hashCode() {
		return new HashCodeBuilder()
			.append(getAuctionId())
			.toHashCode();
	}
	
	public boolean equals(Object obj) {
		if(obj instanceof TprojectAuction == false) return false;
		if(this == obj) return true;
		TprojectAuction other = (TprojectAuction)obj;
		return new EqualsBuilder()
			.append(getAuctionId(),other.getAuctionId())
			.isEquals();
	}
}

