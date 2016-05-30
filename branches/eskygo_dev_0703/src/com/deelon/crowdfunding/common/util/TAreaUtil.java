package com.deelon.crowdfunding.common.util;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;

import javax.annotation.PostConstruct;

import org.apache.commons.lang.ArrayUtils;
import org.springframework.stereotype.Service;

import com.deelon.core.util.AppConfigUtil;
import com.deelon.core.util.AppUtil;
import com.deelon.crowdfunding.common.constants.WuyouchouConfigKeys;
import com.deelon.loan.model.front.Tarea;
import com.deelon.loan.service.front.TareaService;
import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;
import com.google.common.collect.Lists;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Service
public class TAreaUtil {
	

	public LoadingCache<Long, Tarea> tAreaCache;
	public LoadingCache<Long, List<Long>> tParentAreaCache;
	public List<String> topLevels;

	public Map<Long, List<Long>> topLevelCities;
	
	@PostConstruct
	public void initializer() {

		tAreaCache = CacheBuilder.newBuilder().maximumSize(1000)
				.expireAfterWrite(1, TimeUnit.DAYS)
				.build(new CacheLoader<Long, Tarea>() {
					@Override
					public Tarea load(Long key) {
						TareaService tareaService = (TareaService) AppUtil
								.getBean(TareaService.class);
						Tarea sysFile = (Tarea) tareaService.getById(key);
						return sysFile;
					}

					@Override
					public Map<Long, Tarea> loadAll(
							Iterable<? extends Long> keys) throws Exception {
						TareaService tareaService = (TareaService) AppUtil
								.getBean(TareaService.class);
						List<Tarea> tareas = tareaService.getByAreaIds(Lists
								.newArrayList(keys));
						Map<Long, Tarea> result = new HashMap<Long, Tarea>();
						for (Tarea file : tareas) {
							result.put(file.getAreaId(), file);
						}
						return result;
					}

				});
		tParentAreaCache = CacheBuilder.newBuilder().maximumSize(50)
				.expireAfterWrite(1, TimeUnit.DAYS)
				.build(new CacheLoader<Long, List<Long>>() {
					@Override
					public List<Long> load(Long key) {

						TareaService tareaService = (TareaService) AppUtil
								.getBean(TareaService.class);
						// get List from parent
						List<Tarea> tareas = tareaService.getbyParentId(key);
						List<Long> tareaIds = new ArrayList<Long>(tareas.size());
						for (Tarea area : tareas) {
							tareaIds.add(area.getAreaId());
						}
						return tareaIds;
					}

					@Override
					public Map<Long, List<Long>> loadAll(
							Iterable<? extends Long> keys) throws Exception {
						TareaService tareaService = (TareaService) AppUtil
								.getBean(TareaService.class);
						List<Tarea> tareas = tareaService.getByAreaIds(Lists
								.newArrayList(keys));
						Map<Long, List<Long>> result = new HashMap<Long, List<Long>>();
						for (Tarea tarea : tareas) {
							if (!result.containsKey(tarea.getParentId())) {
								result.put(tarea.getParentId(),
										new ArrayList<Long>());
							}
							result.get(tarea.getParentId()).add(
									tarea.getAreaId());
						}
						return result;
					}

				});
	}
	
	public Map<Long, List<Long>> getTopLevelCities(){
		String topLevelIdsJson = AppConfigUtil
				.get(WuyouchouConfigKeys.USETOPLEVELNAMEAREAID);
		if ( null != topLevelIdsJson ) {
			Gson gson = new Gson();
			Type type = new TypeToken<HashMap<Long, List<Long>>>() {}.getType();
			topLevelCities = gson.fromJson(topLevelIdsJson, type);
		} else {
			topLevelCities = new HashMap<Long, List<Long>>(); // create an empty one
		}
		return topLevelCities;
	}
	public List<Tarea> getAreaByParentId(long parentId) {
		AppConfigUtil.get(WuyouchouConfigKeys.USETOPLEVELNAMEAREAID);
		Map<Long, List<Long>> cities = getTopLevelCities();
		if (null != cities && cities.containsKey(parentId)) {
			// return a special version
			
			try {
				return Lists.newArrayList(tAreaCache.getAll(topLevelCities.get(parentId)).values());
			} catch (ExecutionException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
		}
		try {
			return Lists.newArrayList(tAreaCache.getAll(tParentAreaCache.get(parentId)).values());
		} catch (ExecutionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public Tarea getAreaById(long id) {
		try {
			return tAreaCache.get(id);
		} catch (ExecutionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
}
