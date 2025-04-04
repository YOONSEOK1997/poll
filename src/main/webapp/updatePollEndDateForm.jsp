<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   
    String num = request.getParameter("num");  
  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>종료날짜수정</title>
</head>
<body>
<h1>종료날짜수정</h1>
    <form method="post" action="/poll/updatePollEndDateAction.jsp">
      <input type="hidden" name="num" value="<%= num %>">
        <table border="1">
            <tr>
                <td>종료일</td>
                <td><input type="date" name="enddate"></td>
            </tr> 
        </table>
        
        <button type="submit">수정</button>
    </form>
</body>
</html>
