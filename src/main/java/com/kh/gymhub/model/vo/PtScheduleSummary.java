package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PtScheduleSummary {
    // PT 이용권 정보
    private Integer ptPassNo;
    private Integer totalCount;       // 전체 PT 횟수
    private Integer usedCount;        // 사용 완료 횟수
    private Integer remainingCount;   // 남은 횟수
    private Date ptEnd;               // 만료일
    
    // 계산된 값
    private double progressRate;      // 진행률 (0-100)
    private String progressRateLabel; // 진행률 레이블 (예: "60%")
    private String endDateLabel;      // 만료일 레이블 (예: "2025.12.31")
}

