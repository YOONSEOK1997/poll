<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 업로드</title>
</head>
<body>
	<form action ="/poll/imgBoard/insertImageAction.jsp" method="post" enctype="multipart/form-data">
		<div>메모 :<input type="text" name="memo"/></div>
		<div>이미지 : <input type="file" name="imageFile" /> </div>
	
		<button type="submit" > 이미지 등록 </button>
	</form>
</body>
</html>