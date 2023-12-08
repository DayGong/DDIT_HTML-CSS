package kr.or.ddit.board.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.ddit.board.service.BoardServiceImpl;
import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.board.vo.ReplyVO;

@WebServlet("/ReplyInsert.do")
public class ReplyInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 전송데이터 받기 - bonum, name, cont
		ReplyVO replyVo = new ReplyVO();
		try {
			BeanUtils.populate(replyVo, request.getParameterMap());
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}
		
		// service객체 얻기
		IBoardService service = BoardServiceImpl.getInstance();
		
		// service메소드 호출 - 결과값 int
		int res = service.insertReply(replyVo);
		
		// request에 결과값 저장
		request.setAttribute("result", res);
		
		// view페이지로 이동
		request.getRequestDispatcher("boardview/result.jsp").forward(request, response);
	}

}
