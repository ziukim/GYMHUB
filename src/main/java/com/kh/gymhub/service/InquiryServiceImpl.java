package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.InquiryMapper;
<<<<<<< HEAD
import com.kh.gymhub.model.mapper.InquiryMapper;
import com.kh.gymhub.model.vo.InquiryReserve;
import org.springframework.beans.factory.annotation.Autowired;
=======
import com.kh.gymhub.model.vo.InquiryReserve;
>>>>>>> d0982fa5179d205f92ac84af68dbd1819ce5da0d
import org.springframework.stereotype.Service;

import java.util.List;

<<<<<<< HEAD
/**
 * InquiryService 구현체
 */
=======
>>>>>>> d0982fa5179d205f92ac84af68dbd1819ce5da0d
@Service
public class InquiryServiceImpl implements InquiryService {

    private final InquiryMapper inquiryMapper;

<<<<<<< HEAD
    @Autowired
=======
>>>>>>> d0982fa5179d205f92ac84af68dbd1819ce5da0d
    public InquiryServiceImpl(InquiryMapper inquiryMapper) {
        this.inquiryMapper = inquiryMapper;
    }

<<<<<<< HEAD
    /**
     * 회원 번호로 예약 조회
     */
    @Override
    public InquiryReserve getReserveByMemberNo(int memberNo) {
        // 1. 회원 번호 유효성 검사
        if (memberNo <= 0) {
            return null;
        }

        // 2. 예약 정보 조회
        InquiryReserve reserve = inquiryMapper.selectReserveByMemberNo(memberNo);

        // 3. 결과 반환
        return reserve;
    }

    /**
     * 회원 번호와 헬스장 번호로 예약 조회
     */
    @Override
    public InquiryReserve getReserveByMemberAndGym(int memberNo, int gymNo) {
        // 1. 파라미터 유효성 검사
        if (memberNo <= 0 || gymNo <= 0) {
            return null;
        }

        // 2. 예약 정보 조회
        InquiryReserve reserve = inquiryMapper.selectReserveByMemberAndGym(memberNo, gymNo);

        // 3. 결과 반환
        return reserve;
    }

    /**
     * 헬스장 번호로 예약된 시간대 조회
     */
    @Override
    public List<InquiryReserve> getReservedTimesByGymNo(int gymNo) {
        // 1. 헬스장 번호 유효성 검사
        if (gymNo <= 0) {
            return null;
        }

        // 2. 예약된 시간대 조회
        List<InquiryReserve> reservedTimes = inquiryMapper.selectReservedTimesByGymNo(gymNo);

        // 3. 결과 반환
        return reservedTimes;
    }

    /**
     * 예약 정보 저장
     */
    @Override
    public int insertReserve(InquiryReserve reserve) {
        // 1. 예약 정보 유효성 검사
        if (reserve == null) {
            return 0;
        }

        if (reserve.getGymNo() <= 0 || reserve.getMemberNo() <= 0) {
            return 0;
        }

        if (reserve.getVisitDatetime() == null) {
            return 0;
        }

        // 2. 예약 상태 기본값 설정
        if (reserve.getInquiryStatus() == null || reserve.getInquiryStatus().isEmpty()) {
            reserve.setInquiryStatus("대기");
        }

        // 3. 예약 정보 저장
        int result = 0;
        try {
            result = inquiryMapper.insertReserve(reserve);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("예약 저장 중 오류 발생: " + e.getMessage());
        }

        // 4. 결과 반환
        return result;
    }

    /**
     * 예약 정보 수정
     */
    @Override
    public int updateReserve(InquiryReserve reserve) {
        // 1. 예약 정보 유효성 검사
        if (reserve == null || reserve.getInquiryNo() <= 0) {
            return 0;
        }

        // 2. 예약 정보 수정
        int result = 0;
        try {
            result = inquiryMapper.updateReserve(reserve);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("예약 수정 중 오류 발생: " + e.getMessage());
        }

        // 3. 결과 반환
        return result;
    }

    /**
     * 예약 삭제
     */
    @Override
    public int deleteReserve(int inquiryNo) {
        // 1. 예약 번호 유효성 검사
        if (inquiryNo <= 0) {
            return 0;
        }

        // 2. 예약 삭제
        int result = 0;
        try {
            result = inquiryMapper.deleteReserve(inquiryNo);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("예약 삭제 중 오류 발생: " + e.getMessage());
        }

        // 3. 결과 반환
        return result;
    }

    @Override
    public List<InquiryReserve> getReservationsByGymNo(int gymNo) {
        return inquiryMapper.selectReservationsByGymNo(gymNo);
    }

    @Override
    public int updateInquiryStatus(int inquiryNo, String status) {
        return inquiryMapper.updateInquiryStatus(inquiryNo, status);
    }
}
=======
    @Override
    public List<InquiryReserve> getApprovedFutureReservationsByGymNo(int gymNo) {
        return inquiryMapper.selectApprovedFutureReservationsByGymNo(gymNo);
    }

    @Override
    public List<InquiryReserve> getReservedInquiriesByGymNo(int gymNo) {
        return inquiryMapper.selectReservedInquiriesByGymNo(gymNo);
    }

    @Override
    public int updateInquiryStatusToCompleted(int inquiryNo) {
        return inquiryMapper.updateInquiryStatusToCompleted(inquiryNo);
    }
}

>>>>>>> d0982fa5179d205f92ac84af68dbd1819ce5da0d
