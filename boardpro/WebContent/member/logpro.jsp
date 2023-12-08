<%@ page import="kr.or.ddit.member.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="true" %>
    
<script type="text/javascript" src="../js/jquery-3.7.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  

<script>
mypath = '<%= request.getContextPath() %>';

$(()=>{
	
	// 로그아웃 버튼 클릭 이벤트
	$(document).on('click', '#logout', function() {
		$.ajax({
			url: `${mypath}/LogOut.do`,
			type: 'get',
			success: function(res) {
				location.href=`${mypath}/main/index.jsp`;
			},
			error: function(xhr) {
				alert("오류 상태: " + xhr.status);
			}
		});
	});
	
	// 로그인 버튼 클릭 이벤트 
	$(document).on('click', '#login', function(){
		
		//입력 한 id와 pass을 가져온다 
		idvalue = $('#id').val().trim();
		passvalue= $('#pass').val().trim();
		
		console.log(idvalue, passvalue);
		
		$.ajax({
			// url: 'http://localhost/boardpro/LogIn.do',
			url: `${mypath}/LogIn.do`,
			type: 'post',
			data: {"id": idvalue, "pass": passvalue},
			success: function(res) {
				// $('.dlog').html(res);
				location.href = `${mypath}/main/index.jsp`;
			},
			error: function(xhr) {
				alert("에러 상태: " + xhr.status);
			},
			dataType: 'html'
		})
	})
})

</script>

<%
	// 로그인 했는지 안했는지를 판단 - HttpSession을 이용
	MemberVO vo = (MemberVO)session.getAttribute("loginOk");
	String check = (String)session.getAttribute("check");
	
	if(vo == null) { // 로그인 안 했거나 로그인 id 비밀번호가 틀렸거나 - 로그인 폼을 만든다.
		%>
			<input id="id" type="text" placeholder="id입력">&nbsp;&nbsp;&nbsp;
			<input type="password" id="pass" placeholder="pass입력">&nbsp;&nbsp;&nbsp;
			<input type="button" id="login" value="로그인">
		<%
	} else if(vo != null) { // 로그인 성공 - session이 제대로 수행됐다. - 로그아웃 폼을 만든다.
		%>
		<span><%= vo.getMem_id()%>님 환영합니다.</span>&nbsp;&nbsp;&nbsp;
		<input type="button" id="logout" value="로그아웃"> 
	<%
	}
	
	if(check == "false") {
		%>
		
		<span id="check">로그인 오류 또는 비회원입니다</span>&nbsp;&nbsp;&nbsp;
		
		<%
	}
%>