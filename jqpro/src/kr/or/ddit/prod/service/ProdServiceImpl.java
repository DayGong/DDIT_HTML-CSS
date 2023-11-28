package kr.or.ddit.prod.service;

import java.util.List;

import kr.or.ddit.prod.dao.IProdDao;
import kr.or.ddit.prod.dao.ProdDaoImpl;
import kr.or.ddit.prod.vo.ProdVO;

public class ProdServiceImpl implements IProdService {
	
	// dao객체
	private IProdDao dao = ProdDaoImpl.getDao();
	
	// 생성자
	private ProdServiceImpl() {}
	
	// 자신의 객체 변수 선언
	private static IProdService service;
	
	// 자신의 객체를 생성하고 리턴
	public static IProdService getService() {
		if ( service == null ) {
			service = new ProdServiceImpl();
		}
		
		return service;
	}

	@Override
	public List<ProdVO> selectByLgu(String prod_lgu) {
		return dao.selectByLgu(prod_lgu);
	}

	@Override
	public ProdVO selectById(String prod_id) {
		return dao.selectById(prod_id);
	}

}
