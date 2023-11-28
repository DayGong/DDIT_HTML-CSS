<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	p{
		font-size: 2.0em;
		color: blue;
	}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	String userName = request.getParameter("name");
%>

<P><%= userName %>님 환영합니다.</P>
</body>
</html>