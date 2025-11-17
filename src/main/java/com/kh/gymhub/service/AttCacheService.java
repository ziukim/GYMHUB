package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.AttCache;

import java.sql.Date;
import java.util.List;
import java.util.Map;

public interface AttCacheService {
    /**
     * 혼잡도 캐시 데이터 삽입
     * @param attCache 혼잡도 캐시 정보
     * @return 삽입된 행 수
     */
    int insertAttCache(AttCache attCache);

    /**
     * 특정 헬스장의 시간대별 혼잡도 조회 (최근 N일 평균)
     * @param gymNo 헬스장 번호
     * @param days 최근 며칠간의 데이터를 평균낼지 (기본값: 7일)
     * @return 시간대별 평균 혼잡도 리스트
     */
    List<Map<String, Object>> getCongestionByGymNo(int gymNo, int days);

    /**
     * 특정 헬스장의 시간대별 혼잡도 조회 (기본 7일 평균)
     * @param gymNo 헬스장 번호
     * @return 시간대별 평균 혼잡도 리스트
     */
    List<Map<String, Object>> getCongestionByGymNo(int gymNo);

    /**
     * 특정 헬스장의 특정 날짜의 시간대별 혼잡도 조회
     * @param gymNo 헬스장 번호
     * @param cacheDate 날짜
     * @return 시간대별 혼잡도 리스트
     */
    List<AttCache> getCongestionByGymNoAndDate(int gymNo, Date cacheDate);

    /**
     * 전날 데이터를 기반으로 시간대별 혼잡도 계산 및 저장
     * @param gymNo 헬스장 번호
     * @param targetDate 대상 날짜 (전날)
     * @return 저장된 레코드 수
     */
    int calculateAndSaveCongestion(int gymNo, Date targetDate);
}

