<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ include file="./IsLoggedIn.jsp"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<script type="text/javascript">
function validateForm(form) { 
    if (form.title.value == "") {
        alert("제목을 입력하세요.");
        form.title.focus();
        return false;
    }
    if (form.content.value == "") {
        alert("내용을 입력하세요.");
        form.content.focus();
        return false;
    }
}
</script>
</head>
<body>
<jsp:include page="../Common/Link.jsp" />

<!-- 전달받은 b_flag 받을려고 추가 -->
<%
String boardTitle = "";
if(request.getParameter("b_flag").equals("notice")){
	boardTitle = "공지사항";
}
else if(request.getParameter("b_flag").equals("qna")){
	boardTitle = "질문과답변";
}
else if(request.getParameter("b_flag").equals("faq")){
	boardTitle = "자주묻는질문";
}
else if(request.getParameter("b_flag").equals("ent")){
	boardTitle = "연애톡톡";
}
else if(request.getParameter("b_flag").equals("staff")){
	boardTitle = "직원전용";
}
%>
<h2><%=boardTitle %> - 글쓰기(Write)</h2>
<form name="writeFrm" method="post" action="WriteProcess.jsp"
    onsubmit="return validateForm(this);">
      
<!-- 게시판의 플레그(b_flag)를 전달한 용도의 hidden박스를 추가한다 -->  
<input type="hid-den" name="b_flag" value="${param.b_flag }" />
      
    <table border="1" width="90%">
        <tr>
            <td>제목</td>
            <td>
                <input type="text" name="title" style="width: 90%;" />
            </td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="content" style="width: 90%; height: 100px;"></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type="submit">작성 완료</button>
                <button type="reset">다시 입력</button>
                <button type="button" onclick="location.href='List.jsp';">
                    목록 보기</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>

