package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.MachineManage;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * 기구 관리 Service 인터페이스
 */
public interface MachineService {

    /**
     * 기구 등록 (이미지 포함)
     * @param machineManage 기구 관리 정보
     * @param file 이미지 파일
     * @return 성공 여부
     */
    int insertMachine(MachineManage machineManage, MultipartFile file);

    /**
     * 특정 헬스장의 기구 목록 조회
     * @param gymNo 헬스장 번호
     * @return 기구 관리 목록
     */
    List<MachineManage> selectMachineListByGymNo(int gymNo);

    /**
     * 기구 관리 정보 상세 조회
     * @param machineManageNo 기구 관리 번호
     * @return 기구 관리 정보
     */
    MachineManage selectMachineManageByNo(int machineManageNo);

    /**
     * 기구 관리 정보 수정 (점검일, 다음점검일, 상태)
     * @param machineManage 기구 관리 정보
     * @return 수정 성공 여부
     */
    int updateMachineManage(MachineManage machineManage);

    /**
     * 기구 삭제
     * @param machineManageNo 기구 관리 번호
     * @return 삭제 성공 여부
     */
    int deleteMachineManage(int machineManageNo);
}
