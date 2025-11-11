package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.MachineMapper;
import com.kh.gymhub.model.vo.Machine;
import com.kh.gymhub.model.vo.MachineManage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class MachineServiceImpl implements MachineService {

    private final MachineMapper machineMapper;
    private final ServletContext servletContext;

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

                log.info("파일 저장 경로: {}", serverPath);

                String changeName = saveFile(file, serverPath);
                machine.setMachinePhotoPath(webPath + changeName);
            }

            // 3. 기구 정보 등록
            int result = machineMapper.insertMachine(machine);
            log.info("Machine 등록 결과: {}, machineNo: {}", result, machine.getMachineNo());

            // 4. MACHINE_MANAGE 테이블에 관리 정보 저장
            if (result > 0 && machine.getMachineNo() > 0) {
                machineManage.setMachineNo(machine.getMachineNo());
                machineManage.setMachineStatus("정상"); // 기본값

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
                log.info("MachineManage 등록 결과: {}", result);
            } else {
                log.error("Machine 등록 실패 또는 machineNo 미생성");
                throw new RuntimeException("기구 등록에 실패했습니다.");
            }

            return result;

        } catch (Exception e) {
            log.error("기구 등록 중 오류 발생", e);
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
                boolean created = dir.mkdirs();
                log.info("디렉토리 생성: {} - {}", savePath, created);
            }

            // 파일 저장
            File saveFile = new File(savePath, changeName);
            file.transferTo(saveFile);
            log.info("파일 저장 완료: {}", saveFile.getAbsolutePath());

        } catch (IOException e) {
            log.error("파일 저장 실패", e);
            throw new RuntimeException("파일 저장에 실패했습니다.", e);
        }

        return changeName;
    }

    @Override
    public List<MachineManage> selectMachineListByGymNo(int gymNo) {
        List<MachineManage> list = machineMapper.selectMachineListByGymNo(gymNo);
        log.info("조회된 기구 수: {}", list != null ? list.size() : 0);
        return list;
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
}