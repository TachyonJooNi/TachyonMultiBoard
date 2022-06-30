<%@page import="utils.BoardPage"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="model1.board.BoardDAO"%>
<%@ page import="model1.board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
BoardDAO dao = new BoardDAO(application);


Map<String, Object> param = new HashMap<String, Object>();

//멀티게시판 구현을 위해 반드시 필요한 파라미터
String b_flag = request.getParameter("b_flag");
//파라미터를 DAO로 전달하기 위해 Map컬렉션에 저장한다.
param.put("b_flag", b_flag);

String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
if (searchWord != null) {
    param.put("searchField", searchField); 
    param.put("searchWord", searchWord); 
}
//b_flag까지 넣어서 전달하고 DAO로 가서 selectCount() 수정
int totalCount = dao.selectCount(param);

int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));

int totalPage = (int)Math.ceil((double)totalCount / pageSize); 

int pageNum = 1; 
String pageTemp = request.getParameter("pageNum");
if (pageTemp != null && !pageTemp.equals(""))
 	pageNum = Integer.parseInt(pageTemp); 

int start = (pageNum - 1) * pageSize + 1;
int end = pageNum * pageSize;
param.put("start", start);
param.put("end", end);

//b_flag까지 넣어서 전달하고 DAO로 가서 selectListPage() 수정
List<BoardDTO> boardLists = dao.selectListPage(param);

dao.close();   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원제 게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../Common/Link.jsp" />  

    <h2>목록 보기(List) - 현재 페이지 : <%= pageNum %> (전체 : <%= totalPage %>)</h2>
    <form method="get">  
    <table border="1" width="90%">
    <tr>
        <td align="center">
            <select name="searchField"> 
                <option value="title">제목</option> 
                <option value="content">내용</option>
            </select>
            <input type="text" name="searchWord" />
            <input type="submit" value="검색하기" />
        </td>
    </tr>   
    </table>
    </form>
    <table border="1" width="90%">
        <tr>
            <th width="10%">번호</th>
            <th width="50%">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
        </tr>
<%
if (boardLists.isEmpty()) {
%>
        <tr>
            <td colspan="5" align="center">
                등록된 게시물이 없습니다^^*
            </td>
        </tr>
<%
}
else {
    int virtualNum = 0;
    int countNum = 0;
    
    for (BoardDTO dto : boardLists)
    {
    	
    	virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++);
%>
        <tr align="center">
            <td><%= virtualNum %></td>  
            <td align="left"> 
                <a href="View.jsp?num=<%= dto.getNum() %>&b_flag=<%=dto.getB_flag()%>"><%= dto.getTitle() %></a> 
            </td>
            <td align="center"><%= dto.getId() %></td>           
            <td align="center"><%= dto.getVisitcount() %></td>   
            <td align="center"><%= dto.getPostdate() %></td>    
        </tr>
<%
    }
}
%>
    </table>
   
    <table border="1" width="90%">
        <tr align="center">
        	<td>
        		<ul class="pagination">
                <%= BoardPage.pagingStr(totalCount, pageSize,
                       blockPage, pageNum, request.getRequestURI()) %>
                </ul>
            </td>
            <!-- b_flag 전달 -->
            <!-- 우리는 EL을 배웠으니까 굳이 getParameter() 쓸 필요없다. -->
            <td><button type="button" onclick="location.href='Write.jsp?b_flag=${param.b_flag}';">글쓰기
                </button></td>
        </tr>
        <tr>
        	<td>
	        	<ul class="pagination">
				  <li class="page-item"><a class="page-link" href="#">이전</a></li>
				  <li class="page-item"><a class="page-link" href="#">1</a></li>
				  <li class="page-item"><a class="page-link" href="#">2</a></li>
				  <li class="page-item"><a class="page-link" href="#">3</a></li>
				  <li class="page-item"><a class="page-link" href="#">다음</a></li>
				</ul>
        	</td>
        </tr>
    </table>
</body>
</html>
