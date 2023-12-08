<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.or.ddit.member.vo.MemberVO"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bootstrap Example</title>
<script type="text/javascript" src="../js/jquery-3.7.1.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script> -->

<script src="../js/jquery.serializejson.min.js"></script>
<script src="../js/board.js"></script>

<style>
body {
	margin: 5px;
}

p {
	border: 1px dotted gray;
	margin: 1px;
	padding: 2px;
}

.p12 {
	display: flex;
	flex-direction: row;
}

.p1 {
	flex: 70%;
}

.p2 {
	flex: 30%;
	text-align: right;
}

input[name=reply] {
	height: 50px;
	vertical-align: top;
}

#write {
	margin-left: 80%;
}

.navbar a {
	visibility: hidden;
}

#pagelist {
	margin-left: 15%;
}

.reply-body {
	border: 1xp dotted orange;
	background: #efdadd;
	margin: 2px;
	padding: 20px;
}

#modifyform {
	display: none;
}
</style>

<%
	// 로그인 비교
	// memVo에는 mem_id, mem_pass, mem_name가 들어있음
	MemberVO memVo = (MemberVO)session.getAttribute("loginOk");

	String ss= null;
	// VO객체를 json데이터로 변경 - script에서 사용
	Gson gson = new Gson();
	
	if (memVo != null) {
		ss = gson.toJson(memVo);
	}
	/*
	ss = {
			"mem_id" : "a001",
			"mem_pass" : "asdfasdf",
			"mem_name" : "김은대"
	}
	*/
%>

<script>

uvo = <%= ss %>;

mypath = '<%= request.getContextPath() %>';
currentPage = 1;

// 전역객체 선언
reply = {};	// 필요할 때마다 동적으로 속성과 메소드를 추가할 수 있다

$(() => {
	
	// 리스트 출력
	ListPageServer(1);
	
	// 글쓰기 모달창에서 입력후 확인 버튼 클릭
	$('#send').on('click', function() {
		fdata = $('#wform').serializeJSON();
		console.log(fdata);
		
		// 서버로 전송 - ajax
		WriteBoardServer();
		
		// 모달창 닫기
		// 모달에 입력한 내용을 지우기
		$('#wform .txt').val("");
		$('#wModal').modal('hide');
		
	})
	
	// 글쓰기 이벤트 - 모달 창 열기
	$('#write').on('click', function() {
		// 로그인 체크
		if(uvo == null) {
			alert("로그인 하세요");
			return false;
		}
		
		// 로그인 된 상태면, 세션에 저장된 MemberVO에서 mem_name을 가져온다.
		// modal의 작성자에 이름을 출력한다.
		uname = uvo.mem_name;
		$('#wform #writer').val(uname);
		$('#wform #writer').prop('readonly', true);
		
		$('#wModal').modal('show');
	})
	
	// 검색 type(stype)과 검색어 word(sword)를 입력하고 List출력
	$('#search').on('click', function() {
		// 댓글 수정폼을 띄운다
		// 이미 어딘가에 수정폼이 띄어있다면 다음에 다시 띄운다
		if ($('#modifyform').css('display') != "none") {
			replyReset();
		}
		
		ListPageServer(1);
	})
	
	// 다음(next) 클릭 이벤트
	$(document).on('click', '#next', function() {
		// 댓글 수정폼을 띄운다
		// 이미 어딘가에 수정폼이 띄어있다면 다음에 다시 띄운다
		if ($('#modifyform').css('display') != "none") {
			replyReset();
		}
		
		currentPage = parseInt($('.pageno').last().text().trim()) + 1;
		ListPageServer(currentPage);
	});
	
	// 이전(prev) 클릭 이벤트
	$(document).on('click', '#prev', function() {
		// 댓글 수정폼을 띄운다
		// 이미 어딘가에 수정폼이 띄어있다면 다음에 다시 띄운다
		if ($('#modifyform').css('display') != "none") {
			replyReset();
		}
		
		currentPage = parseInt($('.pageno').first().text().trim()) - 1;
		ListPageServer(currentPage);
	});
	
	// 페이지 번호 클릭 이벤트
	$(document).on('click', '.pageno', function() {
		// 댓글 수정폼을 띄운다
		// 이미 어딘가에 수정폼이 띄어있다면 다음에 다시 띄운다
		if ($('#modifyform').css('display') != "none") {
			replyReset();
		}
		
		currentPage = parseInt($(this).text().trim());
		ListPageServer(currentPage);
	});
	
	// 수정, 삭제, 등록, 제목, 조회수 증가, 댓글 리스트(수정, 삭제)에 대한 이벤트
	$(document).on('click', '.action', function(){
		vaction = $(this).attr('name');
		vidx = $(this).attr('idx');	// 글번호

		// 다른 함수 영역으로 넘어갔을 때 
		// 클릭한 요소 객체를 사용하기 위해서 전역 변수로 설정한다.
		gthis = this;
		
		if(vaction == "delete") {
			alert(vidx + "번을 삭제합니다.");
			
			// DB삭제 - ajax함수 호출
			DeleteBoardServer(vidx);
			
		} else if (vaction == "modify") {
			alert(vidx + "번을 수정합니다.");
			
			// 본문의 내용을 출력한다. - 제목, 이름, 이메일, 내용
			// 본문의 내용을 가져온다
			vparents = $(this).parents('.card');
			
			vsub = $(vparents).find('.sub').text().trim();
			vwriter = $(vparents).find('.wr').text().trim();
			vmail = $(vparents).find('.em').text().trim();
			vpass = $(vparents).find('.pass').text().trim();
			vtext = $(vparents).find('.p3').html().trim();
			
			rvtext = vtext.replaceAll(/<br>/g, "");

			// 모달창에 출력
			$('#mform #mnum').val(vidx);
			$('#mform #mwriter').val(vwriter);
			$('#mform #mwriter').prop('readonly', true);
			$('#mform #msubject').val(vsub);
			$('#mform #mmail').val(vmail);
			$('#mform #mpassword').val(vpass);
			$('#mform #mcontent').val(rvtext);
			
			// 수정 모달창을 띄운다
			$('#mModal').modal('show');
			
			// 수정글 입력후 서버로 전송한다. - msend버튼의 이벤트 처리
			
		} else if (vaction == "reply") {
			// alert(vidx + "번 글에 댓글을 등록합니다.");

			if(uvo == null) {
				alert('로그인 후 이용 가능합니다');
				return false;
			}

			// 로그인 성공했을 때 입력한 댓글 내용 가져오기
			txtvalue = $(this).prev().val(); // 엔터가 포함
			// console.log('txt: ' +txtvalue);

			// DB에 저장하기위해서 bonum, cont, name이 필요
			// bonum = vidx, cont = txtvalue, name = 로그인에서 가져옴
			reply.bonum = vidx;
			reply.cont = txtvalue;
			reply.name = uvo.mem_name;

			// 서버로 전송
			ReplyInsertServer();

			// 화면에서 입력한 내용을 지우기
			$(this).prev().val("");

		} else if (vaction == "list") {
			// alert(vidx + "번의 조회수 증가, 댓글 리스트 가져온다.");

			varia = $(this).attr('aria-expanded');
			if (varia == "true") {
				// alert("조회수 증가");

				// 서버로 전송 - 성공시 화면의 값도 바뀐다.
				UpdateHitServer();
			}
			
			// 댓글 리스트 출력
			ReplyListServer();

		} else if (vaction == "r_modify") {
			alert(vidx + "번 댓글을 수정합니다.")
			
			// 댓글 수정폼을 띄운다
			// 이미 어딘가에 수정폼이 띄어있다면 다음에 다시 띄운다
			if ($('#modifyform').css('display') != "none") {
				replyReset();
			}
			
			// 수정할 원래 내용을 가져온다
			vp3 = $(this).parents('.reply-body').find('.p3');
			modifycont = vp3.html().trim();
			
			// 원래 내용에는 <br>이 포함되어 있다.
			mcont = modifycont.replaceAll(/<br>/g, "\n");
			
			// 수정폼에 출력
			$('#modifyform textarea').val(mcont);
			
			// p3에 있는 글자만 삭제한 뒤 수정폼을 p3으로 이동
			$(vp3).empty().append($('#modifyform'));
			
			// 수정폼이 보이도록 한다.
			$('#modifyform').show();
			
		} else if (vaction == "r_delete") {
			alert(vidx + "번 댓글을 삭제합니다.")
			
			// 서버로 전송 - DB삭제
			ReplyDeleteServer();
		}
	})
	
	// 수정 입력 후 전송 버튼
	$('#msend').on('click', function(){
		// 수정 입력된 내용을 가져온다.
		mdata = $('#mform').serializeJSON();
		console.log(mdata);
		
		// 서버로 전송 - ajax
		UpdateBoardServer();

		// 입력된 내용을 지운다.
		$('#mform .txt').val("");
		
		// 창 닫기
		$('#mModal').modal('hide');
	})
	
	// 댓글 수정창에서 확인 버튼 클릭
	$('#btnok').on('click', function() {
		// 새롭게 수정한 내용을 가져온다.
		modicont = $('#modifyform textarea').val(); // 엔터 포함 - DB저장
		
		// DB에서 수정 성공하면 사용할 변수 = modiout
		modiout = modicont.replaceAll(/\n/g, "<br>")// 성공 후 화면에 출력 - 엔터를 <br>로 변경
		vp3 = $('#modifyform').parent();
		
		// $('#modifyform')을 body로 이동
		$('#modifyform').appendTo($('body'));
		$('#modifyform').hide();
		
		reply.cont = modicont;
		reply.renum = vidx;
		
		RelpyUpdateServer();
	})
	
	// 댓글 수정창에서 취소 버튼 클릭
	$('#btnreset').on('click', function() {
		replyReset();
	})
	
	// 원래 댓글 내용을 수정폼에 띄우는 함수
	replyReset = function() {
		// 댓글 수정창을 기준으로 p3을 찾는다
		p3 = $('#modifyform').parent();
		
		// 수정폼을 body로 이동
		$('#modifyform').appendTo($('body'));
		$('#modifyform').hide();
		
		// 원래 내용을 p3에 다시 출력
		$(p3).html(modifycont);
	}
})
</script>
</head>
</head>
<body>
	<!-- append()는 새로운 것을 붙이는 기능과 
		 원래 있던 것을 잘라내 붙여넣는 기능이 있다. -->
	<div id="modifyform">
		<textarea rows="5" cols="40"></textarea>
		<input type="button" value="확인" id="btnok">
		<input type="button" value="취소" id="btnreset">	
	</div>
	
	<div>
		<h2>Accordion 게시판</h2>

		<!-- 모달 띄우기 onclick없이 -->
		<!-- <input type="button" value="글쓰기" id="write" data-toggle="modal" data-target="#myModal"> -->
		<input type="button" value="글쓰기" id="write">
		<br><br>
		<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
			<div class="container-fluid">
				<a class="navbar-brand" href="javascript:void(0)">Logo</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#mynavbar">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="mynavbar">
					<ul class="navbar-nav me-auto">
						<li class="nav-item">
							<a class="nav-link" href="javascript:void(0)">Link</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="javascript:void(0)">Link</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="javascript:void(0)">Link</a>
						</li>
					</ul>
					<form class="d-flex">
						<select class="form-select" id="stype">
							<option value="">전체</option>
							<option value="writer">작성자</option>
							<option value="subject">제목</option>
							<option value="content">내용</option>
						</select>
						<input class="form-control me-2" type="text" id="sword" placeholder="Search">
						<button class="btn btn-primary" type="button" id="search">Search</button>
					</form>
				</div>
			</div>
		</nav>
		
		<!-- 게시글 3개씩 출력하는 곳 -->
		<div id="result1" class="result"></div>
		<br><br>
		<!-- 넘김 모양 출력 -->
		<div id="pagelist"></div>
		<!-- The Modal -->
		<div class="modal" id="wModal">
			<div class="modal-dialog">
				<div class="modal-content">
		
				<!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">Modal Heading</h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		      	<form name="wform" id="wform">
		      		<label>작성자</label>
					<input type="text" id="writer" name="writer" class="txt">
					<br>
					<label>제목</label>
					<input type="text" id="subject" name="subject" class="txt">
					<br>
					<label>이메일</label>
					<input type="text" id="mail" name="mail" class="txt">
					<br>
					<label>비밀번호</label>
					<input type="password" id="password" name="password" class="txt">
					<br>
					<label>내용</label><br>
					<textarea rows="5" cols="30" id="content" name="content" class="txt"></textarea>
						
					<br><br>
					<input type="button" value="확인" id="send">
				</form>
		      </div>
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		      </div>
		
		    </div>
		  </div>
		</div>
	</div>
	
	<!-- 글 수정 모달 -->
	<!-- The Modal -->
		<div class="modal" id="mModal">
		  <div class="modal-dialog">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">Modal Heading</h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		      	<form name="mform" id="mform">
		      		<label>작성자</label>
					<input type="text" id="mwriter" name="writer" class="txt">
					<input type="hidden" id="mnum" name="num" value="">
					<br>
					<label>제목</label>
					<input type="text" id="msubject" name="subject" class="txt">
					<br>
					<label>이메일</label>
					<input type="text" id="mmail" name="mail" class="txt">
					<br>
					<label>비밀번호</label>
					<input type="password" id="mpassword" name="password" class="txt">
					<br>
					<label>내용</label><br>
					<textarea rows="5" cols="30" id="mcontent" name="content" class="txt"></textarea>
					<br><br>
					<input type="button" value="확인" id="msend">
				</form>
		      </div>
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
</body>
</html>