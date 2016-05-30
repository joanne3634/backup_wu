/*
 * Powered By [Allen]
 * Since 2013 - 2014
 */


package com.deelon.loan.service.sysManager;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.deelon.core.db.IEntityDao;
import com.deelon.core.service.BaseService;
import com.deelon.loan.dao.sysManager.TprojectAuctionDao;
import com.deelon.loan.model.sysManager.TprojectAuction;

@ Service
public class TprojectAuctionService extends BaseService<TprojectAuction>{
	
	@ Resource
	private TprojectAuctionDao tprojectAuctionDao;
	
	protected IEntityDao<TprojectAuction, Long> getEntityDao()
	{
		return this.tprojectAuctionDao;
	}
	
	/**
	 * 查找一笔转让对应有效的竞拍信息（isCancel=0）
	 * @param transferId 转让ID
	 * @return
	 */
	public List<TprojectAuction> getByTransferId(long transferId){
		return tprojectAuctionDao.getBySqlKey("getByTransferId", transferId);
	}
	
	/**
	 * 返回一笔转让中投标价格最高的投标，如果没有有效的投标，返回null
	 * @param transferId 转让ID
	 * @return
	 */
	public TprojectAuction getHightestAuction(long transferId){
		TprojectAuction tprojectAuction = null;
		List<TprojectAuction> transferList = this.getByTransferId(transferId);

		if(transferList!=null){
			BigDecimal hightestPrice = BigDecimal.valueOf(0);
			Date date = new Date(0);
			for(TprojectAuction auction:transferList){
				if(hightestPrice.compareTo(auction.getOfferPrice()) < 0){
					hightestPrice = auction.getOfferPrice();
					date = auction.getOfferTime(); //报价时间
					tprojectAuction = auction;
				}else if(hightestPrice.compareTo(auction.getOfferPrice()) == 0){
					if(date.after(auction.getOfferTime())){
						date = auction.getOfferTime();
						tprojectAuction = auction;
					}
				}
			}
		}
		return tprojectAuction;
	}
}