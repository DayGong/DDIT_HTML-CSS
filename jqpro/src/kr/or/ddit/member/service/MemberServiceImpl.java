package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public class MemberServiceImpl implements IMemberService {
	
	// dao 접근을 위한 dao 객체 변수 선언
	private IMemberDao dao = MemberDaoImpl.getDao();
	
	// 싱글톤을 위한 자신의 객체 변수 선언
	private static IMemberService service;
	
	public static IMemberService getService() {
		if (service == null) {
			service = new MemberServiceImpl();
		}
		
		return service;
	}

	@Override
	public String selectById(String mem_id) {
		return dao.selectById(mem_id);
	}

	@Override
	public int insertMember(MemberVO memVo) {
		return dao.insertMember(memVo);
	}

	@Override
	public List<ZipVO> selectByDong(String searchDong) {
		return dao.selectByDong(searchDong);
	}

}
