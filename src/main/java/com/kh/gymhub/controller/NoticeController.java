package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.GymNotice;
import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.service.NoticeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

@Controller
public class NoticeController {
    
    private final NoticeService noticeService;

    @Autowired
    public NoticeController(NoticeService noticeService) {
        this.noticeService = noticeService;
    }
    
    @GetMapping("/notice.no")
    public String noticeList(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getGymNo() == null) {
            // 로그인하지 않았거나 gym_no가 없는 경우 빈 리스트 전달
            model.addAttribute("notices", new java.util.ArrayList<>());
            return "notice/noticeList";
        }
        
        // 헬스장 번호로 공지사항 조회
        int gymNo = loginMember.getGymNo();
        List<com.kh.gymhub.model.vo.GymNotice> notices = noticeService.getNoticesByGymNo(gymNo);
        
        model.addAttribute("notices", notices != null ? notices : new java.util.ArrayList<>());
        
        return "notice/noticeList";
    }
    
    @GetMapping("/noticeDetail.no")
    public String noticeDetail(@RequestParam(value = "id", required = false) String noticeId, 
                               HttpSession session, Model model) {
        // noticeId가 없으면 목록으로 리다이렉트
        if (noticeId == null || noticeId.isEmpty()) {
            session.setAttribute("errorMsg", "공지사항 번호가 필요합니다.");
            return "redirect:/notice.no";
        }
        
        try {
            int noticeNo = Integer.parseInt(noticeId);
            
            // DB에서 공지사항 조회
            GymNotice notice = noticeService.getNoticeByNo(noticeNo);
            
            if (notice == null) {
                session.setAttribute("errorMsg", "공지사항을 찾을 수 없습니다.");
                return "redirect:/notice.no";
            }
            
            // 세션에서 로그인 정보 확인 (권한 체크용)
            Member loginMember = (Member) session.getAttribute("loginMember");
            
            // 같은 헬스장의 공지사항인지 확인
            if (loginMember != null && loginMember.getGymNo() != null) {
                if (notice.getGymNo() != loginMember.getGymNo()) {
                    session.setAttribute("errorMsg", "접근 권한이 없습니다.");
                    return "redirect:/notice.no";
                }
            }
            
            model.addAttribute("notice", notice);
            return "notice/noticeDetail";
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "잘못된 공지사항 번호입니다.");
            return "redirect:/notice.no";
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "공지사항 조회 중 오류가 발생했습니다.");
            return "redirect:/notice.no";
        }
    }
    
    @GetMapping("/noticeEnrollForm.no")
    public String noticeEnrollForm(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getGymNo() == null) {
            session.setAttribute("errorMsg", "로그인이 필요합니다.");
            return "redirect:/notice.no";
        }
        
        model.addAttribute("loginMember", loginMember);
        return "notice/noticeEnroll";
    }
    
    @PostMapping("/noticeEnroll.no")
    public String noticeEnroll(
            @RequestParam("noticeTitle") String noticeTitle,
            @RequestParam("noticeAuthor") String noticeWriter,
            @RequestParam("noticeContent") String noticeContent,
            @RequestParam(value = "noticeType", required = false) String noticeCategory,
            @RequestParam(value = "noticeFile", required = false) MultipartFile file,
            HttpSession session) {
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getGymNo() == null) {
            session.setAttribute("errorMsg", "로그인이 필요합니다.");
            return "redirect:/notice.no";
        }
        
        try {
            // 카테고리가 없으면 기본값 설정
            if (noticeCategory == null || noticeCategory.isEmpty()) {
                noticeCategory = "general";
            }
            
            // GymNotice 객체 생성
            GymNotice notice = GymNotice.builder()
                    .noticeTitle(noticeTitle)
                    .noticeWriter(noticeWriter)
                    .noticeContent(noticeContent)
                    .noticeCategory(noticeCategory)
                    .noticeFixStatus("N") // 기본값: 고정 아님
                    .gymNo(loginMember.getGymNo())
                    .build();
            
            // 공지사항 등록
            int result = noticeService.insertNotice(notice, file);
            
            if (result > 0) {
                session.setAttribute("alertMsg", "공지사항이 등록되었습니다.");
                return "redirect:/notice.no";
            } else {
                session.setAttribute("errorMsg", "공지사항 등록에 실패했습니다.");
                return "redirect:/noticeEnrollForm.no";
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "공지사항 등록 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/noticeEnrollForm.no";
        }
    }
    
    @GetMapping("/noticeUpdateForm.no")
    public String noticeUpdateForm(@RequestParam(value = "id", required = false) String noticeId,
                                   HttpSession session, Model model) {
        // noticeId가 없으면 목록으로 리다이렉트
        if (noticeId == null || noticeId.isEmpty()) {
            session.setAttribute("errorMsg", "공지사항 번호가 필요합니다.");
            return "redirect:/notice.no";
        }
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "권한이 없습니다.");
            return "redirect:/notice.no";
        }
        
        try {
            int noticeNo = Integer.parseInt(noticeId);
            
            // DB에서 공지사항 조회
            GymNotice notice = noticeService.getNoticeByNo(noticeNo);
            
            if (notice == null) {
                session.setAttribute("errorMsg", "공지사항을 찾을 수 없습니다.");
                return "redirect:/notice.no";
            }
            
            // 같은 헬스장의 공지사항인지 확인
            if (notice.getGymNo() != loginMember.getGymNo()) {
                session.setAttribute("errorMsg", "접근 권한이 없습니다.");
                return "redirect:/notice.no";
            }
            
            model.addAttribute("notice", notice);
            return "notice/noticeUpdate";
            
        } catch (NumberFormatException e) {
            session.setAttribute("errorMsg", "잘못된 공지사항 번호입니다.");
            return "redirect:/notice.no";
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "공지사항 조회 중 오류가 발생했습니다.");
            return "redirect:/notice.no";
        }
    }
    
    @PostMapping("/noticeUpdate.no")
    public String noticeUpdate(
            @RequestParam("noticeId") int noticeNo,
            @RequestParam("noticeTitle") String noticeTitle,
            @RequestParam("noticeAuthor") String noticeWriter,
            @RequestParam("noticeContent") String noticeContent,
            @RequestParam(value = "noticeType", required = false) String noticeCategory,
            @RequestParam(value = "noticeFile", required = false) MultipartFile file,
            HttpSession session) {
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "권한이 없습니다.");
            return "redirect:/notice.no";
        }
        
        try {
            // 기존 공지사항 조회
            GymNotice existingNotice = noticeService.getNoticeByNo(noticeNo);
            
            if (existingNotice == null) {
                session.setAttribute("errorMsg", "공지사항을 찾을 수 없습니다.");
                return "redirect:/notice.no";
            }
            
            // 같은 헬스장의 공지사항인지 확인
            if (existingNotice.getGymNo() != loginMember.getGymNo()) {
                session.setAttribute("errorMsg", "접근 권한이 없습니다.");
                return "redirect:/notice.no";
            }
            
            // 카테고리가 없으면 기본값 설정
            if (noticeCategory == null || noticeCategory.isEmpty()) {
                noticeCategory = "general";
            }
            
            // GymNotice 객체 생성 (기존 파일 경로 유지)
            GymNotice notice = GymNotice.builder()
                    .noticeNo(noticeNo)
                    .noticeTitle(noticeTitle)
                    .noticeWriter(noticeWriter)
                    .noticeContent(noticeContent)
                    .noticeCategory(noticeCategory)
                    .filePath(existingNotice.getFilePath()) // 기존 파일 경로 유지
                    .build();
            
            // 공지사항 수정 (파일이 있으면 새로 저장, 없으면 기존 경로 유지)
            int result = noticeService.updateNotice(notice, file);
            
            if (result > 0) {
                session.setAttribute("alertMsg", "공지사항이 수정되었습니다.");
                return "redirect:/noticeDetail.no?id=" + noticeNo;
            } else {
                session.setAttribute("errorMsg", "공지사항 수정에 실패했습니다.");
                return "redirect:/noticeUpdateForm.no?id=" + noticeNo;
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "공지사항 수정 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/noticeUpdateForm.no?id=" + noticeNo;
        }
    }

    // AJAX: 공지사항 고정 상태 토글
    @PostMapping("/notice/toggleFix.ajax")
    @ResponseBody
    public Map<String, Object> toggleNoticeFix(@RequestParam("noticeNo") int noticeNo,
                                                 HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        try {
            // 현재 공지사항 정보 조회
            GymNotice notice = noticeService.getNoticeByNo(noticeNo);
            
            if (notice == null) {
                result.put("success", false);
                result.put("message", "공지사항을 찾을 수 없습니다.");
                return result;
            }
            
            // 같은 헬스장의 공지사항인지 확인
            if (notice.getGymNo() != loginMember.getGymNo()) {
                result.put("success", false);
                result.put("message", "접근 권한이 없습니다.");
                return result;
            }
            
            // 고정 상태 토글 (Y -> N, N -> Y)
            String currentStatus = notice.getNoticeFixStatus();
            String newStatus = "Y".equals(currentStatus) ? "N" : "Y";
            
            int updateResult = noticeService.updateNoticeFixStatus(noticeNo, newStatus);
            
            if (updateResult > 0) {
                result.put("success", true);
                result.put("fixStatus", newStatus);
                result.put("message", "Y".equals(newStatus) ? "공지사항이 고정되었습니다." : "공지사항 고정이 해제되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "고정 상태 변경에 실패했습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

}

