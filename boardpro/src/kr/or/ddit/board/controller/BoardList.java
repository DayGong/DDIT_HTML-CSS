package kr.or.ddit.board.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.BoardVO;
import kr.or.ddit.board.vo.PageVO;

@WebServlet("/boardList.do")
public class BoardList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 요청 시 전송 데이터 받기 - page, stype, sword
		int spage = Integer.parseInt(request.getParameter("page")); // 최초 실행시 1
		String stype = request.getParameter("stype");				// 최초 실행시 값이 없다
		String sword = request.getParameter("sword");				// 최초 실행시 값이 없다
		
		// service객체
		IBoardService service = BoardServiceImpl.getInstance();
		
		// 메소드 호출 - 페이지 정보 값
		PageVO vo = service.getPageInfo(spage, stype, sword);
		// 리턴값 : start, end, startPage, endPage, totalPage
		
		// 해당 페이지에따라 게시판 글을 3개씩 가져오기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", vo.getStart());
		map.put("end", vo.getEnd());
		map.put("stype", stype);
		map.put("sword", sword);
		
		// 1페이지: 1~3, 2페이지: 4~6, 3페이지: 7~9, ...
		// 1페이지: 1~2, 2페이지: 1~2, 3페이지: 3~4, 4페이지:3~4, 5페이지: 5~6, ...
		List<BoardVO> list = service.selectByPage(map);
		
		// list 결과값을 request에 저장
		request.setAttribute("pagelist", list);	// 게시판 글 3개가 저장
		request.setAttribute("startPage", vo.getStartPage());   // 1
		request.setAttribute("endPage", vo.getEndPage());		// 2
		request.setAttribute("totalPage", vo.getTotalPage());	// 7
		
		request.getRequestDispatcher("boardview/listPage.jsp").forward(request, response);
		
	}

}
