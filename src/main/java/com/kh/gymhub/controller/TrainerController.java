package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class TrainerController {

    @Autowired
    private MemberService memberService;

    // 트레이너 대시보드
    @GetMapping("/trainer/dashboard")
    public String trainerDashboard(@SessionAttribute(name = "loginMember", required = false) Member loginMember, Model model) {
        if (loginMember == null) {
            return "redirect:/login"; // 로그인 안되어 있으면 로그인 페이지로
        }
        // 세션에서 받은 정보로 최신 회원 정보를 다시 조회하여 모델에 추가
        Member currentMember = memberService.getMemberById(loginMember.getMemberId());
        model.addAttribute("loginMember", currentMember);
        return "trainer/trainerDashboard";
    }

    // 트레이너 공지사항
    @GetMapping("/trainer/noticeList")
    public String trainerNoticeList() {
        return "notice/noticeList";
    }

    // 정보 수정 처리
    @PostMapping("/trainer/updateInfo")
    public String updateTrainerInfo(@ModelAttribute Member member,
                                    @SessionAttribute("loginMember") Member loginMember,
                                    HttpSession session,
                                    RedirectAttributes redirectAttributes) {
        
        member.setMemberId(loginMember.getMemberId()); // 보안을 위해 ID는 세션에서 가져옴
        int result = memberService.updateMember(member);

        if (result > 0) {
            // 세션에 있는 loginMember 정보도 업데이트
            session.setAttribute("loginMember", memberService.getMemberById(loginMember.getMemberId()));
            redirectAttributes.addFlashAttribute("message", "회원 정보가 성공적으로 수정되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "회원 정보 수정에 실패했습니다.");
        }

        return "redirect:/trainer/dashboard";
    }

    // 비밀번호 변경 처리
    @PostMapping("/trainer/updatePassword")
    public String updatePassword(@RequestParam("currentPassword") String currentPassword,
                                 @RequestParam("newPassword") String newPassword,
                                 @SessionAttribute("loginMember") Member loginMember,
                                 RedirectAttributes redirectAttributes) {

        int result = memberService.updatePassword(loginMember.getMemberId(), currentPassword, newPassword);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("message", "비밀번호 변경에 실패했습니다. 현재 비밀번호를 확인해주세요.");
        }

        return "redirect:/trainer/dashboard";
    }
}
