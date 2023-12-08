<%@page import="kr.or.ddit.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 서블릿에서 저장한 데이터 꺼내기
	List<BoardVO> boardList = (List<BoardVO>)request.getAttribute("pagelist");
	int startPage = (Integer)request.getAttribute("startpage");
	int endPage = (Integer)request.getAttribute("endpage");
	int totalPage = (Integer)request.getAttribute("totalpage");
%>

[
<% 
	for(int i = 0; i < boardList.size(); i ++) {
		BoardVO vo = boardList.get(i);
		if(i > 0) {
			out.print(",");
		}
		%>
		{
			"num" : "<%= vo.getNum() %>",
			"writer" : "<%= vo.getWriter() %>",
			"subject" : "<%= vo.getSubject() %>",
			"content" : "<%= vo.getContent() %>",
			"hit" : "<%= vo.getHit() %>",
			"wdate" : "<%= vo.getWdate() %>",
			"mail" : "<%= vo.getMail() %>"
		}
		<%
	}
%>
]