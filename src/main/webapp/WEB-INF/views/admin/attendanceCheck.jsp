<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>출석 관리</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
            background: linear-gradient(135deg, #0a0a0a 0%, #1a0f0a 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        body::before {
            content: '';
            position: fixed;
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(255, 107, 0, 0.15) 0%, transparent 70%);
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            animation: pulse 4s ease-in-out infinite;
            z-index: 0;
        }

        @keyframes pulse {
            0%, 100% {
                opacity: 0.5;
                transform: translate(-50%, -50%) scale(1);
            }
            50% {
                opacity: 1;
                transform: translate(-50%, -50%) scale(1.1);
            }
        }

        .attendance-container {
            background: linear-gradient(145deg, #1a0f0a 0%, #2d1810 100%);
            border: 3px solid #ff6b00;
            border-radius: 30px;
            padding: 60px 50px;
            max-width: 600px;
            width: 100%;
            text-align: center;
            box-shadow: 0 0 80px rgba(255, 107, 0, 0.4);
            position: relative;
            z-index: 1;
            animation: slideUp 0.5s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .attendance-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .back-button {
            background: transparent;
            border: 2px solid #ff6b00;
            color: #ff6b00;
            width: 45px;
            height: 45px;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .back-button:hover {
            background: rgba(255, 107, 0, 0.1);
            transform: translateX(-5px);
        }

        .today-info {
            text-align: right;
        }

        .today-date {
            font-size: 14px;
            color: #ffa366;
            margin-bottom: 5px;
        }

        .today-count {
            font-size: 18px;
            color: #ff6b00;
            font-weight: 700;
        }

        .attendance-logo-text {
            font-size: 42px;
            color: #ff6b00;
            font-weight: 900;
            text-shadow: 0 0 30px rgba(255, 107, 0, 0.6);
            margin-bottom: 40px;
        }

        .attendance-title {
            font-size: 32px;
            color: #ff6b00;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .attendance-subtitle {
            font-size: 16px;
            color: #ffa366;
            margin-bottom: 50px;
        }

        .phone-input-group {
            margin-bottom: 30px;
        }

        .phone-label {
            display: block;
            font-size: 16px;
            color: #ffa366;
            margin-bottom: 15px;
            text-align: left;
            font-weight: 600;
        }

        .phone-input {
            width: 100%;
            padding: 22px;
            font-size: 22px;
            text-align: center;
            background-color: rgba(45, 24, 16, 0.6);
            border: 3px solid #ff6b00;
            border-radius: 15px;
            color: white;
            font-weight: 700;
            letter-spacing: 1.5px;
            transition: all 0.3s;
        }

        .phone-input::placeholder {
            color: #8a6a50;
            font-weight: 400;
        }

        .phone-input:focus {
            outline: none;
            border-color: #ff8800;
            background-color: rgba(45, 24, 16, 0.8);
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.5);
            transform: scale(1.02);
        }

        .submit-button {
            width: 100%;
            padding: 22px;
            font-size: 20px;
            font-weight: 700;
            background: linear-gradient(135deg, #ff6b00 0%, #ff8800 100%);
            color: white;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 8px 30px rgba(255, 107, 0, 0.5);
        }

        .submit-button:hover {
            background: linear-gradient(135deg, #ff8800 0%, #ffa000 100%);
            box-shadow: 0 12px 40px rgba(255, 107, 0, 0.7);
            transform: translateY(-3px);
        }

        .submit-button:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        .help-text {
            text-align: center;
            font-size: 14px;
            color: #8a6a50;
            margin-top: 30px;
        }

        /* 출석 완료 모달 */
        .success-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.9);
            z-index: 3000;
            align-items: center;
            justify-content: center;
        }

        .success-modal.show {
            display: flex;
        }

        .success-content {
            background: linear-gradient(145deg, #1a0f0a 0%, #2d1810 100%);
            border: 3px solid #4caf50;
            border-radius: 30px;
            padding: 60px 50px;
            max-width: 500px;
            width: 90%;
            text-align: center;
            box-shadow: 0 0 80px rgba(76, 175, 80, 0.5);
            position: relative;
            animation: successSlide 0.4s ease-out;
        }

        @keyframes successSlide {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .success-icon {
            width: 120px;
            height: 120px;
            margin: 0 auto 30px;
            background: rgba(76, 175, 80, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .success-icon svg {
            color: #4caf50;
            filter: drop-shadow(0 0 15px rgba(76, 175, 80, 0.8));
        }

        .success-title {
            font-size: 32px;
            color: #4caf50;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .success-name {
            font-size: 24px;
            color: #ffa366;
            margin-bottom: 30px;
        }

        .success-message {
            font-size: 16px;
            color: #8a6a50;
            margin-bottom: 40px;
        }

        .close-success-btn {
            background: transparent;
            border: 2px solid #4caf50;
            color: #4caf50;
            padding: 16px 50px;
            border-radius: 14px;
            font-size: 17px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .close-success-btn:hover {
            background: rgba(76, 175, 80, 0.15);
            border-color: #66bb6a;
            color: #66bb6a;
        }

        .auto-close-timer {
            position: absolute;
            top: 20px;
            right: 20px;
            background: rgba(76, 175, 80, 0.2);
            border: 2px solid #4caf50;
            border-radius: 10px;
            padding: 8px 16px;
            font-size: 14px;
            color: #4caf50;
            font-weight: 600;
        }

        .error-message {
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 30px;
            display: none;
            font-weight: 600;
            font-size: 16px;
            background: linear-gradient(135deg, rgba(255, 82, 82, 0.25) 0%, rgba(255, 82, 82, 0.15) 100%);
            border: 3px solid #ff5252;
            color: #ff5252;
        }

        .error-message.show {
            display: block;
        }

        @media (max-width: 600px) {
            .attendance-container {
                padding: 40px 30px;
            }

            .attendance-logo-text {
                font-size: 32px;
            }

            .attendance-title {
                font-size: 26px;
            }
        }
    </style>
</head>
<body>
<div class="attendance-container">
    <div class="attendance-header">
        <button class="back-button" onclick="goBack()">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
                <path d="M19 12H5M5 12L12 19M5 12L12 5" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </button>
        <div class="today-info">
            <div class="today-date" id="todayDate"></div>
            <div class="today-count">오늘 출석: <span id="todayCount">0</span>명</div>
        </div>
    </div>

    <div class="attendance-logo-text">GYMHub</div>

    <h1 class="attendance-title">출석 체크</h1>
    <p class="attendance-subtitle">회원님의 전화번호를 입력해주세요</p>

    <div id="errorMessage" class="error-message"></div>

    <div class="phone-input-group">
        <label class="phone-label">전화번호</label>
        <input
                type="tel"
                id="phoneInput"
                class="phone-input"
                placeholder="010-0000-0000"
                maxlength="13"
                autofocus>
    </div>

    <button class="submit-button" id="submitBtn" onclick="checkAttendance()">
        출석하기
    </button>

    <p class="help-text">가입 시 등록한 전화번호를 입력해주세요</p>
</div>

<!-- 출석 완료 모달 -->
<div class="success-modal" id="successModal">
    <div class="success-content">
        <div class="auto-close-timer" id="autoCloseTimer">5초 후 자동 닫힘</div>

        <div class="success-icon">
            <svg width="70" height="70" viewBox="0 0 24 24" fill="none">
                <path d="M22 11.08V12C21.9988 14.1564 21.3005 16.2547 20.0093 17.9818C18.7182 19.7088 16.9033 20.9725 14.8354 21.5839C12.7674 22.1953 10.5573 22.1219 8.53447 21.3746C6.51168 20.6273 4.78465 19.2461 3.61096 17.4371C2.43727 15.628 1.87979 13.4881 2.02168 11.3363C2.16356 9.18455 2.99721 7.13631 4.39828 5.49706C5.79935 3.85781 7.69279 2.71537 9.79619 2.24013C11.8996 1.76489 14.1003 1.98232 16.07 2.86" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M22 4L12 14.01L9 11.01" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>

        <h2 class="success-title">출석 완료!</h2>
        <div class="success-name" id="successName"></div>
        <p class="success-message">출석체크가 완료되었습니다</p>

        <button class="close-success-btn" onclick="closeSuccessModal()">닫기</button>
    </div>
</div>

<script>
    // 임시 회원 데이터
    var tempMembers = [
        { phone: '010-1234-5678', name: '홍길동' },
        { phone: '010-9876-5432', name: '김철수' },
        { phone: '010-5555-6666', name: '이영희' },
        { phone: '010-1111-2222', name: '박민수' },
        { phone: '010-3333-4444', name: '정수진' }
    ];

    var todayAttendance = [];
    var autoCloseTimer = null;

    // 페이지 로드 시 로그인 확인
    window.onload = function() {
        var user = localStorage.getItem('loginUser');
        if (!user) {
            alert('로그인이 필요합니다.');
            location.href = 'index.jsp';
            return;
        }
        updateTodayDate();
    };

    function updateTodayDate() {
        var today = new Date();
        var options = { year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' };
        var dateStr = today.toLocaleDateString('ko-KR', options);
        document.getElementById('todayDate').textContent = dateStr;
    }

    function updateAttendanceCount() {
        document.getElementById('todayCount').textContent = todayAttendance.length;
    }

    // 전화번호 자동 하이픈
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

    function checkAttendance() {
        var phone = document.getElementById('phoneInput').value.trim();
        var errorDiv = document.getElementById('errorMessage');
        var submitBtn = document.getElementById('submitBtn');

        if (!phone) {
            showError('전화번호를 입력해주세요.');
            return;
        }

        submitBtn.disabled = true;
        submitBtn.style.opacity = '0.6';
        errorDiv.classList.remove('show');

        setTimeout(function() {
            submitBtn.disabled = false;
            submitBtn.style.opacity = '1';

            var member = null;
            for (var i = 0; i < tempMembers.length; i++) {
                if (tempMembers[i].phone === phone) {
                    member = tempMembers[i];
                    break;
                }
            }

            if (member) {
                var alreadyChecked = false;
                for (var j = 0; j < todayAttendance.length; j++) {
                    if (todayAttendance[j].phone === phone) {
                        alreadyChecked = true;
                        break;
                    }
                }

                if (alreadyChecked) {
                    showError('이미 출석체크를 완료하셨습니다.');
                    document.getElementById('phoneInput').value = '';
                    document.getElementById('phoneInput').focus();
                } else {
                    todayAttendance.push({
                        phone: phone,
                        name: member.name,
                        time: new Date().toLocaleTimeString('ko-KR')
                    });
                    updateAttendanceCount();

                    document.getElementById('phoneInput').value = '';
                    showSuccessModal(member.name);
                }
            } else {
                showError('등록되지 않은 전화번호입니다.');
                document.getElementById('phoneInput').value = '';
                document.getElementById('phoneInput').focus();
            }
        }, 500);
    }

    function showSuccessModal(memberName) {
        document.getElementById('successName').textContent = memberName + '님';
        document.getElementById('successModal').classList.add('show');

        var countdown = 5;
        updateTimerDisplay(countdown);

        autoCloseTimer = setInterval(function() {
            countdown--;
            if (countdown > 0) {
                updateTimerDisplay(countdown);
            } else {
                closeSuccessModal();
            }
        }, 1000);
    }

    function updateTimerDisplay(seconds) {
        document.getElementById('autoCloseTimer').textContent = seconds + '초 후 자동 닫힘';
    }

    function closeSuccessModal() {
        if (autoCloseTimer) {
            clearInterval(autoCloseTimer);
            autoCloseTimer = null;
        }
        document.getElementById('successModal').classList.remove('show');
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
            location.href = 'adminSelect.jsp';
        }
    }

    // 엔터키 처리
    document.getElementById('phoneInput').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            checkAttendance();
        }
    });
</script>
</body>
</html>