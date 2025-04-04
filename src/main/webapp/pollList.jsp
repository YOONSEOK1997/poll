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
    int rowPerPage = 5;
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
   <link rel="stylesheet" type="text/css" href="/poll/css/poll.css?after">
</head>
<body>
    <div class="container">
        <h1>설문 리스트</h1>
        
        <table>
            <tr>
                <th>No</th>
                <th>제목</th>
                <th>시작일자</th>
                <th>종료일자</th>
                <th>Type</th>
                <th>가능한투표</th>
                <th>투표자수</th>
                <th>종료날짜수정</th>
                <th>수정</th>
                <th>삭제</th>
                <th>결과</th>
            </tr>
            <% int no = (currentPage - 1) * rowPerPage + 1;
               for (QuestionDto q : list) {
                   boolean isBeforeStart = today.compareTo(q.getStartdate()) < 0; 
                   boolean isInRange = q.getStartdate().compareTo(today) <= 0 && today.compareTo(q.getEnddate()) <= 0;
                   boolean isAfterEnd = today.compareTo(q.getEnddate()) > 0;
            %>
            <tr>
                <td><%= q.getNum()%></td>
                <td><%= q.getTitle() %></td>
                <td><%= q.getStartdate() %></td>
                <td><%= q.getEnddate() %></td>
                <td><%= q.getType() %></td>
              
                <td>
                    <% if (isBeforeStart) { %>
                        투표 시작 전
                    <% } else if (isInRange) { %>
                        <a href="updateItemForm.jsp?num=<%= q.getNum() %>">투표하기</a>
                    <% } else if (isAfterEnd) { %>
                        투표 종료
                    <% } %>
                </td>
             
                <td><%= q.getTotalCount() %></td>
                <td><a href ="updatePollEndDateForm.jsp?num=<%=q.getNum()%>">종료날짜수정</a></td>
           		   <td>
                    <%if(q.getTotalCount() > 0)  {%>
                	<a style="color: red;">수정 불가</a> 
                    <% } else { %>
               <a href="updatePollForm.jsp?num=<%=q.getNum()%>">수정</a>
                 <%}%>
                </td> 
           	
                <td>
                    <%if(q.getTotalCount() > 0)  {%>
                	<a style="color: red;">삭제 불가</a> 
                    <% } else { %>
                <a href="/poll/deletePollAction.jsp?num=<%=q.getNum()%>">삭제</a>
                 <%}%> 
                </td>  
               <td>
					<%
					if (isAfterEnd){
					%>
							<a href='/poll/questionOneResult.jsp?qnum=<%=q.getNum()%>'>결과보기</a>
					<%		
						} else {
					%>
							투표진행중
					<%		
						}
					%>
				</td>

           
            </tr>
            <% } %>
        </table>
        
     	<button type ="button" onclick = "location.href='insertPollForm.jsp'">등록</button>
        <div class="pagination">
            <% int prevPage = 1;
               if (currentPage > 1) {
                   prevPage = currentPage - 1;
               } %>
            <% int nextPage = currentPage + 1; %>
            <a href="?currentPage=<%= prevPage %>">이전</a>
            <a href="?currentPage=<%= nextPage %>">다음</a>
        </div>
    </div>
</body>
</html>
