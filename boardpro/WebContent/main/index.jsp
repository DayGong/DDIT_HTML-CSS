<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/logpro.css">

</head>

<body>
	<header>
	<!-- 로그인 실행 결과를 삽입 - 로그인 안 했을 때: 로그인폼 또는 로그인 했을 때: 로그아웃-->
		<div class="dlog">
			<jsp:include page="../member/logpro.jsp"></jsp:include>
		</div>
		
		<a href="../member/member.html" target="iboard">회원가입</a>&nbsp;&nbsp;&nbsp;
		<a href="../reqboard/board.jsp" target="iboard">게시판</a>
	</header>
	
	<section>
		<iframe name="iboard" src="../reqboard/board.jsp"></iframe>
	</section>
</body>
</html>