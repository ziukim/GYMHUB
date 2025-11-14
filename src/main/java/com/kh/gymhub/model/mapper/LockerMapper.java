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
    
    // 회원번호로 락커 이용권 조회
    LockerPass selectLockerPassByMemberNo(@Param("memberNo") int memberNo, @Param("gymNo") int gymNo);
    
    // 락커 이용권 만료일 연장
    int updateLockerPassEndDate(@Param("lockerPassNo") int lockerPassNo, @Param("newEndDate") java.util.Date newEndDate);
    
    // 락커 이용권의 락커번호 변경
    int updateLockerPassLockerNo(@Param("lockerPassNo") int lockerPassNo, @Param("newLockerNo") int newLockerNo);
    
    // 락커 이용권 상태를 만료로 변경
    int updateLockerPassStatusToExpired(@Param("lockerPassNo") int lockerPassNo);
    
    // 락커 실제 번호로 락커 조회
    Locker selectLockerByRealNumAndGymNo(@Param("lockerRealNum") String lockerRealNum, @Param("gymNo") int gymNo);
}

