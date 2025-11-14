package com.kh.gymhub.model.vo;

import lombok.*;
import java.util.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class InquiryReserve {
<<<<<<< .merge_file_4FLqf4

    private int inquiryNo;
    private int gymNo;
    private int memberNo;
    private Date visitDatetime;
    private String inquiryStatus;
    private String inquiryMemo;

    // ✅ JOIN용 필드 추가
    private String memberName;
    private String memberPhone;
}
=======
    private int inquiryNo;           // 방문 예약 번호(PK)
    private int gymNo;               // 헬스장 번호(FK)
    private int memberNo;             // 회원 번호(FK)
    private Date visitDatetime;       // 방문 예정 일시
    private String request;           // 요청사항
    private String inquiryStatus;     // 예약 상태
    private String inquiryMemo;      // 메모
    
    // JOIN용 필드 (회원 이름, 전화번호)
    private String memberName;        // 회원 이름
    private String memberPhone;       // 회원 전화번호
}

>>>>>>> .merge_file_r3LUhv
