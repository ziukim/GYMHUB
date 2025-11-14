package com.kh.gymhub.model.vo;

import lombok.*;
import java.util.Date;

/**
 * INQUIRY_RESERVE 테이블과 매핑되는 VO 클래스
 */
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class InquiryReserve {

    private int inquiryNo;        // 방문 예약 번호(PK)
    private int gymNo;            // 헬스장 번호(FK)
    private int memberNo;         // 회원 번호(FK)
    private Date visitDatetime;   // 방문 예정 일시
    private String inquiryStatus; // 예약 상태
    private String inquiryMemo;   // 메모 (사용 안 하면 제거해도 됨)

}