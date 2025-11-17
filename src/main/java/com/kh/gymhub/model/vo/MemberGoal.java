package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class MemberGoal {
    private int goalManageNo;
    private int memberNo;
    private int goalNo;
    private String goalTitle;
    private String goalStatus;
    private String goalDate;
}





