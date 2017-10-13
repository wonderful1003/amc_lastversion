package com.amc.service.community;

import java.util.List;

import com.amc.common.Search;
import com.amc.service.domain.Comment;
import com.amc.service.domain.FreeBoard;

public interface CommunityService {
	
	public List<FreeBoard> getFreeBoardList(Search search);
	
	public FreeBoard getFreeBoard(int freeBoardNo);
	
	public void deleteFreeBoard(int freeBoardNo);
	
	public void addFreeBoard(FreeBoard freeboard);
	
	public void updateFreeBoard(FreeBoard freeBoard);
	
	//restController에서 사용
	public void addComment(Comment comment);
	
	public List<Comment> getCommentList();
	
	public List<Comment> getReplyList();
	
	public void deleteComment(int commentNo);
	
	public void updateComment(Comment comment);
	
}
