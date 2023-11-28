package kr.or.ddit.prod.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.mybatis.config.MybatisUtil;
import kr.or.ddit.prod.vo.ProdVO;

public class ProdDaoImpl implements IProdDao {
	
	// maapper수행을 위한 SqlSession필요 - SqlSession객체 변수 선언
	private SqlSession session;
	
	// 자신의 객체 변수 선언
	private static IProdDao dao;
	
	// 자신의 객체를 생성하여 리턴하는 메소드
	public static IProdDao getDao() {
		if ( dao == null ) {
			dao = new ProdDaoImpl();
		}
		
		return dao;
	}

	@Override
	public List<ProdVO> selectByLgu(String prod_lgu) {
		// 0. SqlSession객체 열기
		session = MybatisUtil.getSqlSession();
		
		// 1. 리턴 값의 변수 선언
		List<ProdVO> prodList = new ArrayList<ProdVO>();
		
		// 2. 실행
		try {
			
			prodList = session.selectList("prod.selectByLgu", prod_lgu);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		// 3. 리턴 결과
		return prodList;
	}

	@Override
	public ProdVO selectById(String prod_id) {
		session = MybatisUtil.getSqlSession();
		
		ProdVO prod = new ProdVO();
		
		try {
			
			prod = session.selectOne("prod.selectById", prod_id);
			
			session.commit();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		
		return prod;
	}

}
