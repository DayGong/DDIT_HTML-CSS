<%@page import="com.google.gson.JsonElement"%>
<%@page import="com.google.gson.JsonObject"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 서블릿에서 저장한 데이터 꺼내기
	List<BoardVO> boardList = (List<BoardVO>)request.getAttribute("pagelist");
	int startPage = (Integer)request.getAttribute("startPage");
	int endPage = (Integer)request.getAttribute("endPage");
	int totalPage = (Integer)request.getAttribute("totalPage");
	
	// json데이터를 만드는 라이브러리_Gson
	// Gson gson = new Gson();
	/* Gson gson = new GsonBuilder().setPrettyPrinting().create();
	String result = gson.toJson(boardList);
	
	out.print(result);
	out.flush(); */
	
	JsonObject obj = new JsonObject();
	obj.addProperty("startPage", startPage);
	obj.addProperty("endPage", endPage);
	obj.addProperty("totalPage", totalPage);
	
	Gson gson = new Gson();
	JsonElement result = gson.toJsonTree(boardList);
	
	obj.add("jsonTreeResult", result);
	
	out.print(obj);
	out.flush();
	
%>