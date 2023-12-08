package kr.or.ddit.board.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.ReplyVO;
import kr.or.ddit.mybatis.config.MybatisUtil;

public class BoardDaoImpl implements IBoardDao {
	
	private static BoardDaoImpl dao;
	
	private BoardDaoImpl() {};
	
	public static BoardDaoImpl getInstance() {
		if(dao == null) {
			dao = new BoardDaoImpl();
		}
		return dao;
	}

	@Override
	public List<BoardVO> selectByPage(Map<String, Object> map) {
		SqlSession session = MybatisUtil.getSqlSession();
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		
		try {
			
			boardList = session.selectList("board.selectByPage", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return boardList;
	}

	@Override
	public int getTotalCount(Map<String, Object> map) {
		SqlSession session = MybatisUtil.getSqlSession();
		int res = 0;
		
		try {
			
			res = session.selectOne("board.getTotalCount", map);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public int insertBoard(BoardVO vo) {
		SqlSession session = MybatisUtil.getSqlSession();
		int res = 0;
		
		try {
			
			res = session.insert("board.insertBoard", vo);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public int updateBoard(BoardVO vo) {
		SqlSession session = MybatisUtil.getSqlSession();
		int res = 0;
		
		try {
			
			res = session.update("board.updateBoard", vo);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public int deleteBoard(int num) {
		SqlSession session = MybatisUtil.getSqlSession();
		int res = 0;
		
		try {
			
			res = session.delete("board.deleteBoard", num);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public int updateHit(int num) {
		SqlSession session = MybatisUtil.getSqlSession();
		int res = 0;
		
		try {
			
			res = session.update("board.updateHit", num);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<ReplyVO> selectReply(int bonum) {
		SqlSession session = null;
		List<ReplyVO> replyVo = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			
			replyVo = session.selectList("board.selectReply", bonum);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return replyVo;
	}

	@Override
	public int insertReply(ReplyVO replyVo) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = MybatisUtil.getSqlSession();
			
			res = session.insert("board.insertReply", replyVo);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public int updateReply(ReplyVO replyVo) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = MybatisUtil.getSqlSession();
			
			res = session.update("board.updateReply", replyVo);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public int deleteReply(int renum) {
		SqlSession session = null;
		int res = 0;
		
		try {
			session = MybatisUtil.getSqlSession();
			
			res = session.delete("board.deleteReply", renum);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

}
