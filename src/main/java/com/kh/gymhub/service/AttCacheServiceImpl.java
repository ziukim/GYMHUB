package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.AttCacheMapper;
import com.kh.gymhub.model.vo.AttCache;
import com.kh.gymhub.model.vo.Gym;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

@Service
public class AttCacheServiceImpl implements AttCacheService {

    private final AttCacheMapper attCacheMapper;
    private final GymService gymService;

    @Autowired
    public AttCacheServiceImpl(AttCacheMapper attCacheMapper, GymService gymService) {
        this.attCacheMapper = attCacheMapper;
        this.gymService = gymService;
    }

    @Override
    public int insertAttCache(AttCache attCache) {
        return attCacheMapper.insertAttCache(attCache);
    }

    @Override
    public List<Map<String, Object>> getCongestionByGymNo(int gymNo, int days) {
        return attCacheMapper.selectCongestionByGymNo(gymNo, days);
    }

    @Override
    public List<Map<String, Object>> getCongestionByGymNo(int gymNo) {
        return getCongestionByGymNo(gymNo, 7); // 기본 7일 평균
    }

    @Override
    public List<AttCache> getCongestionByGymNoAndDate(int gymNo, Date cacheDate) {
        return attCacheMapper.selectCongestionByGymNoAndDate(gymNo, cacheDate);
    }

    @Override
    public int calculateAndSaveCongestion(int gymNo, Date targetDate) {
        // 시간대 목록: 06-08, 08-10, 10-12, 12-14, 14-16, 16-18, 18-20, 20-22, 22-24
        String[] timeSlots = {"06-08", "08-10", "10-12", "12-14", "14-16", "16-18", "18-20", "20-22", "22-24"};
        
        int savedCount = 0;
        
        // 각 시간대별로 평균 혼잡도 계산 및 저장
        for (String timeSlot : timeSlots) {
            // 시간대의 시작 시간과 종료 시간 추출
            int startHour = Integer.parseInt(timeSlot.substring(0, 2));
            int endHour = Integer.parseInt(timeSlot.substring(3, 5));
            
            // 시작 날짜/시간과 종료 날짜/시간 설정
            Calendar startCal = Calendar.getInstance();
            startCal.setTime(targetDate);
            startCal.set(Calendar.HOUR_OF_DAY, startHour);
            startCal.set(Calendar.MINUTE, 0);
            startCal.set(Calendar.SECOND, 0);
            startCal.set(Calendar.MILLISECOND, 0);
            
            Calendar endCal = Calendar.getInstance();
            endCal.setTime(targetDate);
            endCal.set(Calendar.HOUR_OF_DAY, endHour);
            endCal.set(Calendar.MINUTE, 0);
            endCal.set(Calendar.SECOND, 0);
            endCal.set(Calendar.MILLISECOND, 0);
            
            Date startDate = new Date(startCal.getTimeInMillis());
            Date endDate = new Date(endCal.getTimeInMillis());
            
            // 평균 혼잡도 계산
            Integer avgCount = attCacheMapper.calculateAverageCountByTimeSlot(
                    gymNo, startDate, endDate, timeSlot);
            
            if (avgCount == null) {
                avgCount = 0;
            }
            
            // ATT_CACHE 테이블에 저장
            AttCache attCache = new AttCache();
            attCache.setGymNo(gymNo);
            attCache.setCacheDate(targetDate);
            attCache.setTimeSlot(timeSlot);
            attCache.setMemberCount(avgCount);
            
            int result = attCacheMapper.insertAttCache(attCache);
            if (result > 0) {
                savedCount++;
            }
        }
        
        return savedCount;
    }

    /**
     * 매일 새벽 2시에 전날(어제) 데이터를 집계하여 ATT_CACHE 테이블에 저장합니다.
     * CRON 표현식: 초 분 시 일 월 요일
     * "0 0 2 * * ?" = 매일 02시 00분 00초
     * 
     * 실행 시간: 매일 새벽 2시
     * 집계 대상: 전날(어제)의 ATTENDANCE 데이터
     * 집계 방식: 각 헬스장별로 9개 시간대(06-08, 08-10, ..., 22-24)의 평균 인원수 계산
     */
    @Scheduled(cron = "0 0 2 * * ?")
    public void scheduledCongestionCalculation() {
        try {
            System.out.println("[혼잡도 집계 스케줄러] 시작: " + new java.util.Date());
            
            // 모든 헬스장 조회
            List<Gym> gyms = gymService.getAllGyms();
            
            if (gyms == null || gyms.isEmpty()) {
                System.out.println("[혼잡도 집계 스케줄러] 집계할 헬스장이 없습니다.");
                return;
            }
            
            // 전날 날짜 계산
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DAY_OF_MONTH, -1);
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MILLISECOND, 0);
            Date yesterday = new Date(cal.getTimeInMillis());
            
            int totalProcessed = 0;
            int totalSaved = 0;
            
            // 각 헬스장별로 전날 데이터 집계
            for (Gym gym : gyms) {
                try {
                    // 이미 해당 날짜의 데이터가 있는지 확인
                    List<AttCache> existingData = attCacheMapper.selectCongestionByGymNoAndDate(
                            gym.getGymNo(), yesterday);
                    
                    // 이미 데이터가 있으면 스킵 (중복 집계 방지)
                    if (existingData != null && !existingData.isEmpty()) {
                        System.out.println("[혼잡도 집계 스케줄러] 헬스장 " + gym.getGymNo() + 
                                " (" + gym.getGymName() + ") - 이미 집계된 데이터가 있습니다. 스킵합니다.");
                        continue;
                    }
                    
                    // 전날 데이터 집계 및 저장
                    int savedCount = calculateAndSaveCongestion(gym.getGymNo(), yesterday);
                    
                    totalProcessed++;
                    totalSaved += savedCount;
                    
                    System.out.println("[혼잡도 집계 스케줄러] 헬스장 " + gym.getGymNo() + 
                            " (" + gym.getGymName() + ") - " + savedCount + "개 시간대 데이터 저장 완료");
                    
                } catch (Exception e) {
                    System.err.println("[혼잡도 집계 스케줄러] 헬스장 " + gym.getGymNo() + 
                            " 집계 중 오류 발생: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            
            System.out.println("[혼잡도 집계 스케줄러] 완료: " + totalProcessed + "개 헬스장 처리, " + 
                    totalSaved + "개 레코드 저장");
            
        } catch (Exception e) {
            System.err.println("[혼잡도 집계 스케줄러] 전체 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 서버 시작 시 실행되는 초기화 메서드
     * 누락된 집계 데이터를 확인하고 자동으로 처리합니다.
     * 
     * 최근 7일간의 데이터를 확인하여 누락된 날짜가 있으면 집계를 수행합니다.
     * 이렇게 하면 서버가 다운되어 있었거나 새로 시작했을 때도 누락된 데이터를 복구할 수 있습니다.
     * 
     * ApplicationReadyEvent를 사용하여 모든 빈이 초기화된 후에 실행됩니다.
     */
    @EventListener(ApplicationReadyEvent.class)
    public void initializeMissingAggregations() {
        try {
            System.out.println("[혼잡도 집계 초기화] 서버 시작 시 누락된 집계 데이터 확인 시작");
            
            // 모든 헬스장 조회
            List<Gym> gyms = gymService.getAllGyms();
            
            if (gyms == null || gyms.isEmpty()) {
                System.out.println("[혼잡도 집계 초기화] 집계할 헬스장이 없습니다.");
                return;
            }
            
            // 최근 7일간의 데이터 확인 (오늘 제외, 어제부터 7일 전까지)
            Calendar cal = Calendar.getInstance();
            cal.set(Calendar.HOUR_OF_DAY, 0);
            cal.set(Calendar.MINUTE, 0);
            cal.set(Calendar.SECOND, 0);
            cal.set(Calendar.MILLISECOND, 0);
            
            int totalProcessed = 0;
            int totalSaved = 0;
            
            // 각 헬스장별로 누락된 집계 확인 및 처리
            for (Gym gym : gyms) {
                try {
                    int gymProcessed = 0;
                    int gymSaved = 0;
                    
                    // 최근 7일간 확인 (어제부터 7일 전까지)
                    for (int dayOffset = 1; dayOffset <= 7; dayOffset++) {
                        Calendar targetCal = (Calendar) cal.clone();
                        targetCal.add(Calendar.DAY_OF_MONTH, -dayOffset);
                        Date targetDate = new Date(targetCal.getTimeInMillis());
                        
                        // 해당 날짜의 데이터가 있는지 확인
                        List<AttCache> existingData = attCacheMapper.selectCongestionByGymNoAndDate(
                                gym.getGymNo(), targetDate);
                        
                        // 데이터가 없으면 집계 수행
                        if (existingData == null || existingData.isEmpty()) {
                            System.out.println("[혼잡도 집계 초기화] 헬스장 " + gym.getGymNo() + 
                                    " (" + gym.getGymName() + ") - " + targetDate + " 데이터 누락 발견, 집계 시작");
                            
                            int savedCount = calculateAndSaveCongestion(gym.getGymNo(), targetDate);
                            gymProcessed++;
                            gymSaved += savedCount;
                            
                            System.out.println("[혼잡도 집계 초기화] 헬스장 " + gym.getGymNo() + 
                                    " (" + gym.getGymName() + ") - " + targetDate + " 집계 완료 (" + savedCount + "개 시간대)");
                        }
                    }
                    
                    if (gymProcessed > 0) {
                        totalProcessed += gymProcessed;
                        totalSaved += gymSaved;
                        System.out.println("[혼잡도 집계 초기화] 헬스장 " + gym.getGymNo() + 
                                " (" + gym.getGymName() + ") - 총 " + gymProcessed + "일치 데이터 복구 완료");
                    }
                    
                } catch (Exception e) {
                    System.err.println("[혼잡도 집계 초기화] 헬스장 " + gym.getGymNo() + 
                            " 처리 중 오류 발생: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            
            if (totalProcessed > 0) {
                System.out.println("[혼잡도 집계 초기화] 완료: " + totalProcessed + "일치 데이터 복구, " + 
                        totalSaved + "개 레코드 저장");
            } else {
                System.out.println("[혼잡도 집계 초기화] 완료: 누락된 데이터가 없습니다.");
            }
            
        } catch (Exception e) {
            System.err.println("[혼잡도 집계 초기화] 전체 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

