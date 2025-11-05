package com.kh.gymhub.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GymController {
    
    @GetMapping("/dashboard.do")
    public String gymDashboard() {
        return "gym/gymDashBoard";
    }
    @GetMapping("/ptBoard.bo")
    public String ptBoard() {
        return "gym/gymPtBoard";
    }
}
