<%@page import="model.QuestionDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%
    // 설문 리스트 -> 페이징 -> title 링크(startDate <= 오늘날짜 <= endDate) -> 투표 프로그램
    int currentPage = 1;
    if (request.getParameter("currentPage") != null) {
        currentPage = Integer.parseInt(request.getParameter("currentPage"));
    }
    int rowPerPage = 3;
    Paging paging = new Paging();
    paging.setCurrentPage(currentPage);
    paging.setRowPerPage(rowPerPage);

    QuestionDao questionDao = new QuestionDao();
    ArrayList<QuestionDto> list = questionDao.selectQuestionList(paging);

    // 오늘 날짜 구하기
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문 리스트</title>
</head>
<body>
    <h1>설문 리스트</h1>
    <table border="1">
        <tr>
            <th>No</th>
            <th>Title</th>
            <th>Start Date</th>
            <th>End Date</th>
            <th>Type</th>
        </tr>
        <%
            int no = (currentPage - 1) * rowPerPage + 1;
            for (QuestionDto q : list) {
                boolean isInRange = q.getStartdate().compareTo(today) <= 0 && today.compareTo(q.getEnddate()) <= 0;
        %>
        <tr>
            <td><%= no++ %></td>
            <td>
                <% if (isInRange) { %>
                    <!-- 링크로 표시 -->
                    <a href="vote.jsp?num=<%= q.getNum() %>"><%= q.getTitle() %></a>
                <% } else { %>
                    <!-- 그냥 텍스트로 표시 -->
                    <%= q.getTitle() %>
                <% } %>
            </td>
            <td><%= q.getStartdate() %></td>
            <td><%= q.getEnddate() %></td>
            <td><%= q.getType() %></td>
        </tr>
        <% } %>
    </table>

    <!-- 페이지 이동 -->
    <div>
        <% int prevPage = (currentPage > 1) ? currentPage - 1 : 1; %>
        <% int nextPage = currentPage + 1; %>
        <a href="?currentPage=<%= prevPage %>">이전</a>
        <a href="?currentPage=<%= nextPage %>">다음</a>
    </div>
</body>
</html>
