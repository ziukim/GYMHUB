package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Locker {
    private int lockerNo;
    private int gymNo;
    private String lockerRealNum;
    private String lockerStatus;
}

