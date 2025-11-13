<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymHub - 영상 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">
    <style>
        /* gymVideoManagement 전용 스타일 */
        /* main-content는 common.css에 있음 */

        /* Section Container */
        .section {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.3);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 16px;
            border-bottom: 2px solid #ff6b00;
            margin-bottom: 24px;
        }

        .section-title {
            font-size: 18px;
            color: #ff6b00;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .upload-button {
            background-color: #ff6b00;
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            color: white;
            font-size: 14px;
            cursor: pointer;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            transition: all 0.3s;
        }

        .upload-button:hover {
            box-shadow: 0 0 25px rgba(255, 107, 0, 0.6);
            transform: translateY(-2px);
        }

        /* Video Grid */
        .video-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        /* Video Card */
        .video-card {
            background-color: #3d2810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            overflow: hidden;
            cursor: pointer;
            transition: all 0.3s;
            position: relative;
        }

        .video-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 20px rgba(255, 107, 0, 0.4);
        }

        .video-thumbnail {
            position: relative;
            width: 100%;
            height: 160px;
            overflow: hidden;
            background-color: #1a0f0a;
        }

        .video-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .play-button {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 50px;
            height: 50px;
            background-color: #ff6b00;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            color: white;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.6);
            transition: all 0.3s;
        }

        .video-card:hover .play-button {
            transform: translate(-50%, -50%) scale(1.1);
            box-shadow: 0 0 25px rgba(255, 107, 0, 0.8);
        }

        .video-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #ff3333;
            color: white;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
        }

        .video-info {
            padding: 16px;
            position: relative;
        }

        .video-title {
            font-size: 14px;
            color: white;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .video-date {
            font-size: 12px;
            color: #b0b0b0;
        }

        .video-delete-button {
            position: absolute;
            bottom: 12px;
            right: 12px;
            width: 32px;
            height: 32px;
            background: transparent;
            border: 1px solid #ff6b00;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            z-index: 10;
        }

        .video-delete-button:hover {
            background: rgba(255, 82, 82, 0.1);
            border-color: #ff5252;
        }

        .video-delete-icon {
            width: 18px;
            height: 18px;
        }

        /* Modal Overlay */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.8);
            z-index: 1000;
            align-items: center;
            justify-content: center;
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal-content {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 30px;
            max-width: 600px;
            width: 90%;
            box-shadow: 0 0 30px rgba(255, 107, 0, 0.5);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 20px;
            color: #ff6b00;
        }

        .close-button {
            background: transparent;
            border: none;
            color: #ff6b00;
            font-size: 24px;
            cursor: pointer;
            padding: 0;
            width: 30px;
            height: 30px;
        }

        .modal-body {
            color: white;
        }

        .modal-body p {
            margin-bottom: 10px;
            line-height: 1.6;
        }

        /* 업로드 모달 폼 스타일 */
        .upload-modal-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-label {
            font-size: 14px;
            color: #ff6b00;
            font-weight: 500;
        }

        .form-input {
            width: 100%;
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 12px 16px;
            color: white;
            font-size: 14px;
            font-family: 'Noto Sans KR', sans-serif;
            transition: all 0.3s;
            box-sizing: border-box;
        }

        .form-input:focus {
            outline: none;
            box-shadow: 0 0 15px rgba(255, 107, 0, 0.4);
            border-color: #ff8800;
        }

        .form-input::placeholder {
            color: #666;
        }

        .modal-footer {
            display: flex;
            justify-content: flex-end;
            gap: 12px;
            margin-top: 24px;
            padding-top: 20px;
            border-top: 2px solid #ff6b00;
        }

        .modal-btn {
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            border: 2px solid;
            font-family: 'Noto Sans KR', sans-serif;
        }

        .modal-btn-cancel {
            background-color: transparent;
            border-color: #ff6b00;
            color: #b0b0b0;
        }

        .modal-btn-cancel:hover {
            background-color: rgba(255, 107, 0, 0.1);
            color: #ff6b00;
        }

        .modal-btn-upload {
            background-color: #ff6b00;
            border-color: #ff6b00;
            color: white;
        }

        .modal-btn-upload:hover {
            background-color: #ff8800;
            box-shadow: 0 0 20px rgba(255, 107, 0, 0.6);
            transform: translateY(-2px);
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .main-content {
                width: 100% !important;
                margin-left: 0 !important;
            }
            
            .video-grid {
                grid-template-columns: repeat(2, 1fr);
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
                <h1>영상 관리</h1>
                <p>운동 강의 영상을 업로드하고 관리하세요</p>
            </div>
            <div class="section">
                <div class="section-header">
                    <h2 class="section-title">
                        운동 강의 영상 관리
                    </h2>
                    <button class="upload-button" onclick="uploadVideo()">영상 업로드</button>
                </div>

                <div class="video-grid" id="videoGrid">
                    <!-- 영상 카드들이 여기에 동적으로 추가됩니다 -->
                </div>
            </div>
        </div>
    </div>

    <!-- 영상 재생 Modal -->
    <div class="modal-overlay" id="videoModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title" id="modalTitle">영상 재생</h3>
                <button class="close-button" onclick="closeModal()">×</button>
            </div>
            <div class="modal-body">
                <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; background-color: #1a0f0a; border-radius: 8px;">
                    <iframe id="videoPlayer" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: none;" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                </div>
            </div>
        </div>
    </div>

    <!-- 영상 업로드 Modal -->
    <div class="modal-overlay" id="uploadModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 class="modal-title">영상 업로드</h3>
                <button class="close-button" onclick="closeUploadModal()">×</button>
            </div>
            <div class="modal-body">
                <form id="uploadVideoForm" class="upload-modal-form">
                    <div class="form-group">
                        <label class="form-label" for="youtubeUrl">유튜브 url</label>
                        <input type="text" id="youtubeUrl" name="youtubeUrl" class="form-input" placeholder="url 입력" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="videoTitle">영상 제목</label>
                        <input type="text" id="videoTitle" name="videoTitle" class="form-input" placeholder="영상 제목을 입력하세요" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="videoAuthor">작성자</label>
                        <input type="text" id="videoAuthor" name="videoAuthor" class="form-input" placeholder="작성자를 입력하세요" required>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="modal-btn modal-btn-cancel" onclick="closeUploadModal()">취소</button>
                        <button type="submit" class="modal-btn modal-btn-upload">업로드</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        // 영상 데이터
        let videos = [];

        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            loadVideosFromServer();
        });

        // 서버에서 영상 리스트 가져오기
        function loadVideosFromServer() {
            fetch('${pageContext.request.contextPath}/video/list.ajax', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.success) {
                    videos = data.videos || [];
                    renderVideos();
                } else {
                    console.error('데이터 로드 실패:', data.message);
                    alert('영상 데이터를 불러오는데 실패했습니다: ' + (data.message || '알 수 없는 오류'));
                }
            })
            .catch(function(error) {
                console.error('AJAX 오류:', error);
                alert('영상 데이터를 불러오는데 실패했습니다.');
            });
        }

        // 영상 카드 렌더링
        function renderVideos() {
            const videoGrid = document.getElementById('videoGrid');
            videoGrid.innerHTML = '';

            for (let i = 0; i < videos.length; i++) {
                const video = videos[i];
                const card = createVideoCard(video);
                videoGrid.appendChild(card);
            }

            // 카드 진입 애니메이션
            setTimeout(function() {
                const cards = document.querySelectorAll('.video-card');
                for (let i = 0; i < cards.length; i++) {
                    const card = cards[i];
                    const index = i;
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(20px)';
                    setTimeout(function() {
                        card.style.transition = 'all 0.5s ease';
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, index * 50);
                }
            }, 100);
        }

        // 영상 카드 생성
        function createVideoCard(video) {
            const card = document.createElement('div');
            card.className = 'video-card';
            card.onclick = function() {
                playVideo(video);
            };

            // YouTube URL에서 썸네일 추출
            const thumbnailUrl = getYouTubeThumbnail(video.youtubeUrl);
            const videoDate = getVideoDate(video);
            const escapedTitle = video.youtubeUrlTitle.replace(/'/g, "\\'").replace(/"/g, '&quot;');
            const contextPath = '${pageContext.request.contextPath}';

            card.innerHTML = 
                '<div class="video-thumbnail">' +
                    '<img src="' + thumbnailUrl + '" alt="' + escapedTitle + '" onerror="this.src=\'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400&h=300&fit=crop\'">' +
                    '<div class="play-button">▶</div>' +
                '</div>' +
                '<div class="video-info">' +
                    '<div class="video-title">' + video.youtubeUrlTitle + '</div>' +
                    '<div class="video-date">' + videoDate + '</div>' +
                    '<button class="video-delete-button" onclick="event.stopPropagation(); deleteVideo(' + video.youtubeUrlNo + ', \'' + escapedTitle + '\')">' +
                        '<img src="' + contextPath + '/resources/images/icon/delete.png" alt="삭제" class="video-delete-icon">' +
                    '</button>' +
                '</div>';

            return card;
        }

        // YouTube URL에서 썸네일 URL 추출
        function getYouTubeThumbnail(url) {
            if (!url) return 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400&h=300&fit=crop';
            
            let videoId = '';
            if (url.includes('youtube.com/watch?v=')) {
                videoId = url.split('v=')[1].split('&')[0];
            } else if (url.includes('youtu.be/')) {
                videoId = url.split('youtu.be/')[1].split('?')[0];
            }
            
            if (videoId) {
                return 'https://img.youtube.com/vi/' + videoId + '/maxresdefault.jpg';
            }
            return 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400&h=300&fit=crop';
        }

        // 영상 날짜 포맷팅 (현재는 기본값 반환, 필요시 수정)
        function getVideoDate(video) {
            // DB에 날짜 필드가 없으므로 기본값 반환
            return '등록됨';
        }

        // YouTube URL을 embed URL로 변환
        function convertToEmbedUrl(url) {
            if (!url) return '';
            
            let videoId = '';
            if (url.includes('youtube.com/watch?v=')) {
                videoId = url.split('v=')[1].split('&')[0];
            } else if (url.includes('youtu.be/')) {
                videoId = url.split('youtu.be/')[1].split('?')[0];
            } else if (url.includes('youtube.com/embed/')) {
                // 이미 embed URL인 경우
                return url;
            }
            
            if (videoId) {
                return 'https://www.youtube.com/embed/' + videoId;
            }
            return '';
        }

        // 영상 재생
        function playVideo(video) {
            document.getElementById('modalTitle').textContent = video.youtubeUrlTitle;
            const embedUrl = convertToEmbedUrl(video.youtubeUrl);
            const videoPlayer = document.getElementById('videoPlayer');
            
            if (embedUrl) {
                videoPlayer.src = embedUrl;
            } else {
                alert('유효하지 않은 YouTube URL입니다.');
                return;
            }
            
            document.getElementById('videoModal').classList.add('active');
        }

        // 모달 닫기
        function closeModal() {
            const videoPlayer = document.getElementById('videoPlayer');
            videoPlayer.src = ''; // iframe 비워서 영상 중지
            document.getElementById('videoModal').classList.remove('active');
        }

        // 모달 외부 클릭 시 닫기
        document.getElementById('videoModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal();
            }
        });

        // ESC 키로 모달 닫기
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                closeModal();
                closeUploadModal();
            }
        });

        // 영상 업로드 모달 열기
        function uploadVideo() {
            document.getElementById('uploadModal').classList.add('active');
        }

        // 영상 업로드 모달 닫기
        function closeUploadModal() {
            document.getElementById('uploadModal').classList.remove('active');
            document.getElementById('uploadVideoForm').reset();
        }

        // 영상 업로드 모달 외부 클릭 시 닫기
        document.getElementById('uploadModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeUploadModal();
            }
        });

        // 영상 업로드 폼 제출
        document.getElementById('uploadVideoForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const youtubeUrl = document.getElementById('youtubeUrl').value.trim();
            const videoTitle = document.getElementById('videoTitle').value.trim();
            const videoAuthor = document.getElementById('videoAuthor').value.trim();
            
            if (!youtubeUrl || !videoTitle || !videoAuthor) {
                alert('모든 필드를 입력해주세요.');
                return;
            }
            
            // AJAX로 서버에 업로드 요청
            const requestData = {
                youtubeUrl: youtubeUrl,
                videoTitle: videoTitle,
                videoAuthor: videoAuthor
            };

            fetch('${pageContext.request.contextPath}/video/add.ajax', {
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
                    alert('영상이 업로드되었습니다.');
                    closeUploadModal();
                    // 서버에서 다시 전체 리스트 가져오기
                    loadVideosFromServer();
                } else {
                    alert('영상 업로드에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
                }
            })
            .catch(function(error) {
                console.error('AJAX 오류:', error);
                alert('영상 업로드 중 오류가 발생했습니다.');
            });
        });

        // 영상 삭제
        function deleteVideo(youtubeUrlNo, title) {
            if (confirm('정말로 "' + title + '" 영상을 삭제하시겠습니까?')) {
                // AJAX로 서버에 삭제 요청
                const requestData = {
                    youtubeUrlNo: youtubeUrlNo
                };

                fetch('${pageContext.request.contextPath}/video/delete.ajax', {
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
                        // videos 배열에서 제거
                        const newVideos = [];
                        for (let i = 0; i < videos.length; i++) {
                            if (videos[i].youtubeUrlNo !== youtubeUrlNo) {
                                newVideos.push(videos[i]);
                            }
                        }
                        videos = newVideos;
                        
                        renderVideos();
                        alert('영상이 삭제되었습니다.');
                    } else {
                        alert('영상 삭제에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
                    }
                })
                .catch(function(error) {
                    console.error('AJAX 오류:', error);
                    alert('영상 삭제 중 오류가 발생했습니다.');
                });
            }
        }
    </script>
</body>
</html>

