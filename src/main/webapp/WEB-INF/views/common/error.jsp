<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>오류 발생</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        .error-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 2rem;
        }

        .error-card {
            max-width: 500px;
            width: 100%;
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 16px;
            padding: 40px;
            text-align: center;
        }

        .error-icon {
            font-size: 48px;
            margin-bottom: 20px;
            color: #ff6b00;
        }

        .error-title {
            font-size: 24px;
            color: #ff6b00;
            margin-bottom: 16px;
        }

        .error-message {
            font-size: 16px;
            color: #b0b0b0;
            margin-bottom: 32px;
            line-height: 1.6;
        }

        .error-buttons {
            display: flex;
            gap: 12px;
            justify-content: center;
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-card">
        <div class="error-icon">⚠️</div>
        <h1 class="error-title">오류 발생</h1>
        <p class="error-message">
            <c:out value="${errorMsg}" default="알 수 없는 오류가 발생하였습니다." />
        </p>
        <div class="error-buttons">
            <button onclick="history.back()" class="btn btn-secondary">이전 페이지로</button>
            <button onclick="location.href='${pageContext.request.contextPath}/'" class="btn btn-primary">홈으로</button>
        </div>
    </div>
</div>
</body>
</html>