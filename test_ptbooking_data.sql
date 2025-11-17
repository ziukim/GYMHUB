-- ========================================
-- PT 예약 기능 테스트용 데이터
-- GYM_NO = 9, trainer (MEMBER_NO=10)
-- ========================================

-- 0. 기존 테스트 데이터 삭제 (역순으로)
DELETE FROM PT_RESERVE WHERE PT_PASS_NO IN (
    SELECT PT_PASS_NO FROM PT_PASS WHERE MEMBER_NO IN (
        SELECT MEMBER_NO FROM MEMBER WHERE MEMBER_ID IN ('testmember1', 'testmember2', 'testmember3')
    )
);

DELETE FROM PT_PASS WHERE MEMBER_NO IN (
    SELECT MEMBER_NO FROM MEMBER WHERE MEMBER_ID IN ('testmember1', 'testmember2', 'testmember3')
);

DELETE FROM PURCHASE_ITEM WHERE PURCHASE_NO IN (
    SELECT PURCHASE_NO FROM PURCHASE WHERE MEMBER_NO IN (
        SELECT MEMBER_NO FROM MEMBER WHERE MEMBER_ID IN ('testmember1', 'testmember2', 'testmember3')
    )
);

DELETE FROM PURCHASE WHERE MEMBER_NO IN (
    SELECT MEMBER_NO FROM MEMBER WHERE MEMBER_ID IN ('testmember1', 'testmember2', 'testmember3')
);

DELETE FROM MEMBER WHERE MEMBER_ID IN ('trainer2', 'trainer3', 'testmember1', 'testmember2', 'testmember3');

COMMIT;

-- 1. GYM_NO=9인 트레이너 2명 추가
INSERT INTO MEMBER (
    MEMBER_NO, MEMBER_TYPE, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, 
    MEMBER_ADDRESS, MEMBER_PHONE, MEMBER_BIRTH, STATUS, 
    MEMBER_CREATEAT, MEMBER_UPDATEAT, MEMBER_EMAIL, MEMBER_PHOTO_PATH, 
    GYM_NO, TRAINER_LICENSE, TRAINER_CAREER, TRAINER_AWARD
) VALUES (
    SEQ_MNO.NEXTVAL, 2, 'trainer2', '$2a$10$abcdefghijklmnopqrstuv', '이트레이너',
    '서울시 강남구', '010-2200-3333', TO_DATE('1988-05-20', 'YYYY-MM-DD'), 'Y',
    SYSDATE, SYSDATE, 'trainer2@example.com', NULL,
    9, '생활스포츠지도사 2급', '3년', '2022 서울시 보디빌딩 대회 3위'
);

INSERT INTO MEMBER (
    MEMBER_NO, MEMBER_TYPE, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, 
    MEMBER_ADDRESS, MEMBER_PHONE, MEMBER_BIRTH, STATUS, 
    MEMBER_CREATEAT, MEMBER_UPDATEAT, MEMBER_EMAIL, MEMBER_PHOTO_PATH, 
    GYM_NO, TRAINER_LICENSE, TRAINER_CAREER, TRAINER_AWARD
) VALUES (
    SEQ_MNO.NEXTVAL, 2, 'trainer3', '$2a$10$abcdefghijklmnopqrstuv', '박트레이너',
    '서울시 서초구', '010-3300-4444', TO_DATE('1992-08-15', 'YYYY-MM-DD'), 'Y',
    SYSDATE, SYSDATE, 'trainer3@example.com', NULL,
    9, '생활스포츠지도사 1급', '5년', '2023 전국 크로스핏 대회 2위'
);

-- 2. 일반 회원 3명 추가 (GYM_NO=9)
INSERT INTO MEMBER (
    MEMBER_NO, MEMBER_TYPE, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, 
    MEMBER_ADDRESS, MEMBER_PHONE, MEMBER_BIRTH, STATUS, 
    MEMBER_CREATEAT, MEMBER_UPDATEAT, MEMBER_EMAIL, MEMBER_PHOTO_PATH, 
    GYM_NO, TRAINER_LICENSE, TRAINER_CAREER, TRAINER_AWARD
) VALUES (
    SEQ_MNO.NEXTVAL, 1, 'testmember1', '$2a$10$abcdefghijklmnopqrstuv', '김회원',
    '서울시 강남구', '010-1100-2222', TO_DATE('1995-03-15', 'YYYY-MM-DD'), 'Y',
    SYSDATE, SYSDATE, 'testmember1@example.com', NULL,
    9, NULL, NULL, NULL
);

INSERT INTO MEMBER (
    MEMBER_NO, MEMBER_TYPE, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, 
    MEMBER_ADDRESS, MEMBER_PHONE, MEMBER_BIRTH, STATUS, 
    MEMBER_CREATEAT, MEMBER_UPDATEAT, MEMBER_EMAIL, MEMBER_PHOTO_PATH, 
    GYM_NO, TRAINER_LICENSE, TRAINER_CAREER, TRAINER_AWARD
) VALUES (
    SEQ_MNO.NEXTVAL, 1, 'testmember2', '$2a$10$abcdefghijklmnopqrstuv', '이회원',
    '서울시 서초구', '010-2200-3344', TO_DATE('1992-07-20', 'YYYY-MM-DD'), 'Y',
    SYSDATE, SYSDATE, 'testmember2@example.com', NULL,
    9, NULL, NULL, NULL
);

INSERT INTO MEMBER (
    MEMBER_NO, MEMBER_TYPE, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, 
    MEMBER_ADDRESS, MEMBER_PHONE, MEMBER_BIRTH, STATUS, 
    MEMBER_CREATEAT, MEMBER_UPDATEAT, MEMBER_EMAIL, MEMBER_PHOTO_PATH, 
    GYM_NO, TRAINER_LICENSE, TRAINER_CAREER, TRAINER_AWARD
) VALUES (
    SEQ_MNO.NEXTVAL, 1, 'testmember3', '$2a$10$abcdefghijklmnopqrstuv', '박회원',
    '서울시 송파구', '010-3300-4455', TO_DATE('1998-11-10', 'YYYY-MM-DD'), 'Y',
    SYSDATE, SYSDATE, 'testmember3@example.com', NULL,
    9, NULL, NULL, NULL
);

COMMIT;

-- 3. 각 회원에게 PT 이용권 생성
DECLARE
    v_member1_no NUMBER;
    v_member2_no NUMBER;
    v_member3_no NUMBER;
    v_purchase_no NUMBER;
    v_product_no NUMBER;
BEGIN
    -- 회원 번호 조회
    SELECT MEMBER_NO INTO v_member1_no FROM MEMBER WHERE MEMBER_ID = 'testmember1';
    SELECT MEMBER_NO INTO v_member2_no FROM MEMBER WHERE MEMBER_ID = 'testmember2';
    SELECT MEMBER_NO INTO v_member3_no FROM MEMBER WHERE MEMBER_ID = 'testmember3';
    
    -- GYM_NO=9의 PT 상품 번호 조회 (없으면 NULL)
    BEGIN
        SELECT PRODUCT_NO INTO v_product_no 
        FROM PRODUCT 
        WHERE GYM_NO = 9 AND PRODUCT_TYPE = 'PT' AND ROWNUM = 1;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_product_no := NULL; -- PT 상품이 없으면 NULL로 처리
    END;
    
    -- ============================================
    -- 회원1 (김회원) PT 이용권
    -- ============================================
    INSERT INTO PURCHASE (PURCHASE_NO, MEMBER_NO, GYM_NO, PURCHASE_DATE, PURCHASE_COST, PURCHASE_STATUS)
    VALUES (SEQ_PURCHASE_NO.NEXTVAL, v_member1_no, 9, SYSDATE - 10, 500000, 'Y')
    RETURNING PURCHASE_NO INTO v_purchase_no;
    
    IF v_product_no IS NOT NULL THEN
        INSERT INTO PURCHASE_ITEM (PURCHASE_ITEM_NO, PURCHASE_NO, PRODUCT_NO, PT_COUNT, MEMBERSHIP_PERIOD)
        VALUES (SEQ_PURCHASE_ITEM_NO.NEXTVAL, v_purchase_no, v_product_no, 10, NULL);
    END IF;
    
    INSERT INTO PT_PASS (PT_PASS_NO, PURCHASE_NO, MEMBER_NO, GYM_NO, PT_START, PT_END, PT_USED_COUNT, PT_TOTAL_COUNT)
    VALUES (SEQ_PT_PASS_NO.NEXTVAL, v_purchase_no, v_member1_no, 9, SYSDATE - 10, SYSDATE + 80, 0, 10);
    
    -- ============================================
    -- 회원2 (이회원) PT 이용권
    -- ============================================
    INSERT INTO PURCHASE (PURCHASE_NO, MEMBER_NO, GYM_NO, PURCHASE_DATE, PURCHASE_COST, PURCHASE_STATUS)
    VALUES (SEQ_PURCHASE_NO.NEXTVAL, v_member2_no, 9, SYSDATE - 5, 500000, 'Y')
    RETURNING PURCHASE_NO INTO v_purchase_no;
    
    IF v_product_no IS NOT NULL THEN
        INSERT INTO PURCHASE_ITEM (PURCHASE_ITEM_NO, PURCHASE_NO, PRODUCT_NO, PT_COUNT, MEMBERSHIP_PERIOD)
        VALUES (SEQ_PURCHASE_ITEM_NO.NEXTVAL, v_purchase_no, v_product_no, 10, NULL);
    END IF;
    
    INSERT INTO PT_PASS (PT_PASS_NO, PURCHASE_NO, MEMBER_NO, GYM_NO, PT_START, PT_END, PT_USED_COUNT, PT_TOTAL_COUNT)
    VALUES (SEQ_PT_PASS_NO.NEXTVAL, v_purchase_no, v_member2_no, 9, SYSDATE - 5, SYSDATE + 85, 0, 10);
    
    -- ============================================
    -- 회원3 (박회원) PT 이용권
    -- ============================================
    INSERT INTO PURCHASE (PURCHASE_NO, MEMBER_NO, GYM_NO, PURCHASE_DATE, PURCHASE_COST, PURCHASE_STATUS)
    VALUES (SEQ_PURCHASE_NO.NEXTVAL, v_member3_no, 9, SYSDATE - 3, 500000, 'Y')
    RETURNING PURCHASE_NO INTO v_purchase_no;
    
    IF v_product_no IS NOT NULL THEN
        INSERT INTO PURCHASE_ITEM (PURCHASE_ITEM_NO, PURCHASE_NO, PRODUCT_NO, PT_COUNT, MEMBERSHIP_PERIOD)
        VALUES (SEQ_PURCHASE_ITEM_NO.NEXTVAL, v_purchase_no, v_product_no, 10, NULL);
    END IF;
    
    INSERT INTO PT_PASS (PT_PASS_NO, PURCHASE_NO, MEMBER_NO, GYM_NO, PT_START, PT_END, PT_USED_COUNT, PT_TOTAL_COUNT)
    VALUES (SEQ_PT_PASS_NO.NEXTVAL, v_purchase_no, v_member3_no, 9, SYSDATE - 3, SYSDATE + 87, 0, 10);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('일반 회원 3명과 PT 이용권 생성 완료');
END;
/

-- 4. trainer (MEMBER_NO=10)의 2025-11-22 예약 3개 추가
DECLARE
    v_trainer_no NUMBER := 10; -- trainer의 MEMBER_NO (고정값)
    v_member1_no NUMBER;
    v_member2_no NUMBER;
    v_member3_no NUMBER;
    v_pt_pass1_no NUMBER;
    v_pt_pass2_no NUMBER;
    v_pt_pass3_no NUMBER;
BEGIN
    -- 회원 번호 조회
    SELECT MEMBER_NO INTO v_member1_no FROM MEMBER WHERE MEMBER_ID = 'testmember1';
    SELECT MEMBER_NO INTO v_member2_no FROM MEMBER WHERE MEMBER_ID = 'testmember2';
    SELECT MEMBER_NO INTO v_member3_no FROM MEMBER WHERE MEMBER_ID = 'testmember3';
    
    -- PT_PASS 번호 조회
    SELECT PT_PASS_NO INTO v_pt_pass1_no FROM PT_PASS WHERE MEMBER_NO = v_member1_no AND ROWNUM = 1;
    SELECT PT_PASS_NO INTO v_pt_pass2_no FROM PT_PASS WHERE MEMBER_NO = v_member2_no AND ROWNUM = 1;
    SELECT PT_PASS_NO INTO v_pt_pass3_no FROM PT_PASS WHERE MEMBER_NO = v_member3_no AND ROWNUM = 1;
    
    -- 예약 1: 2025-11-22 10:00 (김회원 -> trainer)
    INSERT INTO PT_RESERVE (
        PT_RESERVE_NO, PT_PASS_NO, PT_RESERVE_TIME, 
        MEMBER_NO, PT_TRAINER_NO, PT_RESERVE_STATUS
    ) VALUES (
        SEQ_PT_RESERVE_NO.NEXTVAL, 
        v_pt_pass1_no, 
        TO_DATE('2025-11-22 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        v_trainer_no,  -- 희망 트레이너
        v_trainer_no,  -- 확정된 트레이너
        '승인됨'
    );
    
    -- 예약 2: 2025-11-22 14:00 (이회원 -> trainer)
    INSERT INTO PT_RESERVE (
        PT_RESERVE_NO, PT_PASS_NO, PT_RESERVE_TIME, 
        MEMBER_NO, PT_TRAINER_NO, PT_RESERVE_STATUS
    ) VALUES (
        SEQ_PT_RESERVE_NO.NEXTVAL, 
        v_pt_pass2_no, 
        TO_DATE('2025-11-22 14:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        v_trainer_no,
        v_trainer_no,
        '승인됨'
    );
    
    -- 예약 3: 2025-11-22 18:00 (박회원 -> trainer)
    INSERT INTO PT_RESERVE (
        PT_RESERVE_NO, PT_PASS_NO, PT_RESERVE_TIME, 
        MEMBER_NO, PT_TRAINER_NO, PT_RESERVE_STATUS
    ) VALUES (
        SEQ_PT_RESERVE_NO.NEXTVAL, 
        v_pt_pass3_no, 
        TO_DATE('2025-11-22 18:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        v_trainer_no,
        v_trainer_no,
        '승인됨'
    );
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('trainer(MEMBER_NO=10)의 2025-11-22 예약 3개 추가 완료');
    DBMS_OUTPUT.PUT_LINE('  - 10:00 (김회원)');
    DBMS_OUTPUT.PUT_LINE('  - 14:00 (이회원)');
    DBMS_OUTPUT.PUT_LINE('  - 18:00 (박회원)');
END;
/

-- ============================================
-- 5. 확인 쿼리
-- ============================================

-- 트레이너 목록 확인
SELECT MEMBER_NO, MEMBER_ID, MEMBER_NAME, MEMBER_TYPE, GYM_NO, TRAINER_LICENSE, TRAINER_CAREER
FROM MEMBER
WHERE GYM_NO = 9 AND MEMBER_TYPE = 2
ORDER BY MEMBER_NO;

-- 일반 회원 목록 확인
SELECT MEMBER_NO, MEMBER_ID, MEMBER_NAME, MEMBER_TYPE, GYM_NO
FROM MEMBER
WHERE MEMBER_ID IN ('testmember1', 'testmember2', 'testmember3')
ORDER BY MEMBER_NO;

-- PT_PASS 확인
SELECT PP.PT_PASS_NO, PP.MEMBER_NO, M.MEMBER_NAME, PP.PT_TOTAL_COUNT, PP.PT_USED_COUNT
FROM PT_PASS PP
JOIN MEMBER M ON PP.MEMBER_NO = M.MEMBER_NO
WHERE M.MEMBER_ID IN ('testmember1', 'testmember2', 'testmember3')
ORDER BY PP.PT_PASS_NO;

-- trainer의 2025-11-22 예약 확인
SELECT 
    PR.PT_RESERVE_NO,
    TO_CHAR(PR.PT_RESERVE_TIME, 'YYYY-MM-DD HH24:MI') AS RESERVE_TIME,
    M_RESERVING.MEMBER_NAME AS RESERVING_MEMBER,
    M_TRAINER.MEMBER_NAME AS TRAINER_NAME,
    PR.PT_RESERVE_STATUS
FROM PT_RESERVE PR
JOIN PT_PASS PP ON PR.PT_PASS_NO = PP.PT_PASS_NO
JOIN MEMBER M_RESERVING ON PP.MEMBER_NO = M_RESERVING.MEMBER_NO
JOIN MEMBER M_TRAINER ON PR.PT_TRAINER_NO = M_TRAINER.MEMBER_NO
WHERE PR.PT_TRAINER_NO = 10
  AND TO_CHAR(PR.PT_RESERVE_TIME, 'YYYY-MM-DD') = '2025-11-22'
ORDER BY PR.PT_RESERVE_TIME;

COMMIT;
