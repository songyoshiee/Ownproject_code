package com.watchers.business.finder.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.watchers.business.finder.mapper.FinderMapper;
import com.watchers.business.finder.model.FinderVo;
import com.watchers.common.constant.FrameworkConst;
import com.watchers.common.exception.WatchersBizException;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class FinderServiceImpl implements FinderService{
	@Autowired
	FinderMapper finderMapper;
	
	@Override
	public JSONArray getFinderList(FinderVo finderInfo) {
		List<FinderVo> list = finderMapper.getFinderList(finderInfo);
		return JSONArray.fromObject(list);
	}

	@Override
	public JSONObject procFinderModify(FinderVo finderInfo) {
		JSONObject result = new JSONObject();
		
		int cnt = finderMapper.updFinder(finderInfo);
		
		if(cnt == 1) {
			result.put(FrameworkConst.RESULT_CODE, FrameworkConst.RESULT_SUCCESS);
			result.put(FrameworkConst.RESULT_MSG, "결과반영이 완료되었습니다!");
			return result;
		} else {
			throw new WatchersBizException("결과반영 중 오류가 발생하였습니다");
		}
	}

	@Override
	public JSONArray getMissingsList(FinderVo finderInfo) {
		List<FinderVo> list = finderMapper.getMissingsList(finderInfo);
		return JSONArray.fromObject(list);
	}

	@Override
	public JSONObject insFinder(FinderVo finderInfo) {
		JSONObject result = new JSONObject();
		
		int cnt = finderMapper.insFinder(finderInfo);
		
		if(cnt == 1) {
			result.put(FrameworkConst.RESULT_CODE, FrameworkConst.RESULT_SUCCESS);
			result.put(FrameworkConst.RESULT_MSG, "결과반영이 완료되었습니다!");
			return result;
		} else {
			throw new WatchersBizException("결과반영 중 오류가 발생하였습니다");
		}
	}
	
}
