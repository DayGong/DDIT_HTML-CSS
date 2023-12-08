package kr.or.ddit.board.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PageVO;
import kr.or.ddit.board.vo.ReplyVO;

public interface IBoardService {
	// 리스트 출력
	public List<BoardVO> selectByPage(Map<String, Object> map);

	// 전체 글 갯수
	public int getTotalCount(Map<String, Object> map);

	// 글 저장하기
	public int insertBoard(BoardVO vo);

	// 글 수정하기
	public int updateBoard(BoardVO vo);

	// 글 삭제하기
	public int deleteBoard(int num);

	// 조회수 증가하기
	public int updateHit(int num);

	// 페이지 정보 계산
	public PageVO getPageInfo(int page, String stype, String sword);

	// 댓글 리스트
	public List<ReplyVO> selectReply(int bonum);

	// 댓글 저장
	public int insertReply(ReplyVO replyVo);

	// 댓글 수정
	public int updateReply(ReplyVO replyVo);

	// 댓글 삭제
	public int deleteReply(int renum);

}
