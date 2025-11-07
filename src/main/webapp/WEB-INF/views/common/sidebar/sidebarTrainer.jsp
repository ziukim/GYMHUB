<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* Logo Container */
    .logo-container {
        position: absolute;
        left: 33px;
        top: 1px;
        width: 221px;
        height: 108px;
        display: flex;
        align-items: center;
        gap: 7px;
        padding: 24px 22px 24px 0;
        box-sizing: border-box;
    }
    .logo-container:hover {
        transform: scale(1.02);
        transition: transform 0.2s ease-in-out;
    }


    .icon {
        width: 48px;
        height: 48px;
        flex-shrink: 0;
    }

    .icon img {
        display: block;
        width: 100%;
        height: 100%;
        object-fit: contain;
        filter: drop-shadow(0 0 4px #e67000)
        drop-shadow(0 0 8px #e67000)
        drop-shadow(0 0 12px #e68900);
        animation: iconNeonBuzz 3s ease-in-out infinite;
    }

    @keyframes iconNeonBuzz {
        0%, 100% {
            filter: drop-shadow(0 0 4px #e67000)
            drop-shadow(0 0 8px #e67000)
            drop-shadow(0 0 12px #e68900);
        }
        10% {
            filter: drop-shadow(0 0 2px #e67000)
            drop-shadow(0 0 4px #e67000);
        }
        20% {
            filter: drop-shadow(0 0 6px #e67000)
            drop-shadow(0 0 10px #e67000)
            drop-shadow(0 0 14px #e68900);
        }
        30% {
            filter: drop-shadow(0 0 4px #e67000)
            drop-shadow(0 0 8px #e67000);
        }
    }

    .logo-text-container {
        width: 143px;
        height: 62px;
        flex-shrink: 0;
        position: relative;
    }

    .logo-text {
        position: absolute;
        left: 7px;
        top: 19px;
        width: 129px;
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        font-size: 1.2rem;
        font-weight: 800;
        font-style: italic;
        line-height: 24px;
        color: #ff6b00;
        text-transform: uppercase;
        letter-spacing: 0.08em;
        text-shadow:
                0 0 5px #e67000,
                0 0 10px #e67000,
                0 0 15px #e68900;
        animation: neonBuzz 3s ease-in-out infinite;
    }

    @keyframes neonBuzz {
        0%, 100% {
            text-shadow:
                    0 0 5px #e67000,
                    0 0 10px #e67000,
                    0 0 15px #e68900;
        }
        10% {
            text-shadow:
                    0 0 3px #e67000,
                    0 0 5px #e67000;
        }
        20% {
            text-shadow:
                    0 0 7px #e67000,
                    0 0 12px #e67000,
                    0 0 18px #e68900;
        }
        30% {
            text-shadow:
                    0 0 5px #e67000,
                    0 0 10px #e67000;
        }
    }

    /* Divider */
    .divider {
        position: absolute;
        left: 0;
        top: 108px;
        width: 255px;
        height: 1px;
        background-color: #ff6b00;
    }

    /* Navigation */
    .navigation {
        position: absolute;
        left: 0;
        top: 109px;
        width: 255px;
        height: 726px;
        padding: 16px;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .nav-button {
        position: relative;
        width: 100%;
        height: 36px;
        border-radius: 6px;
        border: 1px solid transparent;
        background: transparent;
        cursor: pointer;
        transition: border-color 0.2s;
        flex-shrink: 0;
    }

    .nav-button:hover {
        border-color: #ff6b00;
    }

    .nav-button.active {
        border-color: #ff6b00;
    }

    .nav-button.logout {
        border-radius: 8px;
        width: 223px;
    }

    .nav-button img {
        position: absolute;
        left: 12px;
        top: 10px;
        width: 16px;
        height: 16px;
        object-fit: contain;
    }

    .nav-button span {
        position: absolute;
        left: 40px;
        top: 7px;
        font-family: 'ABeeZee', 'Noto Sans KR', sans-serif;
        font-size: 14px;
        line-height: 20px;
        color: #ffa366;
        white-space: nowrap;
        font-weight: 400;
    }

    .nav-button.logout span {
        color: #ff5252;
    }

    /* ===== Logout Modal ===== */
    .gh-modal.hidden { display: none; }
    .gh-modal {
        position: fixed; inset: 0; z-index: 9999;
        display: flex; align-items: center; justify-content: center;
    }
    .gh-modal__overlay {
        position: absolute; inset: 0;
        background: rgba(0,0,0,0.55);
        backdrop-filter: blur(2px);
    }
    .gh-modal__box {
        position: relative;
        width: min(420px, 92vw);
        background: #1a0f0a;
        border: 2px solid #ff6b00;
        border-radius: 12px;
        padding: 20px 20px 16px;
        box-shadow: 0 0 24px rgba(255,107,0,0.35);
        transform: translateY(10px) scale(0.98);
        opacity: 0;
        transition: all .18s ease;
    }
    .gh-modal.show .gh-modal__box {
        transform: translateY(0) scale(1);
        opacity: 1;
    }
    .gh-modal__icon {
        font-size: 28px;
        margin-bottom: 8px;
        text-align: center;
    }
    .gh-modal__title {
        margin: 0 0 6px 0;
        font-size: 18px; font-weight: 700; color: #ffa366; text-align: center;
        text-shadow: 0 0 6px #e67000, 0 0 10px #e68900;
    }
    .gh-modal__desc {
        margin: 0 0 16px 0;
        font-size: 13px; color: #b0b0b0; text-align: center;
    }
    .gh-modal__actions {
        display: flex; gap: 10px; justify-content: flex-end;
    }
    .gh-btn {
        min-width: 96px; height: 36px; padding: 0 14px;
        border-radius: 8px; border: 1px solid transparent;
        background: transparent; color: #ffa366; cursor: pointer;
        transition: all .15s ease;
        font-family: 'Noto Sans KR', sans-serif; font-size: 14px;
    }
    .gh-btn:focus { outline: none; box-shadow: 0 0 0 2px rgba(255,107,0,.35); }
    .gh-btn--cancel {
        border-color: #555; color: #b0b0b0; background: #23130d;
    }
    .gh-btn--cancel:hover { border-color: #777; color: #cfcfcf; }
    .gh-btn--confirm {
        border-color: #ff6b00; color: #ff6b00; background: #26160f;
        box-shadow: inset 0 0 0 1px rgba(255,107,0,.25);
    }
    .gh-btn--confirm:hover {
        background: #2d1810; box-shadow: 0 0 14px rgba(255,107,0,.35);
    }

</style>

<div class="sidebar">
    <!-- Logo Container (index.html로 이동 기능 추가) -->
    <div class="logo-container" onclick="location.href='${pageContext.request.contextPath}/'" style="cursor:pointer;">
        <div class="icon">
            <img src="${pageContext.request.contextPath}/resources/images/icon/logo.png" alt="GymHub 로고 아이콘">
        </div>
        <div class="logo-text-container">
            <p class="logo-text">GymHub</p>
        </div>
    </div>

    <div class="divider"></div>

    <!-- Navigation -->
    <nav class="navigation">
        <!-- 각 버튼에 data-route 추가, onclick 제거 -->
        <button class="nav-button ${currentPage == 'dashboard' ? 'active' : ''}"
                data-route="/trainer/dashboard">
            <img src="${pageContext.request.contextPath}/resources/images/icon/home.png" alt="대시보드 아이콘">
            <span>대시보드</span>
        </button>

        <button class="nav-button ${currentPage == 'notice' ? 'active' : ''}"
                data-route="/trainer/noticeList">
            <img src="${pageContext.request.contextPath}/resources/images/icon/campaign.png" alt="공지사항 아이콘">
            <span>공지사항</span>
        </button>

        <button class="nav-button logout"
                data-route="/logout.do">
            <img src="${pageContext.request.contextPath}/resources/images/icon/output.png" alt="로그아웃 아이콘">
            <span>로그아웃</span>
        </button>
    </nav>

</div>


<!-- Logout Confirm Modal -->
<div id="gh-logout-modal" class="gh-modal hidden" aria-hidden="true">
    <div class="gh-modal__overlay" data-close="true"></div>
    <div class="gh-modal__box" role="dialog" aria-modal="true" aria-labelledby="gh-logout-title">
        <div class="gh-modal__icon">⚠️</div>
        <h3 id="gh-logout-title" class="gh-modal__title">로그아웃 하시겠습니까?</h3>
        <p class="gh-modal__desc">현재 세션이 종료되고 메인 화면으로 이동합니다.</p>
        <div class="gh-modal__actions">
            <button type="button" class="gh-btn gh-btn--cancel" data-close="true">취소</button>
            <button type="button" class="gh-btn gh-btn--confirm" id="gh-logout-confirm">로그아웃</button>
        </div>
    </div>
</div>

<script>
    const ctx = '${pageContext.request.contextPath}';

    // 공통 네비게이션(기존)
    document.querySelectorAll('.nav-button[data-route]').forEach(btn => {
        btn.addEventListener('click', function (e) {
            const to = this.getAttribute('data-route');
            // 로그아웃 버튼은 모달을 띄우고, 그 외는 바로 이동
            if (this.classList.contains('logout')) {
                e.preventDefault();
                e.stopPropagation();
                openLogoutModal();
                return;
            }
            if (to) location.href = ctx + to;
        });
    });

    // Active 표시 (기존)
    (function markActive() {
        const path = location.pathname;
        const buttons = Array.from(document.querySelectorAll('.nav-button[data-route]'));
        let current =
            buttons.find(b => (ctx + b.dataset.route) === path) ||
            buttons.find(b => path.startsWith(ctx + b.dataset.route));
        if (current) {
            buttons.forEach(b => b.classList.remove('active'));
            current.classList.add('active');
            current.setAttribute('aria-current', 'page');
        }
    })();

    // ====== Logout Modal Logic ======
    const modal = document.getElementById('gh-logout-modal');
    const confirmBtn = document.getElementById('gh-logout-confirm');

    function openLogoutModal() {
        if (!modal) return;
        modal.classList.remove('hidden');
        // next tick for transition
        requestAnimationFrame(() => modal.classList.add('show'));
        // 포커스 이동
        setTimeout(() => confirmBtn?.focus(), 50);
    }

    function closeLogoutModal() {
        if (!modal) return;
        modal.classList.remove('show');
        setTimeout(() => modal.classList.add('hidden'), 150);
    }

    // 오버레이/취소 버튼 닫기
    modal?.addEventListener('click', (e) => {
        if (e.target.matches('[data-close="true"]')) {
            closeLogoutModal();
        }
    });

    // ESC로 닫기
    window.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && !modal?.classList.contains('hidden')) {
            closeLogoutModal();
        }
    });

    // 확인 버튼 → 로그아웃 이동
    confirmBtn?.addEventListener('click', () => {
        location.href = ctx + '/logout.do';
    });

    // (옵션) 클릭 로그 유지
    document.querySelectorAll('.nav-button').forEach(button => {
        button.addEventListener('click', function() {
            console.log(this.querySelector('span')?.textContent + ' 클릭됨');
        });
    });
</script>

