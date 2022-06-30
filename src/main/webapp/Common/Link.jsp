<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<table border="1" width="90%"> 
    <tr>
        <td align="center">
        <!-- 로그인 여부에 따른 메뉴 변화 -->
        <% if (session.getAttribute("UserId") == null) { %>
            <a href="../06Session/LoginForm.jsp">로그인</a>
        <% } else { %>
            <a href="../06Session/Logout.jsp">로그아웃</a>
        <% } %>
        	&nbsp;&nbsp;&nbsp;
        	<a href="../09PagingBoard/List.jsp?b_flag=notice">공지사항</a>
        	&nbsp;&nbsp;&nbsp;
        	<a href="../09PagingBoard/List.jsp?b_flag=qna">질문과답변</a>
        	&nbsp;&nbsp;&nbsp;
        	<a href="../09PagingBoard/List.jsp?b_flag=faq">자주묻는질문</a>
        	&nbsp;&nbsp;&nbsp;
        	<a href="../09PagingBoard/List.jsp?b_flag=ent">연애톡톡</a>
        	&nbsp;&nbsp;&nbsp;
        	<a href="../09PagingBoard/List.jsp?b_flag=staff">직원전용게시판</a>
        	&nbsp;&nbsp;&nbsp;
        	<!-- 게시판 5개 추가 작성 (멀티게시판처리 완료후 아래내용들 추가만 하니 게시판 생성끝) -->
        	<a href="../09PagingBoard/List.jsp?b_flag=unknow">익명게시판</a>
        	&nbsp;&nbsp;&nbsp;
        	<a href="../09PagingBoard/List.jsp?b_flag=postsc">상품후기</a>
        	&nbsp;&nbsp;&nbsp;
        	<a href="../09PagingBoard/List.jsp?b_flag=news">뉴스</a>
        	&nbsp;&nbsp;&nbsp;
        	<a href="../09PagingBoard/List.jsp?b_flag=wearh">날씨</a>
        	&nbsp;&nbsp;&nbsp;
        	<a href="../09PagingBoard/List.jsp?b_flag=stock">주식</a>
            <!-- 8장과 9장의 회원제 게시판 프로젝트에서 사용할 링크 -->
        </td>
    </tr>
</table>

