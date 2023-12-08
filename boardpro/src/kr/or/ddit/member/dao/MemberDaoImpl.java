package kr.or.ddit.member.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;
import kr.or.ddit.mybatis.config.MybatisUtil;

public class MemberDaoImpl implements IMemberDao {

	// mapper 수행을 위한 SqlSession 객체 변수
	SqlSession session;
	
	// 싱글톤을 위한 자신의 객체변수 선언
	private static IMemberDao dao;
	
	// 자신의 객체를 생성하여 리턴하는 메소드
	public static IMemberDao getDao() {
		if (dao == null) {
			dao = new MemberDaoImpl();
		}
		
		return dao;
	}
	
	@Override
	public String selectById(String mem_id) {
		session = MybatisUtil.getSqlSession();
		
		String memId = null;
		
		try {
			memId = session.selectOne("member.selectById", mem_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return memId;
	}

	@Override
	public int insertMember(MemberVO memVo) {
		session = MybatisUtil.getSqlSession();
		
		int res = 0;
		
		try {
			res = session.insert("member.insertMember", memVo);
			
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return res;
	}

	@Override
	public List<ZipVO> selectByDong(String searchDong) {
		session = MybatisUtil.getSqlSession();
		
		List<ZipVO> zipList = new ArrayList<ZipVO>();
		
		try {
			zipList = session.selectList("member.selectByDong", searchDong);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return zipList;
	}

	@Override
	public MemberVO loginProc(Map<String, Object> map) {
		MemberVO memVo = null;
		
		try {
			session = MybatisUtil.getSqlSession();
			memVo = session.selectOne("member.loginProc", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return memVo;
	}

}
