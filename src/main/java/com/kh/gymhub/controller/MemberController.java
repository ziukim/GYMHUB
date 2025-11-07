package com.kh.gymhub.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {
    
    @GetMapping("/member/dashboard")
    public String memberDashboard() {
        return "member/memberDashboard";
    }

    @GetMapping("/member/violist")
    public String memberVideoList() { return "member/memberVideoList"; }

    @GetMapping("/member/info")
    public String memberInfo() { return "member/memberInfo"; }

    @GetMapping("/notice")
    public String memberNotice() { return "notice/noticeList"; }

    @GetMapping("/schedule")
    public String memberPtSchedule() { return "member/ptSchedule"; }

    @GetMapping("/schedule/ptbooking")
    public String memberptBookingForm() { return "member/ptBookingForm"; }

    // 수정 요함
    @GetMapping("/booking/booking")
    public String Booking() { return "booking/booking"; }


}
