package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.Locker;
import com.kh.gymhub.service.LockerService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Slf4j
@Controller
@RequestMapping("/locker")
@RequiredArgsConstructor
public class LockerController {

    private final LockerService lockerService;

    @PostMapping("/add.gym")
    @ResponseBody
    public String addLocker(@RequestParam("lockerRealNum") String lockerRealNum, HttpSession session) {
        Integer gymNo = (Integer) session.getAttribute("gymNo");

        log.info("=== 락커 추가 요청 시작 ===");
        log.info("gymNo: {}, lockerRealNum: {}", gymNo, lockerRealNum);

        if (gymNo == null) {
            log.error("세션에 gymNo가 없습니다!");
            return "fail_auth";
        }

        try {
            Locker locker = Locker.builder()
                    .gymNo(gymNo)
                    .lockerRealNum(lockerRealNum)
                    .lockerStatus("빈") // '빈' 상태로 추가
                    .build();

            int result = lockerService.addLocker(locker);

            if (result > 0) {
                log.info("락커 추가 성공");
                return "success";
            } else {
                log.error("락커 추가 실패");
                return "fail";
            }
        } catch (Exception e) {
            log.error("락커 추가 중 예외 발생", e);
            // 제약 조건 위반 (예: 중복된 락커 번호)에 대한 처리
            if (e.getMessage().contains("UQ_LOCKER_REAL_NUM")) {
                return "fail_duplicate";
            }
            return "error";
        }
    }
}
