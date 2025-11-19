package com.kh.gymhub.model.vo;

import lombok.*;
import java.util.Date;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PtReserve {
    private int ptReserveNo;
    private int ptPassNo;
    private Date ptReserveTime;
    private Integer ptTrainer; // 희망 트레이너 회원번호 (NULL 가능)
    private int ptTrainerNo; // 배정된 트레이너 회원번호
    private String ptReserveStatus; // 대기중, 승인됨, 거절됨
    
    // 조인을 위한 필드
    private String memberName; // 회원 이름
    private String memberPhone; // 회원 전화번호
    private String memberPhotoPath; // 회원 프로필 사진 경로
    private String trainerName; // 배정된 트레이너 이름
    private String desiredTrainerName; // 희망 트레이너 이름
    private int memberNo; // 회원 번호
    private int gymNo; // 헬스장 번호
}

