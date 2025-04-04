<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%

	int qnum = Integer.parseInt(request.getParameter("num"));
	
	ItemDao itemDao = new ItemDao();
	
	QuestionDao questionDao = new QuestionDao();
	
	// item 먼저 삭제 후 question 삭제
	itemDao.deleteItem(qnum);
	questionDao.deleteQuestion(qnum);
	
	response.sendRedirect("/poll/pollList.jsp");
%>


