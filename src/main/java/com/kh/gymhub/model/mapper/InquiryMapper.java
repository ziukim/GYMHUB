package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.InquiryReserve;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 방문예약 관련 데이터베이스 작업을 처리하는 Mapper 인터페이스
 */
@Mapper
public interface InquiryMapper {

    /**
     * 회원 번호로 예약 조회 (가장 최근 예약 1건)
     * @param memberNo 회원 번호
     * @return 예약 정보 (없으면 null)
     */
    InquiryReserve selectReserveByMemberNo(int memberNo);

    /**
     * 회원 번호와 헬스장 번호로 예약 조회
     * @param memberNo 회원 번호
     * @param gymNo 헬스장 번호
     * @return 예약 정보 (없으면 null)
     */
    InquiryReserve selectReserveByMemberAndGym(int memberNo, int gymNo);

    /**
     * 헬스장 번호로 예약된 시간대 조회
     * @param gymNo 헬스장 번호
     * @return 예약된 시간대 리스트
     */
    List<InquiryReserve> selectReservedTimesByGymNo(int gymNo);

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
    List<InquiryReserve> selectReservationsByGymNo(int gymNo);

    /**
     * 예약 상태 업데이트
     * @param inquiryNo 예약 번호
     * @param status 새로운 상태
     * @return 성공 시 1, 실패 시 0
     */
    int updateInquiryStatus(@Param("inquiryNo") int inquiryNo, @Param("status") String status);
}