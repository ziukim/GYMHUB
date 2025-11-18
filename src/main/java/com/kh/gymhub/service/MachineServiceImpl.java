package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.MachineMapper;
import com.kh.gymhub.model.vo.Machine;
import com.kh.gymhub.model.vo.MachineManage;
import jakarta.servlet.ServletContext;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class MachineServiceImpl implements MachineService {

    private final MachineMapper machineMapper;
    private final ServletContext servletContext;

    public MachineServiceImpl(MachineMapper machineMapper, ServletContext servletContext) {
        this.machineMapper = machineMapper;
        this.servletContext = servletContext;
    }

    @Override
    @Transactional
    public int insertMachine(MachineManage machineManage, MultipartFile file) {
        try {
            // 1. MACHINE 테이블에 기본 정보 저장
            Machine machine = Machine.builder()
                    .machineName(machineManage.getMachineName())
                    .brand(machineManage.getBrand())
                    .build();

            // 2. 이미지 파일이 있으면 저장
            if (file != null && !file.isEmpty()) {
                // 실제 서버의 절대 경로 가져오기
                String webPath = "/resources/uploadfiles/Machine/";
                String serverPath = servletContext.getRealPath(webPath);

                String changeName = saveFile(file, serverPath);
                machine.setMachinePhotoPath(webPath + changeName);
            }

            // 3. 기구 정보 등록
            int result = machineMapper.insertMachine(machine);

            // 4. MACHINE_MANAGE 테이블에 관리 정보 저장
            if (result > 0 && machine.getMachineNo() > 0) {
                machineManage.setMachineNo(machine.getMachineNo());
                machineManage.setMachineStatus("Y"); // 기본값

                // 점검일이 없으면 현재 날짜로 설정
                if (machineManage.getMachineCheckedDate() == null) {
                    machineManage.setMachineCheckedDate(new Date());
                }

                // 다음 점검일이 없으면 28일 후로 설정
                if (machineManage.getMachineNextCheck() == null) {
                    Date nextCheck = new Date(System.currentTimeMillis() + (28L * 24 * 60 * 60 * 1000));
                    machineManage.setMachineNextCheck(nextCheck);
                }

                result = machineMapper.insertMachineManage(machineManage);
            } else {
                throw new RuntimeException("기구 등록에 실패했습니다.");
            }

            return result;

        } catch (Exception e) {
            throw new RuntimeException("기구 등록에 실패했습니다: " + e.getMessage(), e);
        }
    }

    private String saveFile(MultipartFile file, String savePath) {
        // 파일명 생성: 현재시간 + UUID + 원본파일확장자
        String originName = file.getOriginalFilename();
        String ext = originName.substring(originName.lastIndexOf("."));

        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String uuid = UUID.randomUUID().toString().substring(0, 5);
        String changeName = currentTime + "_" + uuid + ext;

        try {
            // 저장 경로 디렉토리 생성
            File dir = new File(savePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 파일 저장
            File saveFile = new File(savePath, changeName);
            file.transferTo(saveFile);

        } catch (IOException e) {
            throw new RuntimeException("파일 저장에 실패했습니다.", e);
        }

        return changeName;
    }

    @Override
    public List<MachineManage> selectMachineListByGymNo(int gymNo) {
        return machineMapper.selectMachineListByGymNo(gymNo);
    }

    @Override
    public MachineManage selectMachineManageByNo(int machineManageNo) {
        return machineMapper.selectMachineManageByNo(machineManageNo);
    }

    @Override
    @Transactional
    public int updateMachineManage(MachineManage machineManage) {
        return machineMapper.updateMachineManage(machineManage);
    }

    @Override
    @Transactional
    public int deleteMachineManage(int machineManageNo) {
        return machineMapper.deleteMachineManage(machineManageNo);
    }

    @Override
    @Transactional
    public int updateMachineStatusToInspection() {
        return machineMapper.updateMachineStatusToInspection();
    }

    /**
     * 매일 자정에 다음 점검일이 오늘인 기구들의 상태를 점검중(I)으로 변경합니다.
     * CRON 표현식: 초 분 시 일 월 요일
     * "0 0 0 * * ?" = 매일 0시 0분 0초
     */
    @Scheduled(cron = "0 0 0 * * ?")
    public void scheduledMachineInspectionUpdate() {
        try {
            int updatedCount = this.updateMachineStatusToInspection();
            if (updatedCount > 0) {
                System.out.println("기구 점검 상태 업데이트 완료: " + updatedCount + "개 기구가 점검중 상태로 변경되었습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("기구 점검 상태 업데이트 중 오류 발생: " + e.getMessage());
        }
    }
}

