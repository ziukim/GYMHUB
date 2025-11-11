package com.kh.gymhub.model.vo;

import lombok.*;
import java.sql.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Member {
    private int memberNo;
    private Integer memberType; // 1:일반, 2:트레이너, 3:헬스장운영자
    private String memberId;
    private String memberPwd;
    private String memberName;
    private String memberAddress;
    private String memberPhone;
    private Date memberBirth;
    private String status;
    private Date memberCreateat;
    private Date memberUpdateat;
    private String memberEmail;
    private String memberPhotoPath;
    private Integer gymNo;
    private String trainerLicense;
    private String trainerCareer;
    private String trainerAward;
}

