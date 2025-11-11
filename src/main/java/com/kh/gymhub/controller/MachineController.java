package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.LockerPass;
import com.kh.gymhub.model.vo.MachineManage;
import com.kh.gymhub.service.LockerService;
import com.kh.gymhub.service.MachineService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MachineController {

    private final MachineService machineService;
    private final LockerService lockerService;

    /**
     * 기구 및 락커 목록 페이지 이동
     */
    @GetMapping("/machineList.gym")
    public String machineList(HttpSession session, Model model) {
        Integer gymNo = (Integer) session.getAttribute("gymNo");

        log.info("=== 시설 목록 조회 시작 ===");
        log.info("세션 gymNo: {}", gymNo);

        if (gymNo == null) {
            log.warn("세션에 gymNo가 없습니다!");
            // 테스트용: gymNo가 없으면 1번으로 설정 (실제 환경에서는 제거)
            gymNo = 1;
            log.info("테스트용 gymNo 설정: 1");
        }

        try {
            // 1. 기구 목록 조회
            List<MachineManage> machineList = machineService.selectMachineListByGymNo(gymNo);
            log.info("조회된 기구 목록 크기: {}", machineList != null ? machineList.size() : 0);
            model.addAttribute("machineList", machineList);

            // 2. 락커 목록 조회
            List<LockerPass> lockerPassList = lockerService.selectLockerPassListByGymNo(gymNo);
            log.info("조회된 락커 목록 크기: {}", lockerPassList != null ? lockerPassList.size() : 0);
            model.addAttribute("lockerPassList", lockerPassList);

            return "gym/gymFacilitiesBoard";

        } catch (Exception e) {
            log.error("시설 목록 조회 중 오류", e);
            model.addAttribute("errorMsg", "시설 목록을 불러오는데 실패했습니다.");
            return "gym/gymFacilitiesBoard";
        }
    }

    /**
     * 기구 등록 폼 페이지
     */
    @GetMapping("/machineEnrollForm.gym")
    public String machineEnrollForm(HttpSession session, RedirectAttributes ra) {
        Integer gymNo = (Integer) session.getAttribute("gymNo");

        log.info("기구 등록 폼 접근 - gymNo: {}", gymNo);

        if (gymNo == null) {
            // 테스트용: gymNo가 없으면 1번으로 설정
            session.setAttribute("gymNo", 1);
            log.info("테스트용 gymNo 세션 설정: 1");
        }

        return "gym/gymMachineEnrollForm";
    }

    /**
     * 기구 등록 처리 - AJAX용으로 @ResponseBody 추가
     */
    @PostMapping("/machineInsert.gym")
    @ResponseBody
    public String insertMachine(@RequestParam("machineImage") MultipartFile file,
                                @RequestParam("machineName") String machineName,
                                @RequestParam("brand") String brand,
                                HttpSession session) {

        Integer gymNo = (Integer) session.getAttribute("gymNo");

        log.info("=== 기구 등록 요청 시작 ===");
        log.info("gymNo: {}, machineName: {}, brand: {}", gymNo, machineName, brand);
        log.info("파일명: {}, 파일크기: {}", file.getOriginalFilename(), file.getSize());

        if (gymNo == null) {
            log.error("세션에 gymNo가 없습니다!");
            // 테스트용
            gymNo = 1;
            log.info("테스트용 gymNo 설정: 1");
        }

        if (file == null || file.isEmpty()) {
            log.error("업로드된 파일이 없습니다");
            return "no_file";
        }

        if (file.getSize() > 10 * 1024 * 1024) {
            log.error("파일 크기 초과: {}", file.getSize());
            return "file_too_large";
        }

        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            log.error("이미지 파일이 아닙니다: {}", contentType);
            return "invalid_file_type";
        }

        try {
            MachineManage machineManage = new MachineManage();
            machineManage.setGymNo(gymNo);
            machineManage.setMachineName(machineName);
            machineManage.setBrand(brand);

            log.info("서비스 호출 전 - machineManage: {}", machineManage);

            int result = machineService.insertMachine(machineManage, file);

            log.info("서비스 호출 결과: {}", result);

            if (result > 0) {
                log.info("기구 등록 성공!");
                return "success";
            } else {
                log.error("기구 등록 실패 - result: {}", result);
                return "fail";
            }

        } catch (Exception e) {
            log.error("기구 등록 중 예외 발생", e);
            return "error: " + e.getMessage();
        }
    }

    @GetMapping("/machineDetail.gym")
    @ResponseBody
    public MachineManage getMachineDetail(@RequestParam int machineManageNo) {
        log.info("기구 상세 조회 - machineManageNo: {}", machineManageNo);

        try {
            MachineManage machine = machineService.selectMachineManageByNo(machineManageNo);
            log.info("조회된 기구: {}", machine);
            return machine;
        } catch (Exception e) {
            log.error("기구 상세 조회 중 오류", e);
            return null;
        }
    }

    @PostMapping("/machineUpdate.gym")
    @ResponseBody
    public String updateMachine(@RequestBody MachineManage machineManage) {
        log.info("기구 수정 요청: {}", machineManage);

        try {
            int result = machineService.updateMachineManage(machineManage);
            log.info("수정 결과: {}", result);

            return result > 0 ? "success" : "fail";
        } catch (Exception e) {
            log.error("기구 수정 중 오류", e);
            return "error";
        }
    }

    @PostMapping("/machineDelete.gym")
    @ResponseBody
    public String deleteMachine(@RequestParam int machineManageNo) {
        log.info("기구 삭제 요청 - machineManageNo: {}", machineManageNo);

        try {
            int result = machineService.deleteMachineManage(machineManageNo);
            log.info("삭제 결과: {}", result);

            return result > 0 ? "success" : "fail";
        } catch (Exception e) {
            log.error("기구 삭제 중 오류", e);
            return "error";
        }
    }
}