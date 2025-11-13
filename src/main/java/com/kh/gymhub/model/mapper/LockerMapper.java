package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Locker;
import com.kh.gymhub.model.vo.LockerPass;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface LockerMapper {
    List<LockerPass> selectLockerPassListByGymNo(int gymNo);

    int insertLocker(Locker locker);

    int updateExpiredLockerPassStatus();

    int updateLockerStatusForExpiredPasses();
    
    int insertLockerPass(LockerPass lockerPass);
    
    LockerPass selectLockerByRealNum(@Param("lockerRealNum") String lockerRealNum, @Param("gymNo") int gymNo);
    
    int updateLockerStatus(@Param("lockerNo") int lockerNo, @Param("lockerStatus") String lockerStatus);
    
    Locker selectLockerByNo(@Param("lockerNo") int lockerNo);
    
    int countActiveLockerPassByLockerNo(@Param("lockerNo") int lockerNo);
}

