package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.model.vo.PtBookingData;

import java.util.List;

public interface PtBookingService {
    
    /**
     * PT 예약 페이지 데이터 조회
     * @param loginMember 로그인 회원
     * @return PT 예약 데이터
     */
    PtBookingData getPtBookingData(Member loginMember);
    
    /**
     * 특정 날짜/트레이너의 예약된 시간 조회
     * @param trainerNo 트레이너 번호
     * @param reserveDate 예약 날짜 (yyyy-MM-dd)
     * @return 예약된 시간 목록 (HH:mm)
     */
    List<String> getBookedTimeSlots(int trainerNo, String reserveDate);
    
    /**
     * PT 예약 신청
     * @param memberNo 회원 번호
     * @param trainerNo 희망 트레이너 번호
     * @param reserveDateTime 예약 날짜시간 (yyyy-MM-dd HH:mm)
     * @return 성공 여부
     */
    boolean createPtReservation(int memberNo, int trainerNo, String reserveDateTime);
}

