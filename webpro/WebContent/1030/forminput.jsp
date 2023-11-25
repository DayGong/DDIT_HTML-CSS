<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	h1 {
		color: red;
		text-align: center;
	}
	
	p {
		text-align: center;
	}
	
	table {
		border: 3px solid blue;
		margin-left: 30%;
	}
	
	td {
		width: 500px;
		height: 50px;
		/* text-align: center; */
		padding: 20px;
	}
	
	th {
		width: 250px;
		background: skyblue;
	}
</style>
</head>
<body>
<h1>jsp: JAVA Server Page</h1>
<p>클라이언트의 요청시 전송 데이터를 받아서 처리하고
그 처리 결과로 응답데이터를 생성하여 보여준다.</p>

<%
	request.setCharacterEncoding("UTF-8");

	// 전송 데이터 받기
	String userId = request.getParameter("id");
	String userName = request.getParameter("name");
	String userGend = request.getParameter("gender");
	
	String[] frs = request.getParameterValues("fruit");
	String str = "";
	/* for (int i = 0; i < frs.length; i++) {
		str += frs[i] + " ";
	} */
	
	for (String fr : frs) {
		str += fr + " ";
	} 
	
	String text = request.getParameter("area"); // 엔터 기호(\r\n)가 포함
	text = text.replaceAll("\n", "<br>");
	
	// 첨부파일
	String fileName = request.getParameter("file");
	
	// db와 관련된 crud 처리한다.
%>

<table border="1">
	<tr>
		<th>아이디</th>
		<td><%= userId %></td>
	</tr>
	<tr>
		<th>이름</th>
		<td><%= userName %></td>
	</tr>
	<tr>
		<th>성별</th>
		<td><%= userGend %></td>
	</tr>
	<tr>
		<th>좋아하는 과일</th>
		<td><%= str %></td>
	</tr>
	<tr>
		<th>자기소개</th>
		<td><%= text %></td>
	</tr>
	<tr>
		<th>첨부파일</th>
		<td><%= fileName %></td>
	</tr>
</table>
</body>
</html>