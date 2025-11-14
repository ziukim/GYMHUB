package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.PtScheduleSummary;

public interface PtScheduleService {
    
    /**
     * 회원의 PT 스케줄 요약 정보 조회
     * @param memberNo 회원 번호
     * @return PT 스케줄 요약 정보
     */
    PtScheduleSummary getPtScheduleSummary(int memberNo);
}

