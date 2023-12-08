package kr.or.ddit.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.board.dao.BoardDaoImpl;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PageVO;
import kr.or.ddit.board.vo.ReplyVO;

public class BoardServiceImpl implements IBoardService {
	
	private BoardDaoImpl dao = BoardDaoImpl.getInstance();
	
	private static BoardServiceImpl service;
	
	private BoardServiceImpl() {};
	
	public static BoardServiceImpl getInstance() {
		if (service == null) {
			service = new BoardServiceImpl();
		}
		
		return service;
	}

	@Override
	public List<BoardVO> selectByPage(Map<String, Object> map) {
		return dao.selectByPage(map);
	}

	@Override
	public int getTotalCount(Map<String, Object> map) {
		return dao.getTotalCount(map);
	}

	@Override
	public int insertBoard(BoardVO vo) {
		return dao.insertBoard(vo);
	}

	@Override
	public int updateBoard(BoardVO vo) {
		return dao.updateBoard(vo);
	}

	@Override
	public int deleteBoard(int num) {
		return dao.deleteBoard(num);
	}

	@Override
	public int updateHit(int num) {
		return dao.updateHit(num);
	}

	@Override
	public PageVO getPageInfo(int page, String stype, String sword) {
		
		// 전체 글 갯수 구하기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stype", stype);
		map.put("sword", sword);
		
		int count = this.getTotalCount(map);
		
		int plist = PageVO.getPerList(); // 한 페이지에 출력될 게시물 수
		int totalPage = (int) Math.ceil((double)count / plist);
		
		if(page > totalPage ) page = totalPage;
		
		// start, end 구하기
		int start = (page - 1) * plist + 1;
		int end = start + plist - 1;
		
		
		// end가 게시물보다 많으면 게시물의 수를 end에 넣어준다.
		if (end > count) {
			end = count;
		}
		
		// startPage, endPage
		int ppage = PageVO.getPerPage();
		int startPage = ((page-1) / ppage * ppage) + 1;
		int endPage = startPage + ppage - 1;
		
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		
		PageVO pageVo = new PageVO();
		pageVo.setStart(start);
		pageVo.setEnd(end);
		pageVo.setStartPage(startPage);
		pageVo.setEndPage(endPage);
		pageVo.setTotalPage(totalPage);
		
		return pageVo;
	}

	@Override
	public List<ReplyVO> selectReply(int bonum) {
		return dao.selectReply(bonum);
	}

	@Override
	public int insertReply(ReplyVO replyVo) {
		return dao.insertReply(replyVo);
	}

	@Override
	public int updateReply(ReplyVO replyVo) {
		return dao.updateReply(replyVo);
	}

	@Override
	public int deleteReply(int renum) {
		return dao.deleteReply(renum);
	}

}
