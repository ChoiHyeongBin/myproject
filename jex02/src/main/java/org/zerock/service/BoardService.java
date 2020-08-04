package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardService {
	
	public void register(BoardVO board);	// register : 등록하다
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);	// modify : 수정하다
	
	public boolean remove(Long bno);
	
	public List<BoardVO> getList();
}
