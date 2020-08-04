package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {	// 메소드 구현(Override)안하고 abstract 구현하여 테스트 시 오류 발생

	// spring 4.3 이상에서 자동 처리
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		
		log.info("register......" + board);
		
		mapper.insertSelectKey(board);
	}
	
	@Override
	public List<BoardVO> getList() {
		
		log.info("getList.........");
		
		return mapper.getList();
	}
	
	@Override
	public BoardVO get(Long bno) {
		
		log.info("get......" + bno);
		
		return mapper.read(bno);
	}
	
	@Override
	public boolean modify(BoardVO board) {
		
		log.info("modify......" + board);
		
		return mapper.update(board) == 1;
	}
	
	@Override
	public boolean remove(Long bno) {
		
		log.info("remove......" + bno);
		
		return mapper.delete(bno) == 1;
	}

	/*	// 위에서 구현하여 삭제
	@Override
	public BoardVO get(Long bno) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean modify(BoardVO board) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<BoardVO> getList() {
		// TODO Auto-generated method stub
		return null;
	}
	*/
}
