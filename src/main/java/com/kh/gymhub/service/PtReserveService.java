package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.PtReserve;

import java.util.List;

public interface PtReserveService {
    // 대기중인 PT 예약 조회 (헬스장별)
    List<PtReserve> getPendingPtReservesByGymNo(int gymNo);
    
    // 승인됨/거절됨 PT 예약 조회 (헬스장별, 미래 날짜만)
    List<PtReserve> getApprovedOrRejectedPtReservesByGymNo(int gymNo);
    
    // PT 예약 승인 (트레이너 배정)
    int approvePtReserve(int ptReserveNo, int ptTrainerNo);
    
    // PT 예약 거절
    int rejectPtReserve(int ptReserveNo);
    
    // PT 예약 번호로 조회
    PtReserve getPtReserveByNo(int ptReserveNo);
    
    // 날짜별 대기중인 PT 예약 조회 (헬스장별)
    List<PtReserve> getPendingPtReservesByGymNoAndDate(int gymNo, String reserveDate);
    
    // 날짜별 승인됨/거절됨 PT 예약 조회 (헬스장별)
    List<PtReserve> getApprovedOrRejectedPtReservesByGymNoAndDate(int gymNo, String reserveDate);
    
    // 트레이너별 승인된 PT 예약 조회 (PT_TRAINER_NO 기반)
    List<PtReserve> getApprovedPtReservesByTrainerNo(int ptTrainerNo);
    
    // 날짜별 트레이너별 승인된 PT 예약 조회 (PT_TRAINER_NO 기반)
    List<PtReserve> getApprovedPtReservesByTrainerNoAndDate(int ptTrainerNo, String reserveDate);

}

