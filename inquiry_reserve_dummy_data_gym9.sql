-- 헬스장 9번 방문 예약 더미데이터
-- 기존 MEMBER 더미데이터 사용 (user01, user02, user03)

-- 1. 홍길동 (user01, MEMBER_NO = 1) - 헬스장 9번 방문 예약
INSERT INTO INQUIRY_RESERVE VALUES (
    SEQ_INQUIRY_NO.NEXTVAL,  -- INQUIRY_NO
    9,                        -- GYM_NO (헬스장 9번)
    1,                        -- MEMBER_NO (홍길동)
    SYSDATE + 3,              -- VISIT_DATETIME (3일 후)
    '회원권 구매 상담 원합니다',  -- REQUEST
    '예약',                    -- INQUIRY_STATUS
    '오후 2시 방문 예정'        -- INQUIRY_MEMO
);

-- 2. 김영희 (user02, MEMBER_NO = 2) - 헬스장 9번 방문 예약
INSERT INTO INQUIRY_RESERVE VALUES (
    SEQ_INQUIRY_NO.NEXTVAL,  -- INQUIRY_NO
    9,                        -- GYM_NO (헬스장 9번)
    2,                        -- MEMBER_NO (김영희)
    SYSDATE + 5,              -- VISIT_DATETIME (5일 후)
    'PT 상담 및 시설 둘러보기',  -- REQUEST
    '예약',                    -- INQUIRY_STATUS
    '오전 10시 방문 예정'        -- INQUIRY_MEMO
);

-- 3. 박철수 (user03, MEMBER_NO = 3) - 헬스장 9번 방문 예약
INSERT INTO INQUIRY_RESERVE VALUES (
    SEQ_INQUIRY_NO.NEXTVAL,  -- INQUIRY_NO
    9,                        -- GYM_NO (헬스장 9번)
    3,                        -- MEMBER_NO (박철수)
    SYSDATE + 7,              -- VISIT_DATETIME (7일 후)
    '락커 이용 및 운동 루틴 상담',  -- REQUEST
    '예약',                    -- INQUIRY_STATUS
    '오후 4시 방문 예정'        -- INQUIRY_MEMO
);

