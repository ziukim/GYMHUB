package com.kh.gymhub.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Gym {
    private int gymNo;
    private String gymName;
    private String gymOwner;
    private String gymPhone;
    private String gymAddress;
    private String status;
    private Date gymCreateat;
    private Date gymUpdateat;
    private String gymPhotoPath;
    private int attCacheNo;

    // GYM_DETAIL 테이블과 JOIN용 추가 필드
    private String intro;              // 소개
    private String facilitiesInfo;     // 시설 정보
    private String detailAddress;      // 상세 주소
    private String weekBusinessHour;   // 평일 운영시간
    private String weekendBusinessHour; // 주말 운영시간
}
