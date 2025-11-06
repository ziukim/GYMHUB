package com.kh.gymhub.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

@Controller
public class NoticeController {
    
    @GetMapping("/notice.no")
    public String noticeList() {
        return "notice/noticeList";
    }
    
    @GetMapping("/noticeDetail.no")
    public String noticeDetail(@RequestParam(value = "id", required = false) String noticeId, Model model) {
        // TODO: 실제로는 DB에서 공지사항 데이터를 조회해서 모델에 담아야 함
        // 현재는 임시 데이터로 처리
        model.addAttribute("noticeId", noticeId);
        return "notice/noticeDetail";
    }
    
    @GetMapping("/noticeEnrollForm.no")
    public String noticeEnrollForm() {
        return "notice/noticeEnroll";
    }

}

