<%@page import="model1.board.BoardDAO"%>
<%@page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %>
<%
String title = request.getParameter("title");
String content = request.getParameter("content");
String b_flag = request.getParameter("b_flag");//플레그 추가

BoardDTO dto = new BoardDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setB_flag(b_flag);//플레그 추가
dto.setId(session.getAttribute("UserId").toString());

BoardDAO dao = new BoardDAO(application);

int iResult = 0;
iResult = dao.insertWrite(dto);

/* int iResult = 0;
for(int i=1 ; i<=100 ; i++){
	dto.setTitle(title +"-" + i);
	iResult = dao.insertWrite(dto);
} */

dao.close();

if(iResult == 1){
	//b_flag추가
	response.sendRedirect("List.jsp?b_flag="+b_flag);
}
else{
	JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}
%>
