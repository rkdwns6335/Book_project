<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>QnA List</title>
    <link rel="stylesheet" type="text/css" href="../css/qna/qnaList.css">
</head>
<body>
    <div id="qnaListDiv">
        <div align="center">
            <h2>QnA</h2>
        </div>
        <p>총 ${totalA}건 / 금일 ${noCheck}건</p> 
        <table id="qnaList">
            <thead>
                <tr>
                    <th width="50">번호</th>
                    <th width="300">내용</th>
                    <th width="100">작성자</th>
                    <th width="100">작성일</th>
                    <th width="100">답글 여부</th>
                </tr>
            </thead>
            <input type="text" id="pg" value="${map.pg}" style="display:none;">
            <input type="text" id="userId" value="${userId}" style="display:none;">
            <tbody>
                <c:forEach var="qnaDTO" items="${map.list}">
                    <tr class="accordion" data-seq="${qnaDTO.seq}">
                        <td style="text-align: center;">${qnaDTO.seq}</td>
                        <td class="title" style="text-align: center;">
                            <c:choose>
                                <c:when test="${qnaDTO.qnaCheck == 'T'}">
                                    <c:choose>
                                        <c:when test="${userId == qnaDTO.qnaId || userId == 'admin'}">
                                            <img alt="자물쇠" src="../image/qna_secret.jpg" width='10' height='10' style="margin-right: 5px;"> ${qnaDTO.qnaUserContent}
                                        </c:when>
                                        <c:otherwise>
                                            <img alt="자물쇠" src="../image/qna_secret.jpg" width='10' height='10' style="margin-right: 5px;">
                                            쉿 비밀글입니다~!
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    ${qnaDTO.qnaUserContent}
                                </c:otherwise>
                            </c:choose>
                            <img src="../image/qna_plus.png" alt="추가" width="15" height="15" class="toggle-plus" data-open="../image/qna_minus.png">
                        </td>
                        <td style="text-align: center;">${qnaDTO.qnaId}</td>
                        <td style="text-align: center;">
                            <fmt:formatDate value="${qnaDTO.logtime}" pattern="yyyy-MM-dd" />
                        </td>
                        <td style="text-align: center;">
                            <c:if test="${not empty qnaDTO.qnaAdminContent}">
                                <img src="../image/qna_check.png" alt="답글체크" width="15" height="15" style="padding-right: 5px;">
                            </c:if>
                        </td>
                    </tr>
                    <tr class="panel" data-seq="${qnaDTO.seq}">
                        <td colspan="5" style="text-align: center;">
                            <c:choose>
                                <c:when test="${empty qnaDTO.qnaAdminContent}">
                                    <p>답글이 없습니다 ㅠㅠ</p>
                                    <c:if test="${not empty userId && userId == 'admin'}"> 
                                        <textarea id="replyContent_${qnaDTO.seq}" rows="4" placeholder="답글을 입력해주세요..."></textarea>
                                        <div class="align-right">
                                            <button id="AdminWrite_button_${qnaDTO.seq}" type="button" onclick="submitReply(${qnaDTO.seq})">답글 작성</button>
                                        </div>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <c:if test="${qnaDTO.qnaCheck == 'T' && userId != 'admin' && userId != qnaDTO.qnaId}">
                                        <img alt="자물쇠" src="../image/qna_secret.jpg" width='10' height='10' style="margin-right: 5px;">
                                        비밀글입니다~!
                                    </c:if>
                                    <c:if test="${qnaDTO.qnaCheck == 'T' && (userId == 'admin' || userId == qnaDTO.qnaId)}">
                                        <img src="../image/qna_reply.png" alt="답글" width="15" height="15" style="padding-right: 5px;">
                                        <span>${qnaDTO.qnaAdminContent}</span>
                                    </c:if>
                                    <c:if test="${qnaDTO.qnaCheck != 'T'}">
                                        <img src="../image/qna_reply.png" alt="답글" width="15" height="15" style="padding-right: 5px;">
                                        <span>${qnaDTO.qnaAdminContent}</span>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div style="text-align:center; margin-top:20px;">
            ${map.pagingHTML}
        </div>
        
        <div class="align-center">
            <button type="button" onclick="location.href='/BooBooBookProject/qna/qnaWriteForm'">문의글 작성</button>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            $(".accordion").click(function() {
                $(this).next(".panel").slideToggle(); // 패널을 슬라이드 토글
                $(this).find(".toggle-plus").attr("src", $(this).next(".panel").is(":visible") ? "../image/qna_minus.png" : "../image/qna_plus.png"); // 버튼 이미지 변경
            });
        });

        function submitReply(seq) {
            var replyContent = $("#replyContent_" + seq).val();
            if (replyContent.trim() === "") {
                alert("답글을 입력해주세요.");
                return;
            }
            $.ajax({
                type: "POST",
                url: "/qna/qnaReplyWrite",
                data: {
                    seq: seq,
                    replyContent: replyContent
                },
                success: function(response) {
                    alert("답글이 등록되었습니다.");
                    location.reload(); // 페이지 새로 고침
                },
                error: function() {
                    alert("답글 등록에 실패했습니다.");
                }
            });
        }
        function qnaPaging(pg) {
            location.href = '../qna/qnaList?pg=' + pg;
        }
    </script>
</body>
</html>
