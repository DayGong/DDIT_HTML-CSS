<%@page import="kr.or.ddit.lprod.vo.LprodVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.ddit.mybatis.config.MybatisUtil"%>
<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
// 전송 시 데이터 값 받기

// DB에서 CRUD처리
// SqlSession 객체가 필요
SqlSession dbsession = MybatisUtil.getSqlSession();

// list를 json객체배열 생성 - 응답하기
List<LprodVO> list = dbsession.selectList("lprod.selectLprod");

// list를 가지고 출력페이지를 생성한다.
%>

<table border="1">
	<tr>
		<td>LPROD_ID</td>
		<td>LPROD_GU</td>
		<td>LPROD_NM</td>
	</tr>
	
<%
	for(int i = 0; i < list.size(); i++) {
		LprodVO vo = list.get(i);
%>
		<tr>
			<td><%= vo.getLprod_id() %></td>
			<td><%= vo.getLprod_gu() %></td>
			<td><%= vo.getLprod_nm() %></td>
		</tr>
<%
	}
%>
</table>

</body>
</html>
