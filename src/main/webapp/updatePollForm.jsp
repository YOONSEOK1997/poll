<%@page import="java.util.ArrayList"%>
<%@page import="model.*"%>
<%@page import="dto.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
int num = Integer.parseInt(request.getParameter("num"));
QuestionDao questionDao = new QuestionDao();
QuestionDto questionDto = questionDao.selectQuestionByNum(num); // 여기 수정!
ItemDao itemDao = new ItemDao();
ArrayList<ItemDto> items = itemDao.selectItem(num);
int i = 1;
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투표 수정</title>
</head>
<body>
	<h1>투표 수정</h1>
	<hr>
	<h2>설문 수정</h2>
	<form method="post" action="/poll/updatePollAction.jsp">
		<input type="hidden" name="qnum" value="<%=num%>">
		<table border="1">
			<tr>
				<td>질문</td>
				<td colspan="2">
					<input type="text" name="title" value="<%=questionDto.getTitle()%>">
				</td>
			</tr>
			<tr>
					<td rowspan="8"></td>
					<%
						for (ItemDto item : items) {
					%>
							<td><%=i%>) <input type="text" name="content" value='<%=item.getContent()%>'></td>
					<%
							if (i % 2 == 0) {
					%>
								</tr><tr>
					<%		}
						i++; 
						}
					
						while (i <= 8) {
					%>
							<td><%=i%>) <input type="text" name="content"></td>
					<%
							if (i % 2 == 0) {
					%>
								</tr><tr>
					<%
							}
						i++;
						}
					%>
					<td>시작일</td>
					<td>
						<input type="date" name="startdate" value='<%=questionDto.getStartdate()%>'>
					</td>
				</tr>
			<tr>
				<td>종료일</td>
				<td><input type="date" name="enddate" value="<%=questionDto.getEnddate()%>"></td>
			</tr>
			<tr>
				<td>복수투표</td>
				<td>
					<input type="radio" name="type" value="1" <%=questionDto.getType() == 1 ? "checked" : ""%>>yes
					<input type="radio" name="type" value="0" <%=questionDto.getType() == 0 ? "checked" : ""%>>no
				</td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
		<button type="reset">다시쓰기</button>
		<a href="/poll/pollList.jsp">리스트</a>
	</form>
</body>
</html>