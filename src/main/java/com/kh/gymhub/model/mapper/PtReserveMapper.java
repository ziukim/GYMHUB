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
    
    // 회원 탈퇴 시 예정된 PT 예약 취소 처리
    int cancelPtReservesByMemberNo(@Param("memberNo") int memberNo);
    
    // PT 예약 번호로 조회
    PtReserve selectPtReserveByNo(@Param("ptReserveNo") int ptReserveNo);
    
    // 날짜별 대기중인 PT 예약 조회 (헬스장별)
    List<PtReserve> selectPendingPtReservesByGymNoAndDate(@Param("gymNo") int gymNo, @Param("reserveDate") String reserveDate);
    
    // 날짜별 승인됨/거절됨 PT 예약 조회 (헬스장별)
    List<PtReserve> selectApprovedOrRejectedPtReservesByGymNoAndDate(@Param("gymNo") int gymNo, @Param("reserveDate") String reserveDate);
    
    // 트레이너별 승인된 PT 예약 조회 (PT_TRAINER_NO 기반)
    List<PtReserve> selectApprovedPtReservesByTrainerNo(@Param("ptTrainerNo") int ptTrainerNo);
    
    // 날짜별 트레이너별 승인된 PT 예약 조회 (PT_TRAINER_NO 기반)
    List<PtReserve> selectApprovedPtReservesByTrainerNoAndDate(@Param("ptTrainerNo") int ptTrainerNo, @Param("reserveDate") String reserveDate);
    
    // 대기중인 PT 예약 조회 (페이징)
    List<PtReserve> selectPendingPtReservesByGymNoPaged(@Param("gymNo") int gymNo, @Param("startRow") int startRow, @Param("endRow") int endRow);
    
    // 대기중인 PT 예약 수 조회 (페이징용)
    Integer selectPendingPtReserveCountByGymNo(@Param("gymNo") int gymNo);
    
    // 승인됨/거절됨 PT 예약 조회 (페이징)
    List<PtReserve> selectApprovedOrRejectedPtReservesByGymNoPaged(@Param("gymNo") int gymNo, @Param("startRow") int startRow, @Param("endRow") int endRow);
    
    // 승인됨/거절됨 PT 예약 수 조회 (페이징용)
    Integer selectApprovedOrRejectedPtReserveCountByGymNo(@Param("gymNo") int gymNo);
}

