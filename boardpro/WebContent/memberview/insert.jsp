<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int res = (Integer)request.getAttribute("insertRes");
	
	if(res > 0) {
%>
		{
			"sw" : "가입을 축하합니다."
		}
<%	} else { %>
		{
			"sw" : "가입에 실패하였습니다."
		}
<%
	}
%>