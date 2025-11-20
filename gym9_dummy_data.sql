-- ============================================
-- GYM_NO 9 더미 데이터 생성 스크립트
-- 회원 → 구매 → 회원권/PT 이용권 → PT 예약 → 출석 기록 순서로 연계 생성
-- ============================================

-- ============================================
-- 주의: 아래 삭제 쿼리는 선택사항입니다.
-- gym_no 9의 기존 데이터를 삭제하고 새로 생성하려면 아래 주석을 해제하세요.
-- 다른 gym_no의 데이터는 절대 삭제되지 않습니다 (모든 쿼리에 WHERE GYM_NO = 9 조건 있음).
-- ============================================

/*
-- 기존 gym_no 9 관련 데이터 삭제 (외래키 제약조건 때문에 역순으로 삭제)
-- 주의: gym_no 9의 데이터만 삭제하며, 다른 gym_no의 데이터는 절대 삭제하지 않습니다.
-- GYM과 GYM_DETAIL은 사용자가 직접 관리하므로 삭제하지 않음

-- 1단계: 자식 테이블부터 삭제 (외래키 참조하는 테이블)
DELETE FROM PT_RESERVE WHERE PT_PASS_NO IN (SELECT PT_PASS_NO FROM PT_PASS WHERE GYM_NO = 9);
DELETE FROM LOCKER_PASS WHERE LOCKER_NO IN (SELECT LOCKER_NO FROM LOCKER WHERE GYM_NO = 9);
DELETE FROM PT_PASS WHERE GYM_NO = 9;
DELETE FROM MEMBERSHIP WHERE GYM_NO = 9;
DELETE FROM PURCHASE_ITEM WHERE PURCHASE_NO IN (SELECT PURCHASE_NO FROM PURCHASE WHERE GYM_NO = 9);
DELETE FROM SALES WHERE GYM_NO = 9;
DELETE FROM PURCHASE WHERE GYM_NO = 9;
DELETE FROM ATTENDANCE WHERE GYM_NO = 9;
DELETE FROM INQUIRY_RESERVE WHERE GYM_NO = 9;

-- 2단계: MEMBER와 연관된 데이터 (gym_no 9 회원만 삭제)
DELETE FROM INBODY_RECORD WHERE MEMBER_NO IN (SELECT MEMBER_NO FROM MEMBER WHERE GYM_NO = 9);
DELETE FROM GOAL_MANAGE WHERE MEMBER_NO IN (SELECT MEMBER_NO FROM MEMBER WHERE GYM_NO = 9);

-- 3단계: MEMBER 삭제 (gym_no 9만, 다른 gym_no는 절대 삭제 안됨)
DELETE FROM MEMBER WHERE GYM_NO = 9;

-- 4단계: 기타 gym_no 9 관련 데이터
DELETE FROM GYM_NOTICE WHERE GYM_NO = 9;
DELETE FROM YOUTUBE_URL WHERE GYM_NO = 9;
DELETE FROM PRODUCT WHERE GYM_NO = 9;
DELETE FROM STOCK_MANAGER WHERE GYM_NO = 9;
DELETE FROM LOCKER WHERE GYM_NO = 9;
DELETE FROM ATT_CACHE WHERE GYM_NO = 9;

COMMIT;
*/

-- 주의: GYM_NO 9가 이미 존재한다고 가정합니다.
-- GYM과 GYM_DETAIL은 사용자가 직접 관리하므로 여기서는 생성하지 않습니다.

-- 1. GYM_DETAIL (헬스장 상세정보) - 없으면 생성
INSERT INTO GYM_DETAIL (GYM_DETAIL_NO, INTRO, FACILITIES_INFO, DETAIL_ADDRESS, WEEK_BUSINESS_HOUR, WEEKEND_BUSINESS_HOUR, GYM_NO)
SELECT SEQ_GYM_DETAIL_NO.NEXTVAL, '해운대 해변가 프리미엄 피트니스 센터', '주차가능,샤워실,락커실,사우나,GX 프로그램,PT,24시간', '부산 해운대구 해운대해변로 264, 3-4층', '06:00-24:00', '08:00-22:00', 9
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM GYM_DETAIL WHERE GYM_NO = 9);

-- 3. ATT_CACHE (출결캐싱) - 2일치 데이터 (위에서 이미 삭제했으므로 바로 INSERT)
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE-1, '06-08', 15);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE-1, '08-10', 35);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE-1, '10-12', 55);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE-1, '12-14', 85);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE-1, '14-16', 65);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE-1, '16-18', 95);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE-1, '18-20', 110);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE-1, '20-22', 75);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE-1, '22-24', 25);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE, '06-08', 12);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE, '08-10', 32);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE, '10-12', 52);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE, '12-14', 88);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE, '14-16', 68);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE, '16-18', 98);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE, '18-20', 115);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE, '20-22', 78);
INSERT INTO ATT_CACHE VALUES (SEQ_ATT_CACHE_DETAIL_NO.NEXTVAL, 9, SYSDATE, '22-24', 28);

-- 4. LOCKER (락커) - 30개 (위에서 이미 삭제했으므로 바로 INSERT)
-- gym_no 9 전용 락커 번호 사용 (다른 헬스장과 중복 방지)
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-001', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-002', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-003', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-004', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-005', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-006', '만료');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-007', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-008', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-009', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-010', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-011', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-012', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-013', '만료');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-014', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-015', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-016', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-017', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-018', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-019', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-020', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-021', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-022', '만료');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-023', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-024', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-025', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-026', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-027', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-028', '사용중');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-029', '빈');
INSERT INTO LOCKER VALUES (SEQ_LOCKER_NO.NEXTVAL, 9, 'G9-030', '사용중');

-- 5. PRODUCT (상품) - 10개
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_NO.NEXTVAL, 9, 30, '회원권', '2025-01-01', 120000, 'Y');
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_NO.NEXTVAL, 9, 90, '회원권', '2025-01-01', 300000, 'Y');
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_NO.NEXTVAL, 9, 365, '회원권', '2025-01-01', 1100000, 'Y');
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_NO.NEXTVAL, 9, 30, '락커', '2025-01-01', 35000, 'Y');
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_NO.NEXTVAL, 9, 90, '락커', '2025-01-01', 90000, 'Y');
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_NO.NEXTVAL, 9, 10, 'PT', '2025-01-01', 550000, 'Y');
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_NO.NEXTVAL, 9, 20, 'PT', '2025-01-01', 1000000, 'Y');
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_NO.NEXTVAL, 9, 30, 'PT', '2025-01-01', 1400000, 'Y');
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_NO.NEXTVAL, 9, 60, '회원권', '2025-01-01', 220000, 'Y');
INSERT INTO PRODUCT VALUES (SEQ_PRODUCT_NO.NEXTVAL, 9, 180, '회원권', '2025-01-01', 580000, 'Y');

-- 6. MEMBER (회원) - 일반 회원 100명, 트레이너 15명, 운영자 1명
-- 일반 회원 100명을 PL/SQL 블록으로 생성하고, 회원 번호를 변수에 저장하여 연계 데이터 생성
DECLARE
    -- 회원 번호 저장용 변수
    v_member_no NUMBER;
    v_purchase_no NUMBER;
    v_purchase_item_no NUMBER;
    v_membership_no NUMBER;
    v_pt_pass_no NUMBER;
    v_locker_pass_no NUMBER;
    v_trainer_no NUMBER;
    v_locker_no NUMBER;
    v_goal_no NUMBER;
    v_inquiry_no NUMBER;
    v_attendance_no NUMBER;
    v_inbody_no NUMBER;
    v_goal_manage_no NUMBER;
    v_pt_reserve_no NUMBER;
    v_sales_no NUMBER;
    
    -- 트레이너 번호 저장용 배열
    TYPE trainer_array IS TABLE OF NUMBER;
    v_trainers trainer_array := trainer_array();
    
    -- 이름 배열 (30개 이름 반복 사용)
    TYPE name_array IS TABLE OF VARCHAR2(10);
    v_names name_array := name_array('김민수', '이영희', '박철수', '정수진', '최동현', '강미영', '조성민', '윤지은', '임준호', '한소연',
                                     '서민준', '신지우', '오현우', '유서연', '배도현', '남지훈', '노예린', '도준혁', '라민지', '마동석',
                                     '바다영', '사나래', '아이유', '자두영', '차은우', '카리나', '타이거', '파이리', '하나둘', '호두밤');
    
    -- 동 배열
    TYPE dong_array IS TABLE OF VARCHAR2(10);
    v_dongs dong_array := dong_array('우동', '중동', '송정동', '반여동', '재송동', '좌동');
    
    v_name VARCHAR2(10);
    v_dong VARCHAR2(10);
    v_birth_year NUMBER;
    v_birth_month NUMBER;
    v_birth_day NUMBER;
    v_phone_num NUMBER;
    v_purchase_date DATE;
    v_membership_start DATE;
    v_membership_end DATE;
    v_pt_start DATE;
    v_pt_end DATE;
    v_locker_start DATE;
    v_locker_end DATE;
    v_reserve_time DATE;
    v_attendance_date DATE;
    v_inbody_date DATE;
    v_goal_enroll_date DATE;
    v_product_type VARCHAR2(20);
    v_membership_status VARCHAR2(20);
    v_locker_status VARCHAR2(20);
    v_pt_reserve_status VARCHAR2(20);
    v_purchase_status VARCHAR2(20);
    v_membership_period NUMBER;
    v_pt_count NUMBER;
    v_locker_period NUMBER;
    v_purchase_cost NUMBER;
    v_pt_used_count NUMBER;
    v_pt_total_count NUMBER;
    v_trainer_idx NUMBER;
    v_locker_idx NUMBER;
    v_goal_idx NUMBER;
    v_i NUMBER;
BEGIN
    -- 트레이너 번호 저장 (15명) - MERGE 사용
    v_trainers.EXTEND(15);
    FOR i IN 1..15 LOOP
        v_trainer_no := SEQ_MNO.NEXTVAL;
        MERGE INTO MEMBER m
        USING (SELECT 'gym9_trainer' || LPAD(i, 2, '0') AS member_id FROM DUAL) d
        ON (m.MEMBER_ID = d.member_id)
        WHEN NOT MATCHED THEN
            INSERT (MEMBER_NO, MEMBER_TYPE, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_PHONE, MEMBER_BIRTH, STATUS, MEMBER_CREATEAT, MEMBER_UPDATEAT, MEMBER_EMAIL, MEMBER_PHOTO_PATH, GYM_NO, TRAINER_LICENSE, TRAINER_CAREER, TRAINER_AWARD)
            VALUES (
                v_trainer_no, 2, 'gym9_trainer' || LPAD(i, 2, '0'), 'pass1234!',
                CASE i
                    WHEN 1 THEN '김트레이너' WHEN 2 THEN '이코치' WHEN 3 THEN '박강사' WHEN 4 THEN '정트레이너' WHEN 5 THEN '최코치'
                    WHEN 6 THEN '강트레이너' WHEN 7 THEN '조코치' WHEN 8 THEN '윤트레이너' WHEN 9 THEN '임코치' WHEN 10 THEN '한트레이너'
                    WHEN 11 THEN '서코치' WHEN 12 THEN '신트레이너' WHEN 13 THEN '오코치' WHEN 14 THEN '유트레이너' WHEN 15 THEN '배코치'
                END,
                '부산 해운대구 ' || v_dongs(MOD(i-1, 6) + 1) || ' ' || (i * 100),
                '010-2001-' || LPAD(i, 4, '0'),
                TO_DATE('198' || LPAD(MOD(i, 10), 1, '0') || '-' || LPAD(MOD(i*3, 12)+1, 2, '0') || '-' || LPAD(MOD(i*5, 28)+1, 2, '0'), 'YYYY-MM-DD'),
                'Y', SYSDATE - (200 - i), SYSDATE,
                'gym9_trainer' || LPAD(i, 2, '0') || '@email.com',
                '/profile/trainer' || LPAD(i, 2, '0') || '.jpg',
                9,
                CASE WHEN MOD(i, 3) = 0 THEN 'NSCA-CPT' WHEN MOD(i, 3) = 1 THEN 'ACSM-CPT' ELSE 'NASM-CPT' END,
                '트레이너 경력 ' || (5 + MOD(i, 5)) || '년',
                CASE WHEN MOD(i, 4) = 0 THEN '202' || MOD(i, 4) || ' 대회 입상' ELSE NULL END
            );
        
        -- MERGE 후 트레이너 번호 조회
        SELECT MEMBER_NO INTO v_trainer_no FROM MEMBER WHERE MEMBER_ID = 'gym9_trainer' || LPAD(i, 2, '0');
        v_trainers(i) := v_trainer_no;
    END LOOP;
    
    -- 운영자 1명 - MERGE 사용
    MERGE INTO MEMBER m
    USING (SELECT 'gym9_admin' AS member_id FROM DUAL) d
    ON (m.MEMBER_ID = d.member_id)
    WHEN NOT MATCHED THEN
        INSERT (MEMBER_NO, MEMBER_TYPE, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_PHONE, MEMBER_BIRTH, STATUS, MEMBER_CREATEAT, MEMBER_UPDATEAT, MEMBER_EMAIL, MEMBER_PHOTO_PATH, GYM_NO, TRAINER_LICENSE, TRAINER_CAREER, TRAINER_AWARD)
        VALUES (
            SEQ_MNO.NEXTVAL, 3, 'gym9_admin', 'pass1234!', '강관장',
            '부산 해운대구 해운대해변로 264', '051-1234-5678',
            TO_DATE('1975-12-10', 'YYYY-MM-DD'), 'Y', SYSDATE-200, SYSDATE,
            'gym9_admin@email.com', '/profile/admin9.jpg', 9, NULL, NULL, NULL
        );
    
    -- 일반 회원 100명 생성 및 연계 데이터 생성
    FOR i IN 1..100 LOOP
        -- 이름과 동 선택
        v_name := v_names(MOD(i-1, 30) + 1);
        v_dong := v_dongs(MOD(i-1, 6) + 1);
        
        -- 생년월일 생성
        v_birth_year := 1985 + MOD(i, 20);
        v_birth_month := MOD(i, 12) + 1;
        IF v_birth_month = 2 THEN
            v_birth_day := MOD(i, 28) + 1;
        ELSIF v_birth_month IN (4, 6, 9, 11) THEN
            v_birth_day := MOD(i, 30) + 1;
        ELSE
            v_birth_day := MOD(i, 31) + 1;
        END IF;
        
        -- 전화번호 생성
        v_phone_num := 1001000 + i;
        
        -- 회원 생성 (MERGE 사용하여 중복 방지)
        v_member_no := SEQ_MNO.NEXTVAL;
        MERGE INTO MEMBER m
        USING (SELECT 'gym9_user' || LPAD(i, 3, '0') AS member_id FROM DUAL) d
        ON (m.MEMBER_ID = d.member_id)
        WHEN NOT MATCHED THEN
            INSERT (MEMBER_NO, MEMBER_TYPE, MEMBER_ID, MEMBER_PWD, MEMBER_NAME, MEMBER_ADDRESS, MEMBER_PHONE, MEMBER_BIRTH, STATUS, MEMBER_CREATEAT, MEMBER_UPDATEAT, MEMBER_EMAIL, MEMBER_PHOTO_PATH, GYM_NO, TRAINER_LICENSE, TRAINER_CAREER, TRAINER_AWARD)
            VALUES (
                v_member_no, 1, 'gym9_user' || LPAD(i, 3, '0'), 'pass1234!',
                v_name || i,
                '부산 해운대구 ' || v_dong || ' ' || (100 + i),
                '010-' || SUBSTR(TO_CHAR(v_phone_num), 1, 4) || '-' || LPAD(MOD(i*7, 10000), 4, '0'),
                TO_DATE(v_birth_year || '-' || LPAD(v_birth_month, 2, '0') || '-' || LPAD(v_birth_day, 2, '0'), 'YYYY-MM-DD'),
                'Y', SYSDATE - (180 - i), SYSDATE,
                'gym9_user' || LPAD(i, 3, '0') || '@email.com',
                '/profile/user' || LPAD(i, 3, '0') || '.jpg',
                9, NULL, NULL, NULL
            );
        
        -- MERGE 후 회원 번호 조회
        SELECT MEMBER_NO INTO v_member_no FROM MEMBER WHERE MEMBER_ID = 'gym9_user' || LPAD(i, 3, '0');
        
        -- 구매 데이터 생성 (90% 회원이 구매)
        IF MOD(i, 10) != 0 THEN
            v_purchase_date := SYSDATE - (150 - MOD(i, 150));
            v_purchase_no := SEQ_PURCHASE_NO.NEXTVAL;
            
            -- 구매 유형 결정 (70% 회원권, 20% PT, 10% 락커+회원권)
            IF MOD(i, 10) <= 7 THEN
                -- 회원권 구매
                v_product_type := '회원권';
                v_membership_period := CASE MOD(i, 3)
                    WHEN 0 THEN 30
                    WHEN 1 THEN 90
                    ELSE 365
                END;
                v_purchase_cost := CASE v_membership_period
                    WHEN 30 THEN 120000
                    WHEN 90 THEN 300000
                    ELSE 1100000
                END;
                v_membership_start := v_purchase_date;
                v_membership_end := v_membership_start + v_membership_period;
                v_membership_status := CASE 
                    WHEN v_membership_end < SYSDATE THEN '만료'
                    WHEN v_membership_end >= SYSDATE THEN '정상'
                    ELSE '중단'
                END;
                
                INSERT INTO PURCHASE VALUES (v_purchase_no, v_member_no, 9, v_purchase_date, v_purchase_cost, '결제');
                INSERT INTO PURCHASE_ITEM VALUES (SEQ_PURCHASE_ITEM_NO.NEXTVAL, v_membership_period, NULL, NULL, v_membership_start, v_membership_end, v_purchase_no);
                INSERT INTO MEMBERSHIP VALUES (SEQ_MEMBERSHIP_NO.NEXTVAL, v_purchase_no, v_member_no, 9, v_membership_start, v_membership_end, v_membership_status, v_membership_start, v_membership_start);
                -- 회원권 매출 추가
                INSERT INTO SALES VALUES (SEQ_SALES_NO.NEXTVAL, v_purchase_no, NULL, 9, '회원권', v_purchase_date);
                
            ELSIF MOD(i, 10) = 8 THEN
                -- PT 구매
                v_product_type := 'PT';
                v_pt_total_count := CASE MOD(i, 3)
                    WHEN 0 THEN 10
                    WHEN 1 THEN 20
                    ELSE 30
                END;
                v_purchase_cost := CASE v_pt_total_count
                    WHEN 10 THEN 550000
                    WHEN 20 THEN 1000000
                    ELSE 1400000
                END;
                v_pt_start := v_purchase_date;
                v_pt_end := v_pt_start + 180;
                v_pt_used_count := MOD(i, v_pt_total_count);
                
                INSERT INTO PURCHASE VALUES (v_purchase_no, v_member_no, 9, v_purchase_date, v_purchase_cost, '결제');
                INSERT INTO PURCHASE_ITEM VALUES (SEQ_PURCHASE_ITEM_NO.NEXTVAL, 0, NULL, v_pt_total_count, v_pt_start, v_pt_end, v_purchase_no);
                v_pt_pass_no := SEQ_PT_PASS_NO.NEXTVAL;
                INSERT INTO PT_PASS VALUES (v_pt_pass_no, v_purchase_no, v_member_no, 9, v_pt_start, v_pt_end, v_pt_used_count, v_pt_total_count);
                INSERT INTO SALES VALUES (SEQ_SALES_NO.NEXTVAL, v_purchase_no, NULL, 9, 'PT', v_purchase_date);
                
                -- PT 예약 생성 (사용한 횟수만큼)
                FOR j IN 1..v_pt_used_count LOOP
                    v_trainer_idx := MOD(i + j, 15) + 1;
                    IF v_trainer_idx = 0 THEN v_trainer_idx := 15; END IF;
                    v_trainer_no := v_trainers(v_trainer_idx);
                    v_reserve_time := v_pt_start + (j * 7);
                    v_pt_reserve_status := CASE WHEN v_reserve_time < SYSDATE THEN '승인됨' ELSE '대기중' END;
                    
                    INSERT INTO PT_RESERVE VALUES (
                        SEQ_PT_RESERVE_NO.NEXTVAL, v_pt_pass_no, v_reserve_time,
                        v_trainer_no, v_trainer_no, v_pt_reserve_status
                    );
                END LOOP;
                
            ELSE
                -- 락커 + 회원권 구매
                v_membership_period := 30;
                v_locker_period := 30;
                v_purchase_cost := 120000 + 35000;
                v_membership_start := v_purchase_date;
                v_membership_end := v_membership_start + v_membership_period;
                v_locker_start := v_purchase_date;
                v_locker_end := v_locker_start + v_locker_period;
                v_membership_status := CASE WHEN v_membership_end >= SYSDATE THEN '정상' ELSE '만료' END;
                v_locker_status := CASE WHEN v_locker_end >= SYSDATE THEN '정상' ELSE '만료' END;
                
                INSERT INTO PURCHASE VALUES (v_purchase_no, v_member_no, 9, v_purchase_date, v_purchase_cost, '결제');
                INSERT INTO PURCHASE_ITEM VALUES (SEQ_PURCHASE_ITEM_NO.NEXTVAL, v_membership_period, v_locker_period, NULL, v_membership_start, v_membership_end, v_purchase_no);
                INSERT INTO MEMBERSHIP VALUES (SEQ_MEMBERSHIP_NO.NEXTVAL, v_purchase_no, v_member_no, 9, v_membership_start, v_membership_end, v_membership_status, v_membership_start, v_membership_start);
                
                -- 락커 번호 선택 (LOCKER_PASS의 UNIQUE 제약조건 때문에 같은 회원이 같은 락커를 중복 구매할 수 없음)
                BEGIN
                    SELECT LOCKER_NO INTO v_locker_no 
                    FROM (
                        SELECT L.LOCKER_NO 
                        FROM LOCKER L
                        WHERE L.GYM_NO = 9 
                          AND L.LOCKER_STATUS = '빈'
                          AND NOT EXISTS (
                              SELECT 1 FROM LOCKER_PASS LP 
                              WHERE LP.LOCKER_NO = L.LOCKER_NO 
                                AND LP.MEMBER_NO = v_member_no
                          )
                        ORDER BY L.LOCKER_NO
                    )
                    WHERE ROWNUM = 1;
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                        -- 빈 락커가 없거나 모두 해당 회원이 사용 중이면 첫 번째 락커 사용
                        SELECT LOCKER_NO INTO v_locker_no 
                        FROM (SELECT LOCKER_NO FROM LOCKER WHERE GYM_NO = 9 ORDER BY LOCKER_NO)
                        WHERE ROWNUM = 1;
                END;
                
                INSERT INTO LOCKER_PASS VALUES (SEQ_LOCKER_PASS_NO.NEXTVAL, v_purchase_no, v_locker_no, v_member_no, v_locker_start, v_locker_end, v_locker_status);
                INSERT INTO SALES VALUES (SEQ_SALES_NO.NEXTVAL, v_purchase_no, NULL, 9, '회원권', v_purchase_date);
            END IF;
        END IF;
        
        -- 출석 기록 생성 (회원권이 있는 회원만, 평균 8회)
        IF MOD(i, 10) != 0 AND MOD(i, 10) != 9 THEN
            FOR j IN 1..(8 + MOD(i, 5)) LOOP
                v_attendance_date := SYSDATE - (MOD(i*7 + j, 60));
                INSERT INTO ATTENDANCE VALUES (
                    SEQ_ATTENDANCE_NO.NEXTVAL, 9, v_member_no, '입실', v_attendance_date
                );
                INSERT INTO ATTENDANCE VALUES (
                    SEQ_ATTENDANCE_NO.NEXTVAL, 9, v_member_no, '퇴실', v_attendance_date + (MOD(j, 3) + 1) / 24
                );
            END LOOP;
        END IF;
        
        -- 인바디 기록 생성 (50% 회원, 평균 2회)
        IF MOD(i, 2) = 0 THEN
            FOR j IN 1..(2 + MOD(i, 2)) LOOP
                v_inbody_date := SYSDATE - (MOD(i*11 + j, 90));
                INSERT INTO INBODY_RECORD VALUES (
                    SEQ_INBODY_NO.NEXTVAL, v_inbody_date,
                    60 + MOD(i, 30) + (j * 0.5),  -- WEIGHT
                    20 + MOD(i, 15) + (j * 0.3),  -- SMM
                    15 + MOD(i, 10) - (j * 0.2),  -- PBF
                    20 + MOD(i, 8) + (j * 0.1),   -- BMI
                    v_member_no
                );
            END LOOP;
        END IF;
        
        -- 목표 관리 생성 (60% 회원)
        IF MOD(i, 5) <= 2 THEN
            FOR j IN 1..(1 + MOD(i, 3)) LOOP
                v_goal_idx := MOD(i + j, 8) + 1;
                v_goal_enroll_date := SYSDATE - (MOD(i*13 + j, 60));
                INSERT INTO GOAL_MANAGE VALUES (
                    SEQ_GOAL_MANAGE_NO.NEXTVAL, v_member_no, v_goal_idx, v_goal_enroll_date
                );
            END LOOP;
        END IF;
        
        -- 방문 예약 생성 (20% 회원)
        IF MOD(i, 5) = 0 THEN
            INSERT INTO INQUIRY_RESERVE VALUES (
                SEQ_INQUIRY_NO.NEXTVAL, 9, v_member_no,
                SYSDATE + (MOD(i, 30)),
                CASE MOD(i, 3)
                    WHEN 0 THEN '운동 루틴 상담 원합니다'
                    WHEN 1 THEN 'PT 상담 요청'
                    ELSE '시설 둘러보기'
                END,
                CASE WHEN MOD(i, 2) = 0 THEN '예약완료' ELSE '대기중' END,
                CASE WHEN MOD(i, 2) = 0 THEN '오후 방문 예정' ELSE NULL END
            );
        END IF;
    END LOOP;
END;
/

-- 8. GYM_NOTICE (공지사항) - 15개 (위에서 이미 삭제했으므로 바로 INSERT)
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '신규 회원 환영 이벤트', '강관장', '이벤트', '신규 회원 가입 시 첫 달 50% 할인! 많은 관심 부탁드립니다.', SYSDATE-10, 'Y', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '여름 시즌 운영시간 변경 안내', '관리팀', '중요', '7월 1일부터 평일 운영시간이 06:00-24:00으로 변경됩니다.', SYSDATE-8, 'Y', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '새로운 GX 프로그램 오픈', '운영팀', '일반', '요가, 필라테스, 복싱 등 다양한 GX 프로그램이 새롭게 시작됩니다.', SYSDATE-5, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '시설 점검 안내', '시설관리팀', '중요', '8월 15일 오전 2시부터 6시까지 시설 점검이 예정되어 있습니다.', SYSDATE-3, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, 'PT 트레이너 신규 합류', '강관장', '일반', '경력 10년 이상의 전문 트레이너 3명이 새롭게 합류했습니다.', SYSDATE-2, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '주차장 이용 안내', '관리팀', '일반', '주차장 만차 시 인근 공영주차장을 이용해주세요.', SYSDATE-1, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '사우나 이용 시간 변경', '시설관리팀', '일반', '사우나 이용 시간이 오전 6시부터 오후 11시까지로 변경되었습니다.', SYSDATE, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '회원권 연장 할인 이벤트', '운영팀', '이벤트', '기존 회원권 연장 시 10% 추가 할인 혜택을 제공합니다.', SYSDATE-7, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '락커 이용 안내', '관리팀', '일반', '락커 이용 시 개인 물품 보관에 주의해주시기 바랍니다.', SYSDATE-6, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '운동 기구 신규 입고', '시설관리팀', '일반', '최신 스미스머신과 케이블 머신이 입고되었습니다.', SYSDATE-4, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '회원 여러분께 감사 인사', '강관장', '일반', '회원 여러분의 성원에 감사드리며, 더 나은 서비스로 보답하겠습니다.', SYSDATE-9, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '건강검진 이벤트', '운영팀', '이벤트', '정기 건강검진을 받으신 회원분들께 특별 혜택을 제공합니다.', SYSDATE-12, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '샤워실 이용 수칙', '관리팀', '일반', '샤워실 이용 시 위생을 위해 개인 수건을 준비해주세요.', SYSDATE-11, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '운동복 대여 서비스', '운영팀', '일반', '운동복 대여 서비스를 시작했습니다. 데스크에서 문의해주세요.', SYSDATE-13, 'N', NULL, 9);
INSERT INTO GYM_NOTICE VALUES (SEQ_NOTICE_NO.NEXTVAL, '회원 모집 안내', '강관장', '일반', '추천인 제도를 통해 회원을 모집하고 있습니다. 많은 참여 부탁드립니다.', SYSDATE-14, 'N', NULL, 9);

-- 9. YOUTUBE_URL (유튜브 영상) - 10개 (위에서 이미 삭제했으므로 바로 INSERT)
INSERT INTO YOUTUBE_URL VALUES (SEQ_YOUTUBE_URL_NO.NEXTVAL, '김트레이너', '초보자를 위한 전신 운동 루틴', 'https://youtube.com/watch?v=gym9_001', 9);
INSERT INTO YOUTUBE_URL VALUES (SEQ_YOUTUBE_URL_NO.NEXTVAL, '이코치', '가슴 근육 키우기 완벽 가이드', 'https://youtube.com/watch?v=gym9_002', 9);
INSERT INTO YOUTUBE_URL VALUES (SEQ_YOUTUBE_URL_NO.NEXTVAL, '박강사', '하체 운동 집중 공략', 'https://youtube.com/watch?v=gym9_003', 9);
INSERT INTO YOUTUBE_URL VALUES (SEQ_YOUTUBE_URL_NO.NEXTVAL, '정트레이너', '등 운동 완벽 가이드', 'https://youtube.com/watch?v=gym9_004', 9);
INSERT INTO YOUTUBE_URL VALUES (SEQ_YOUTUBE_URL_NO.NEXTVAL, '최코치', '어깨 운동 5가지 필수 동작', 'https://youtube.com/watch?v=gym9_005', 9);
INSERT INTO YOUTUBE_URL VALUES (SEQ_YOUTUBE_URL_NO.NEXTVAL, '강트레이너', '복근 만들기 홈트', 'https://youtube.com/watch?v=gym9_006', 9);
INSERT INTO YOUTUBE_URL VALUES (SEQ_YOUTUBE_URL_NO.NEXTVAL, '조코치', '팔 운동 집중 공략', 'https://youtube.com/watch?v=gym9_007', 9);
INSERT INTO YOUTUBE_URL VALUES (SEQ_YOUTUBE_URL_NO.NEXTVAL, '윤트레이너', '전신 순환 운동', 'https://youtube.com/watch?v=gym9_008', 9);
INSERT INTO YOUTUBE_URL VALUES (SEQ_YOUTUBE_URL_NO.NEXTVAL, '임코치', '스트레칭 루틴', 'https://youtube.com/watch?v=gym9_009', 9);
INSERT INTO YOUTUBE_URL VALUES (SEQ_YOUTUBE_URL_NO.NEXTVAL, '한트레이너', '다이어트 운동 루틴', 'https://youtube.com/watch?v=gym9_010', 9);

COMMIT;

-- 데이터 생성 완료
SELECT 'GYM_NO 9 더미 데이터 생성 완료!' AS MESSAGE FROM DUAL;
SELECT '일반 회원: 100명' AS INFO FROM DUAL;
SELECT '트레이너: 15명' AS INFO FROM DUAL;
SELECT '운영자: 1명' AS INFO FROM DUAL;
SELECT '구매: 약 90건' AS INFO FROM DUAL;
SELECT '회원권: 약 70건' AS INFO FROM DUAL;
SELECT 'PT 이용권: 약 20건' AS INFO FROM DUAL;
SELECT 'PT 예약: 약 100건' AS INFO FROM DUAL;
SELECT '출석 기록: 약 800건' AS INFO FROM DUAL;
SELECT '인바디 기록: 약 200건' AS INFO FROM DUAL;
SELECT '목표 관리: 약 150건' AS INFO FROM DUAL;
SELECT '방문 예약: 약 20건' AS INFO FROM DUAL;
SELECT '총 매출 건수: 약 90건 (회원권 70건 + PT 20건)' AS INFO FROM DUAL;



UPDATE GYM_DETAIL
SET FACILITIES_INFO = REPLACE(
    REPLACE(
        REPLACE(FACILITIES_INFO, '주차장', '주차가능'),
        '락커룸', '락커실'
    ),
    'GX프로그램', 'GX 프로그램'
)
WHERE FACILITIES_INFO LIKE '%주차장%'
   OR FACILITIES_INFO LIKE '%락커룸%'
   OR FACILITIES_INFO LIKE '%GX프로그램%';

COMMIT;

-- 확인 쿼리 (수정 후 확인용)
SELECT GYM_NO, FACILITIES_INFO
FROM GYM_DETAIL
WHERE FACILITIES_INFO IS NOT NULL;
