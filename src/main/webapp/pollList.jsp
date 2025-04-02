<%@page import="model.QuestionDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%
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

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>설문 리스트</title>
    <style>
        body { background-color: #f8f8f8; font-family: Arial, sans-serif; padding: 20px; }
        .container { max-width: 800px; margin: auto; background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }
        h1 { text-align: center; color: #333; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: center; }
        th { background-color: #f2f2f2; }
        tr:hover { background-color: #f1f1f1; }
        a { text-decoration: none; color: #007bff; }
        a:hover { text-decoration: underline; }
        .pagination { text-align: center; margin: 20px 0; }
        .pagination a { margin: 0 5px; padding: 8px 12px; background-color: #007bff; color: white; border-radius: 4px; }
        .pagination a:hover { background-color: #0056b3; }
    </style>
</head>
<body>
    <div class="container">
        <h1>설문 리스트</h1>
        <table>
            <tr>
                <th>No</th>
                <th>Title</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Type</th>
                <th>Vote</th>
            </tr>
            <% int no = (currentPage - 1) * rowPerPage + 1;
               for (QuestionDto q : list) {
                   boolean isBeforeStart = today.compareTo(q.getStartdate()) < 0;
                   boolean isInRange = q.getStartdate().compareTo(today) <= 0 && today.compareTo(q.getEnddate()) <= 0;
                   boolean isAfterEnd = today.compareTo(q.getEnddate()) > 0;
            %>
            <tr>
                <td><%= no++ %></td>
                <td><%= q.getTitle() %></td>
                <td><%= q.getStartdate() %></td>
                <td><%= q.getEnddate() %></td>
                <td><%= q.getType() %></td>
                <td>
                    <% if (isBeforeStart) { %>
                        투표 시작 전
                    <% } else if (isInRange) { %>
                        <a href="vote.jsp?num=<%= q.getNum() %>">투표하기</a>
                    <% } else if (isAfterEnd) { %>
                        투표 종료
                    <% } %>
                </td>
            </tr>
            <% } %>
        </table>
        <div class="pagination">
            <% int prevPage = (currentPage > 1) ? currentPage - 1 : 1; %>
            <% int nextPage = currentPage + 1; %>
            <a href="?currentPage=<%= prevPage %>">이전</a>
            <a href="?currentPage=<%= nextPage %>">다음</a>
        </div>
    </div>
</body>
</html>
