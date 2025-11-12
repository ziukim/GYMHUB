package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.service.GymService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class HomeController {

    private final GymService gymService;

    @Autowired
    public HomeController(GymService gymService) {
        this.gymService = gymService;
    }

    @GetMapping("/")
    public String home(Model model) {
        // 모든 헬스장 목록 조회
        List<Gym> gymList = gymService.getAllGyms();
        model.addAttribute("gymList", gymList);

        return "index";
    }
}