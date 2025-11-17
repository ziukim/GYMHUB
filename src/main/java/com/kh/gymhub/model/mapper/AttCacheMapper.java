package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.AttCache;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.Date;
import java.util.List;
import java.util.Map;

@Mapper
public interface AttCacheMapper {
    /**
     * 혼잡도 캐시 데이터 삽입
     * @param attCache 혼잡도 캐시 정보
     * @return 삽입된 행 수
     */
    int insertAttCache(AttCache attCache);

    /**
     * 특정 헬스장의 시간대별 혼잡도 조회 (최근 N일 평균)
     * @param gymNo 헬스장 번호
     * @param days 최근 며칠간의 데이터를 평균낼지
     * @return 시간대별 평균 혼잡도 리스트
     */
    List<Map<String, Object>> selectCongestionByGymNo(@Param("gymNo") int gymNo, @Param("days") int days);

    /**
     * 특정 헬스장의 특정 날짜의 시간대별 혼잡도 조회
     * @param gymNo 헬스장 번호
     * @param cacheDate 날짜
     * @return 시간대별 혼잡도 리스트
     */
    List<AttCache> selectCongestionByGymNoAndDate(@Param("gymNo") int gymNo, @Param("cacheDate") Date cacheDate);

    /**
     * 특정 헬스장의 특정 시간대의 평균 혼잡도 계산 (ATTENDANCE 테이블 기반)
     * @param gymNo 헬스장 번호
     * @param startDate 시작 날짜
     * @param endDate 종료 날짜
     * @param timeSlot 시간대 (예: "06-08")
     * @return 평균 인원수
     */
    Integer calculateAverageCountByTimeSlot(
            @Param("gymNo") int gymNo,
            @Param("startDate") Date startDate,
            @Param("endDate") Date endDate,
            @Param("timeSlot") String timeSlot
    );
}

