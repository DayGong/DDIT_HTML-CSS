package kr.or.ddit.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.ddit.member.vo.MemberVO;

@WebServlet("/LogOut.do")
public class LogOut extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// session객체를 얻는다
		HttpSession hsession = request.getSession();
		
		MemberVO memVo = (MemberVO)hsession.getAttribute("loginOk");
		
		if (memVo != null) {
			hsession.removeAttribute("loginOk");
			hsession.removeAttribute("check");
		}
		
		// view
		request.getRequestDispatcher("/member/logpro.jsp").forward(request, response);
	}

}
