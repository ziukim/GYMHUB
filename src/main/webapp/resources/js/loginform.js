// 로그인 상태 관리
let isLoggedIn = false;
let currentUser = '';

// DOM이 로드된 후 실행
document.addEventListener('DOMContentLoaded', function() {
    // 모달 요소들
    const loginBtn = document.getElementById('loginBtn');
    const signupBtn = document.getElementById('signupBtn');
    const logoutBtn = document.getElementById('logoutBtn');
    const loginModal = document.getElementById('loginModal');
    const signupModal = document.getElementById('signupModal');
    const closeLoginModal = document.getElementById('closeLoginModal');
    const closeModal = document.getElementById('closeModal');
    const welcomeMessage = document.getElementById('welcomeMessage');
    const goToSignup = document.getElementById('goToSignup');

    // 요소가 존재하는지 확인
    if (!loginBtn || !signupBtn || !loginModal || !signupModal) {
        console.warn('일부 모달 요소를 찾을 수 없습니다.');
        return;
    }

    // 로그인 모달 열기/닫기
    loginBtn.addEventListener('click', () => {
        loginModal.classList.add('active');
    });

    if (closeLoginModal) {
        closeLoginModal.addEventListener('click', () => {
            loginModal.classList.remove('active');
        });
    }

    loginModal.addEventListener('click', (e) => {
        if (e.target === loginModal) {
            loginModal.classList.remove('active');
        }
    });

    // 회원가입 모달 열기/닫기
    signupBtn.addEventListener('click', () => {
        signupModal.classList.add('active');
    });

    if (closeModal) {
        closeModal.addEventListener('click', () => {
            signupModal.classList.remove('active');
        });
    }

    signupModal.addEventListener('click', (e) => {
        if (e.target === signupModal) {
            signupModal.classList.remove('active');
        }
    });

    // 로그인에서 회원가입으로 이동
    if (goToSignup) {
        goToSignup.addEventListener('click', () => {
            loginModal.classList.remove('active');
            signupModal.classList.add('active');
        });
    }

    // 로그인 폼 제출
    const loginForm = document.getElementById('loginForm');
    if (loginForm) {
        loginForm.addEventListener('submit', (e) => {
            e.preventDefault(); // 기본 제출 막기

            const userId = document.getElementById('loginId').value;
            const userPassword = document.getElementById('loginPassword').value;

            if (!userId || !userPassword) {
                alert('아이디와 비밀번호를 입력해주세요.');
                return;
            }

            // 임시 관리자 계정 체크
            if (userId === 'admin' && userPassword === 'admin123') {
                // localStorage에 저장
                localStorage.setItem('loginUser', JSON.stringify({
                    id: userId,
                    name: '어디 센터',
                    type: 'GYM'
                }));

                // 관리자 선택 페이지로 이동
                location.href = 'admin/adminSelect';
                return;
            }

            alert('아이디 또는 비밀번호가 올바르지 않습니다.');
        });
    }

    // 로그아웃
    if (logoutBtn) {
        logoutBtn.addEventListener('click', () => {
            // 서버 측 로그아웃 처리 (JSP에서 처리)
            // 여기서는 클라이언트 측 UI만 업데이트
        });
    }

    // 탭 전환 기능 (회원가입 모달 내)
    const tabButtons = document.querySelectorAll('.tab-button');
    const tabContents = document.querySelectorAll('.tab-content');

    tabButtons.forEach(tab => {
        tab.addEventListener('click', function() {
            const targetTab = this.getAttribute('data-tab');

            tabButtons.forEach(t => t.classList.remove('active'));
            tabContents.forEach(c => c.classList.remove('active'));

            this.classList.add('active');
            const targetContent = document.getElementById(targetTab);
            if (targetContent) {
                targetContent.classList.add('active');
            }
        });
    });

    // 비밀번호 확인 검증
    document.querySelectorAll('.registration-form').forEach(form => {
        const passwordInput = form.querySelector('.password');
        const confirmInput = form.querySelector('.password-confirm');

        if (passwordInput && confirmInput) {
            const errorText = confirmInput.parentElement.querySelector('.helper-text.error');

            confirmInput.addEventListener('input', function() {
                const password = passwordInput.value;
                const confirmPassword = this.value;

                if (errorText) {
                    if (confirmPassword && password !== confirmPassword) {
                        errorText.style.display = 'block';
                        errorText.classList.remove('hidden');
                    } else {
                        errorText.style.display = 'none';
                        errorText.classList.add('hidden');
                    }
                }
            });
        }
    });

    // 검색 기능
    const searchInput = document.querySelector('.search-input');
    const searchBtn = document.querySelector('.search-btn');
    const filterSelect = document.querySelector('.filter-select');
    const gymCards = document.querySelectorAll('.gym-card');

    // 검색 실행 함수
    function performSearch() {
        if (!searchInput || !gymCards.length) return;

        const searchTerm = searchInput.value.toLowerCase().trim();
        const sortOption = filterSelect ? filterSelect.value : '';

        let visibleCards = [];

        // 검색어로 필터링
        gymCards.forEach(card => {
            const titleEl = card.querySelector('.gym-title');
            const locationEl = card.querySelector('.gym-location');
            const descriptionEl = card.querySelector('.gym-description');

            if (!titleEl || !locationEl || !descriptionEl) return;

            const title = titleEl.textContent.toLowerCase();
            const location = locationEl.textContent.toLowerCase();
            const description = descriptionEl.textContent.toLowerCase();

            if (searchTerm === '' ||
                title.includes(searchTerm) ||
                location.includes(searchTerm) ||
                description.includes(searchTerm)) {
                card.style.display = 'block';
                visibleCards.push(card);
            } else {
                card.style.display = 'none';
            }
        });

        // 정렬
        if (sortOption && visibleCards.length > 0) {
            sortCards(visibleCards, sortOption);
        }

        // 검색 결과 메시지
        showSearchResults(visibleCards.length, searchTerm);
    }

    // 카드 정렬 함수
    function sortCards(cards, sortOption) {
        const cardsGrid = document.querySelector('.cards-grid');
        if (!cardsGrid) return;

        const cardsArray = Array.from(cards);

        cardsArray.sort((a, b) => {
            try {
                switch(sortOption) {
                    case 'rating':
                        const ratingElA = a.querySelector('.gym-rating');
                        const ratingElB = b.querySelector('.gym-rating');
                        if (!ratingElA || !ratingElB) return 0;
                        const ratingA = parseFloat(ratingElA.textContent.match(/[\d.]+/)?.[0] || 0);
                        const ratingB = parseFloat(ratingElB.textContent.match(/[\d.]+/)?.[0] || 0);
                        return ratingB - ratingA;

                    case 'price-low':
                        const priceElA = a.querySelector('.gym-price');
                        const priceElB = b.querySelector('.gym-price');
                        if (!priceElA || !priceElB) return 0;
                        const priceA = parseInt(priceElA.textContent.replace(/[^\d]/g, '') || 0);
                        const priceB = parseInt(priceElB.textContent.replace(/[^\d]/g, '') || 0);
                        return priceA - priceB;

                    case 'price-high':
                        const priceElA2 = a.querySelector('.gym-price');
                        const priceElB2 = b.querySelector('.gym-price');
                        if (!priceElA2 || !priceElB2) return 0;
                        const priceA2 = parseInt(priceElA2.textContent.replace(/[^\d]/g, '') || 0);
                        const priceB2 = parseInt(priceElB2.textContent.replace(/[^\d]/g, '') || 0);
                        return priceB2 - priceA2;

                    case 'review':
                        const reviewElA = a.querySelector('.gym-rating');
                        const reviewElB = b.querySelector('.gym-rating');
                        if (!reviewElA || !reviewElB) return 0;
                        const reviewMatchA = reviewElA.textContent.match(/\((\d+)\)/);
                        const reviewMatchB = reviewElB.textContent.match(/\((\d+)\)/);
                        const reviewA = reviewMatchA ? parseInt(reviewMatchA[1]) : 0;
                        const reviewB = reviewMatchB ? parseInt(reviewMatchB[1]) : 0;
                        return reviewB - reviewA;

                    default:
                        return 0;
                }
            } catch (error) {
                console.error('정렬 중 오류:', error);
                return 0;
            }
        });

        // 정렬된 순서대로 DOM에 다시 추가
        cardsArray.forEach(card => {
            cardsGrid.appendChild(card);
        });
    }

    // 검색 결과 메시지 표시
    function showSearchResults(count, searchTerm) {
        const cardsSection = document.querySelector('.cards-section');
        if (!cardsSection) return;

        let resultMessage = document.querySelector('.search-result-message');

        if (!resultMessage) {
            resultMessage = document.createElement('div');
            resultMessage.className = 'search-result-message';
            const cardsGrid = document.querySelector('.cards-grid');
            if (cardsGrid) {
                cardsSection.insertBefore(resultMessage, cardsGrid);
            }
        }

        if (searchTerm) {
            if (count === 0) {
                resultMessage.textContent = `"${searchTerm}"에 대한 검색 결과가 없습니다.`;
                resultMessage.style.display = 'block';
            } else {
                resultMessage.textContent = `"${searchTerm}" 검색 결과: ${count}개`;
                resultMessage.style.display = 'block';
            }
        } else {
            resultMessage.style.display = 'none';
        }
    }

    // 검색 버튼 클릭
    if (searchBtn) {
        searchBtn.addEventListener('click', performSearch);
    }

    // 엔터키로 검색
    if (searchInput) {
        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                performSearch();
            }
        });
    }

    // 필터 변경 시 자동 검색
    if (filterSelect) {
        filterSelect.addEventListener('change', performSearch);
    }

    // 헬스장 상세 모달 관련
    const gymDetailModal = document.getElementById('gymDetailModal');
    const closeGymDetailModal = document.getElementById('closeGymDetailModal');
    const bookingBtn = document.getElementById('bookingBtn');

    // gym-card 클릭 이벤트
    gymCards.forEach(card => {
        card.style.cursor = 'pointer';
        card.addEventListener('click', function() {
            // 카드에서 정보 추출
            const titleEl = card.querySelector('.gym-title');
            const locationEl = card.querySelector('.gym-location');
            const descriptionEl = card.querySelector('.gym-description');
            const priceEl = card.querySelector('.gym-price');
            const tagsEl = card.querySelectorAll('.tag');

            if (!titleEl || !locationEl) return;

            const title = titleEl.textContent;
            const location = locationEl.textContent;
            const description = descriptionEl ? descriptionEl.textContent : '설명이 없습니다.';
            const price = priceEl ? priceEl.textContent : '가격 정보 없음';

            // 태그 수집
            const tags = Array.from(tagsEl).map(tag => tag.textContent);

            // 모달 내용 업데이트
            const gymDetailTitle = document.getElementById('gymDetailTitle');
            const gymDetailAddress = document.getElementById('gymDetailAddress');
            const gymDetailDescription = document.getElementById('gymDetailDescription');
            const gymDetailBadges = document.getElementById('gymDetailBadges');
            const gymDetailPrice = document.getElementById('gymDetailPrice');

            if (gymDetailTitle) gymDetailTitle.textContent = title;
            if (gymDetailAddress) gymDetailAddress.textContent = location;
            if (gymDetailDescription) gymDetailDescription.textContent = description;

            // 뱃지 업데이트
            if (gymDetailBadges) {
                gymDetailBadges.innerHTML = '';
                tags.forEach(tag => {
                    const badge = document.createElement('span');
                    badge.className = 'badge';
                    badge.textContent = tag;
                    gymDetailBadges.appendChild(badge);
                });
            }

            // 가격 정보 업데이트
            if (gymDetailPrice) {
                const priceText = price.replace('월 ', '').replace('원', '');
                gymDetailPrice.innerHTML = `
                    <p>월 ${priceText}</p>
                    <p>3개월: ₩79,000</p>
                    <p>6개월: ₩69,000</p>
                `;
            }

            // 모달 열기
            if (gymDetailModal) {
                gymDetailModal.classList.add('active');
            }
        });
    });

    // 헬스장 상세 모달 닫기
    if (closeGymDetailModal) {
        closeGymDetailModal.addEventListener('click', () => {
            if (gymDetailModal) {
                gymDetailModal.classList.remove('active');
            }
        });
    }

    // 모달 외부 클릭 시 닫기
    if (gymDetailModal) {
        gymDetailModal.addEventListener('click', (e) => {
            if (e.target === gymDetailModal) {
                gymDetailModal.classList.remove('active');
            }
        });
    }

    // 방문 예약 버튼 클릭
    if (bookingBtn) {
        bookingBtn.addEventListener('click', function() {
            // booking 페이지로 이동
            const contextPath = window.contextPath || '';
            window.location.href = contextPath + '/booking/booking';
        });
    }

    // 기구 목록 모달 관련
    const equipmentListModal = document.getElementById('equipmentListModal');
    const closeEquipmentListModal = document.getElementById('closeEquipmentListModal');

    // 기구 더보기 버튼 클릭 시 모달 열기 (이벤트 위임 사용)
    document.addEventListener('click', function(e) {
        if (e.target && e.target.classList.contains('more-text')) {
            e.stopPropagation(); // 이벤트 버블링 방지
            if (equipmentListModal) {
                equipmentListModal.classList.add('active');
            }
        }
    });

    // 기구 목록 모달 닫기
    if (closeEquipmentListModal) {
        closeEquipmentListModal.addEventListener('click', () => {
            if (equipmentListModal) {
                equipmentListModal.classList.remove('active');
            }
        });
    }

    // 기구 목록 모달 외부 클릭 시 닫기
    if (equipmentListModal) {
        equipmentListModal.addEventListener('click', (e) => {
            if (e.target === equipmentListModal) {
                equipmentListModal.classList.remove('active');
            }
        });
    }
});

