package kr.or.ddit.lprod.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.lprod.service.ILprodService;
import kr.or.ddit.lprod.service.LprodServiceImpl;
import kr.or.ddit.lprod.vo.LprodVO;

/**
 * Servlet implementation class LprodList
 */
@WebServlet("/LprodList.do")
public class LprodList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LprodList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 요청 시 전송 데이터 받기
		
		// service객체가 필요
		ILprodService service = LprodServiceImpl.getService();
		
		// service메소드 호출 - 결과값 받기
		List<LprodVO> list = service.selectLprod();
		
		// 결과값으로 응답 데이터를 생성 - 결과값을 출력 - view페이지로 보내기
		
		// request에 결과값을 저장
		request.setAttribute("listkey", list);
		
		// redirect나 forward를 이용하여 view페이지로 이동
		// redirect는 결과값을 view페이지와 공유할 수 없다. 단순 출력에 사용
		// forward를 이용하면 결과값을 view페이지와 공유할 수 있다.
		request.getRequestDispatcher("1127/lprodView.jsp").forward(request, response);
	}

}
