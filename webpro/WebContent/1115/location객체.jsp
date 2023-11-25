<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table {
	border: 2px solid blue;
}

td {
	width: 300px;
	height: 50px;
}
</style>
</head>
<body>

<%
	String userId = request.getParameter("id");
	String userName = request.getParameter("name");
	
	// DB를 이용해서 CRUD처리를 한다.
	// 처리 후 결과물을 생성 - html
%>

<table border="1">
	<tr>
		<td>아이디</td>
		<td><%= userId %></td>
	</tr>
	<tr>
		<td>이름</td>
		<td><%= userName %></td>
	</tr>
</table>

</body>
</html>