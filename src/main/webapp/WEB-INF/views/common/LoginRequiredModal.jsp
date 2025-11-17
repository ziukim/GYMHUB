<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 로그인 필요 모달 -->
<div class="modal-overlay" id="loginRequiredModal">
    <div class="modal-container" onclick="event.stopPropagation();">
        <button class="modal-close" onclick="closeLoginRequiredModal()">×</button>

        <div style="text-align: center; padding: 20px 0;">
            <!-- 아이콘 -->
            <div style="margin-bottom: 20px;">
                <svg width="80" height="80" viewBox="0 0 80 80" fill="none" style="margin: 0 auto;">
                    <circle cx="40" cy="40" r="35" stroke="#FF6B00" stroke-width="3" fill="none"/>
                    <circle cx="40" cy="32" r="10" stroke="#FF6B00" stroke-width="3" fill="none"/>
                    <path d="M 25 55 Q 25 45, 32.5 45 Q 40 45, 47.5 45 Q 55 45, 55 55"
                          stroke="#FF6B00"
                          stroke-width="3"
                          fill="none"
                          stroke-linecap="round"/>
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
                        type="button"
                        onclick="closeLoginRequiredModal(); event.stopPropagation();"
                        class="btn btn-secondary"
                        style="flex: 1; padding: 14px; font-size: 15px; cursor: pointer;">
                    취소
                </button>
                <button
                        type="button"
                        onclick="goToLogin(); event.stopPropagation();"
                        class="btn btn-primary"
                        style="flex: 1; padding: 14px; font-size: 15px; cursor: pointer;">
                    로그인하기
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    (function() {
        // 로그인 필요 모달 닫기
        function closeLoginRequiredModal() {
            const modal = document.getElementById('loginRequiredModal');
            if (modal) {
                modal.classList.remove('active');
            }
        }

        // 로그인 페이지로 이동
        function goToLogin() {
            const loginRequiredModal = document.getElementById('loginRequiredModal');
            if (loginRequiredModal) {
                loginRequiredModal.classList.remove('active');
            }
            
            // 헬스장 상세 모달 닫기 (index.jsp에서 style.display로 제어하므로 동일하게 처리)
            const gymDetailModal = document.getElementById('gymDetailModal');
            if (gymDetailModal) {
                gymDetailModal.style.display = 'none';
            }
            
            // 약간의 지연 후 로그인 모달 열기 (모달 전환 애니메이션을 위해)
            setTimeout(function() {
                const loginModal = document.getElementById('loginModal');
                if (loginModal) {
                    loginModal.classList.add('active');
                }
            }, 100);
        }

        // 전역 함수로 등록
        window.closeLoginRequiredModal = closeLoginRequiredModal;
        window.goToLogin = goToLogin;

        // 모달 외부 클릭 시 닫기 (이벤트 위임 사용)
        document.addEventListener('click', function(e) {
            const loginRequiredModal = document.getElementById('loginRequiredModal');
            if (loginRequiredModal && loginRequiredModal.classList.contains('active')) {
                // 모달 오버레이를 직접 클릭한 경우에만 닫기
                if (e.target === loginRequiredModal) {
                    closeLoginRequiredModal();
                }
            }
        });
    })();
</script>