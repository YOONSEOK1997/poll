<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dto.*" %>
<%@ page import = "model.*" %>
<%@ page import = "java.util.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	ImageDao ImageDao = new ImageDao();
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(10);
	ArrayList<ImageDto> list = ImageDao.selectImageList(p);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		for(ImageDto i : list) {
	%>
			<table border="1">
				<tr>
					<td><%=i.getMemo()%></td>
				</tr>
				<tr>
					<td>
						<img src="/poll/upload/<%=i.getFileName()%>" style="width:400px; height:400px; object-fit:cover;">
					</td>
				</tr>
				<tr>
					<td>
						<a href="/poll/imgBoard/deleteImage.jsp?num=<%=i.getNum()%>&filename=<%=i.getFileName()%>">삭제</a>
					</td>
				</tr>
			</table>
			
			<hr>
	<%		
		}
	%>
	
	<a href="/poll/imgBoard/insertImageForm.jsp">올리기</a>
</body>
</html>
