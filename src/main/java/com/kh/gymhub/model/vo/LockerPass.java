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
public class LockerPass {
    private int lockerPassNo;
    private int purchaseNo;
    private int lockerNo;
    private int memberNo;
    private Date lockerPassStart;
    private Date lockerEnd;
    private String lockerPassStatus;

    // From LOCKER table
    private String lockerRealNum;
    private String lockerStatus;

    // From MEMBER table
    private String memberName;
}
