package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.InquiryReserve;

import java.util.List;

/**
 * 방문예약 관련 비즈니스 로직을 처리하는 서비스 인터페이스
 */
public interface InquiryService {

    /**
     * 회원 번호로 예약 조회
     * @param memberNo 회원 번호
     * @return 예약 정보 (없으면 null)
     */
    InquiryReserve getReserveByMemberNo(int memberNo);

    /**
     * 회원 번호와 헬스장 번호로 예약 조회
     * @param memberNo 회원 번호
     * @param gymNo 헬스장 번호
     * @return 예약 정보 (없으면 null)
     */
    InquiryReserve getReserveByMemberAndGym(int memberNo, int gymNo);

    /**
     * 헬스장 번호로 예약된 시간대 조회
     * @param gymNo 헬스장 번호
     * @return 예약된 시간대 리스트
     */
    List<InquiryReserve> getReservedTimesByGymNo(int gymNo);

    /**
     * 예약 정보 저장
     * @param reserve 예약 정보
     * @return 성공 시 1, 실패 시 0
     */
    int insertReserve(InquiryReserve reserve);

    /**
     * 예약 정보 수정
     * @param reserve 예약 정보
     * @return 성공 시 1, 실패 시 0
     */
    int updateReserve(InquiryReserve reserve);

    /**
     * 예약 삭제
     * @param inquiryNo 예약 번호
     * @return 성공 시 1, 실패 시 0
     */
    int deleteReserve(int inquiryNo);

    /**
     * 헬스장 번호로 모든 예약 조회
     * @param gymNo 헬스장 번호
     * @return 예약 목록
     */
    List<InquiryReserve> getReservationsByGymNo(int gymNo);

    /**
     * 예약 상태 업데이트
     * @param inquiryNo 예약 번호
     * @param status 새로운 상태
     * @return 성공 시 1, 실패 시 0
     */
    int updateInquiryStatus(int inquiryNo, String status);
    
    /**
     * 날짜별 예약 상담 조회 (헬스장별)
     * @param gymNo 헬스장 번호
     * @param reserveDate 예약 날짜 (YYYY-MM-DD)
     * @return 예약 목록
     */
    List<InquiryReserve> getReservationsByGymNoAndDate(int gymNo, String reserveDate);
}