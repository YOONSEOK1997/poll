<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "model.*" %>
<%@ page import = "dto.*" %>
<%@ page import = "java.util.*" %>
<%
	// Contoroller : request 분석 + model 호출
	int qnum = Integer.parseInt(request.getParameter("qnum"));

	// 1) questionOne
	QuestionDao questionDao = new QuestionDao();
	QuestionDto question = questionDao.selectQuestionByNum(qnum); 
	// 2) 1)의 itemList
	ItemDao itemDao = new ItemDao();
	ArrayList<ItemDto> itemList = itemDao.selectItemListbyQnum(qnum);
	// 3) 총투표수
	int totalCount = itemDao.selectItemCountByQnum(qnum);
%>



<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1><%=qnum%>번 설문 투표결과</h1>
	<table border="1">
		<tr>
			<td colspan="4">
				Q : <%=question.getTitle()%>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				총 투표수 : <%=totalCount%>
			</td>
		</tr>
		<tr>
			<td>번호</td><td>내용</td><td>카운트(차트)</td><td>카운트</td>
		</tr>
		
		<%
			for(ItemDto i : itemList) {
		%>
				<tr>
					<td><%=i.getInum()%></td>
					<td><%=i.getContent()%></td>
					<td>
						<!-- 각 count값에 대한 백분율 값 -->
						<%
							int percentage = (int)(Math.round((double)i.getCount() / (double)totalCount * 100));
							
							for(int n=1; n<=percentage; n=n+1) {
						%>
								*
						<%
							}
						%>
					</td>
					<td><%=i.getCount()%></td>
				</tr>
		<%		
			}
		%>
	</table>
</body>
</html>
