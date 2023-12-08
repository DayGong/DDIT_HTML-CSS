/**
 * 
 */

// 댓글 수정
RelpyUpdateServer = function() {
	$.ajax({
		url: `${mypath}/ReplyUpdate.do`,
		type: 'post',
		data: reply, // renum, cont
		success: function(res) {
			alert(res.flag);
			
			if (res.flag == "성공") {
				$(vp3).html(modiout);
			}
		},
		error: function(xhr) {
			alert('오류 상태: ' + xhr.status);
		},
		dataType: 'json'
	})
}

// 댓글 삭제
ReplyDeleteServer = function() {
	$.ajax({
		url: `${mypath}/ReplyDelete.do`,
		type: 'get',
		data: { "renum" : vidx },
		success: function(res) {
			// alert(res.flag);
			
			// 화면에서 삭제(비동기라 가능)
			if (res.flag == "성공") {
				$(gthis).parents('.reply-body').remove();
			}
		},
		error: function(xhr) {
			alert('오류 상태: ' + xhr.status);
		},
		dataType: 'json'
	})
}

// 댓글 리스트 가져오기
ReplyListServer = function() {
	$.ajax({
		url: `${mypath}/ReplyList.do`,
		async: false, // 동기 방식으로 실행
		type: 'get',
		data: { "bonum" : vidx }, // {"bonum" :  reply.bonum }
		success: function(res) {
			rcode = "";
			
			$.each(res, function(i, v) {
				content = v.cont;
				content = content.replaceAll(/\n/g, "<br>");
				
				rcode += 
				`<div class="reply-body">
					<div class="p12">
						<p class="p1">
							작성자 <span class="rwr">${v.name}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							날짜 <span class="rda">${v.redate}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</p>
						<p class="p2">`
							if(uvo != null && uvo.mem_name == v.name) {
								rcode += `
								<input type="button" idx="${v.renum}" value=" 댓글수정" name="r_modify" class="action">
								<input type="button" idx="${v.renum}" value="댓글삭제" name="r_delete" class="action">`
							}
							rcode += 
						`</p>
					</div>
					<p class="p3">${content}</p>
				</div>`;
			}); // 반복
			
			// 출력
			$(gthis).parents('.card').find('.reply-body').remove(); // empty()는 틀이 남는다.
			$(gthis).parents('.card').find('.card-body').append(rcode);
		},
		error: function(xhr) {
			alert('오류 상태: ' + xhr.status);
		},
		dataType: 'json'
	})
}

// 댓글 등록 
ReplyInsertServer  = function(){
	$.ajax({
		url: `${mypath}/ReplyInsert.do`,
		type: 'post',
		data: reply, // bonum, cont, name
		success: function(res) {
			if(res.flag == "성공") {
				// 댓글 리스트 출력
				ReplyListServer();
			}
		},
		error: function(xhr) {
			alert('오류 상태: ' + xhr.status);
		},
		dataType: 'json'
	})
}

// 조회수 증가
UpdateHitServer = function() {
	$.ajax({
		url: `${mypath}/BoardHitUpdate.do`,
		type: 'get',
		data: {"num" : vidx},
		success: function(res) {
			// alert(res.flag);
			
			// 성공했다면
			if(res.flag == "성공") {
				// 화면의 조회수 값을 변경
				// 조회수의 위치값 검색 
				vhit = $(gthis).parents('.card').find('.hit');
				
				// 그위치에서 현재 값을 가져온다   + 1
				hitvalue =   parseInt($(vhit).text().trim()) + 1;
				
				// 화면의 조회수 값을 변경 
				$(vhit).text(hitvalue);
			} 
			
		},
		error: function(xhr) {
			alert('오류 상태: ' + xhr.status);
		},
		dataType: 'json'
	})
}

// 게시글 수정
UpdateBoardServer = function() {
	$.ajax({
		url: `${mypath}/BoardUpdate.do`,
		type: 'post',
		data: mdata,
		success: function(res) {
			alert(res.flag);
			
			if(res.flag == "성공") {
				// 수정된 글만 화면에 다시 뿌려준다. - mdata의 값으로 본문의 내용을 변경
				$(vparents).find('.sub').text(mdata.subject);
				$(vparents).find('.em').text(mdata.mail);
				$(vparents).find('.pass').text(mdata.password);
				
				// 날짜 수정
				today = new Date();
				today = today.toLocaleString();
				$(vparents).find('.da').text(today);

				vcont = mdata.content; // 엔터가 포함된다
				// 엔터를 출력시에는 <br>로 바꿔 출력
				vcont.replaceAll(/\n/g, "<br>");
				$(vparents).find('.p3').html(mdata.content);
				
			} else {
				alert('글수정 오류');
			}
			
		},
		error: function(xhr) {
			alert('오류 상태: ' + xhr.status);
		},
		dataType: 'json'
	})
}

// 게시글 저장
WriteBoardServer = function() {
	$.ajax({
		url: `${mypath}/BoardWrite.do`,
		type: 'post',
		data: fdata,
		success: function(res) {
			// 성공했다면
			if(res.flag == "성공") {
				ListPageServer(1);
			} else {
				alert('글쓰기 오류');
			}
			
		},
		error: function(xhr) {
			alert('오류 상태: ' + xhr.status);
		},
		dataType: 'json'
	})
}

// 게시글 삭제 - 번호가 필요
DeleteBoardServer = function() {
	$.ajax({
		url: `${mypath}/BoardDelete.do`,
		type: 'get',
		data: {"num" : vidx},
		success: function(res) {
			alert(res.flag);
			
			// 성공했다면 ListPageServer를 호출
			//if (res.flag == "성공") {
				// 리스트 출력
				//ListPageServer(currentPage);
			//}
			
		},
		error: function(xhr) {
			alert('오류 상태: ' + xhr.status);
		},
		dataType: 'json'
	})
}

// ListPageServer = function(page){}
// ListPageServer = (page) => {}

// 호출 ListPageServer(1)
function ListPageServer(page) {
	// page 매개변수는 currentPage값이 넘어온 지역변수
	// 한 페이지당 3개씩 리스트 출력하기
	gpage = page;
	
	vtype = $('#stype').val().trim();
	vword = $('#sword').val().trim();
	
	$.ajax({
		url : "http://localhost/boardpro/boardList.do",
		type : 'post',
		data : {
			"page" : page,
			"stype" : vtype,
			"sword" : vword
		},
		success : function(res) {
			code = `<div class="container mt-3">
						<div id="accordion">`;
			
			$.each(res.jsonTreeResult, function(i, v) {
				content = v.content;
				// 엔터 기호를 <br>로 변경 - //g 플래그는 전역 검색
				content = content.replaceAll(/\n/g, "<br>");
				
				code += `<div class="card">
							<div class="card-header">
								<a class="btn sub action" idx="${v.num}" name="list" data-bs-toggle="collapse" href="#collapse${v.num}">
									${v.subject} </a>
							</div>
				<div id="collapse${v.num}" class="collapse"	data-bs-parent="#accordion">
					<div class="card-body">
						<div class="p12">
							<p class="p1">
								작성자 <span class="wr">${v.writer}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span style="display:none;" class="pass">${v.password}</span>
								이메일 <span class="em">${v.mail}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								조회수 <span class="hit">${v.hit}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								날짜 <span class="da">${v.wdate}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								
							</p>
							<p class="p2">`
							if(uvo != null && uvo.mem_name == v.writer) {
								code += `<input type="button" idx="${v.num}" value="수정" name="modify" class="action">
								<input type="button" idx="${v.num}" value="삭제" name="delete" class="action">`
							}
							code += `</p>
						</div>
						<p class="p3">${content}</p>
						<p class="p4">
							<textarea rows="" cols="60"></textarea>
							<input type="button" idx="${v.num}" value="등록" name="reply" class="action">
						</p>
					</div>
				</div>
			</div>`;
			})
			
			code += `</div>
					</div>`;
					
			$('#result1').html(code);
			
			vpage = pageList(res.startPage, res.endPage, res.totalPage);
			
			// vpage 출력
			$('#pagelist').html(vpage);
		},
		error : function(xhr) {
			alert("오류 상태: " + xhr.status);
		},
		dataType : 'json'
	})
}

pageList = function (startpage, endpage, totalpage) {
	// pagelist 모양 만들기
	pager = "";
	pager += `<ul class="pagination">`;
	
	// 이전페이지(previous)
	if ( startpage > 1) {
		pager += `<li class="page-item"><a id="prev" class="page-link" href="#">Previous</a></li>`;
	}
	
	// 페이지번호
	if(gpage > totalpage) currentPage = t;
	for (i = startpage; i <= endpage; i++) { // 1, 2
		if (i == currentPage) {
			pager += `<li class="page-item active"><a class="page-link pageno" href="#">${i}</a></li>`;
		} else {
			pager += `<li class="page-item"><a class="page-link pageno" href="#">${i}</a></li>`;
		}
	}
	
	// 다음페이지
	if ( endpage < totalpage) {
		pager += `<li class="page-item"><a id="next" class="page-link" href="#">Next</a></li>`;
	}
	
	pager += `</ul>`;
	
	return pager;
}