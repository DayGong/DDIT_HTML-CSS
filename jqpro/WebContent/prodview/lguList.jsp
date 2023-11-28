<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 서블릿에서 저장한 값 꺼내기
	List<ProdVO> prodList = (List<ProdVO>)request.getAttribute("keylist");
%>

[
<%
for (int i = 0; i < prodList.size(); i++) {
	ProdVO vo = prodList.get(i);
	
	if ( i > 0 ) {
		out.print(",");
	}
%>
	{
		"prod_id" : "<%= vo.getProd_id() %>",
		"prod_name" : "<%= vo.getProd_name() %>"
	}
<%
}
%>
]