<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>book update form</title>
<link rel="stylesheet" href="../css/bookListForm.css">
</head>
<body>
<img alt="로고" src="../image/booboobooklogo-remove.jpeg" id="logo_image" onclick="location='/BooBooBookProject/'" style="cursor: pointer;">
	<form id="updateForm">
		<table border="1" class="updateForm">
			<tr>
                <th><label for="subject">책 제목</label></th>
                <td>
                	<input type="text" id="subject" name="subject" value="${bookDTO.subject}">
                </td>
            </tr>
            <tr>
                <th><label for="author">책 저자</label></th>
                <td>
                	<input type="text" id="author" name="author" value="${bookDTO.author}">
                </td>
            </tr>
            <tr>
                <th><label for="content">책 내용 요약</label></th>
                <td>
                	<textarea id="content" name="content" style="width: 500px; height: 250px;">${bookDTO.content}</textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                	<span id="showImageList">
                		<img src="https://kr.object.ncloudstorage.com/bitcamp-9th-bucket-141/storage/${bookDTO.imageFileName}" 
                		alt="${ bookDTO.subject }" width="100" height="100"/>
                	</span>
                	<img src="../image/camera.png" id="cameraimage" style="width: 100px; height: 100px;">
                	<input type="file" name="img[]" id="img" multiple = "multiple" style="visibility: hidden;">
                	<input type="hidden" name="seq" value="${seq}">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                	<div class="button-container">
	                    <input type="button" class="submit-btn" value="북 정보 수정" id="updateButton">
	                    <input type="reset" class="submit-btn" value="취소">
	                </div>
                </td>
            </tr>
		</table>
	</form>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="../js/updateBook.js"></script>	
</body>
</html>