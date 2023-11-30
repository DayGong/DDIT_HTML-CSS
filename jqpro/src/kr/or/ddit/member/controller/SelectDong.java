package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.ZipVO;

@WebServlet("/SelectDong.do")
public class SelectDong extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		// 요청시 전송 데이터 받기 - dong
		String dong = request.getParameter("dong");
		
		// service객체 얻어오기
		IMemberService service = MemberServiceImpl.getService();
		
		// service메소드 호출하기 - List<ZipVO>
		List<ZipVO> zipList = service.selectByDong(dong);
		
		// 결과값을 request에 저장
		request.setAttribute("zipList", zipList);
		
		// view페이지 이동
		request.getRequestDispatcher("memberview/selectDong.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
