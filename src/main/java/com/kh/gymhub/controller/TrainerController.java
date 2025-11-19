package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.GymNotice;
import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.model.vo.PtReserve;
import com.kh.gymhub.service.MemberService;
import com.kh.gymhub.service.DashboardService;
import com.kh.gymhub.service.NoticeService;
import com.kh.gymhub.service.PtReserveService;
import jakarta.servlet.http.HttpSession;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TrainerController {

    private final MemberService memberService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final DashboardService dashboardService;
    private final NoticeService noticeService;
    private final PtReserveService ptReserveService;

    @Autowired
    public TrainerController(MemberService memberService, BCryptPasswordEncoder bCryptPasswordEncoder, DashboardService dashboardService, NoticeService noticeService, PtReserveService ptReserveService) {
        this.memberService = memberService;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
        this.dashboardService = dashboardService;
        this.noticeService = noticeService;
        this.ptReserveService = ptReserveService;
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

    // 트레이너 회원 탈퇴
    @PostMapping("/withdrawMember.tr")
    public String withdrawMember(@RequestParam String password,
                                 HttpSession session,
                                 Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인이 필요합니다.");
            return "common/error";
        }

        // 회원 탈퇴 처리
        int result = memberService.withdrawMember(loginMember.getMemberNo(), password);

        if (result > 0) {
            // 세션 무효화
            session.invalidate();
            return "redirect:/?withdraw=success";
        } else if (result == -1) {
            session.setAttribute("errorMsg", "비밀번호가 일치하지 않습니다.");
            return "redirect:/dashboard.tr";
        } else {
            session.setAttribute("errorMsg", "회원 탈퇴에 실패했습니다.");
            return "redirect:/dashboard.tr";
        }
    }

    // 트레이너 PT 스케줄 관리 페이지
    @GetMapping("/ptSchedule.tr")
    public String ptSchedule(HttpSession session, Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인이 필요합니다.");
            return "common/error";
        }

        // 트레이너 번호로 승인된 PT 예약 조회
        int trainerNo = loginMember.getMemberNo();
        List<PtReserve> reserves = ptReserveService.getApprovedPtReservesByTrainerNo(trainerNo);

        // 데이터 포맷팅
        List<Map<String, Object>> formattedReserves = new ArrayList<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm");
        SimpleDateFormat dateOnlyFormat = new SimpleDateFormat("yyyy.MM.dd");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");

        for (PtReserve reserve : reserves) {
            Map<String, Object> formatted = new HashMap<>();
            formatted.put("ptReserveNo", reserve.getPtReserveNo());
            formatted.put("memberName", reserve.getMemberName());
            formatted.put("memberPhone", reserve.getMemberPhone());
            formatted.put("ptReserveTime", reserve.getPtReserveTime());
            formatted.put("reserveDate", dateOnlyFormat.format(reserve.getPtReserveTime()));
            formatted.put("reserveTime", timeFormat.format(reserve.getPtReserveTime()));
            formatted.put("reserveTimeLabel", dateFormat.format(reserve.getPtReserveTime()));
            formatted.put("ptReserveStatus", reserve.getPtReserveStatus());
            formattedReserves.add(formatted);
        }

        model.addAttribute("reserves", formattedReserves);
        model.addAttribute("currentPage", "ptSchedule");

        return "trainer/trainerPtSchedule";
    }

    // AJAX: 날짜별 PT 스케줄 조회
    @GetMapping("/ptSchedule/filterByDate.ajax")
    @ResponseBody
    public Map<String, Object> filterPtScheduleByDate(@RequestParam("date") String date, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 트레이너 번호 가져오기
        int trainerNo = loginMember.getMemberNo();
        
        try {
            List<PtReserve> reserves = ptReserveService.getApprovedPtReservesByTrainerNoAndDate(trainerNo, date);
            
            // 데이터 포맷팅
            List<Map<String, Object>> formattedReserves = new ArrayList<>();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd HH:mm");
            SimpleDateFormat dateOnlyFormat = new SimpleDateFormat("yyyy.MM.dd");
            SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");

            for (PtReserve reserve : reserves) {
                Map<String, Object> formatted = new HashMap<>();
                formatted.put("ptReserveNo", reserve.getPtReserveNo());
                formatted.put("memberName", reserve.getMemberName());
                formatted.put("memberPhone", reserve.getMemberPhone());
                formatted.put("ptReserveTime", reserve.getPtReserveTime());
                formatted.put("reserveDate", dateOnlyFormat.format(reserve.getPtReserveTime()));
                formatted.put("reserveTime", timeFormat.format(reserve.getPtReserveTime()));
                formatted.put("reserveTimeLabel", dateFormat.format(reserve.getPtReserveTime()));
                formatted.put("ptReserveStatus", reserve.getPtReserveStatus());
                formattedReserves.add(formatted);
            }
            
            result.put("success", true);
            result.put("reserves", formattedReserves != null ? formattedReserves : new ArrayList<>());
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "데이터 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

}
