package com.watchers.business.finder.mapper;

import java.util.List;

import com.watchers.business.finder.model.FinderVo;
import com.watchers.common.annotation.WatchersMyBatisMapper;

@WatchersMyBatisMapper
public interface FinderMapper {
	List<FinderVo> getFinderList(FinderVo finderInfo);
	int updFinder(FinderVo finderInfo);
	int insFinder(FinderVo finderInfo);
	List<FinderVo> getMissingsList(FinderVo finderInfo);
}
