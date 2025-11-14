<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 예약 상담 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* gymReservationManagement 전용 스타일 */

        /* Section Container */
        .section {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        .section-header {
            padding-bottom: 16px;
            border-bottom: 2px solid #ff6b00;
            margin-bottom: 24px;
        }

        .section-title {
            font-size: 18px;
            color: #ff6b00;
        }

        /* Consultation List */
        .consultation-list {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        /* Consultation Item */
        .consultation-item {
            background-color: #3d2810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s;
            cursor: pointer;
        }

        .consultation-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 107, 0, 0.3);
        }

        .consultation-info {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .consultation-name {
            font-size: 18px;
            color: white;
            font-weight: 600;
        }

        .consultation-details {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 14px;
            color: #b0b0b0;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .detail-icon {
            font-size: 16px;
        }

        /* Status Button */
        .status-button {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            min-width: 100px;
        }

        .status-button.pending {
            background-color: #ff6b00;
            color: white;
            box-shadow: 0 0 10px rgba(255, 107, 0, 0.4);
        }

        .status-button.pending:hover {
            box-shadow: 0 0 20px rgba(255, 107, 0, 0.6);
            transform: scale(1.05);
        }

        .status-button.completed {
            background-color: #05df72;
            color: white;
            box-shadow: 0 0 10px rgba(5, 223, 114, 0.4);
        }

        .status-button.completed:hover {
            box-shadow: 0 0 20px rgba(5, 223, 114, 0.6);
            transform: scale(1.05);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #b0b0b0;
        }

        .empty-icon {
            font-size: 64px;
            margin-bottom: 16px;
        }

        .empty-text {
            font-size: 18px;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .main-content {
                width: 100% !important;
                margin-left: 0 !important;
            }
        }
    </style>
</head>
<body>
<div class="app-container">
    <!-- Sidebar Include -->
    <jsp:include page="../common/sidebar/sidebarGym.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <div class="page-intro">
            <h1>예약 상담 관리</h1>
            <p>방문 예약 상담을 확인하고 관리하세요</p>
        </div>
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">예약 상담 목록</h2>
            </div>

            <div class="consultation-list">
                <c:choose>
<<<<<<< HEAD
                    <c:when test="${empty reservationList}">
                        <!-- Empty State -->
                        <div class="empty-state">
                            <div class="empty-icon">📅</div>
                            <div class="empty-text">등록된 예약 상담이 없습니다</div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="reservation" items="${reservationList}">
                            <!-- Consultation Item -->
                            <div class="consultation-item" onclick="viewConsultation('${reservation.memberName}', '<fmt:formatDate value="${reservation.visitDatetime}" pattern="yyyy년 MM월 dd일 HH:mm" />', '${reservation.memberPhone}', '${reservation.inquiryMemo != null ? reservation.inquiryMemo : ""}')">
                                <div class="consultation-info">
                                    <div class="consultation-name">${reservation.memberName}</div>
                                    <div class="consultation-details">
                                        <div class="detail-item">
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="날짜" class="detail-icon" style="width: 16px; height: 16px;">
                                            <span><fmt:formatDate value="${reservation.visitDatetime}" pattern="MM월 dd일 HH:mm" /></span>
                                        </div>
                                        <div class="detail-item">
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/call.png" alt="전화" class="detail-icon" style="width: 16px; height: 16px;">
                                            <span>${reservation.memberPhone}</span>
                                        </div>
                                    </div>
                                </div>
                                <button class="status-button ${reservation.inquiryStatus == '완료' ? 'completed' : 'pending'}"
                                        onclick="toggleStatus(event, this, ${reservation.inquiryNo})"
                                        data-inquiry-no="${reservation.inquiryNo}"
                                        data-status="${reservation.inquiryStatus}">
                                        ${reservation.inquiryStatus == '완료' ? '상담 완료' : '상담 예정'}
                                </button>
                            </div>
                        </c:forEach>
=======
                    <c:when test="${not empty reservedInquiries and reservedInquiries.size() > 0}">
                        <c:forEach var="inquiry" items="${reservedInquiries}">
                            <div class="consultation-item" onclick="viewConsultation(${inquiry.inquiryNo})" data-inquiry-no="${inquiry.inquiryNo}">
                                <div class="consultation-info">
                                    <div class="consultation-name">${inquiry.memberName}</div>
                                    <div class="consultation-details">
                                        <div class="detail-item">
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt="날짜" class="detail-icon" style="width: 16px; height: 16px;">
                                            <span>
                                                <fmt:formatDate value="${inquiry.visitDatetime}" pattern="MM월 dd일 HH:mm" />
                                            </span>
                                        </div>
                                        <div class="detail-item">
                                            <img src="${pageContext.request.contextPath}/resources/images/icon/call.png" alt="전화" class="detail-icon" style="width: 16px; height: 16px;">
                                            <span>${inquiry.memberPhone}</span>
                                        </div>
                                    </div>
                                </div>
                                <c:choose>
                                    <c:when test="${inquiry.inquiryStatus == '예약'}">
                                        <button class="status-button pending" onclick="toggleStatus(event, this, ${inquiry.inquiryNo})">상담 예정</button>
                                    </c:when>
                                    <c:when test="${inquiry.inquiryStatus == '완료'}">
                                        <button class="status-button completed" onclick="toggleStatus(event, this, ${inquiry.inquiryNo})">상담 완료</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="status-button pending" onclick="toggleStatus(event, this, ${inquiry.inquiryNo})">${inquiry.inquiryStatus}</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-icon">📋</div>
                            <div class="empty-text">예약 상담 현황이 없습니다</div>
                        </div>
>>>>>>> d0982fa5179d205f92ac84af68dbd1819ce5da0d
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script>
    // 상담 상세 보기
<<<<<<< HEAD
    function viewConsultation(name, time, phone, memo) {
        let message = '상담 정보\n\n이름: ' + name + '\n시간: ' + time + '\n연락처: ' + phone;
        if (memo && memo.trim() !== '') {
            message += '\n메모: ' + memo;
        }
        alert(message);
    }

    // 상태 토글
    function toggleStatus(event, button, inquiryNo) {
        event.stopPropagation();

        const currentStatus = button.dataset.status;
        let newStatus = '';
        let confirmMessage = '';

        if (currentStatus === '완료') {
            newStatus = '대기';
            confirmMessage = '상담을 예정으로 되돌리시겠습니까?';
        } else {
            newStatus = '완료';
            confirmMessage = '상담을 완료 처리하시겠습니까?';
        }

        if (confirm(confirmMessage)) {
            // AJAX 요청
            fetch('${pageContext.request.contextPath}/reservation/updateStatus.gym', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'inquiryNo=' + inquiryNo + '&status=' + encodeURIComponent(newStatus)
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === 'success') {
                        // UI 업데이트
                        button.dataset.status = newStatus;

                        if (newStatus === '완료') {
                            button.classList.remove('pending');
                            button.classList.add('completed');
                            button.textContent = '상담 완료';
                        } else {
                            button.classList.remove('completed');
                            button.classList.add('pending');
                            button.textContent = '상담 예정';
                        }

                        // 애니메이션 효과
                        button.style.transform = 'scale(1.1)';
                        setTimeout(() => {
                            button.style.transform = 'scale(1)';
                        }, 200);

                        alert(data.message);
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('상태 변경 중 오류가 발생했습니다.');
                });
=======
    function viewConsultation(inquiryNo) {
        const item = event.currentTarget;
        const name = item.querySelector('.consultation-name').textContent;
        const time = item.querySelector('.consultation-details .detail-item:first-child span').textContent.trim();
        const phone = item.querySelector('.consultation-details .detail-item:last-child span').textContent.trim();
        
        alert(`상담 정보\n\n이름: ${name}\n시간: ${time}\n연락처: ${phone}`);
    }

    // 상태 토글 (상담 완료 처리)
    function toggleStatus(event, button, inquiryNo) {
        event.stopPropagation(); // 부모 클릭 이벤트 방지
        
        if (button.classList.contains('pending')) {
            if (confirm('상담을 완료 처리하시겠습니까?')) {
                // 서버에 완료 처리 요청
                const requestData = {
                    inquiryNo: inquiryNo
                };
                
                fetch('${pageContext.request.contextPath}/reservation/complete.ajax', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(requestData)
                })
                .then(function(response) {
                    return response.json();
                })
                .then(function(data) {
                    if (data.success) {
                        button.classList.remove('pending');
                        button.classList.add('completed');
                        button.textContent = '상담 완료';
                        
                        // 애니메이션 효과
                        button.style.transform = 'scale(1.1)';
                        setTimeout(() => {
                            button.style.transform = 'scale(1)';
                        }, 200);
                    } else {
                        alert(data.message || '상담 완료 처리에 실패했습니다.');
                    }
                })
                .catch(function(error) {
                    console.error('상담 완료 처리 오류:', error);
                    alert('상담 완료 처리 중 오류가 발생했습니다.');
                });
            }
        } else {
            // 완료 상태는 되돌릴 수 없음 (요구사항에 없음)
            alert('이미 완료 처리된 상담입니다.');
>>>>>>> d0982fa5179d205f92ac84af68dbd1819ce5da0d
        }
    }

    // 카드 진입 애니메이션
    window.addEventListener('load', function() {
        const items = document.querySelectorAll('.consultation-item');
        items.forEach((item, index) => {
            item.style.opacity = '0';
            item.style.transform = 'translateY(20px)';
            setTimeout(() => {
                item.style.transition = 'all 0.5s ease';
                item.style.opacity = '1';
                item.style.transform = 'translateY(0)';
            }, index * 100);
        });
    });

    // 전화 걸기 기능 (모바일에서만 작동)
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.detail-item').forEach(item => {
            const icon = item.querySelector('.detail-icon');
            if (icon && icon.alt === '전화') {
                item.style.cursor = 'pointer';
                item.addEventListener('click', function(event) {
                    event.stopPropagation();
                    const phone = this.querySelector('span:last-child').textContent;
                    if (confirm(phone + '로 전화하시겠습니까?')) {
                        window.location.href = 'tel:' + phone.replace(/-/g, '');
                    }
                });
            }
        });
    });
</script>
</body>
</html>