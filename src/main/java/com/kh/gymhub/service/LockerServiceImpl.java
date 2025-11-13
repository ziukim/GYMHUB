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

    @Override
    public Locker selectLockerByNo(int lockerNo) {
        return lockerMapper.selectLockerByNo(lockerNo);
    }

    @Override
    @Transactional
    public int updateLockerStatus(int lockerNo, String lockerStatus) {
        // 활성 이용권이 있는 경우 수정 불가
        if (hasActiveLockerPass(lockerNo)) {
            return -1; // 활성 이용권이 있음을 나타내는 반환값
        }
        return lockerMapper.updateLockerStatus(lockerNo, lockerStatus);
    }

    @Override
    public boolean hasActiveLockerPass(int lockerNo) {
        int count = lockerMapper.countActiveLockerPassByLockerNo(lockerNo);
        return count > 0;
    }
}

