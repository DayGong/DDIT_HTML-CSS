package kr.or.ddit.lprod.service;

import java.util.List;

import kr.or.ddit.lprod.dao.ILprodDao;
import kr.or.ddit.lprod.dao.LprodDaoImpl;
import kr.or.ddit.lprod.vo.LprodVO;

public class LprodServiceImpl implements ILprodService {

	// dao객체가 필요
	private ILprodDao dao = LprodDaoImpl.getDao();
	
	// 자신의 객체 생성하고 리턴
	private static ILprodService service;
	
	// 자신의 객체를 생성하고 리턴
	public static ILprodService getService() {
		if ( service == null ) service = new LprodServiceImpl();
		
		return service;
	}
	
	@Override
	public List<LprodVO> selectLprod() {
		// 리턴 결과형의 변수 선언
//		List<LprodVO> list = null;
//		
//		list = dao.selectLprod();
//		
//		return list;
		
		return dao.selectLprod();
	}

}
