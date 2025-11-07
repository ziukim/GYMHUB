package com.kh.gymhub.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TrainerController {

    // 트레이너 대시보드
    @GetMapping("/trainer/dashboard")
    public String trainerDashboard() {
        // /WEB-INF/views/trainer/trainerDashboard.jsp 로 이동
        return "trainer/trainerDashboard";
    }

    // 트레이너 공지사항
    @GetMapping("/trainer/noticeList")
    public String trainerNoticeList() {
        // /WEB-INF/views/notice/noticeListView.jsp 로 이동
        return "notice/noticeList";
    }

}
