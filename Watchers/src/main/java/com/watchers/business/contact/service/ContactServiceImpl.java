package com.watchers.business.contact.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.watchers.business.contact.mapper.ContactMapper;
import com.watchers.business.contact.model.BoardVo;
import com.watchers.common.constant.FrameworkConst;
import com.watchers.common.exception.WatchersBizException;
import com.watchers.common.session.manager.SessionLoginUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Service
public class ContactServiceImpl implements ContactService{
	@Autowired
	ContactMapper contactMapper;

	@Override
	public JSONArray getBoardList() {
		List<BoardVo> list = contactMapper.getBoardList();
		return JSONArray.fromObject(list);
	}
	
	@Override
	public JSONObject getBoard(BoardVo boardInfo) {
		BoardVo info = contactMapper.getBoard(boardInfo);
		return JSONObject.fromObject(info);
	}
	
	@Override
	public JSONObject procContactWrite(BoardVo boardInfo) {
		JSONObject result = new JSONObject();
		
		boardInfo.setId(SessionLoginUtil.getLoginUserId());
		int cnt = contactMapper.insBoard(boardInfo);
		
		if(cnt == 1) {
			result.put(FrameworkConst.RESULT_CODE, FrameworkConst.RESULT_SUCCESS);
			result.put(FrameworkConst.RESULT_MSG, "문의글 등록이 완료되었습니다!");
			return result;
		} else {
			throw new WatchersBizException("문의글 등록 중 오류가 발생하였습니다");
		}
	}

	@Override
	public JSONObject procContactModify(BoardVo boardInfo) {
		JSONObject result = new JSONObject();
		
		int cnt = contactMapper.updBoard(boardInfo);
		
		if(cnt == 1) {
			result.put(FrameworkConst.RESULT_CODE, FrameworkConst.RESULT_SUCCESS);
			result.put(FrameworkConst.RESULT_MSG, "문의글 수정이 완료되었습니다!");
			return result;
		} else {
			throw new WatchersBizException("문의글 수정 중 오류가 발생하였습니다");
		}
	}

	@Override
	public JSONObject procContactRemove(BoardVo boardInfo) {
		JSONObject result = new JSONObject();
		
		int cnt = contactMapper.delBoard(boardInfo);
		
		if(cnt == 1) {
			result.put(FrameworkConst.RESULT_CODE, FrameworkConst.RESULT_SUCCESS);
			result.put(FrameworkConst.RESULT_MSG, "문의글 삭제가 완료되었습니다!");
			return result;
		} else {
			throw new WatchersBizException("문의글 삭제 중 오류가 발생하였습니다");
		}
	}
}
