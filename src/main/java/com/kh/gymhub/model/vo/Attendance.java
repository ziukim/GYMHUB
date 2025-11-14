package com.kh.gymhub.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Attendance {
    private int attendanceNo;
    private int gymNo;
    private int memberNo;
    private String checkInInfo;  // '입실' 또는 '퇴실'
    private Date attendanceDate;

    // 통계용 추가 필드
    private String attendanceDateStr;  // 출석일 (포맷된 문자열)
    private String checkInTime;        // 입장 시간
    private String checkOutTime;       // 퇴장 시간
    private String exerciseDuration;   // 운동 시간
}