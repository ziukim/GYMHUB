package com.kh.gymhub.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MemberController {
    
    @GetMapping("/member/dashboard")
    public String memberDashboard() {
        return "member/memberDashboard";
    }
}
