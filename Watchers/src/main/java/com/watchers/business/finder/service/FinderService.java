package com.watchers.business.finder.service;

import com.watchers.business.finder.model.FinderVo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public interface FinderService {
	public JSONArray getFinderList(FinderVo finderInfo);
	public JSONObject procFinderModify(FinderVo finderInfo);
	public JSONArray getMissingsList(FinderVo finderInfo);
	public JSONObject insFinder(FinderVo finderInfo);
}
