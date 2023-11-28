<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.mybatis.config.MybatisUtil"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 요청시 전송 데이터 받기
	
	// DB와 연결 - CRUD처리
	SqlSession dbsession = MybatisUtil.getSqlSession();
	
	List<MemberVO> list = dbsession.selectList("member.getAllMember");
	
	// CRUD처리의 결과값으로 응답데이터를 생성 - json 배열 데이터
%>

[

<%
	for (int i = 0; i < list.size(); i++) {
		MemberVO vo = list.get(i);

		if ( i > 0 ) {
				out.print(",");		
		}
		%>
		
		{
			"id"   : "<%= vo.getMem_id() %>",
			"name" : "<%= vo.getMem_name() %>",
			"addr" : "<%= vo.getMem_add1() %>",
			"tel"  : "<%= vo.getMem_hp() %>",
			"mail" : "<%= vo.getMem_mail() %>"
		}
		
		<%
	}
%>
]