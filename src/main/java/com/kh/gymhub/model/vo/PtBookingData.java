package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PtBookingData {
    private List<Member> trainerList;  // 헬스장의 트레이너 목록
    private Integer ptPassNo;           // 회원의 PT 이용권 번호
    private Integer remainingCount;     // 남은 PT 횟수
}

