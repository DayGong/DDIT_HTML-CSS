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
	}
	
	p {
		font-size: 1.5rem;
	}
	
	table {
		border: 2px solid rgb(210, 220, 98);
	}
	
	td {
		width: 200px;
		height: 50px;
		text-align: center;
	}
</style>
</head>
<body>
	<h1>JSP : Java Server Page</h1>
	<p>클라이언트 요청 시 전송 데이터를 받아서 처리하는 백엔드 프로그램</p>
	<p>html기반에서 java언어를 사용하여 로직을 구현</p>
	<p>html코드 안에서 java언어를 사용시 &lt;% &nbsp; %> 기호 안에서 기술한다.</p>
	<p>처리된 자바 변수를 출력할 때는 &lt;%= &nbsp; %> 기호안에 작성한다.</p>
	
	<%
		request.setCharacterEncoding("UTF-8");
		// 클라이언트가 입력한 데이터를 가져온다. - request객체 -jsp의 내장 객체
		String userId = request.getParameter("id");
		String userPW = request.getParameter("passwd");
		String userName = request.getParameter("name");
		
		// db에서 일치하는 데이터정보가 있는지 검색
		
		// 검색 결과에 따라 응답 데이터를 생성
		String sname = userName;
		if(userName == null) {
			sname = "이름없음";
		}
	%>
	
	<table border="1">
		<tr>
			<td>아이디</td>
			<td><%= userId %></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><%= userPW %></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><%= sname %></td>
		</tr>
	</table>
</body>
</html>