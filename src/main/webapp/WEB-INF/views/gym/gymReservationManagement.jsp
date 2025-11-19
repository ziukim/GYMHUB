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

        /* 날짜 필터 스타일 */
        .date-filter-container {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
        }

        .date-selector {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s;
            flex: 1;
            max-width: 300px;
        }

        .date-selector:hover {
            border-color: #ff8533;
            background-color: #3a2a1f;
        }

        .date-text {
            flex: 1;
            color: #ffa366;
            font-size: 14px;
            font-weight: 500;
        }

        .filter-clear-btn {
            padding: 12px 20px;
            background-color: transparent;
            border: 2px solid #8a6a50;
            border-radius: 8px;
            color: #8a6a50;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
        }

        .filter-clear-btn:hover {
            border-color: #ff6b00;
            color: #ff6b00;
            background-color: rgba(255, 107, 0, 0.1);
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

        <!-- 날짜 필터 -->
        <div class="date-filter-container">
            <div class="date-selector" onclick="openDateCalendar()">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                    <path d="M6.66667 1.66667V5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M13.3333 1.66667V5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M15.8333 3.33334H4.16667C3.24619 3.33334 2.5 4.07953 2.5 5V16.6667C2.5 17.5872 3.24619 18.3333 4.16667 18.3333H15.8333C16.7538 18.3333 17.5 17.5872 17.5 16.6667V5C17.5 4.07953 16.7538 3.33334 15.8333 3.33334Z" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M2.5 8.33334H17.5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                <span class="date-text" id="selectedDateText">전체 날짜</span>
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                    <path d="M5 7.5L10 12.5L15 7.5" stroke="#8A6A50" stroke-width="1.66667" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>
            <button class="filter-clear-btn" id="clearDateFilter" onclick="clearDateFilter()" style="display: none;">필터 초기화</button>
        </div>

        <div class="section">
            <div class="section-header">
                <h2 class="section-title">예약 상담 목록</h2>
            </div>

            <div class="consultation-list">
                <c:choose>
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
                    </c:otherwise>
                </c:choose>
                
                <!-- 페이징 -->
                <c:if test="${not empty pi}">
                    <div class="pagination">
                        <!-- 이전 버튼 -->
                        <c:if test="${pi.currentPage > 1}">
                            <button class="pagination-btn" onclick="location.href='${pageContext.request.contextPath}/reservation.gym?currentPage=${pi.currentPage - 1}'">
                                이전
                            </button>
                        </c:if>
                        <c:if test="${pi.currentPage <= 1}">
                            <button class="pagination-btn disabled">이전</button>
                        </c:if>
                        
                        <!-- 페이지 번호 버튼 -->
                        <c:forEach var="p" begin="${pi.startPage}" end="${pi.endPage}">
                            <c:if test="${p == pi.currentPage}">
                                <button class="pagination-btn active">${p}</button>
                            </c:if>
                            <c:if test="${p != pi.currentPage}">
                                <button class="pagination-btn" onclick="location.href='${pageContext.request.contextPath}/reservation.gym?currentPage=${p}'">
                                    ${p}
                                </button>
                            </c:if>
                        </c:forEach>
                        
                        <!-- 다음 버튼 -->
                        <c:if test="${pi.currentPage < pi.maxPage}">
                            <button class="pagination-btn" onclick="location.href='${pageContext.request.contextPath}/reservation.gym?currentPage=${pi.currentPage + 1}'">
                                다음
                            </button>
                        </c:if>
                        <c:if test="${pi.currentPage >= pi.maxPage}">
                            <button class="pagination-btn disabled">다음</button>
                        </c:if>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<!-- 날짜 선택 달력 팝업 -->
<div class="calendar-overlay" id="dateCalendarOverlay" onclick="closeDateCalendarOnOverlay(event)">
    <div class="calendar-popup" onclick="event.stopPropagation()">
        <div class="calendar-header">
            <button type="button" class="calendar-nav-btn" onclick="prevDateMonth()">◀</button>
            <div class="calendar-month" id="dateCalendarMonth"></div>
            <button type="button" class="calendar-nav-btn" onclick="nextDateMonth()">▶</button>
        </div>

        <div class="calendar-weekdays">
            <div class="calendar-weekday">일</div>
            <div class="calendar-weekday">월</div>
            <div class="calendar-weekday">화</div>
            <div class="calendar-weekday">수</div>
            <div class="calendar-weekday">목</div>
            <div class="calendar-weekday">금</div>
            <div class="calendar-weekday">토</div>
        </div>

        <div class="calendar-days" id="dateCalendarDays"></div>

        <button type="button" class="calendar-close-btn" onclick="closeDateCalendar()">확인</button>
    </div>
</div>

<script>
    // 전역 변수
    var contextPath = '${pageContext.request.contextPath}';
    var selectedFilterDate = null;
    var dateCurrentMonth = new Date();
    var dateTempSelected = null;

    // ========================================
    // 날짜 필터링 관련 함수
    // ========================================

    // 달력 열기
    function openDateCalendar() {
        dateTempSelected = selectedFilterDate ? new Date(selectedFilterDate) : null;
        renderDateCalendar();
        document.getElementById('dateCalendarOverlay').classList.add('show');
    }

    // 달력 닫기
    function closeDateCalendar() {
        if (dateTempSelected) {
            selectedFilterDate = new Date(dateTempSelected);
            updateDateFilterDisplay();
            filterByDate();
        }
        document.getElementById('dateCalendarOverlay').classList.remove('show');
    }

    // 오버레이 클릭 시 달력 닫기
    function closeDateCalendarOnOverlay(event) {
        if (event.target.id === 'dateCalendarOverlay') {
            closeDateCalendar();
        }
    }

    // 달력 렌더링
    function renderDateCalendar() {
        var year = dateCurrentMonth.getFullYear();
        var month = dateCurrentMonth.getMonth();

        // 월 표시
        var monthNames = ['1월', '2월', '3월', '4월', '5월', '6월',
            '7월', '8월', '9월', '10월', '11월', '12월'];
        document.getElementById('dateCalendarMonth').textContent = year + '년 ' + monthNames[month];

        // 날짜 계산
        var firstDay = new Date(year, month, 1).getDay();
        var lastDate = new Date(year, month + 1, 0).getDate();
        var today = new Date();
        today.setHours(0, 0, 0, 0);

        var daysContainer = document.getElementById('dateCalendarDays');
        daysContainer.innerHTML = '';

        // 이전 달 빈 칸
        for (var i = 0; i < firstDay; i++) {
            var emptyDay = document.createElement('div');
            emptyDay.className = 'calendar-day other-month';
            daysContainer.appendChild(emptyDay);
        }

        // 현재 달 날짜
        for (var date = 1; date <= lastDate; date++) {
            var dayElement = document.createElement('div');
            dayElement.className = 'calendar-day current-month';
            dayElement.textContent = date;

            var currentDate = new Date(year, month, date);
            currentDate.setHours(0, 0, 0, 0);

            // 오늘 날짜 표시
            if (currentDate.getTime() === today.getTime()) {
                dayElement.classList.add('today');
            }

            // 날짜 선택 이벤트 (과거 날짜도 선택 가능)
            dayElement.onclick = (function(d) {
                return function() {
                    selectFilterDate(new Date(year, month, d));
                };
            })(date);

            // 선택된 날짜 표시
            if (dateTempSelected &&
                dateTempSelected.getFullYear() === year &&
                dateTempSelected.getMonth() === month &&
                dateTempSelected.getDate() === date) {
                dayElement.classList.add('selected');
            }

            daysContainer.appendChild(dayElement);
        }
    }

    // 날짜 선택
    function selectFilterDate(date) {
        dateTempSelected = date;
        renderDateCalendar();
    }

    // 이전 달
    function prevDateMonth() {
        dateCurrentMonth.setMonth(dateCurrentMonth.getMonth() - 1);
        renderDateCalendar();
    }

    // 다음 달
    function nextDateMonth() {
        dateCurrentMonth.setMonth(dateCurrentMonth.getMonth() + 1);
        renderDateCalendar();
    }

    // 선택된 날짜 표시 업데이트
    function updateDateFilterDisplay() {
        if (selectedFilterDate) {
            var weekdays = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
            var year = selectedFilterDate.getFullYear();
            var month = selectedFilterDate.getMonth() + 1;
            var day = selectedFilterDate.getDate();
            var weekday = weekdays[selectedFilterDate.getDay()];

            var dateString = year + '년 ' + month + '월 ' + day + '일 ' + weekday;
            document.getElementById('selectedDateText').textContent = dateString;
            document.getElementById('clearDateFilter').style.display = 'block';
        } else {
            document.getElementById('selectedDateText').textContent = '전체 날짜';
            document.getElementById('clearDateFilter').style.display = 'none';
        }
    }

    // 날짜별 필터링
    function filterByDate() {
        var dateStr = null;

        if (selectedFilterDate) {
            var year = selectedFilterDate.getFullYear();
            var month = String(selectedFilterDate.getMonth() + 1).padStart(2, '0');
            var day = String(selectedFilterDate.getDate()).padStart(2, '0');
            dateStr = year + '-' + month + '-' + day;
        }

        // 날짜가 선택되지 않았으면 전체 조회
        if (!dateStr) {
            location.reload();
            return;
        }

        // AJAX로 날짜별 조회
        fetch(contextPath + '/reservation/filterByDate.ajax?date=' + dateStr)
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.success) {
                    renderFilteredReservations(data.reservations);
                } else {
                    alert(data.message || '데이터 조회에 실패했습니다.');
                }
            })
            .catch(function(error) {
                console.error('날짜 필터링 오류:', error);
                alert('날짜 필터링 중 오류가 발생했습니다.');
            });
    }

    // 필터링된 예약 목록 렌더링
    function renderFilteredReservations(reservations) {
        var listContainer = document.querySelector('.consultation-list');
        
        // 기존 항목 제거
        listContainer.innerHTML = '';

        if (reservations && reservations.length > 0) {
            // 예약 항목 생성
            for (var i = 0; i < reservations.length; i++) {
                var reservation = reservations[i];
                var item = createReservationItem(reservation);
                listContainer.appendChild(item);
            }

            // 애니메이션 적용
            var items = listContainer.querySelectorAll('.consultation-item');
            items.forEach(function(item, index) {
                item.style.opacity = '0';
                item.style.transform = 'translateY(20px)';
                setTimeout(function() {
                    item.style.transition = 'all 0.5s ease';
                    item.style.opacity = '1';
                    item.style.transform = 'translateY(0)';
                }, index * 100);
            });
        } else {
            // 빈 메시지 표시
            var emptyDiv = document.createElement('div');
            emptyDiv.className = 'empty-state';
            emptyDiv.innerHTML = '<div class="empty-icon">📅</div><div class="empty-text">해당 날짜에 예약 상담이 없습니다</div>';
            listContainer.appendChild(emptyDiv);
        }
    }

    // 예약 항목 생성
    function createReservationItem(reservation) {
        var item = document.createElement('div');
        item.className = 'consultation-item';

        var visitDate = '';
        if (reservation.visitDatetime) {
            var date = new Date(reservation.visitDatetime);
            var year = date.getFullYear();
            var month = String(date.getMonth() + 1).padStart(2, '0');
            var day = String(date.getDate()).padStart(2, '0');
            var hours = String(date.getHours()).padStart(2, '0');
            var minutes = String(date.getMinutes()).padStart(2, '0');
            visitDate = year + '년 ' + month + '월 ' + day + '일 ' + hours + ':' + minutes;
        }

        var statusClass = reservation.inquiryStatus === '완료' ? 'completed' : 'pending';
        var statusText = reservation.inquiryStatus === '완료' ? '상담 완료' : '상담 예정';

        // 날짜 포맷팅 (MM월 dd일 HH:mm)
        var dateDisplay = '';
        if (reservation.visitDatetime) {
            var date = new Date(reservation.visitDatetime);
            var month = String(date.getMonth() + 1).padStart(2, '0');
            var day = String(date.getDate()).padStart(2, '0');
            var hours = String(date.getHours()).padStart(2, '0');
            var minutes = String(date.getMinutes()).padStart(2, '0');
            dateDisplay = month + '월 ' + day + '일 ' + hours + ':' + minutes;
        }

        var html = '<div class="consultation-info">' +
            '<div class="consultation-name">' + (reservation.memberName || '') + '</div>' +
            '<div class="consultation-details">' +
            '<div class="detail-item">' +
            '<img src="' + contextPath + '/resources/images/icon/calendar.png" alt="날짜" class="detail-icon" style="width: 16px; height: 16px;">' +
            '<span>' + dateDisplay + '</span>' +
            '</div>' +
            '<div class="detail-item">' +
            '<img src="' + contextPath + '/resources/images/icon/call.png" alt="전화" class="detail-icon" style="width: 16px; height: 16px;">' +
            '<span>' + (reservation.memberPhone || '') + '</span>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '<button class="status-button ' + statusClass + '" ' +
            'onclick="toggleStatus(event, this, ' + reservation.inquiryNo + ')" ' +
            'data-inquiry-no="' + reservation.inquiryNo + '" ' +
            'data-status="' + (reservation.inquiryStatus || '대기') + '">' +
            statusText +
            '</button>';

        item.innerHTML = html;
        item.setAttribute('onclick', 'viewConsultation(\'' + 
            (reservation.memberName || '') + '\', \'' + 
            visitDate + '\', \'' + 
            (reservation.memberPhone || '') + '\', \'' + 
            (reservation.inquiryMemo || '') + '\')');

        return item;
    }

    // 날짜 필터 초기화
    function clearDateFilter() {
        selectedFilterDate = null;
        updateDateFilterDisplay();
        location.reload();
    }

    // 상담 상세 보기
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