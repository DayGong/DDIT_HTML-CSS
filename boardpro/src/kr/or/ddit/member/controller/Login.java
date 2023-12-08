package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.mybatis.config.MybatisUtil;

@WebServlet("/LogIn.do")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// id와 pass값 받기
		String userId = request.getParameter("id");
		String userPass = request.getParameter("pass");
		
		// service객체 얻기
		IMemberService service = MemberServiceImpl.getService();
		
		// service메소드 호출 - 결과값 받기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_id", userId);
		map.put("mem_pass", userPass);
		
		MemberVO memVo = service.loginProc(map);
		
		// 세션 생성
		HttpSession hsession = request.getSession(); 
		
		// 로그인 성공 - 세션에 값을 저장
		if ( memVo != null ) {
			hsession.setAttribute("loginOk", memVo);
			hsession.setAttribute("check", "true");
		} else { // 로그인 실패
			hsession.setAttribute("check", "false");
		}
		
		// view페이지로 이동 - logpro.jsp
		request.getRequestDispatcher("/member/logpro.jsp").forward(request, response);
	}

}
