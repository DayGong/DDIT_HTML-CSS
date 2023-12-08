package kr.or.ddit.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;

@WebServlet("/IdCheck.do")
public class IdCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 요청 시 전송 데이터 받기
		String mem_id = request.getParameter("mem_id");
				
		// service 객체 얻기
		IMemberService service = MemberServiceImpl.getService();
				
		// service메소드 호출 결과값 가져오기 - String
		String res = service.selectById(mem_id);
				
		// null 또는 a001, b001, c001 ~
		// 결과값을 request에 저장
		request.setAttribute("key_memId", res);
		
		// view페이지로 이동
		request.getRequestDispatcher("memberview/idcheck.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
