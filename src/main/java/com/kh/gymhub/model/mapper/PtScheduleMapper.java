package com.kh.gymhub.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;

@Mapper
public interface PtScheduleMapper {
    
    /**
     * 회원의 활성 PT 이용권 정보 조회
     * @param memberNo 회원 번호
     * @return PT 이용권 정보 (PT_PASS_NO, PT_TOTAL_COUNT, PT_END)
     */
    Map<String, Object> selectActivePtPass(@Param("memberNo") int memberNo);
    
    /**
     * PT 사용 완료 횟수 조회 (예약 확정된 PT 횟수)
     * @param ptPassNo PT 이용권 번호
     * @return 사용 완료 횟수
     */
    Integer countCompletedPtReservations(@Param("ptPassNo") int ptPassNo);
}

