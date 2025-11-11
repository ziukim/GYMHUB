package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Locker;
import com.kh.gymhub.model.vo.LockerPass;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface LockerMapper {
    List<LockerPass> selectLockerPassListByGymNo(int gymNo);

    int insertLocker(Locker locker);

    int updateExpiredLockerPassStatus();

    int updateLockerStatusForExpiredPasses();
}
