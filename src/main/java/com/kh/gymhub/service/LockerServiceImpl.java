package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.LockerMapper;
import com.kh.gymhub.model.vo.Locker;
import com.kh.gymhub.model.vo.LockerPass;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class LockerServiceImpl implements LockerService {

    private final LockerMapper lockerMapper;

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
}

