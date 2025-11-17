package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.GymNotice;
import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.service.MemberService;
import com.kh.gymhub.service.DashboardService;
import com.kh.gymhub.service.NoticeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Date;
import java.util.List;
import java.util.Map;

@Controller
public class TrainerController {

    private final MemberService memberService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final DashboardService dashboardService;
    private final NoticeService noticeService;

    @Autowired
    public TrainerController(MemberService memberService, BCryptPasswordEncoder bCryptPasswordEncoder, DashboardService dashboardService, NoticeService noticeService) {
        this.memberService = memberService;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.dashboardService = dashboardService;
        this.noticeService = noticeService;
    }

    // 트레이너 대시보드
    @GetMapping("/dashboard.tr")
    public String trainerDashboard(HttpSession session, Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인이 필요합니다.");
            return "common/error";
        }

        Integer gymNo = loginMember.getGymNo();

        if (gymNo != null && gymNo > 0) {
            // gym_no가 있는 경우: 헬스장 관련 정보 조회 (한 번만 호출)
            Map<String, Object> dashboardData = dashboardService.getDashboardData(loginMember.getMemberNo(), gymNo);

            model.addAttribute("hasGym", true);
            model.addAttribute("attendance", dashboardData.get("attendance"));
            model.addAttribute("gymInfo", dashboardData.get("gymInfo"));
            model.addAttribute("notices", dashboardData.get("notices"));

        } else {
            // gym_no가 없는 경우
            model.addAttribute("hasGym", false);
        }

        return "trainer/trainerDashboard";
    }

    // 트레이너 공지사항
    @GetMapping("/noticeList.tr")
    public String trainerNoticeList(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null || loginMember.getGymNo() == null) {
            // 로그인하지 않았거나 gym_no가 없는 경우 빈 리스트 전달
            model.addAttribute("notices", new java.util.ArrayList<>());
            return "notice/noticeList";
        }

        // 헬스장 번호로 공지사항 조회
        int gymNo = loginMember.getGymNo();
        List<GymNotice> notices = noticeService.getNoticesByGymNo(gymNo);

        model.addAttribute("notices", notices != null ? notices : new java.util.ArrayList<>());

        return "notice/noticeList";
    }
    

    // 트레이너 비밀번호 변경
    @PostMapping("/updatePassword.tr")
    public String updatePassword(@RequestParam String currentPassword,
                                 @RequestParam String newPassword,
                                 HttpSession session,
                                 Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인이 필요합니다.");
            return "common/error";
        }

        // 현재 비밀번호 확인
        if (!bCryptPasswordEncoder.matches(currentPassword, loginMember.getMemberPwd())) {
            session.setAttribute("errorMsg", "현재 비밀번호가 일치하지 않습니다.");
            return "redirect:/dashboard.tr";
        }

        // 새 비밀번호 암호화
        String encodedNewPassword = bCryptPasswordEncoder.encode(newPassword);

        int result = memberService.updatePassword(loginMember.getMemberNo(), encodedNewPassword);

        if (result > 0) {
            session.setAttribute("alertMsg", "비밀번호가 변경되었습니다.");
            return "redirect:/dashboard.tr";
        } else {
            model.addAttribute("errorMsg", "비밀번호 변경에 실패했습니다.");
            return "common/error";
        }
    }

    // 트레이너 정보 수정
    @PostMapping("/updateMemberInfo.tr")
    public String updateMemberInfo(@RequestParam String memberName,
                                   @RequestParam String birthDate,
                                   @RequestParam String phone,
                                   @RequestParam String email,
                                   @RequestParam String address,
                                   @RequestParam(required = false) String trainerCareer,
                                   @RequestParam(required = false) String trainerLicense,
                                   @RequestParam(required = false) String trainerAward,
                                   HttpSession session,
                                   Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인이 필요합니다.");
            return "common/error";
        }

        // Member 객체에 수정할 정보 설정
        Member updateMember = new Member();
        updateMember.setMemberNo(loginMember.getMemberNo());
        updateMember.setMemberName(memberName);
        updateMember.setMemberPhone(phone);
        updateMember.setMemberEmail(email);
        updateMember.setMemberAddress(address);
        updateMember.setTrainerCareer(trainerCareer);
        updateMember.setTrainerLicense(trainerLicense);
        updateMember.setTrainerAward(trainerAward);

        // 생년월일 변환 (YYYY. MM. DD. 형식 처리)
        if (birthDate != null && !birthDate.isEmpty()) {
            String cleanDate = birthDate.replaceAll("[^0-9]", "");
            if (cleanDate.length() == 8) {
                String formattedDate = cleanDate.substring(0, 4) + "-"
                        + cleanDate.substring(4, 6) + "-"
                        + cleanDate.substring(6, 8);
                updateMember.setMemberBirth(Date.valueOf(formattedDate));
            }
        }

        int result = memberService.updateMemberInfo(updateMember);

        if (result > 0) {
            // 세션 정보 업데이트
            Member updatedMember = memberService.getMemberById(loginMember.getMemberId());
            session.setAttribute("loginMember", updatedMember);
            session.setAttribute("alertMsg", "회원정보가 수정되었습니다.");
            return "redirect:/dashboard.tr";
        } else {
            model.addAttribute("errorMsg", "회원정보 수정에 실패했습니다.");
            return "common/error";
        }
    }

}
