package kr.or.ddit.mybatis.config;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.member.vo.MemberVO;

public class Main {
	public static void main(String[] args) {
		SqlSession dbsession = MybatisUtil.getSqlSession();
		
		List<MemberVO> list = dbsession.selectList("member.getAllMember");
		
		System.out.println(list);
	}
}
