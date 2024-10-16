<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book List Form</title>
<link rel="stylesheet" href="../css/bookListForm.css">
</head>
<body>
	<img alt="로고" src="../image/booboobooklogo-remove.jpeg" id="logo_image" onclick="location='/BooBooBookProject/'" style="cursor: pointer;">
	<form id="uploadForm">
		<table border="1" class="uploadForm">
			<tr>
                <th><label for="subject">책 제목</label></th>
                <td>
                	<input type="text" id="subject" name="subject">
                </td>
            </tr>
            <tr>
                <th><label for="author">책 저자</label></th>
                <td>
                	<input type="text" id="author" name="author">
                </td>
            </tr>
            <tr>
                <th><label for="content">책 내용 요약</label></th>
                <td>
                	<textarea id="content" name="content" style="width: 500px; height: 250px;"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                	<span id="showImageList">이미지 미리보기</span>
                	<img src="../image/camera.png" id="cameraimage" style="width: 100px; height: 100px;">
                	<input type="file" name="img[]" id="img" multiple = "multiple" style="visibility: hidden;">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                	<div class="button-container">
	                    <input type="button" class="submit-btn" value="북 정보 업로드" id="uploadAJaxbutton">
	                    <input type="reset" class="submit-btn" value="취소">
	                </div>
                </td>
            </tr>
		</table>
	</form>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="../js/uploadBook.js"></script>	
</body>
</html>