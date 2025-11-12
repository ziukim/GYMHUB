package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.LockerMapper;
import com.kh.gymhub.model.vo.Locker;
import com.kh.gymhub.model.vo.LockerPass;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class LockerServiceImpl implements LockerService {

    private final LockerMapper lockerMapper;

    public LockerServiceImpl(LockerMapper lockerMapper) {
        this.lockerMapper = lockerMapper;
    }

    @Override
    public List<LockerPass> selectLockerPassListByGymNo(int gymNo) {
        return lockerMapper.selectLockerPassListByGymNo(gymNo);
    }

    @Override
    public int addLocker(Locker locker) {
        return lockerMapper.insertLocker(locker);
    }

    @Override
    @Transactional
    public void updateExpiredLockers() {
        int updatedPasses = lockerMapper.updateExpiredLockerPassStatus();
        if (updatedPasses > 0) {
            lockerMapper.updateLockerStatusForExpiredPasses();
        }
    }

    /**
     * 매일 자정에 만료된 락커의 상태를 업데이트합니다.
     * CRON 표현식: 초 분 시 일 월 요일
     * "0 0 0 * * ?" = 매일 0시 0분 0초
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void scheduledLockerUpdate() {
        try {
            this.updateExpiredLockers();
        } catch (Exception e) {
            // 로그 처리 필요시 추가
        }
    }
}

