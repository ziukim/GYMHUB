<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>이용권 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css">

    <style>

        /* 전체 컨테이너 박스 */
        .products-container {
            background-color: #1a0f0a;
            border: 2px solid #ff6b00;
            border-radius: 12px;
            padding: 32px;
            box-shadow: 0px 0px 20px 0px rgba(255,107,0,0.4);
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
        <!-- Header -->
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
                    </div>
                    <div class="products-list" id="membership-list">
                        <!-- 이용권 상품들이 여기에 동적으로 추가됩니다 -->
                    </div>
                    <button class="add-product-btn" onclick="showAddForm('membership')">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/add.png" alt="이용권 추가" class="icon-plus" style="width: 24px; height: 24px; vertical-align: middle;">
                    </button>
                </div>

                <!-- PT 섹션 -->
                <div class="category-section">
                    <div class="category-header">
                        <h2 class="category-title">PT (Personal Training)</h2>
                    </div>
                    <div class="products-list" id="pt-list">
                        <!-- PT 상품들이 여기에 동적으로 추가됩니다 -->
                    </div>
                    <button class="add-product-btn" onclick="showAddForm('pt')">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/add.png" alt="PT 추가" class="icon-plus" style="width: 24px; height: 24px; vertical-align: middle;">
                    </button>
                </div>

                <!-- 락커 섹션 -->
                <div class="category-section">
                    <div class="category-header">
                        <h2 class="category-title">락커</h2>
                    </div>
                    <div class="products-list" id="locker-list">
                        <!-- 락커 상품들이 여기에 동적으로 추가됩니다 -->
                    </div>
                    <button class="add-product-btn" onclick="showAddForm('locker')">
                        <img src="${pageContext.request.contextPath}/resources/images/icon/add.png" alt="락커 추가" class="icon-plus" style="width: 24px; height: 24px; vertical-align: middle;">
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 상품 데이터
    let products = [];
    let nextId = 1;
    let editingId = null;
    let addingCategory = null;

    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        loadProductsFromServer();
    });

    // 일(day) 단위를 표시 형식으로 변환
    // 365의 배수면 "N년", 30의 배수면 "N개월", 그 외는 "N일"
    function formatDuration(days) {
        if (days % 365 === 0) {
            return (days / 365) + '년';
        } else if (days % 30 === 0) {
            return (days / 30) + '개월';
        } else {
            return days + '일';
        }
    }

    // 서버에서 상품 리스트 가져오기
    function loadProductsFromServer() {
        fetch('${pageContext.request.contextPath}/product/list.ajax', {
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
                // 서버에서 받은 데이터를 products 배열로 변환
                products = [];
                
                // 이용권 데이터 변환
                if (data.membership && Array.isArray(data.membership)) {
                    for (let i = 0; i < data.membership.length; i++) {
                        const product = data.membership[i];
                        const durationText = formatDuration(product.durationMonths);
                        products.push({
                            id: product.productNo,
                            name: product.productType + ' ' + durationText,
                            category: 'membership',
                            price: product.productPrice,
                            duration: durationText,
                            durationDays: product.durationMonths, // 원본 일 단위 값 저장
                            productNo: product.productNo
                        });
                    }
                }
                
                // PT 데이터 변환
                if (data.pt && Array.isArray(data.pt)) {
                    for (let i = 0; i < data.pt.length; i++) {
                        const product = data.pt[i];
                        products.push({
                            id: product.productNo,
                            name: product.productType + ' ' + product.durationMonths + '회',
                            category: 'pt',
                            price: product.productPrice,
                            duration: product.durationMonths + '회',
                            durationDays: product.durationMonths, // 원본 횟수 값 저장
                            productNo: product.productNo
                        });
                    }
                }
                
                // 락커 데이터 변환
                if (data.locker && Array.isArray(data.locker)) {
                    for (let i = 0; i < data.locker.length; i++) {
                        const product = data.locker[i];
                        const durationText = formatDuration(product.durationMonths);
                        products.push({
                            id: product.productNo,
                            name: product.productType + ' ' + durationText,
                            category: 'locker',
                            price: product.productPrice,
                            duration: durationText,
                            durationDays: product.durationMonths, // 원본 일 단위 값 저장
                            productNo: product.productNo
                        });
                    }
                }
                
                // 다음 ID 설정
                if (products.length > 0) {
                    let maxId = 0;
                    for (let i = 0; i < products.length; i++) {
                        if (products[i].id > maxId) {
                            maxId = products[i].id;
                        }
                    }
                    nextId = maxId + 1;
                }
                
                // 화면 렌더링
                renderAllProducts();
            } else {
                console.error('데이터 로드 실패:', data.message);
                alert('상품 데이터를 불러오는데 실패했습니다: ' + (data.message || '알 수 없는 오류'));
            }
        })
        .catch(function(error) {
            console.error('AJAX 오류:', error);
            alert('상품 데이터를 불러오는데 실패했습니다.');
        });
    }

    // 모든 상품 렌더링
    function renderAllProducts() {
        renderProducts('membership');
        renderProducts('pt');
        renderProducts('locker');
    }

    // 카테고리별 상품 렌더링
    function renderProducts(category) {
        const listId = category + '-list';
        const list = document.getElementById(listId);
        
        // 카테고리별 상품 필터링
        const categoryProducts = [];
        for (let i = 0; i < products.length; i++) {
            if (products[i].category === category) {
                categoryProducts.push(products[i]);
            }
        }

        // 리스트 초기화
        list.innerHTML = '';

        // 상품 카드 생성
        for (let i = 0; i < categoryProducts.length; i++) {
            const card = createProductCard(categoryProducts[i]);
            list.appendChild(card);
        }
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
        // 수정 폼에는 일 단위 값 표시 (PT는 회 단위)
        const durationValue = product.category === 'pt' ? product.durationDays : product.durationDays + '일';
        const durationLabel = product.category === 'pt' ? '횟수' : '유효기간';
        return `
            <form class="edit-form" onsubmit="saveEdit(event, \${product.id})">
                <div class="form-field">
                    <label class="form-label">가격 (원)</label>
                    <input type="number" class="form-input" id="price-\${product.id}" value="\${product.price}" required>
                </div>
                <div class="form-field">
                    <label class="form-label">\${durationLabel}</label>
                    <input type="text" class="form-input" id="duration-\${product.id}" value="\${durationValue}" placeholder="\${product.category === 'pt' ? '예: 10회, 20회' : '예: 30일, 60일, 365일'}" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-save">
                       
                        저장
                    </button>
                    <button type="button" class="btn-cancel" onclick="cancelEdit()">
                       
                        취소
                    </button>
                </div>
            </form>
        `;
    }

    // 추가 폼 생성
    function createAddForm(category) {
        const durationLabel = category === 'pt' ? '횟수' : '유효기간';
        const durationPlaceholder = category === 'pt' ? '예: 10회, 20회' : '예: 30일, 60일, 365일';
        return `
            <form class="edit-form" onsubmit="saveAdd(event, '\${category}')">
                <div class="form-field">
                    <label class="form-label">가격 (원)</label>
                    <input type="number" class="form-input" id="add-price" required>
                </div>
                <div class="form-field">
                    <label class="form-label">\${durationLabel}</label>
                    <input type="text" class="form-input" id="add-duration" placeholder="\${durationPlaceholder}" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-save">
                        추가
                    </button>
                    <button type="button" class="btn-cancel" onclick="cancelAdd()">
                        취소
                    </button>
                </div>
            </form>
        `;
    }

    // 상품 찾기 헬퍼 함수
    function findProductById(id) {
        for (let i = 0; i < products.length; i++) {
            if (products[i].id === id) {
                return products[i];
            }
        }
        return null;
    }

    // 상품 인덱스 찾기 헬퍼 함수
    function findProductIndexById(id) {
        for (let i = 0; i < products.length; i++) {
            if (products[i].id === id) {
                return i;
            }
        }
        return -1;
    }

    // 수정 시작
    function startEdit(id) {
        editingId = id;
        const product = findProductById(id);
        if (product) {
            renderProducts(product.category);
        }
    }

    // 수정 저장
    function saveEdit(event, id) {
        event.preventDefault();

        const price = parseInt(document.getElementById('price-' + id).value);
        const duration = document.getElementById('duration-' + id).value;

        const product = findProductById(id);
        if (!product) {
            alert('상품을 찾을 수 없습니다.');
            return;
        }

        // AJAX로 서버에 수정 요청
        const requestData = {
            productNo: id,
            price: price,
            duration: duration,
            category: product.category
        };

        fetch('${pageContext.request.contextPath}/product/update.ajax', {
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
                // 서버에서 수정된 상품 정보로 업데이트
                if (data.product) {
                    const updatedProduct = data.product;
                    const categoryName = product.category;
                    const durationText = categoryName === 'pt' ? updatedProduct.durationMonths + '회' : formatDuration(updatedProduct.durationMonths);
                    
                    const productIndex = findProductIndexById(id);
                    if (productIndex !== -1) {
                        products[productIndex].name = updatedProduct.productType + ' ' + durationText;
                        products[productIndex].price = updatedProduct.productPrice;
                        products[productIndex].duration = durationText;
                        products[productIndex].durationDays = updatedProduct.durationMonths;
                    }
                } else {
                    // 상품 정보가 없으면 서버에서 다시 전체 리스트 가져오기
                    loadProductsFromServer();
                }
                
                editingId = null;
                renderProducts(product.category);
                alert('상품이 수정되었습니다.');
            } else {
                alert('상품 수정에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
            }
        })
        .catch(function(error) {
            console.error('AJAX 오류:', error);
            alert('상품 수정 중 오류가 발생했습니다.');
        });
    }

    // 수정 취소
    function cancelEdit() {
        const product = findProductById(editingId);
        editingId = null;
        if (product) {
            renderProducts(product.category);
        }
    }

    // 상품 삭제
    function deleteProduct(id) {
        const product = findProductById(id);
        if (!product) return;

        if (confirm('"' + product.name + '"을(를) 삭제하시겠습니까?')) {
            // AJAX로 서버에 삭제 요청
            const requestData = {
                productNo: id
            };

            fetch('${pageContext.request.contextPath}/product/delete.ajax', {
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
                    // products 배열에서 제거
                    const newProducts = [];
                    for (let i = 0; i < products.length; i++) {
                        if (products[i].id !== id) {
                            newProducts.push(products[i]);
                        }
                    }
                    products = newProducts;
                    
                    renderProducts(product.category);
                    alert('상품이 삭제되었습니다.');
                } else {
                    alert('상품 삭제에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
                }
            })
            .catch(function(error) {
                console.error('AJAX 오류:', error);
                alert('상품 삭제 중 오류가 발생했습니다.');
            });
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

        const price = parseInt(document.getElementById('add-price').value);
        const duration = document.getElementById('add-duration').value;

        if (!price || !duration) {
            alert('모든 필수 항목을 입력해주세요.');
            return;
        }

        // AJAX로 서버에 추가 요청
        const requestData = {
            category: category,
            price: price,
            duration: duration
        };

        fetch('${pageContext.request.contextPath}/product/add.ajax', {
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
                // 추가 폼 제거
                const addFormCard = document.getElementById('add-form-card');
                if (addFormCard) {
                    addFormCard.remove();
                }
                addingCategory = null;

                // 서버에서 추가된 상품 정보로 새 상품 객체 생성
                if (data.product) {
                    const product = data.product;
                    const categoryName = category === 'membership' ? 'membership' : category === 'pt' ? 'pt' : 'locker';
                    const durationText = category === 'pt' ? product.durationMonths + '회' : formatDuration(product.durationMonths);
                    
                    const newProduct = {
                        id: product.productNo,
                        name: product.productType + ' ' + durationText,
                        category: categoryName,
                        price: product.productPrice,
                        duration: durationText,
                        durationDays: product.durationMonths, // 원본 일 단위 값 저장
                        productNo: product.productNo
                    };

                    // products 배열에 추가
                    products.push(newProduct);
                    
                    // 다음 ID 업데이트
                    if (product.productNo >= nextId) {
                        nextId = product.productNo + 1;
                    }
                    
                    // 화면에 반영
                    renderProducts(category);
                    
                    alert('상품이 추가되었습니다.');
                } else {
                    // 상품 정보가 없으면 서버에서 다시 전체 리스트 가져오기
                    loadProductsFromServer();
                    alert('상품이 추가되었습니다.');
                }
            } else {
                alert('상품 추가에 실패했습니다: ' + (data.message || '알 수 없는 오류'));
            }
        })
        .catch(function(error) {
            console.error('AJAX 오류:', error);
            alert('상품 추가 중 오류가 발생했습니다.');
        });
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
