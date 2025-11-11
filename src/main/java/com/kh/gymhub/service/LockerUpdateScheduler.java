package com.kh.gymhub.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class LockerUpdateScheduler {

    private final LockerService lockerService;

    /**
     * 매일 자정에 만료된 락커의 상태를 업데이트합니다.
     * CRON 표현식: 초 분 시 일 월 요일
     * "0 0 0 * * ?" = 매일 0시 0분 0초
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void updateExpiredLockersStatus() {
        log.info("=== 만료된 락커 상태 업데이트 스케줄러 시작 ===");
        try {
            lockerService.updateExpiredLockers();
            log.info("=== 만료된 락커 상태 업데이트 스케줄러 성공 ===");
        } catch (Exception e) {
            log.error("만료된 락커 상태 업데이트 중 오류 발생", e);
        }
    }
}
