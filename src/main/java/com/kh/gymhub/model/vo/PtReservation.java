package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PtReservation {
    private Integer ptReserveNo;        // PT 예약 번호
    private Integer ptPassNo;           // PT 이용권 번호
    private Timestamp ptReserveTime;    // 예약 시간
    private Integer memberNo;           // 희망 트레이너 번호
    private Integer ptTrainerNo;        // 확정 트레이너 번호
    private String ptReserveStatus;     // 예약 상태 (대기중/승인됨/거절됨)
    
    // 희망 트레이너 정보 (대기중일 때)
    private String desiredTrainerName;
    private String desiredTrainerPhotoPath;
    private String desiredTrainerPhone;
    private String desiredTrainerEmail;
    private String desiredTrainerLicense;
    
    // 확정 트레이너 정보 (승인됨일 때)
    private String confirmedTrainerName;
    private String confirmedTrainerPhotoPath;
    private String confirmedTrainerPhone;
    private String confirmedTrainerEmail;
    private String confirmedTrainerLicense;
    
    // 포맷된 정보
    private String reserveTimeLabel;    // 예약 시간 레이블 (yyyy.MM.dd HH:mm)
    private String reserveDateLabel;    // 예약 날짜 레이블 (yyyy년 M월 d일)
    private String reserveHourLabel;    // 예약 시간 레이블 (HH:mm)
}

