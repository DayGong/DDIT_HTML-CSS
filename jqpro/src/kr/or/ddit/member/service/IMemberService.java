package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.member.vo.ZipVO;

public interface IMemberService {
	
	// 아이디 중복 검사
	public String selectById(String mem_id);
	
	// 저장하기 - 회원가입하기
	public int insertMember(MemberVO memVo);
	
	// 우편번호 찾기
	public List<ZipVO> selectByDong(String searchDong);
	
}
