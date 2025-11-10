package com.kh.gymhub.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;
import java.util.HashMap;
import java.util.Map;

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
    
    @GetMapping("/noticeUpdateForm.no")
    public String noticeUpdateForm(@RequestParam(value = "id", required = false) String noticeId, Model model) {
        // TODO: 실제로는 DB에서 공지사항 데이터를 조회해서 모델에 담아야 함
        // 현재는 임시 데이터로 처리
        Map<String, Object> notice = new HashMap<>();
        
        // noticeDetail.jsp의 임시 데이터를 참고하여 매핑
        Map<String, Map<String, Object>> noticeDataMap = new HashMap<>();
        
        Map<String, Object> notice1 = new HashMap<>();
        notice1.put("noticeNo", "1");
        notice1.put("noticeType", "urgent");
        notice1.put("noticeTitle", "연말연시 운영시간 안내");
        notice1.put("noticeContent", "12월 31일과 1월 1일은 오전 10시부터 오후 6시까지 운영합니다. 회원 여러분의 양해 부탁드립니다.");
        notice1.put("noticeWriter", "관리자 (운영자)");
        notice1.put("noticeFile", null);
        noticeDataMap.put("1", notice1);
        
        Map<String, Object> notice2 = new HashMap<>();
        notice2.put("noticeNo", "2");
        notice2.put("noticeType", "event");
        notice2.put("noticeTitle", "11월 신규 GX 프로그램 오픈");
        notice2.put("noticeContent", "새로운 GX 프로그램이 준비되었습니다!");
        notice2.put("noticeWriter", "빅트레이너 (트레이너)");
        notice2.put("noticeFile", null);
        noticeDataMap.put("2", notice2);
        
        Map<String, Object> notice3 = new HashMap<>();
        notice3.put("noticeNo", "3");
        notice3.put("noticeType", "important");
        notice3.put("noticeTitle", "시설 점검 안내");
        notice3.put("noticeContent", "내일(금)의 오전 2시부터 6시까지 시설 점검이 예정되어 있습니다. 해당 시간에는 이용이 불가합니다.");
        notice3.put("noticeWriter", "시설관리 (운영자)");
        notice3.put("noticeFile", null);
        noticeDataMap.put("3", notice3);
        
        Map<String, Object> notice4 = new HashMap<>();
        notice4.put("noticeNo", "4");
        notice4.put("noticeType", "general");
        notice4.put("noticeTitle", "신규 운동 기구 입고 완료");
        notice4.put("noticeContent", "회원 여러분이 요청하신 최신 스미스머신과 케이블 크로스오버가 입고되었습니다. 2층 프리웨이트존에서 이용하실 수 있습니다.");
        notice4.put("noticeWriter", "어트레이너 (트레이너)");
        notice4.put("noticeFile", null);
        noticeDataMap.put("4", notice4);
        
        // noticeId에 해당하는 데이터 가져오기
        if (noticeId != null && noticeDataMap.containsKey(noticeId)) {
            notice = noticeDataMap.get(noticeId);
        } else {
            // 기본값 설정
            notice.put("noticeNo", noticeId != null ? noticeId : "");
            notice.put("noticeType", "general");
            notice.put("noticeTitle", "");
            notice.put("noticeContent", "");
            notice.put("noticeWriter", "");
            notice.put("noticeFile", null);
        }
        
        model.addAttribute("notice", notice);
        model.addAttribute("noticeId", noticeId);
        
        // TODO: 실제 DB 조회 로직
        // Notice notice = noticeService.selectNotice(noticeId);
        // model.addAttribute("notice", notice);
        
        return "notice/noticeUpdate";
    }

}

