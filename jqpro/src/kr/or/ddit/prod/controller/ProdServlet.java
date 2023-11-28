package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.vo.ProdVO;

/**
 * Servlet implementation class ProdServlet
 */
@WebServlet("/ProdServlet.do")
public class ProdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ProdServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		// 1. 요청 시 전송 데이터 받기 - lprod_gu
		String lprod_gu = request.getParameter("lprod_gu");

		// 2. service객체 열기
		IProdService service = ProdServiceImpl.getService();

		// 3. service 메소드 호출 - 결과값 받기 - List
		List<ProdVO> prodList= service.selectByLgu(lprod_gu);

		// 4. 결과값을 request에 저장
		request.setAttribute("keylist", prodList);

		// 5. view페이지 이동 - json 배열객체 생성
		request.getRequestDispatcher("prodview/lguList.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. 요청 시 전송 데이터 받기 - prod_gu
		String prod_id = request.getParameter("prod_id");

		// 2. service객체 열기
		IProdService service = ProdServiceImpl.getService();

		// 3. service 메소드 호출 - 결과값 받기 - ProdVO
		ProdVO prodVo = service.selectById(prod_id);

		// 4. 결과값을 request에 저장
		request.setAttribute("keyvo", prodVo);

		// 5. view페이지 이동 - json 배열객체 생성
		request.getRequestDispatcher("prodview/prodDetail.jsp").forward(request, response);
	}

}
