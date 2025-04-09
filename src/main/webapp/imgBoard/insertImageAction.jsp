<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	String memo = request.getParameter("memo");	
	Part part = request.getPart("imageFile"); // 파일 받는 API
	String originalName = part.getSubmittedFileName();
	System.out.println("originalName: "+originalName);
	
	// 1) 중복되지 않는 새로운 파일이름 생성 - java.util.UUID API 사용
	UUID uuid = UUID.randomUUID();
	String fileName = uuid.toString();
	fileName = fileName.replace("-", "");
	System.out.println("uuid str: "+fileName);

	// 2) 1의 결과에 확장자 추가
	int dotLastPos = originalName.lastIndexOf("."); // 마지막 . 의 인덱스값 반환
	System.out.println("dotLastPos: "+dotLastPos);
	String ext = originalName.substring(dotLastPos);
	
	//request 입력값 유효성 검증
	if(!ext.equals(".png")) {
		response.sendRedirect("/poll/imgBoard/insertImageForm.jsp?msg=ErrorNotPng");
	return;
	}
	
	fileName = fileName + ext;
	System.out.println("fileName: "+fileName);
	
	ImageDto img = new ImageDto();
	img.setMemo(memo);
	img.setFileName(fileName);
	
	// 3) 파일저장
	// 빈파일 생성
	// File emptyFile = new File("c:/upload/a.png");
	String path = request.getServletContext().getRealPath("upload"); 
	// 톰켓안에 poll 프로젝트안 upload폴더 실제 물리적주소를 반환
	System.out.println("path: "+path);
	File emptyFile = new File(path, fileName);
	// 파일을 보낼 inputstram 설정
	InputStream is = part.getInputStream(); // 파트안의 스트림(이미지파일의 바이너리파일)
	// 파일을 받을 outputstream 설정
	OutputStream os = Files.newOutputStream(emptyFile.toPath());
	is.transferTo(os); // inputstream binary -> 반복(1byte씩) -> outputstream
	
	// 4) db의 저장
	ImageDao imageDao = new ImageDao();
	imageDao.insertImage(img);
	response.sendRedirect("/poll/imgBoard/imageList.jsp");
%>
