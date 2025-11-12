package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.LockerPass;
import com.kh.gymhub.model.vo.MachineManage;
import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.service.LockerService;
import com.kh.gymhub.service.MachineService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Controller
public class MachineController {

    private final MachineService machineService;
    private final LockerService lockerService;

    @Autowired
    public MachineController(MachineService machineService, LockerService lockerService) {
        this.machineService = machineService;
        this.lockerService = lockerService;
    }

    /**
     * 기구 및 락커 목록 페이지 이동
     */
    @GetMapping("/machineList.gym")
    public String machineList(HttpSession session, Model model) {
        Integer gymNo = (Integer) session.getAttribute("gymNo");

        if (gymNo == null) {
            Member loginMember = (Member) session.getAttribute("loginMember");
            if (loginMember != null && loginMember.getMemberType() == 3) {
                gymNo = loginMember.getGymNo();
                if (gymNo != null) {
                    session.setAttribute("gymNo", gymNo);
                }
            }
        }

        if (gymNo == null) {
            model.addAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "gym/gymFacilitiesBoard";
        }

        try {
            // 1. 기구 목록 조회
            List<MachineManage> machineList = machineService.selectMachineListByGymNo(gymNo);
            model.addAttribute("machineList", machineList);

            // 2. 락커 목록 조회
            List<LockerPass> lockerPassList = lockerService.selectLockerPassListByGymNo(gymNo);
            model.addAttribute("lockerPassList", lockerPassList);

            return "gym/gymFacilitiesBoard";

        } catch (Exception e) {
            model.addAttribute("errorMsg", "시설 목록을 불러오는데 실패했습니다.");
            return "gym/gymFacilitiesBoard";
        }
    }

    /**
     * 기구 등록 폼 페이지
     */
    @GetMapping("/machineEnrollForm.gym")
    public String machineEnrollForm(HttpSession session) {
        Integer gymNo = (Integer) session.getAttribute("gymNo");
        if (gymNo == null) {
            Member loginMember = (Member) session.getAttribute("loginMember");
            if (loginMember != null && loginMember.getMemberType() == 3) {
                gymNo = loginMember.getGymNo();
                if (gymNo != null) {
                    session.setAttribute("gymNo", gymNo);
                }
            }
        }
        return "gym/gymMachineEnrollForm";
    }

    /**
     * 기구 등록 처리
     */
    @PostMapping("/machineInsert.gym")
    @ResponseBody
    public String insertMachine(@RequestParam("machineImage") MultipartFile file,
                                @RequestParam("machineName") String machineName,
                                @RequestParam("brand") String brand,
                                HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null || loginMember.getMemberType() != 3) {
            return "fail_auth";
        }

        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            return "fail_auth";
        }

        if (file == null || file.isEmpty()) {
            return "no_file";
        }

        if (file.getSize() > 10 * 1024 * 1024) {
            return "file_too_large";
        }

        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            return "invalid_file_type";
        }

        try {
            MachineManage machineManage = new MachineManage();
            machineManage.setGymNo(gymNo);
            machineManage.setMachineName(machineName);
            machineManage.setBrand(brand);

            int result = machineService.insertMachine(machineManage, file);

            if (result > 0) {
                return "success";
            } else {
                return "fail";
            }

        } catch (Exception e) {
            return "error: " + e.getMessage();
        }
    }

    @GetMapping("/machineDetail.gym")
    @ResponseBody
    public MachineManage getMachineDetail(@RequestParam int machineManageNo) {
        try {
            return machineService.selectMachineManageByNo(machineManageNo);
        } catch (Exception e) {
            return null;
        }
    }

    @PostMapping("/machineUpdate.gym")
    @ResponseBody
    public String updateMachine(@RequestBody MachineManage machineManage) {
        try {
            int result = machineService.updateMachineManage(machineManage);
            return result > 0 ? "success" : "fail";
        } catch (Exception e) {
            return "error";
        }
    }

    @PostMapping("/machineDelete.gym")
    @ResponseBody
    public String deleteMachine(@RequestParam int machineManageNo) {
        try {
            int result = machineService.deleteMachineManage(machineManageNo);
            return result > 0 ? "success" : "fail";
        } catch (Exception e) {
            return "error";
        }
    }

    /**
     * 락커 추가
     */
    @PostMapping("/locker/add.gym")
    @ResponseBody
    public String addLocker(@RequestParam String lockerRealNum,
                            HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null || loginMember.getMemberType() != 3) {
            return "fail_auth";
        }

        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            return "fail_auth";
        }

        try {
            com.kh.gymhub.model.vo.Locker locker = new com.kh.gymhub.model.vo.Locker();
            locker.setGymNo(gymNo);
            locker.setLockerRealNum(lockerRealNum);
            locker.setLockerStatus("빈");

            int result = lockerService.addLocker(locker);
            return result > 0 ? "success" : "fail_duplicate";
        } catch (Exception e) {
            return "fail";
        }
    }
}

