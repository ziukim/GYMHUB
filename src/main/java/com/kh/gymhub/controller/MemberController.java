package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


@Controller
public class MemberController {

    private final MemberService memberService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public MemberController(MemberService memberService, BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.memberService = memberService;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @GetMapping("/member/dashboard")
    public String memberDashboard() {
        return "member/memberDashboard";
    }

    @GetMapping("/member/violist")
    public String memberVideoList() { return "member/memberVideoList"; }

    @GetMapping("/member/info")
    public String memberInfo() { return "member/memberInfo"; }

    @GetMapping("/notice")
    public String memberNotice() { return "notice/noticeList"; }

    @GetMapping("/schedule")
    public String memberPtSchedule() { return "member/ptSchedule"; }

    @GetMapping("/schedule/ptbooking")
    public String memberptBookingForm() { return "member/ptBookingForm"; }

    // 수정 요함
    @GetMapping("/booking/booking")
    public String Booking() { return "booking/booking"; }

    // ====================================== 회원가입 ======================================================
    @GetMapping("/signup/checkId")
    @ResponseBody
    public String checkDuplicateId(@RequestParam String checkId) {
        int count = memberService.getMemberCountById(checkId);
        return count > 0 ? "NNNNN" : "NNNNY";
    }

    @PostMapping("/signup/member.do")
    public String signupMember(@RequestParam String id,
                               @RequestParam String password,
                               @RequestParam String name,
                               @RequestParam String phone,
                               @RequestParam(required = false) String address,
                               @RequestParam String birthDate,
                               HttpSession session,
                               Model model) {

        Member member = new Member();
        member.setMemberType(1);
        member.setMemberId(id);
        member.setMemberPwd(bCryptPasswordEncoder.encode(password));
        member.setMemberName(name);
        member.setMemberPhone(phone);
        member.setMemberAddress(address);

        int result = memberService.addMember(member);

        if(result > 0) {
            session.setAttribute("alertMsg", "회원가입에 성공하였습니다.");
            return "redirect:/";
        } else {
            model.addAttribute("errorMsg", "회원가입에 실패하였습니다.");
            return "common/error";
        }
    }

    @PostMapping("/signup/trainer.do")
    public String signupTrainer(@RequestParam String id,
                                @RequestParam String password,
                                @RequestParam String name,
                                @RequestParam String phone,
                                @RequestParam(required = false) String address,
                                @RequestParam String birthDate,
                                @RequestParam(required = false) String email,
                                @RequestParam(required = false) String career,
                                @RequestParam(required = false) String certification,
                                @RequestParam(required = false) String detailCareer,
                                HttpSession session,
                                Model model) {

        Member member = new Member();
        member.setMemberType(2);
        member.setMemberId(id);
        member.setMemberPwd(bCryptPasswordEncoder.encode(password));
        member.setMemberName(name);
        member.setMemberPhone(phone);
        member.setMemberAddress(address);
        member.setMemberEmail(email);
        member.setTrainerLicense(certification);
        member.setTrainerCareer(career);
        member.setTrainerAward(detailCareer);

        int result = memberService.addMember(member);

        if(result > 0) {
            session.setAttribute("alertMsg", "트레이너 회원가입에 성공하였습니다.");
            return "redirect:/";
        } else {
            model.addAttribute("errorMsg", "트레이너 회원가입에 실패하였습니다.");
            return "common/error";
        }
    }

    @PostMapping("/signup/gym.do")
    public String signupGym(@RequestParam String id,
                            @RequestParam String password,
                            @RequestParam String phone,
                            @RequestParam(required = false) String address,
                            @RequestParam(required = false) String representative,
                            @RequestParam(required = false) String gymName,
                            @RequestParam(required = false) String email,
                            HttpSession session,
                            Model model) {

        Member member = new Member();
        member.setMemberType(3);
        member.setMemberId(id);
        member.setMemberPwd(bCryptPasswordEncoder.encode(password));
        member.setMemberName(representative != null ? representative : gymName);
        member.setMemberPhone(phone);
        member.setMemberAddress(address);
        member.setMemberEmail(email);

        int result = memberService.addMember(member);

        if(result > 0) {
            session.setAttribute("alertMsg", "헬스장 운영자 회원가입에 성공하였습니다.");
            return "redirect:/";
        } else {
            model.addAttribute("errorMsg", "헬스장 운영자 회원가입에 실패하였습니다.");
            return "common/error";
        }
    }


}
