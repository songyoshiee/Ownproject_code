package com.watchers.business.contact.service;

import com.watchers.business.contact.model.BoardVo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public interface ContactService {
	public JSONArray getBoardList();
	public JSONObject getBoard(BoardVo boardInfo);
	public JSONObject procContactWrite(BoardVo boardInfo);
	public JSONObject procContactModify(BoardVo boardInfo);
	public JSONObject procContactRemove(BoardVo boardInfo);
}
