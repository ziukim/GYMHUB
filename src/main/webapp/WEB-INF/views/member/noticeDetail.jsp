<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>헬스장 대시보드</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="../common/sidebar/sidebarMember.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <h1>헬스장 운영자 대시보드</h1>
        <!-- 페이지 내용 -->
    </div>
</div>
</body>
</html>