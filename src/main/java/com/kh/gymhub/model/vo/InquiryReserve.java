package com.kh.gymhub.model.vo;

import lombok.*;
import java.util.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class InquiryReserve {

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