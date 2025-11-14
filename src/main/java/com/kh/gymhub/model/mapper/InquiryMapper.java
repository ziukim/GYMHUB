package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.InquiryReserve;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface InquiryMapper {
    /**
     * 헬스장 번호로 승인된 미래 예약 목록 조회
     * @param gymNo 헬스장 번호
     * @return 승인된 미래 예약 목록
     */
    List<InquiryReserve> selectApprovedFutureReservationsByGymNo(@Param("gymNo") int gymNo);
    
    /**
     * 헬스장 번호로 '예약' 상태의 예약 목록 조회
     * @param gymNo 헬스장 번호
     * @return 예약 상태의 예약 목록
     */
    List<InquiryReserve> selectReservedInquiriesByGymNo(@Param("gymNo") int gymNo);
    
    /**
     * 예약 상태를 '완료'로 업데이트
     * @param inquiryNo 예약 번호
     * @return 업데이트된 행 수
     */
    int updateInquiryStatusToCompleted(@Param("inquiryNo") int inquiryNo);
}

