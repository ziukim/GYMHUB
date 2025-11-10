<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이용권 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

    <style>
        .main-content {
            flex: 1;
            margin-right: 0;
        }

        /* 전체 컨테이너 박스 */
        .products-container {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            padding: 32px;
            box-shadow: 0px 0px 20px 0px rgba(255,107,0,0.4);
        }

        /* 페이지 헤더 */
        .page-header {
            margin-bottom: 2rem;
        }

        .page-header h1 {
            font-size: 28px;
            color: #ff6b00;
            margin-bottom: 0.5rem;
        }

        .page-header p {
            font-size: 14px;
            color: #b0b0b0;
        }

        /* 3단 그리드 레이아웃 */
        .products-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 24px;
            align-items: start;
        }

        /* 카테고리 섹션 */
        .category-section {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 26px;
            box-shadow: 0px 0px 15px 0px rgba(255,107,0,0.3);
        }

        .category-header {
            padding-bottom: 12px;
            border-bottom: 2px solid #ff6b00;
            margin-bottom: 16px;
        }

        .category-title {
            font-size: 20px;
            color: #ff6b00;
            margin-bottom: 4px;
        }

        .category-count {
            font-size: 12px;
            color: #b0b0b0;
        }

        .products-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        /* 상품 카드 */
        .product-card {
            background-color: #2d1810;
            border: 2px solid #ff6b00;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0px 0px 15px 0px rgba(255,107,0,0.3);
        }

        .product-header {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 12px;
        }

        .product-info {
            flex: 1;
            min-width: 0;
        }

        .product-name {
            font-size: 18px;
            color: white;
            margin-bottom: 4px;
        }

        .product-duration {
            font-size: 14px;
            color: #b0b0b0;
        }

        .product-price {
            font-size: 24px;
            color: #ff6b00;
            padding-top: 12px;
            border-top: 1px solid #3a3a3a;
        }

        /* 버튼 그룹 */
        .product-actions {
            display: flex;
            gap: 8px;
        }

        /* 버튼 */
        .edit-btn, .delete-btn {
            background: transparent;
            border: 1px solid #ff6b00;
            width: 36px;
            height: 36px;
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .edit-btn:hover {
            background-color: rgba(255, 107, 0, 0.1);
        }

        .delete-btn {
            border-color: #ff5252;
        }

        .delete-btn:hover {
            background-color: rgba(255, 82, 82, 0.1);
        }

        .add-product-btn {
            width: 100%;
            background: transparent;
            border: 2px dashed #ff6b00;
            height: 80px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            cursor: pointer;
            color: #ff6b00;
            font-size: 16px;
            transition: all 0.3s;
        }

        .add-product-btn:hover {
            background-color: #1a0f0a;
        }

        /* 수정 폼 */
        .edit-form {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .form-field {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .form-label {
            font-size: 12px;
            color: #b0b0b0;
        }

        .form-input {
            width: 100%;
            background-color: #0a0a0a;
            border: 1px solid #ff6b00;
            border-radius: 4px;
            padding: 8px 12px;
            color: white;
            font-size: 14px;
            height: 36px;
        }

        .form-input:focus {
            outline: none;
            border-color: #ff8800;
        }

        .form-actions {
            display: flex;
            gap: 8px;
            padding-top: 8px;
        }

        .btn-save {
            flex: 1;
            background-color: #ff6b00;
            border: none;
            height: 36px;
            border-radius: 8px;
            color: white;
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-shadow: 0px 0px 10px 0px rgba(255,107,0,0.4);
        }

        .btn-cancel {
            flex: 1;
            background-color: #0a0a0a;
            border: 1px solid #ff6b00;
            height: 36px;
            border-radius: 8px;
            color: #ffa366;
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-save:hover {
            background-color: #ff8800;
        }

        .btn-cancel:hover {
            background-color: rgba(255, 107, 0, 0.1);
        }

        /* 아이콘 */
        .icon-edit {
            width: 16px;
            height: 16px;
            stroke: #ffa366;
        }

        .icon-delete {
            width: 16px;
            height: 16px;
            stroke: #ff5252;
        }

        .icon-plus {
            width: 20px;
            height: 20px;
            stroke: #ff6b00;
        }

        .icon-check, .icon-x {
            width: 16px;
            height: 16px;
        }

        /* 숨김 처리 */
        .hidden {
            display: none;
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
            <h1>이용권 관리</h1>
            <p>헬스장 이용권, PT, 락커를 관리합니다</p>
        </div>

        <!-- 전체 컨테이너 박스 -->
        <div class="products-container">
            <div class="products-grid">
                <!-- 이용권 섹션 -->
                <div class="category-section">
                    <div class="category-header">
                        <h2 class="category-title">이용권</h2>
                        <p class="category-count"><span id="membership-count">3</span>개 상품</p>
                    </div>
                    <div class="products-list" id="membership-list">
                        <!-- 이용권 상품들이 여기에 동적으로 추가됩니다 -->
                    </div>
                    <button class="add-product-btn" onclick="showAddForm('membership')">
                        <svg class="icon-plus" viewBox="0 0 24 24" fill="none">
                            <line x1="12" y1="5" x2="12" y2="19" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                            <line x1="5" y1="12" x2="19" y2="12" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                        이용권 추가
                    </button>
                </div>

                <!-- PT 섹션 -->
                <div class="category-section">
                    <div class="category-header">
                        <h2 class="category-title">PT (Personal Training)</h2>
                        <p class="category-count"><span id="pt-count">2</span>개 상품</p>
                    </div>
                    <div class="products-list" id="pt-list">
                        <!-- PT 상품들이 여기에 동적으로 추가됩니다 -->
                    </div>
                    <button class="add-product-btn" onclick="showAddForm('pt')">
                        <svg class="icon-plus" viewBox="0 0 24 24" fill="none">
                            <line x1="12" y1="5" x2="12" y2="19" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                            <line x1="5" y1="12" x2="19" y2="12" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                        PT 추가
                    </button>
                </div>

                <!-- 락커 섹션 -->
                <div class="category-section">
                    <div class="category-header">
                        <h2 class="category-title">락커</h2>
                        <p class="category-count"><span id="locker-count">2</span>개 상품</p>
                    </div>
                    <div class="products-list" id="locker-list">
                        <!-- 락커 상품들이 여기에 동적으로 추가됩니다 -->
                    </div>
                    <button class="add-product-btn" onclick="showAddForm('locker')">
                        <svg class="icon-plus" viewBox="0 0 24 24" fill="none">
                            <line x1="12" y1="5" x2="12" y2="19" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                            <line x1="5" y1="12" x2="19" y2="12" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                        락커 추가
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 초기 데이터
    let products = [
        { id: 1, name: '1개월 회원권', category: 'membership', price: 120000, duration: '1개월' },
        { id: 2, name: '3개월 회원권', category: 'membership', price: 330000, duration: '3개월' },
        { id: 3, name: '6개월 회원권', category: 'membership', price: 600000, duration: '6개월' },
        { id: 4, name: 'PT 10회권', category: 'pt', price: 500000, duration: '10회' },
        { id: 5, name: 'PT 20회권', category: 'pt', price: 950000, duration: '20회' },
        { id: 6, name: '락커 (1개월)', category: 'locker', price: 10000, duration: '1개월' },
        { id: 7, name: '락커 (3개월)', category: 'locker', price: 30000, duration: '3개월' }
    ];

    let nextId = 8;
    let editingId = null;
    let addingCategory = null;

    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        renderAllProducts();
    });

    // 모든 상품 렌더링
    function renderAllProducts() {
        renderProducts('membership');
        renderProducts('pt');
        renderProducts('locker');
    }

    // 카테고리별 상품 렌더링
    function renderProducts(category) {
        const listId = category + '-list';
        const countId = category + '-count';
        const list = document.getElementById(listId);
        const categoryProducts = products.filter(p => p.category === category);

        // 개수 업데이트
        document.getElementById(countId).textContent = categoryProducts.length;

        // 리스트 초기화
        list.innerHTML = '';

        // 상품 카드 생성
        categoryProducts.forEach(product => {
            const card = createProductCard(product);
            list.appendChild(card);
        });
    }

    // 상품 카드 생성
    function createProductCard(product) {
        const card = document.createElement('div');
        card.className = 'product-card';
        card.id = 'product-' + product.id;

        if (editingId === product.id) {
            card.innerHTML = createEditForm(product);
        } else {
            card.innerHTML = `
                <div class="product-header">
                    <div class="product-info">
                        <div class="product-name">\${product.name}</div>
                        <div class="product-duration">\${product.duration}</div>
                    </div>
                    <div class="product-actions">
                        <button class="edit-btn" onclick="startEdit(\${product.id})">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/edit.png" alt="이메일" class="detail-icon">
                        </button>
                        <button class="delete-btn" onclick="deleteProduct(\${product.id})">
                            <img src="${pageContext.request.contextPath}/resources/images/icon/delete.png" alt="이메일" class="detail-icon">
                        </button>
                    </div>
                </div>
                <div class="product-price">\${product.price.toLocaleString()}원</div>
            `;
        }

        return card;
    }

    // 수정 폼 생성
    function createEditForm(product) {
        return `
            <form class="edit-form" onsubmit="saveEdit(event, \${product.id})">
                <div class="form-field">
                    <label class="form-label">상품명</label>
                    <input type="text" class="form-input" id="name-\${product.id}" value="\${product.name}" required>
                </div>
                <div class="form-field">
                    <label class="form-label">가격 (원)</label>
                    <input type="number" class="form-input" id="price-\${product.id}" value="\${product.price}" required>
                </div>
                <div class="form-field">
                    <label class="form-label">유효기간</label>
                    <input type="text" class="form-input" id="duration-\${product.id}" value="\${product.duration}" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-save">
                        <svg class="icon-check" viewBox="0 0 24 24" fill="none" stroke="white">
                            <polyline points="20 6 9 17 4 12" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        저장
                    </button>
                    <button type="button" class="btn-cancel" onclick="cancelEdit()">
                        <svg class="icon-x" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                            <line x1="18" y1="6" x2="6" y2="18" stroke-width="2" stroke-linecap="round"/>
                            <line x1="6" y1="6" x2="18" y2="18" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                        취소
                    </button>
                </div>
            </form>
        `;
    }

    // 추가 폼 생성
    function createAddForm(category) {
        const categoryName = category === 'membership' ? '이용권' : category === 'pt' ? 'PT' : '락커';
        return `
            <form class="edit-form" onsubmit="saveAdd(event, '\${category}')">
                <div class="form-field">
                    <label class="form-label">상품명</label>
                    <input type="text" class="form-input" id="add-name" placeholder="\${categoryName} 이름을 입력하세요" required>
                </div>
                <div class="form-field">
                    <label class="form-label">가격 (원)</label>
                    <input type="number" class="form-input" id="add-price" required>
                </div>
                <div class="form-field">
                    <label class="form-label">유효기간</label>
                    <input type="text" class="form-input" id="add-duration" placeholder="예: 1개월, 10회" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-save">
                        <svg class="icon-check" viewBox="0 0 24 24" fill="none" stroke="white">
                            <polyline points="20 6 9 17 4 12" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                        추가
                    </button>
                    <button type="button" class="btn-cancel" onclick="cancelAdd()">
                        <svg class="icon-x" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                            <line x1="18" y1="6" x2="6" y2="18" stroke-width="2" stroke-linecap="round"/>
                            <line x1="6" y1="6" x2="18" y2="18" stroke-width="2" stroke-linecap="round"/>
                        </svg>
                        취소
                    </button>
                </div>
            </form>
        `;
    }

    // 수정 시작
    function startEdit(id) {
        editingId = id;
        const product = products.find(p => p.id === id);
        if (product) {
            renderProducts(product.category);
        }
    }

    // 수정 저장
    function saveEdit(event, id) {
        event.preventDefault();

        const name = document.getElementById('name-' + id).value;
        const price = parseInt(document.getElementById('price-' + id).value);
        const duration = document.getElementById('duration-' + id).value;

        const productIndex = products.findIndex(p => p.id === id);
        if (productIndex !== -1) {
            products[productIndex].name = name;
            products[productIndex].price = price;
            products[productIndex].duration = duration;

            editingId = null;
            renderProducts(products[productIndex].category);
        }
    }

    // 수정 취소
    function cancelEdit() {
        const product = products.find(p => p.id === editingId);
        editingId = null;
        if (product) {
            renderProducts(product.category);
        }
    }

    // 상품 삭제
    function deleteProduct(id) {
        const product = products.find(p => p.id === id);
        if (!product) return;

        if (confirm(`"${product.name}"을(를) 삭제하시겠습니까?`)) {
            const category = product.category;
            products = products.filter(p => p.id !== id);
            renderProducts(category);
        }
    }

    // 추가 폼 표시
    function showAddForm(category) {
        addingCategory = category;
        const list = document.getElementById(category + '-list');

        const card = document.createElement('div');
        card.className = 'product-card';
        card.id = 'add-form-card';
        card.innerHTML = createAddForm(category);

        list.appendChild(card);
    }

    // 추가 저장
    function saveAdd(event, category) {
        event.preventDefault();

        const name = document.getElementById('add-name').value;
        const price = parseInt(document.getElementById('add-price').value);
        const duration = document.getElementById('add-duration').value;

        if (!name || !price) {
            alert('모든 필수 항목을 입력해주세요.');
            return;
        }

        const newProduct = {
            id: nextId++,
            name: name,
            category: category,
            price: price,
            duration: duration
        };

        products.push(newProduct);
        addingCategory = null;
        renderProducts(category);
    }

    // 추가 취소
    function cancelAdd() {
        const addFormCard = document.getElementById('add-form-card');
        if (addFormCard) {
            addFormCard.remove();
        }
        addingCategory = null;
    }
</script>
</body>
</html>