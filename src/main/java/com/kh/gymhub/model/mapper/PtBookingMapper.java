package com.kh.gymhub.model.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.Timestamp;
import java.util.List;

@Mapper
public interface PtBookingMapper {
    
    /**
     * 특정 날짜/트레이너의 예약된 시간 조회
     * @param trainerNo 트레이너 번호
     * @param reserveDate 예약 날짜 (yyyy-MM-dd)
     * @return 예약된 시간 목록 (HH:mm 형식)
     */
    List<String> selectBookedTimeSlots(@Param("trainerNo") int trainerNo, 
                                        @Param("reserveDate") String reserveDate);
    
    /**
     * PT 예약 신청
     * @param ptPassNo PT 이용권 번호
     * @param reserveTime 예약 시간
     * @param desiredTrainerNo 희망 트레이너 번호
     * @return 성공 여부
     */
    int insertPtReservation(@Param("ptPassNo") int ptPassNo,
                            @Param("reserveTime") Timestamp reserveTime,
                            @Param("desiredTrainerNo") int desiredTrainerNo);
}

