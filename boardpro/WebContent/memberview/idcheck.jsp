<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
// 서블릿에서 저장된 데이터 꺼내기
String res = (String)request.getAttribute("key_memId");

if (res == null) {
%>
	{
		"useCheck" : "사용 가능"
	}
<% } else { %>
	{
		"useCheck" : "사용 불가능"
	}
<%
}
%>