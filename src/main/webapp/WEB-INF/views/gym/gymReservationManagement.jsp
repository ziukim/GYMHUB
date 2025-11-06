<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 예약 상담 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* main-content 가로로 가득 차게 - !important로 common.css 오버라이드 */
        .main-content {
            width: calc(100% - 255px) !important;
            margin-left: 255px !important;
            padding: 24px 24px 24px 24px !important;
            margin-right: 0 !important;
        }

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
        <div class="section">
            <div class="section-header">
                <h2 class="section-title">예약 상담 목록</h2>
            </div>

            <div class="consultation-list">
                <!-- Consultation Item 1 - 상담 예정 -->
                <div class="consultation-item" onclick="viewConsultation(1)">
                    <div class="consultation-info">
                        <div class="consultation-name">홍길지</div>
                        <div class="consultation-details">
                            <div class="detail-item">
                                <span class="detail-icon">📅</span>
                                <span>10월 29일 15:00</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-icon">📞</span>
                                <span>010-1234-5678</span>
                            </div>
                        </div>
                    </div>
                    <button class="status-button pending" onclick="toggleStatus(event, this)">상담 예정</button>
                </div>

                <!-- Consultation Item 2 - 상담 예정 -->
                <div class="consultation-item" onclick="viewConsultation(2)">
                    <div class="consultation-info">
                        <div class="consultation-name">김민현</div>
                        <div class="consultation-details">
                            <div class="detail-item">
                                <span class="detail-icon">📅</span>
                                <span>10월 30일 10:00</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-icon">📞</span>
                                <span>010-2345-6789</span>
                            </div>
                        </div>
                    </div>
                    <button class="status-button pending" onclick="toggleStatus(event, this)">상담 예정</button>
                </div>

                <!-- Consultation Item 3 - 상담 완료 -->
                <div class="consultation-item" onclick="viewConsultation(3)">
                    <div class="consultation-info">
                        <div class="consultation-name">박서준</div>
                        <div class="consultation-details">
                            <div class="detail-item">
                                <span class="detail-icon">📅</span>
                                <span>10월 28일 14:00</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-icon">📞</span>
                                <span>010-3456-7890</span>
                            </div>
                        </div>
                    </div>
                    <button class="status-button completed" onclick="toggleStatus(event, this)">상담 완료</button>
                </div>

                <!-- Consultation Item 4 - 상담 완료 -->
                <div class="consultation-item" onclick="viewConsultation(4)">
                    <div class="consultation-info">
                        <div class="consultation-name">이수진</div>
                        <div class="consultation-details">
                            <div class="detail-item">
                                <span class="detail-icon">📅</span>
                                <span>10월 27일 16:00</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-icon">📞</span>
                                <span>010-4567-8901</span>
                            </div>
                        </div>
                    </div>
                    <button class="status-button completed" onclick="toggleStatus(event, this)">상담 완료</button>
                </div>

                <!-- Consultation Item 5 - 상담 완료 -->
                <div class="consultation-item" onclick="viewConsultation(5)">
                    <div class="consultation-info">
                        <div class="consultation-name">최영희</div>
                        <div class="consultation-details">
                            <div class="detail-item">
                                <span class="detail-icon">📅</span>
                                <span>10월 26일 11:00</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-icon">📞</span>
                                <span>010-5678-9012</span>
                            </div>
                        </div>
                    </div>
                    <button class="status-button completed" onclick="toggleStatus(event, this)">상담 완료</button>
                </div>

                <!-- Consultation Item 6 - 상담 완료 -->
                <div class="consultation-item" onclick="viewConsultation(6)">
                    <div class="consultation-info">
                        <div class="consultation-name">정민수</div>
                        <div class="consultation-details">
                            <div class="detail-item">
                                <span class="detail-icon">📅</span>
                                <span>10월 25일 13:00</span>
                            </div>
                            <div class="detail-item">
                                <span class="detail-icon">📞</span>
                                <span>010-6789-0123</span>
                            </div>
                        </div>
                    </div>
                    <button class="status-button completed" onclick="toggleStatus(event, this)">상담 완료</button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 상담 상세 보기
    function viewConsultation(id) {
        const item = event.currentTarget;
        const name = item.querySelector('.consultation-name').textContent;
        const time = item.querySelector('.consultation-details .detail-item:first-child span:last-child').textContent;
        const phone = item.querySelector('.consultation-details .detail-item:last-child span:last-child').textContent;
        
        alert(`상담 정보\n\n이름: ${name}\n시간: ${time}\n연락처: ${phone}`);
    }

    // 상태 토글
    function toggleStatus(event, button) {
        event.stopPropagation(); // 부모 클릭 이벤트 방지
        
        if (button.classList.contains('pending')) {
            if (confirm('상담을 완료 처리하시겠습니까?')) {
                button.classList.remove('pending');
                button.classList.add('completed');
                button.textContent = '상담 완료';
                
                // 애니메이션 효과
                button.style.transform = 'scale(1.1)';
                setTimeout(() => {
                    button.style.transform = 'scale(1)';
                }, 200);
            }
        } else {
            if (confirm('상담을 예정으로 되돌리시겠습니까?')) {
                button.classList.remove('completed');
                button.classList.add('pending');
                button.textContent = '상담 예정';
                
                // 애니메이션 효과
                button.style.transform = 'scale(1.1)';
                setTimeout(() => {
                    button.style.transform = 'scale(1)';
                }, 200);
            }
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
    document.querySelectorAll('.detail-item').forEach(item => {
        const icon = item.querySelector('.detail-icon');
        if (icon && icon.textContent === '📞') {
            item.style.cursor = 'pointer';
            item.addEventListener('click', function(event) {
                event.stopPropagation();
                const phone = this.querySelector('span:last-child').textContent;
                if (confirm(`${phone}로 전화하시겠습니까?`)) {
                    window.location.href = `tel:${phone}`;
                }
            });
        }
    });
</script>
</body>
</html>

