package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.PtReservation;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
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
    
    /**
     * 가장 가까운 미래 PT 예약 조회 (대기중/승인됨)
     * @param ptPassNo PT 이용권 번호
     * @return 가장 가까운 미래 예약
     */
    PtReservation selectUpcomingReservation(@Param("ptPassNo") int ptPassNo);
    
    /**
     * 예정된 PT 목록 조회 (승인됨 + 미래)
     * @param ptPassNo PT 이용권 번호
     * @return 예정된 PT 목록
     */
    List<PtReservation> selectScheduledPtList(@Param("ptPassNo") int ptPassNo);
    
    /**
     * 완료된 PT 목록 조회 (승인됨 + 과거)
     * @param ptPassNo PT 이용권 번호
     * @return 완료된 PT 목록
     */
    List<PtReservation> selectCompletedPtList(@Param("ptPassNo") int ptPassNo);
}

