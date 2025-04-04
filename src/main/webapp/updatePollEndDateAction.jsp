<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*"%>
<%
    String enddate = request.getParameter("enddate");
    int num = Integer.parseInt(request.getParameter("num"));  
  
    QuestionDto questionDto = new QuestionDto();
    questionDto.setEnddate(enddate);
    questionDto.setNum(num);  
    
    QuestionDao questionDao = new QuestionDao();
    questionDao.updateQuestionEndDate(questionDto);  
    
	response.sendRedirect("/poll/pollList.jsp");
%>

