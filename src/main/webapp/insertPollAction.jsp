<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*"%>
<%
	// controller(1.요청값 분석, 2.모델 호출)
	// 1.요청값 분석
	String title = request.getParameter("title");
	String startdate = request.getParameter("startdate");
	String enddate = request.getParameter("enddate");
	int type = Integer.parseInt(request.getParameter("type"));

	// item.content
	String[] content = request.getParameterValues("content");
	// 공백요소를 제거 후 새로운 배열(ArrayList<String>)에 저장
	// ex) "a" , "b" , "c" ,          
	ArrayList<String> contentList = new ArrayList<>();
	for(String c : content) {
		if(!c.equals("")) {
			contentList.add(c);
		}
	}
	System.out.println(contentList);
	
	QuestionDto questionDto = new QuestionDto();
	questionDto.setTitle(title);
	questionDto.setStartdate(startdate);
	questionDto.setEnddate(enddate);
	questionDto.setType(type);
	
	// 2.Question 모델(DAO메서드) 호출
	QuestionDao questionDao = new QuestionDao();
	int qnum = questionDao.insertQuestion(questionDto);
	
	ArrayList<ItemDto> itemList = new ArrayList<>();
	int i = 1;
	for(String c : contentList) {
		ItemDto itemDto = new ItemDto();
		itemDto.setQnum(qnum);
		itemDto.setInum(i);
		itemDto.setContent(c);
		itemList.add(itemDto);
		i=i+1;
	}
	
	// 2-1.Item 모델(DAO메서드) 호출
	ItemDao itemDao = new ItemDao();
	for(ItemDto itemDto : itemList) {
		itemDao.insertItem(itemDto);
	}
	
	// view가 필요가 없다 -> 새로운 요청 pollList.jsp
	response.sendRedirect("/poll/pollList.jsp");
%>
