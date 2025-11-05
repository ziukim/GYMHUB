package com.kh.gymhub.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TrainerController {
    
    @GetMapping("/trainer/dashboard")
    public String trainerDashboard() {
        return "trainer/trainerDashboard";
    }
}
