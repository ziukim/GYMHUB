package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Attendance;
import com.kh.gymhub.model.vo.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AttendanceMapper {
    // 오늘 출석 수 조회 (입실만 있고 퇴실이 없는 회원 수)
    Integer selectTodayAttendanceCountByGymNo(@Param("gymNo") int gymNo);
    
    /**
     * 전화번호와 헬스장 번호로 회원 조회 (만료되지 않은 회원권 보유자만)
     * @param phone 전화번호
     * @param gymNo 헬스장 번호
     * @return 회원 정보
     */
    Member selectMemberByPhoneAndGymNo(@Param("phone") String phone, @Param("gymNo") int gymNo);
    
    /**
     * 전화번호와 헬스장 번호로 트레이너 조회 (MEMBER_TYPE=2, GYM_NO 매칭)
     * @param phone 전화번호
     * @param gymNo 헬스장 번호
     * @return 트레이너 정보
     */
    Member selectTrainerByPhoneAndGymNo(@Param("phone") String phone, @Param("gymNo") int gymNo);
    
    /**
     * 오늘 날짜의 입실 기록 조회
     * @param gymNo 헬스장 번호
     * @param memberNo 회원 번호
     * @return 입실 기록
     */
    Attendance selectTodayCheckIn(@Param("gymNo") int gymNo, @Param("memberNo") int memberNo);
    
    /**
     * 오늘 날짜의 퇴실 기록 조회
     * @param gymNo 헬스장 번호
     * @param memberNo 회원 번호
     * @return 퇴실 기록
     */
    Attendance selectTodayCheckOut(@Param("gymNo") int gymNo, @Param("memberNo") int memberNo);
    
    /**
     * 출석 기록 삽입
     * @param attendance 출석 정보
     * @return 삽입된 행 수
     */
    int insertAttendance(Attendance attendance);
}

