package com.kh.gymhub.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * 기구 관리 정보 VO (헬스장별 기구 관리)
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MachineManage {
    private int machineManageNo;        // 머신 관리 번호(PK)
    private int gymNo;                  // 헬스장 번호(FK)
    private int machineNo;              // 기구 번호(FK)
    private Date machineCheckedDate;    // 점검일
    private Date machineNextCheck;      // 다음 점검일
    private String machineStatus;       // 기구 상태(정상/점검/고장)

    // JOIN용 필드
    private String machineName;         // 기구명
    private String brand;               // 브랜드
    private String machinePhotoPath;    // 기구 사진 경로
}