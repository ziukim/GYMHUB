<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인 필요 모달 -->
<div class="modal-overlay" id="loginRequiredModal" style="display: none;">
    <div class="modal-container" style="max-width: 440px;">
        <button class="modal-close" onclick="closeLoginRequiredModal()">×</button>

        <div style="text-align: center; padding: 20px 0;">
            <!-- 아이콘 -->
            <div style="margin-bottom: 20px;">
                <svg width="80" height="80" viewBox="0 0 80 80" fill="none" style="margin: 0 auto;">
                    <circle cx="40" cy="40" r="35" stroke="#FF6B00" stroke-width="3" fill="none"/>
                    <path d="M40 50C47.732 50 54 43.732 54 36C54 28.268 47.732 22 40 22C32.268 22 26 28.268 26 36C26 43.732 32.268 50 40 50Z" stroke="#FF6B00" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M27.5 60C27.5 55.8579 29.1437 51.8854 32.0787 48.9504C35.0137 46.0154 38.9862 44.3716 43.1283 44.3716H56.8717C61.0138 44.3716 64.9863 46.0154 67.9213 48.9504C70.8563 51.8854 72.5 55.8579 72.5 60" stroke="#FF6B00" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </div>

            <!-- 제목 -->
            <h2 style="color: #FF6B00; font-size: 24px; margin-bottom: 20px; font-weight: bold;">
                로그인이 필요한 서비스입니다
            </h2>

            <!-- 설명 -->
            <div style="margin-bottom: 30px;">
                <p style="color: #8A6A50; font-size: 16px; margin-bottom: 15px;">
                    방문 예약은 회원만 이용 가능합니다.
                </p>
                <p style="color: #8A6A50; font-size: 14px; line-height: 1.6;">
                    회원가입 후 다양한 헬스장을 예약하고<br>
                    혜택을 받아보세요!
                </p>
            </div>

            <!-- 회원 전용 혜택 -->
            <div style="background-color: #2D1810; border-radius: 8px; padding: 20px; margin-bottom: 30px; text-align: left;">
                <p style="color: #FF6B00; font-size: 14px; font-weight: 600; margin-bottom: 12px;">
                    회원 전용 혜택
                </p>
                <ul style="list-style: none; padding: 0; margin: 0;">
                    <li style="color: #8A6A50; font-size: 13px; margin-bottom: 8px; padding-left: 20px; position: relative;">
                        <span style="position: absolute; left: 0; color: #FF6B00;">✓</span>
                        온라인 방문 예약
                    </li>
                    <li style="color: #8A6A50; font-size: 13px; margin-bottom: 8px; padding-left: 20px; position: relative;">
                        <span style="position: absolute; left: 0; color: #FF6B00;">✓</span>
                        공지사항 및 혜택 알림
                    </li>
                    <li style="color: #8A6A50; font-size: 13px; margin-bottom: 8px; padding-left: 20px; position: relative;">
                        <span style="position: absolute; left: 0; color: #FF6B00;">✓</span>
                        PT 예약 및 스케줄 확인
                    </li>
                    <li style="color: #8A6A50; font-size: 13px; margin-bottom: 8px; padding-left: 20px; position: relative;">
                        <span style="position: absolute; left: 0; color: #FF6B00;">✓</span>
                        운동 기록 관리
                    </li>
                    <li style="color: #8A6A50; font-size: 13px; padding-left: 20px; position: relative;">
                        <span style="position: absolute; left: 0; color: #FF6B00;">✓</span>
                        헬스장 실시간 혼잡도 확인
                    </li>
                </ul>
            </div>

            <!-- 버튼 그룹 -->
            <div style="display: flex; gap: 12px;">
                <button
                        onclick="closeLoginRequiredModal()"
                        class="btn btn-secondary"
                        style="flex: 1; padding: 14px; font-size: 15px;">
                    취소
                </button>
                <button
                        onclick="goToLogin()"
                        class="btn btn-primary"
                        style="flex: 1; padding: 14px; font-size: 15px;">
                    로그인하기
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // 로그인 필요 모달 닫기
    function closeLoginRequiredModal() {
        const modal = document.getElementById('loginRequiredModal');
        if (modal) {
            modal.style.display = 'none';
        }
    }

    // 로그인 페이지로 이동
    function goToLogin() {
        closeLoginRequiredModal();
        // 로그인 모달 열기
        const loginModal = document.getElementById('loginModal');
        if (loginModal) {
            loginModal.classList.add('active');
        }
    }

    // 모달 외부 클릭 시 닫기
    const loginRequiredModalOverlay = document.getElementById('loginRequiredModal');
    if (loginRequiredModalOverlay) {
        loginRequiredModalOverlay.addEventListener('click', function(e) {
            if (e.target === loginRequiredModalOverlay) {
                closeLoginRequiredModal();
            }
        });
    }
</script>