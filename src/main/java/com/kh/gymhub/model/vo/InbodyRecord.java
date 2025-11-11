package com.kh.gymhub.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class InbodyRecord {
    private int inbodyNo;
    private Date inbodyDate;
    private double weight;
    private double smm;        // 근육량
    private double pbf;        // 체지방률
    private double bmi;
    private int memberNo;
}