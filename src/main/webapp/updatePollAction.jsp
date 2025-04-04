<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>

<%
    // 요청 파라미터 가져오기
    String title = request.getParameter("title");
    int type = Integer.parseInt(request.getParameter("type"));
    int qnum = Integer.parseInt(request.getParameter("qnum"));
    String[] contents = request.getParameterValues("content");

    // 질문 업데이트
    QuestionDao questionDao = new QuestionDao();
    QuestionDto questionDto = new QuestionDto();
    questionDto.setNum(qnum);
    questionDto.setTitle(title);
    questionDto.setType(type);
    
    questionDao.updateQuestion(questionDto);

    // 아이템 목록 생성
    ArrayList<ItemDto> items = new ArrayList<>();
    int inum = 1;

    for (String s : contents) {
        if (s.isEmpty()) continue;

        ItemDto itemDto = new ItemDto();
        itemDto.setQnum(qnum);
        itemDto.setInum(inum);
        itemDto.setContent(s);

        items.add(itemDto);
        inum++;
    }

    // 기존 아이템 삭제 후 새로운 아이템 추가
    ItemDao itemDao = new ItemDao();
    itemDao.deleteItem(qnum);

    for (ItemDto i : items) {
        itemDao.insertItem(i);
    }

    // 리스트 페이지로 이동
    response.sendRedirect("/poll/pollList.jsp");
%>
