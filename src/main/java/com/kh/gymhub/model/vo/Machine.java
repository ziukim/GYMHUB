package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 기구 정보 VO
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Machine {
    private int machineNo;              // 기구 번호(PK)
    private String machineName;         // 기구명
    private String brand;               // 브랜드
    private String machinePhotoPath;    // 기구 사진 경로
}
