package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.PtReserve;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PtReserveMapper {
    // 대기중인 PT 예약 조회 (헬스장별)
    List<PtReserve> selectPendingPtReservesByGymNo(@Param("gymNo") int gymNo);
    
    // 승인됨/거절됨 PT 예약 조회 (헬스장별, 미래 날짜만)
    List<PtReserve> selectApprovedOrRejectedPtReservesByGymNo(@Param("gymNo") int gymNo);
    
    // PT 예약 승인 (트레이너 배정)
    int updatePtReserveApprove(@Param("ptReserveNo") int ptReserveNo, @Param("ptTrainerNo") int ptTrainerNo);
    
    // PT 예약 거절
    int updatePtReserveReject(@Param("ptReserveNo") int ptReserveNo);
    
    // PT 예약 번호로 조회
    PtReserve selectPtReserveByNo(@Param("ptReserveNo") int ptReserveNo);
}

