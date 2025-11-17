package com.kh.gymhub.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class AttCache {
    private int cacheDetailNo;
    private int gymNo;
    private Date cacheDate;
    private String timeSlot;  // 예: "06-08", "08-10", "10-12", ...
    private int memberCount;   // 해당 시간대 평균 인원수
}

