package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.MemberMapper;
import com.kh.gymhub.model.mapper.PtBookingMapper;
import com.kh.gymhub.model.mapper.PtScheduleMapper;
import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.model.vo.PtBookingData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Service
public class PtBookingServiceImpl implements PtBookingService {

    private final PtBookingMapper ptBookingMapper;
    private final MemberMapper memberMapper;
    private final PtScheduleMapper ptScheduleMapper;

    @Autowired
    public PtBookingServiceImpl(PtBookingMapper ptBookingMapper, 
                                MemberMapper memberMapper,
                                PtScheduleMapper ptScheduleMapper) {
        this.ptBookingMapper = ptBookingMapper;
        this.memberMapper = memberMapper;
        this.ptScheduleMapper = ptScheduleMapper;
    }

    @Override
    public PtBookingData getPtBookingData(Member loginMember) {
        // 1. 회원 정보 확인
        if (loginMember == null || loginMember.getGymNo() == null) {
            return PtBookingData.builder()
                    .trainerList(null)
                    .ptPassNo(null)
                    .remainingCount(0)
                    .build();
        }
        
        // 2. 해당 헬스장의 트레이너 목록 조회
        List<Member> trainerList = memberMapper.selectTrainersByGymNo(loginMember.getGymNo());
        
        // 3. 회원의 활성 PT 이용권 정보 조회
        Map<String, Object> ptPassInfo = ptScheduleMapper.selectActivePtPass(loginMember.getMemberNo());
        Integer ptPassNo = null;
        Integer totalCount = 0;
        Integer usedCount = 0;
        Integer remainingCount = 0;
        
        if (ptPassInfo != null) {
            ptPassNo = getIntegerValue(ptPassInfo.get("PT_PASS_NO"));
            totalCount = getIntegerValue(ptPassInfo.get("PT_TOTAL_COUNT"));
            usedCount = ptScheduleMapper.countCompletedPtReservations(ptPassNo);
            if (usedCount == null) {
                usedCount = 0;
            }
            remainingCount = totalCount - usedCount;
            if (remainingCount < 0) {
                remainingCount = 0;
            }
        }
        
        return PtBookingData.builder()
                .trainerList(trainerList)
                .ptPassNo(ptPassNo)
                .remainingCount(remainingCount)
                .build();
    }

    @Override
    public List<String> getBookedTimeSlots(int trainerNo, String reserveDate) {
        return ptBookingMapper.selectBookedTimeSlots(trainerNo, reserveDate);
    }

    @Override
    public boolean createPtReservation(int memberNo, int trainerNo, String reserveDateTime) {
        // 1. 회원의 PT 이용권 정보 조회
        Map<String, Object> ptPassInfo = ptScheduleMapper.selectActivePtPass(memberNo);
        if (ptPassInfo == null) {
            return false;
        }
        
        Integer ptPassNo = getIntegerValue(ptPassInfo.get("PT_PASS_NO"));
        if (ptPassNo == null || ptPassNo <= 0) {
            return false;
        }
        
        // 2. 날짜 시간 파싱
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        Timestamp reserveTime = null;
        try {
            reserveTime = new Timestamp(sdf.parse(reserveDateTime).getTime());
        } catch (ParseException e) {
            e.printStackTrace();
            return false;
        }
        
        // 3. PT 예약 신청
        int result = ptBookingMapper.insertPtReservation(ptPassNo, reserveTime, trainerNo);
        return result > 0;
    }
    
    /**
     * Object를 Integer로 안전하게 변환
     */
    private Integer getIntegerValue(Object value) {
        if (value == null) {
            return 0;
        }
        if (value instanceof Number) {
            return ((Number) value).intValue();
        }
        return 0;
    }
}

