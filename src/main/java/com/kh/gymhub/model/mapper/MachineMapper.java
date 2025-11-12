package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Machine;
import com.kh.gymhub.model.vo.MachineManage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 기구 관리 Mapper 인터페이스
 */
@Mapper
public interface MachineMapper {

    /**
     * 기구 정보 등록 (MACHINE 테이블)
     * @param machine 기구 정보
     * @return 등록된 행 수
     */
    int insertMachine(Machine machine);

    /**
     * 헬스장에 기구 추가 (MACHINE_MANAGE 테이블)
     * @param machineManage 기구 관리 정보
     * @return 등록된 행 수
     */
    int insertMachineManage(MachineManage machineManage);

    /**
     * 특정 헬스장의 기구 목록 조회 (JOIN)
     * @param gymNo 헬스장 번호
     * @return 기구 관리 목록
     */
    List<MachineManage> selectMachineListByGymNo(@Param("gymNo") int gymNo);

    /**
     * 기구 관리 정보 조회
     * @param machineManageNo 기구 관리 번호
     * @return 기구 관리 정보
     */
    MachineManage selectMachineManageByNo(@Param("machineManageNo") int machineManageNo);

    /**
     * 기구 관리 정보 수정 (점검일, 다음점검일, 상태)
     * @param machineManage 기구 관리 정보
     * @return 수정된 행 수
     */
    int updateMachineManage(MachineManage machineManage);

    /**
     * 기구 삭제 (MACHINE_MANAGE에서만 삭제)
     * @param machineManageNo 기구 관리 번호
     * @return 삭제된 행 수
     */
    int deleteMachineManage(@Param("machineManageNo") int machineManageNo);
}

