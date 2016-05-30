/*
 * Copyright (c) 2008 Asiainfo Technologies(China),Inc.
 *
 * FileName: SysFileHelper.java
 *
 * Description:
 *
 * Created: Allen 2013-5-17
 * 
 * |--------------------------------------------------History---------------------------------------------------|
 * |                                                                                                            |
 * |-----Author-----|-----Date-----|----Version----|----------------------------Desc----------------------------| 
 * || 
 * |------------------------------------------------------------------------------------------------------------|
 */
package com.deelon.platform.util;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.morph.util.StringUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.deelon.core.model.BaseModel;
import com.deelon.core.util.AppUtil;
import com.deelon.core.util.StringUtil;
import com.deelon.platform.model.system.SysFile;
import com.deelon.platform.service.system.SysFileService;
import com.deelon.platform.service.util.ServiceUtil;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import com.google.common.collect.Lists;
import com.wabacus.util.Logger;

/**
 * SysFileHelper(Monkey patching)
 *
 * <P></P>
 * 
 * @author Wong Shek Hei Felix 2013-5-17
 * @version 0.0.1
 */

public class SysFileHelper
{
	private static Log logger = LogFactory.getLog(SysFileHelper.class);
	// ----------------------------------------------------- Properties
	private static LoadingCache<Long, SysFile> sysFileCache;
	static {
		sysFileCache = CacheBuilder.newBuilder()
			       .maximumSize(500)
			       .expireAfterAccess(1, TimeUnit.DAYS)
			       .build(
			           new CacheLoader<Long, SysFile>() {
			        	   @Override
			             public SysFile load(Long key) {
			            	 SysFileService sysFileService = (SysFileService)AppUtil.getBean( "sysFileService" );
			            	 SysFile sysFile = (SysFile)sysFileService.getById(key);
			            	 return sysFile;
			             }

						@Override
						public Map<Long, SysFile> loadAll(
								Iterable<? extends Long> keys) throws Exception {
			            	 SysFileService sysFileService = (SysFileService)AppUtil.getBean( "sysFileService" );
			            	 List<SysFile> sysFiles = sysFileService.getFileInId(Lists.newArrayList(keys));
			            	 Map<Long, SysFile> result = new HashMap<Long, SysFile>();
			            	 for (SysFile file : sysFiles ) {
			            		 result.put(file.getFileId(), file);
			            	 }
			            	 return result;
						}
			        	   
			           });

	}
	// ----------------------------------------------------- Constructors

	// ----------------------------------------------------- Methods
	 private static String attachPath = ServiceUtil.getBasePath().replace("/", "\\");
	 public static List<SysFile> getByIdsFileInfo(List<Long> contentFileIds){
		 SysFileService sysFileService=(SysFileService)AppUtil.getBean( "sysFileService" );
		if(contentFileIds!=null&&contentFileIds.size()>0){
			return getSysFileByIds(contentFileIds); 
		}
		return null;
	 }
	 public static List<Long> getFileIdsFromPPic(String ppic) {
		JSONObject json=JSONObject.fromObject(ppic);
		JSONArray jsonArray = JSONArray.fromObject(json.get( "attachs" ));		
		List<Long> ids=new ArrayList<Long>();	
		for(int i=0;i<jsonArray.size();i++){
			JSONObject o=JSONObject.fromObject(jsonArray.get( i ));
			String id= (String)o.get( "fileId" ); 
			if(id!=null&&id!=""&&!id.equals("")){
				ids.add( Long.parseLong( id) );
			}
		}
		return ids;
	 }
	public static void getByIdsFileInfo(String contentFileIds,BaseModel bm){
		List<Long> ids = getFileIdsFromPPic(contentFileIds);
		if ( !ids.isEmpty() ) {
			List<SysFile> files = getByIdsFileInfo(ids);
			if ( null != files ) {
				Iterator<SysFile> itr = files.iterator();
				SysFile file = itr.next();

				StringBuilder fileNames = new StringBuilder(file.getFileName());
				StringBuilder filePaths = new StringBuilder(file.getFilePath());
				StringBuilder exts = new StringBuilder(file.getExt());
				StringBuilder fileIds = new StringBuilder(file.getFileId().toString());
				while ( itr.hasNext() ) {
					file = itr.next();
					fileNames.append(',')
					 .append(file.getFileName());
					filePaths.append(',')
					 .append(file.getFilePath());
					exts.append(',')
					 .append(file.getExt());
					fileIds.append(',')
					 .append(file.getFileId());
				}
				bm.setFileNames(fileNames.toString());
				bm.setFilePaths(filePaths.toString());
				bm.setExtPath(exts.toString());
				bm.setFilesIds(fileIds.toString());
			}
		}
	}
	/**
	 * 获取附件全路径
	 * @param fileId
	 * @return
	 */
	public static String getByIdsFilePath(String fileId){
		List<Long> fileIds = new ArrayList<Long>();
		for(String id : fileId.split(",") ) {
			fileIds.add(Long.valueOf(id));
		}
		return StringUtils.join(getPathByIds(fileIds), ",");
	}
	public static List<SysFile> getSysFileByIds(List<Long> fileIds) {
		try {
			return sysFileCache.getAll(fileIds).values().asList();
		} catch (ExecutionException e) {
			logger.error(e.getCause());
		} catch (RuntimeException e) {
			logger.info(e.getCause());
		}
		return null;
	}
	public static List<String> getPathByIds(List<Long> fileIds){
		SysFileService sysFileService=(SysFileService)AppUtil.getBean( "sysFileService" );
		ArrayList<String> paths = new ArrayList<String>(fileIds.size());
		for ( Long id : fileIds ) {
			SysFile sysFile = (SysFile)sysFileService.getById(id);
			String fullPath = StringUtil.trimSufffix(attachPath, File.separator) + File.separator + sysFile.getFilePath().replace("/", File.separator);
			paths.add(fullPath);
			
		}
		return paths;
	}
	public static SysFile getSysFileById(Long id) {
		try {
			return sysFileCache.get(id);
		} catch (ExecutionException e) {
			logger.error(e.getCause());
		} catch (RuntimeException e) {
			logger.info(e.getCause());
		}
		return null;
	}
}
