<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	// param 받기
	String title = request.getParameter("title");
	int type = Integer.parseInt(request.getParameter("type"));
	int qnum = Integer.parseInt(request.getParameter("qnum"));
	
	// item.content 공백요소는 제외해야함
	String[] contents = request.getParameterValues("content");

	// Question 모델 호출해서 수정
	QuestionDao questionDao = new QuestionDao();
	QuestionDto questionDto = new QuestionDto();
	questionDao.updateQuestion(questionDto); 
	
	ArrayList<ItemDto> itemList = new ArrayList<>();
	
	// 아이템들 받기
	int inum = 1;
	for(String s : contents){
		if(s.isEmpty()){
			continue;
		}
		ItemDto itemDto = new ItemDto();
		
		itemDto.setQnum(qnum);
		itemDto.setInum(inum);
		itemDto.setContent(s);
		
		itemList.add(itemDto);
		inum++;
	}
	
	
	// Item 모델 호출해서 DELETE 후 INSERT
	ItemDao itemDao = new ItemDao();
	
	// DELETE
	itemDao.deleteItem(qnum);
	
	// INSERT
	for(ItemDto i : itemList){
		itemDao.insertItem(i);
	}
	
	// view가 필요가 없다 -> 새로운 요청 pollList.jsp
	response.sendRedirect("/poll/pollList.jsp");
%>