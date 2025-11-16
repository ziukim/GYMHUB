package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.Attendance;
import com.kh.gymhub.model.vo.Member;

public interface AttendanceService {
    /**
     * 전화번호와 헬스장 번호로 회원 조회 (만료되지 않은 회원권 보유자만)
     * @param phone 전화번호
     * @param gymNo 헬스장 번호
     * @return 회원 정보
     */
    Member getMemberByPhoneAndGymNo(String phone, int gymNo);
    
    /**
     * 전화번호와 헬스장 번호로 트레이너 조회 (MEMBER_TYPE=2, GYM_NO 매칭)
     * @param phone 전화번호
     * @param gymNo 헬스장 번호
     * @return 트레이너 정보
     */
    Member getTrainerByPhoneAndGymNo(String phone, int gymNo);
    
    /**
     * 오늘 날짜의 입실 기록 조회
     * @param gymNo 헬스장 번호
     * @param memberNo 회원 번호
     * @return 입실 기록
     */
    Attendance getTodayCheckIn(int gymNo, int memberNo);
    
    /**
     * 오늘 날짜의 퇴실 기록 조회
     * @param gymNo 헬스장 번호
     * @param memberNo 회원 번호
     * @return 퇴실 기록
     */
    Attendance getTodayCheckOut(int gymNo, int memberNo);
    
    /**
     * 출석 기록 삽입
     * @param attendance 출석 정보
     * @return 삽입된 행 수
     */
    int insertAttendance(Attendance attendance);
    
    /**
     * 오늘 날짜의 현재 혼잡도 조회 (입실만 있고 퇴실이 없는 회원 수)
     * @param gymNo 헬스장 번호
     * @return 현재 이용 인원 수
     */
    Integer getTodayAttendanceCountByGymNo(int gymNo);
}

