<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>출석 관리 - GYMHub</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&family=ABeeZee&family=ADLaM+Display&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #000000;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .attendance-container {
            background: #1a0f0a;
            border: 2px solid #FF6B00;
            border-radius: 20px;
            padding: 50px 40px;
            max-width: 450px;
            width: 100%;
            text-align: center;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .back-btn {
            background: transparent;
            border: 1px solid #FF6B00;
            color: #8A6A50;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .back-btn:hover {
            border-color: #FF6B00;
            color: #FF6B00;
        }

        .today-info {
            text-align: right;
        }

        .today-date {
            font-size: 12px;
            color: #8A6A50;
            margin-bottom: 4px;
        }

        .today-count {
            font-size: 14px;
            color: #FF6B00;
            font-weight: 700;
        }

        .icon-section {
            margin-bottom: 25px;
        }

        .phone-icon {
            width: 60px;
            height: 60px;
            margin: 0 auto;
            background: #2D1810;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .phone-icon svg {
            color: #FF6B00;
        }

        .main-title {
            font-size: 18px;
            color: #FF6B00;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .sub-title {
            font-size: 13px;
            color: #FFA366;
            margin-bottom: 30px;
            opacity: 0.8;
        }

        .phone-input-group {
            margin-bottom: 20px;
        }

        .phone-input {
            width: 100%;
            padding: 16px;
            font-size: 16px;
            text-align: center;
            background: #2D1810;
            border: 1px solid #FF6B00;
            border-radius: 10px;
            color: #FFA366;
            font-weight: 600;
            letter-spacing: 1px;
            transition: all 0.2s ease;
        }

        .phone-input::placeholder {
            color: #8A6A50;
            font-weight: 400;
            opacity: 0.6;
        }

        .phone-input:focus {
            outline: none;
            border-color: #FF6B00;
            background: #2D1810;
        }

        .submit-btn {
            width: 100%;
            padding: 16px;
            font-size: 16px;
            font-weight: 700;
            background: #FF6B00;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .submit-btn:hover {
            background: #FFA366;
        }

        .submit-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .help-text {
            font-size: 12px;
            color: #8A6A50;
            margin-top: 15px;
            opacity: 0.7;
        }

        /* 결과 모달 */
        .result-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.85);
            z-index: 9999;
            align-items: center;
            justify-content: center;
        }

        .result-modal.show {
            display: flex;
        }

        .result-content {
            background: #1a0f0a;
            border: 2px solid #FF6B00;
            border-radius: 20px;
            padding: 40px 35px;
            max-width: 450px;
            width: 90%;
            text-align: center;
            position: relative;
        }

        .timer-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #2D1810;
            border: 1px solid #FF6B00;
            border-radius: 8px;
            padding: 6px 12px;
            font-size: 12px;
            color: #8A6A50;
            font-weight: 600;
        }

        .result-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 20px;
            background: #2D1810;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .result-icon.checkin svg {
            color: #4caf50;
        }

        .result-icon.checkout svg {
            color: #ff5252;
        }

        .result-title {
            font-size: 24px;
            color: #FF6B00;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .result-name {
            font-size: 20px;
            color: #FFA366;
            margin-bottom: 25px;
            font-weight: 700;
        }

        .result-info {
            background: #2D1810;
            border: 1px solid #FF6B00;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 25px;
            text-align: left;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
            padding-bottom: 12px;
            border-bottom: 1px solid #FF6B00;
        }

        .info-row:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .info-label {
            font-size: 14px;
            color: #8A6A50;
            font-weight: 600;
            min-width: 70px;
        }

        .info-value {
            font-size: 14px;
            color: #FFA366;
            font-weight: 700;
            text-align: right;
            flex: 1;
        }

        .membership-badges {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .badge {
            background: #1a0f0a;
            border: 1px solid #FF6B00;
            border-radius: 6px;
            padding: 5px 10px;
            font-size: 12px;
            color: #FFA366;
            font-weight: 600;
        }

        .close-btn {
            width: 100%;
            background: transparent;
            border: 1px solid #FF6B00;
            color: #8A6A50;
            padding: 14px;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .close-btn:hover {
            border-color: #FF6B00;
            color: #FF6B00;
        }

        .error-message {
            background: rgba(255, 82, 82, 0.15);
            border: 1px solid #ff5252;
            border-radius: 10px;
            padding: 12px;
            margin-bottom: 15px;
            color: #ff5252;
            font-size: 14px;
            font-weight: 600;
            display: none;
        }

        .error-message.show {
            display: block;
        }

        @media (max-width: 600px) {
            .attendance-container {
                padding: 40px 30px;
            }

            .result-content {
                padding: 35px 25px;
            }
        }
    </style>
</head>
<body>
<div class="attendance-container">
    <div class="header-section">
        <div class="today-info">
            <div class="today-date" id="todayDate"></div>
            <div class="today-count">출석: <span id="todayCount">0</span>명</div>
        </div>
    </div>

    <div class="icon-section">
        <div class="phone-icon">
            <svg width="30" height="30" viewBox="0 0 24 24" fill="none">
                <path d="M22 16.92V19.92C22.0011 20.1985 21.9441 20.4742 21.8325 20.7293C21.7209 20.9845 21.5573 21.2136 21.3521 21.4019C21.1469 21.5901 20.9046 21.7335 20.6407 21.8227C20.3769 21.9119 20.0974 21.9451 19.82 21.92C16.7428 21.5856 13.787 20.5341 11.19 18.85C8.77382 17.3147 6.72533 15.2662 5.18999 12.85C3.49997 10.2412 2.44824 7.27099 2.11999 4.18C2.095 3.90347 2.12787 3.62476 2.21649 3.36162C2.30512 3.09849 2.44756 2.85669 2.63476 2.65162C2.82196 2.44655 3.0498 2.28271 3.30379 2.17052C3.55777 2.05833 3.83233 2.00026 4.10999 2H7.10999C7.5953 1.99522 8.06579 2.16708 8.43376 2.48353C8.80173 2.79999 9.04207 3.23945 9.10999 3.72C9.23662 4.68007 9.47144 5.62273 9.80999 6.53C9.94454 6.88792 9.97366 7.27691 9.8939 7.65088C9.81415 8.02485 9.62886 8.36811 9.35999 8.64L8.08999 9.91C9.51355 12.4135 11.5864 14.4864 14.09 15.91L15.36 14.64C15.6319 14.3711 15.9751 14.1858 16.3491 14.1061C16.7231 14.0263 17.1121 14.0555 17.47 14.19C18.3773 14.5286 19.3199 14.7634 20.28 14.89C20.7658 14.9585 21.2094 15.2032 21.5265 15.5775C21.8437 15.9518 22.0122 16.4296 22 16.92Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>
    </div>

    <h1 class="main-title">출석 체크</h1>
    <p class="sub-title">회원님의 전화번호를 입력해주세요</p>

    <div class="error-message" id="errorMessage"></div>

    <div class="phone-input-group">
        <input
                type="tel"
                id="phoneInput"
                class="phone-input"
                placeholder="01012345678"
                maxlength="13"
                autofocus>
    </div>

    <button class="submit-btn" id="submitBtn" onclick="processAttendance()">
        확인
    </button>

    <p class="help-text">가입 시 등록한 전화번호를 입력해주세요</p>
</div>

<!-- 결과 모달 -->
<div class="result-modal" id="resultModal">
    <div class="result-content">
        <div class="timer-badge" id="timerBadge">5초 후 닫힘</div>

        <div class="result-icon" id="resultIcon">
            <svg width="50" height="50" viewBox="0 0 24 24" fill="none">
                <path d="M22 11.08V12C21.9988 14.1564 21.3005 16.2547 20.0093 17.9818C18.7182 19.7088 16.9033 20.9725 14.8354 21.5839C12.7674 22.1953 10.5573 22.1219 8.53447 21.3746C6.51168 20.6273 4.78465 19.2461 3.61096 17.4371C2.43727 15.628 1.87979 13.4881 2.02168 11.3363C2.16356 9.18455 2.99721 7.13631 4.39828 5.49706C5.79935 3.85781 7.69279 2.71537 9.79619 2.24013C11.8996 1.76489 14.1003 1.98232 16.07 2.86" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M22 4L12 14.01L9 11.01" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>

        <h2 class="result-title" id="resultTitle">출석 완료!</h2>
        <div class="result-name" id="resultName"></div>

        <div class="result-info">
            <div class="info-row">
                <span class="info-label">회원명</span>
                <span class="info-value" id="infoName"></span>
            </div>
            <div class="info-row">
                <span class="info-label">회원권</span>
                <div class="membership-badges" id="membershipInfo"></div>
            </div>
            <div class="info-row">
                <span class="info-label" id="timeLabel">출석시간</span>
                <span class="info-value" id="infoTime"></span>
            </div>
        </div>

        <button class="close-btn" onclick="closeResultModal()">확인</button>
    </div>
</div>

<script>
    var autoCloseTimer = null;

    window.onload = function() {
        updateTodayDate();
    };

    function updateTodayDate() {
        var today = new Date();
        var options = { month: 'long', day: 'numeric', weekday: 'short' };
        var dateStr = today.toLocaleDateString('ko-KR', options);
        document.getElementById('todayDate').textContent = dateStr;
    }

    // 전화번호 자동 하이픈 추가
    document.getElementById('phoneInput').addEventListener('input', function(e) {
        var value = e.target.value.replace(/[^0-9]/g, '');
        var result = '';

        if (value.length < 4) {
            result = value;
        } else if (value.length < 7) {
            result = value.substr(0, 3) + '-' + value.substr(3);
        } else if (value.length < 11) {
            result = value.substr(0, 3) + '-' + value.substr(3, 3) + '-' + value.substr(6);
        } else {
            result = value.substr(0, 3) + '-' + value.substr(3, 4) + '-' + value.substr(7, 4);
        }

        e.target.value = result;
    });

    // 엔터키 처리
    document.getElementById('phoneInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            processAttendance();
        }
    });

    function processAttendance() {
        var phone = document.getElementById('phoneInput').value.trim();
        var errorDiv = document.getElementById('errorMessage');
        var submitBtn = document.getElementById('submitBtn');

        if (!phone) {
            showError('전화번호를 입력해주세요.');
            return;
        }

        submitBtn.disabled = true;
        errorDiv.classList.remove('show');

        // 서버에 AJAX 요청
        var requestData = {
            phone: phone
        };

        fetch('${pageContext.request.contextPath}/attendance/check.ajax', {
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
            submitBtn.disabled = false;

            if (data.success) {
                var now = new Date();
                var timeStr = now.toLocaleTimeString('ko-KR', { hour: '2-digit', minute: '2-digit' });
                
                // 회원 정보 객체 생성
                var member = {
                    name: data.memberName,
                    phone: data.memberPhone,
                    membershipInfo: data.membershipInfo || ''
                };
                
                if (data.type === '입실') {
                    // 오늘 출석 수 업데이트 (페이지 새로고침 없이)
                    // 실제로는 서버에서 오늘 출석 수를 다시 조회해야 하지만,
                    // 간단하게 1 증가시킴
                    var todayCountElement = document.getElementById('todayCount');
                    var currentCount = parseInt(todayCountElement.textContent) || 0;
                    todayCountElement.textContent = currentCount + 1;
                    
                    showResult(member, 'checkin', timeStr);
                } else if (data.type === '퇴실') {
                    showResult(member, 'checkout', timeStr);
                }
            } else {
                showError(data.message || '출석 체크 처리에 실패했습니다.');
                document.getElementById('phoneInput').value = '';
                document.getElementById('phoneInput').focus();
            }
        })
        .catch(function(error) {
            submitBtn.disabled = false;
            console.error('출석 체크 오류:', error);
            showError('출석 체크 처리 중 오류가 발생했습니다.');
            document.getElementById('phoneInput').value = '';
            document.getElementById('phoneInput').focus();
        });
    }

    function showResult(member, type, time) {
        document.getElementById('phoneInput').value = '';

        var resultIcon = document.getElementById('resultIcon');
        var resultTitle = document.getElementById('resultTitle');
        var timeLabel = document.getElementById('timeLabel');

        if (type === 'checkin') {
            resultTitle.textContent = '출석 완료!';
            timeLabel.textContent = '출석시간';
            resultIcon.classList.remove('checkout');
            resultIcon.classList.add('checkin');
        } else {
            resultTitle.textContent = '퇴장이 완료되었습니다!';
            timeLabel.textContent = '퇴실시간';
            resultIcon.classList.remove('checkin');
            resultIcon.classList.add('checkout');
        }

        document.getElementById('resultName').textContent = member.name + '님 환영합니다!';
        document.getElementById('infoName').textContent = member.name;
        document.getElementById('infoTime').textContent = time;

        // 회원권 표시
        var membershipInfoElement = document.getElementById('membershipInfo');
        if (member.membershipInfo && member.membershipInfo.trim() !== '') {
            // 회원권 정보를 뱃지로 표시
            var membershipParts = member.membershipInfo.split(' + ');
            var membershipHtml = '';
            membershipParts.forEach(function(part) {
                membershipHtml += '<div class="badge">' + part.trim() + '</div>';
            });
            membershipInfoElement.innerHTML = membershipHtml;
        } else {
            membershipInfoElement.innerHTML = '';
        }

        // 모달 표시
        document.getElementById('resultModal').classList.add('show');

        // 자동 닫힘 타이머
        var countdown = 5;
        updateTimerDisplay(countdown);

        autoCloseTimer = setInterval(function() {
            countdown--;
            if (countdown > 0) {
                updateTimerDisplay(countdown);
            } else {
                closeResultModal();
            }
        }, 1000);
    }

    function updateTimerDisplay(seconds) {
        document.getElementById('timerBadge').textContent = seconds + '초 후 닫힘';
    }

    function closeResultModal() {
        if (autoCloseTimer) {
            clearInterval(autoCloseTimer);
            autoCloseTimer = null;
        }
        document.getElementById('resultModal').classList.remove('show');
        document.getElementById('phoneInput').focus();
    }

    function showError(message) {
        var errorDiv = document.getElementById('errorMessage');
        errorDiv.textContent = message;
        errorDiv.classList.add('show');

        setTimeout(function() {
            errorDiv.classList.remove('show');
        }, 3000);
    }

    function goBack() {
        if (confirm('출석 관리를 종료하시겠습니까?')) {
            window.location.href = '${pageContext.request.contextPath}/';
        }
    }
</script>
</body>
</html>