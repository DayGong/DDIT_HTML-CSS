package kr.or.ddit.board.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;

@WebServlet("/ReplyDelete.do")
public class ReplyDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 전송데이터 가져오기 - renum
		int renum = Integer.parseInt(request.getParameter("renum"));
		
		// service 객체 얻어오기
		IBoardService service = BoardServiceImpl.getInstance();
		
		// service 메소드 호출하기 - int
		int res = service.deleteReply(renum);
		
		// 결과값을 저장
		request.setAttribute("result", res);
		
		// view페이지로 이동
		request.getRequestDispatcher("boardview/result.jsp").forward(request, response);
	}
}
