/**
 * 
 */

function proc1() {
	// 랜덤 발생
	cr = parseInt(Math.random() * 256)
	cg = parseInt(Math.random() * 256)
	cb = parseInt(Math.random() * 256)
	
	// div를 검색 => id=res
	// let vres = window.document.getElementById('res1');
	// window. 생략 가능
	let vres = document.querySelector('#res1')
	
	/*vres.style.background = "rgb(" + cr + 
							  ", " + cg + 
							  ", " + cb + ")";*/
	
	/* 백틱(``)을 이용한 템플릿 문자열(리터럴)*/
	vres.style.background = `rgb(${cr}, ${cg}, ${cb})`;				
}