package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.Locker;
import com.kh.gymhub.model.vo.LockerPass;

import java.util.List;

public interface LockerService {
    List<LockerPass> selectLockerPassListByGymNo(int gymNo);

    int addLocker(Locker locker);

    void updateExpiredLockers();
}

