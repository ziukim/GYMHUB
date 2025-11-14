package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.PtScheduleMapper;
import com.kh.gymhub.model.vo.PtReservation;
import com.kh.gymhub.model.vo.PtScheduleSummary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Service
public class PtScheduleServiceImpl implements PtScheduleService {

    private final PtScheduleMapper ptScheduleMapper;

    @Autowired
    public PtScheduleServiceImpl(PtScheduleMapper ptScheduleMapper) {
        this.ptScheduleMapper = ptScheduleMapper;
    }

    @Override
    public PtScheduleSummary getPtScheduleSummary(int memberNo) {
        // 1. 활성 PT 이용권 정보 조회
        Map<String, Object> ptPassInfo = ptScheduleMapper.selectActivePtPass(memberNo);
        
        if (ptPassInfo == null) {
            // PT 이용권이 없는 경우 기본값 반환
            return PtScheduleSummary.builder()
                    .totalCount(0)
                    .usedCount(0)
                    .remainingCount(0)
                    .progressRate(0.0)
                    .progressRateLabel("0%")
                    .endDateLabel("-")
                    .build();
        }
        
        // 2. PT 이용권 번호 및 전체 횟수
        Integer ptPassNo = getIntegerValue(ptPassInfo.get("PT_PASS_NO"));
        Integer totalCount = getIntegerValue(ptPassInfo.get("PT_TOTAL_COUNT"));
        
        // PT_END를 안전하게 Date로 변환
        Date ptEnd = null;
        Object ptEndObj = ptPassInfo.get("PT_END");
        if (ptEndObj != null) {
            if (ptEndObj instanceof java.sql.Timestamp) {
                ptEnd = new Date(((java.sql.Timestamp) ptEndObj).getTime());
            } else if (ptEndObj instanceof Date) {
                ptEnd = (Date) ptEndObj;
            }
        }
        
        // 3. 사용 완료 횟수 조회
        Integer usedCount = ptScheduleMapper.countCompletedPtReservations(ptPassNo);
        if (usedCount == null) {
            usedCount = 0;
        }
        
        // 4. 남은 횟수 계산
        int remainingCount = totalCount - usedCount;
        if (remainingCount < 0) {
            remainingCount = 0;
        }
        
        // 5. 진행률 계산
        double progressRate = 0.0;
        if (totalCount > 0) {
            progressRate = (double) usedCount / totalCount * 100;
        }
        
        // 6. 진행률 레이블
        String progressRateLabel = String.format("%.0f%%", progressRate);
        
        // 7. 만료일 레이블
        String endDateLabel = "-";
        if (ptEnd != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
            endDateLabel = sdf.format(ptEnd);
        }
        
        // 8. 예약 정보 조회
        PtReservation upcomingReservation = ptScheduleMapper.selectUpcomingReservation(ptPassNo);
        if (upcomingReservation != null) {
            formatReservationTime(upcomingReservation);
        }
        
        List<PtReservation> scheduledPtList = ptScheduleMapper.selectScheduledPtList(ptPassNo);
        for (PtReservation reservation : scheduledPtList) {
            formatReservationTime(reservation);
        }
        
        List<PtReservation> completedPtList = ptScheduleMapper.selectCompletedPtList(ptPassNo);
        for (PtReservation reservation : completedPtList) {
            formatReservationTime(reservation);
        }
        
        // 9. 결과 반환
        return PtScheduleSummary.builder()
                .ptPassNo(ptPassNo)
                .totalCount(totalCount)
                .usedCount(usedCount)
                .remainingCount(remainingCount)
                .progressRate(progressRate)
                .progressRateLabel(progressRateLabel)
                .ptEnd(ptEnd)
                .endDateLabel(endDateLabel)
                .upcomingReservation(upcomingReservation)
                .scheduledPtList(scheduledPtList)
                .completedPtList(completedPtList)
                .build();
    }
    
    /**
     * 예약 시간 포맷팅
     */
    private void formatReservationTime(PtReservation reservation) {
        if (reservation == null || reservation.getPtReserveTime() == null) {
            return;
        }
        
        Timestamp reserveTime = reservation.getPtReserveTime();
        SimpleDateFormat sdfFull = new SimpleDateFormat("yyyy.MM.dd HH:mm");
        SimpleDateFormat sdfDate = new SimpleDateFormat("yyyy년 M월 d일");
        SimpleDateFormat sdfHour = new SimpleDateFormat("HH:mm");
        
        reservation.setReserveTimeLabel(sdfFull.format(reserveTime));
        reservation.setReserveDateLabel(sdfDate.format(reserveTime));
        reservation.setReserveHourLabel(sdfHour.format(reserveTime));
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

