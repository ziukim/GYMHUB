package com.kh.gymhub.model.vo;

import lombok.*;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class GymDetail {
    private int gymDetailNo;
    private String intro;
    private String facilitiesInfo;
    private String detailAddress;
    private String weekBusinessHour;
    private String weekendBusinessHour;
    private int gymNo;
}

