<%@page import="kr.or.ddit.prod.vo.ProdVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 서블릿에서 저장한 공유 데이터 꺼내기
	ProdVO prodVo = (ProdVO)request.getAttribute("keyvo");
%>

{
	"prod_id" : "<%= prodVo.getProd_id() %>",
	"prod_name" : "<%= prodVo.getProd_name() %>",
	"prod_buyer" : "<%= prodVo.getProd_buyer() %>",
	"prod_cost" : "<%= prodVo.getProd_cost() %>",
	"prod_lgu" : "<%= prodVo.getProd_lgu() %>",
	"prod_detail" : "<%= prodVo.getProd_detail() %>",
	"prod_price" : "<%= prodVo.getProd_price() %>",
	"prod_sale" : "<%= prodVo.getProd_sale() %>"
}