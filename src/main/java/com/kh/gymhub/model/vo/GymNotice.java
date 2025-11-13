package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import java.sql.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class GymNotice {
    private int noticeNo;
    private String noticeTitle;
    private String noticeWriter;
    private String noticeCategory;
    private String noticeContent;
    private Date noticeDate;
    private String noticeFixStatus;
    private String filePath;
    private int gymNo;
}
