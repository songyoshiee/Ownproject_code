package com.watchers.business.contact.mapper;

import java.util.List;

import com.watchers.business.contact.model.BoardVo;
import com.watchers.common.annotation.WatchersMyBatisMapper;

@WatchersMyBatisMapper
public interface ContactMapper {
	List<BoardVo> getBoardList();
	BoardVo getBoard(BoardVo boardInfo);
	int insBoard(BoardVo boardInfo);
	int updBoard(BoardVo boardInfo);
	int delBoard(BoardVo boardInfo);
}
