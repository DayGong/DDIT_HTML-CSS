package kr.or.ddit.lprod.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.lprod.vo.LprodVO;
import kr.or.ddit.mybatis.config.MybatisUtil;

public class LprodDaoImpl implements ILprodDao {
	
	// mapper를 수행하기위해 SqlSession이 필요
	private SqlSession session;
	
	// 자신의 객체 변수 선언
	private static ILprodDao dao;
	
	// 자신이 객체를 생성해서 return하는 메소드
	public static ILprodDao getDao() {
		if (dao == null) dao = new LprodDaoImpl();
		
		return dao;
	}
	
	@Override
	public List<LprodVO> selectLprod() {
		session = MybatisUtil.getSqlSession();

		// 리턴 결과형의 변수 선언
		List<LprodVO> list = null;

		try {
			list = session.selectList("lprod.selectLprod");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// SELECT는 DB의 값이 변경되는 것이 아니기 때문에 commit()이 필수가 아님
			session.commit();
			session.close();
		}

		return list;
	}

}
