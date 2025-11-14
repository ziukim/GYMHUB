package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Attendance {
    private int attendanceNo;
    private int gymNo;
    private int memberNo;
    private String checkInInfo;
    private Date attendanceDate;
}

