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
    public String memberDashboardPage(HttpSession session) {
        // 로그인 체크 (선택사항 - 필요시 추가)
        return "member/memberDashboard";
    }

    @GetMapping("/member/violist")
    public String memberVideoList() { return "member/memberVideoList"; }

    @GetMapping("/member/info")
    public String memberInfo(HttpSession session, Model model) {
        // 세션에서 로그인 정보 가져오기
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null) {
            // 로그인하지 않은 경우 메인 페이지로 리다이렉트
            session.setAttribute("errorMsg", "로그인이 필요합니다.");
            return "redirect:/";
        }
        
        // Model에 추가 (JSP에서 사용하기 위해)
        model.addAttribute("loginMember", loginMember);
        return "member/memberInfo";
    }

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

    // ====================================== 로그인 ======================================================
    @PostMapping("/login.do")
    public String login(@RequestParam String id,
                       @RequestParam String password,
                       HttpSession session) {
        
        Member loginMember = memberService.login(id, password);
        
        if (loginMember != null) {
            // 세션에 로그인 정보 저장
            session.setAttribute("loginMember", loginMember);
            
            // 멤버 타입 3(헬스장 운영자)이면 선택 모달 표시 플래그 설정
            if (loginMember.getMemberType() == 3) {
                session.setAttribute("showGymSelectModal", true);
            }
            
            session.setAttribute("alertMsg", loginMember.getMemberName() + "님 환영합니다!");
            return "redirect:/";
        } else {
            session.setAttribute("errorMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "redirect:/";
        }
    }

    @GetMapping("/logout.me")
    public String logout(HttpSession httpSession) {
        // 세션 완전 무효화
        httpSession.invalidate();
        return "redirect:/?logout=success";
    }
    
    // GET 방식 로그아웃
    @GetMapping("/logout.do")
    public String logoutGet(HttpSession session) {
        // 세션 완전 무효화
        session.invalidate();
        return "redirect:/?logout=success";
    }
    
    // POST 방식 로그아웃 (호환성을 위해 유지)
    @PostMapping("/logout.do")
    public String logoutPost(HttpSession session) {
        // 세션 완전 무효화
        session.invalidate();
        return "redirect:/?logout=success";
    }
    
    // /logout 엔드포인트 추가 (호환성을 위해)
    @GetMapping("/logout")
    public String logoutSimple(HttpSession session) {
        // 세션 완전 무효화
        session.invalidate();
        return "redirect:/?logout=success";
    }

    @GetMapping("/member.dashboard")
    public String memberDashboard(HttpSession session) {
        // 로그인 체크 (선택사항 - 필요시 추가)
        return "member/memberDashboard";
    }
}
