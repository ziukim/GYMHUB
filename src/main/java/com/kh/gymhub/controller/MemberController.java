package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.InbodyRecord;
import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.service.InbodyService;
import com.kh.gymhub.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.Date;
import java.util.List;



@Controller
public class MemberController {

    private final MemberService memberService;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;
    private final InbodyService inbodyService;

    @Autowired
    public MemberController(MemberService memberService, BCryptPasswordEncoder bCryptPasswordEncoder, InbodyService inbodyService) {
        this.memberService = memberService;
        this.inbodyService = inbodyService;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @GetMapping("/dashboard.me")
    public String memberDashboardPage(HttpSession session) {
        // 로그인 체크 (선택사항 - 필요시 추가)
        return "member/memberDashboard";
    }

    @GetMapping("/videoList.me")
    public String memberVideoList() { return "member/memberVideoList"; }

    @GetMapping("/info.me")
    public String memberInfo(HttpSession session, Model model) {
        // 세션에서 로그인 정보 가져오기
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            // 로그인하지 않은 경우 메인 페이지로 리다이렉트
            session.setAttribute("errorMsg", "로그인이 필요합니다.");
            return "redirect:/";
        }

        // 인바디 기록 목록 조회
        List<InbodyRecord> inbodyList = inbodyService.getInbodyList(loginMember.getMemberNo());

        // Model에 추가
        model.addAttribute("loginMember", loginMember);
        model.addAttribute("inbodyList", inbodyList);

        return "member/memberInfo";
    }

    @GetMapping("/notice.me")
    public String memberNotice() { return "notice/noticeList"; }

    @GetMapping("/schedule.me")
    public String memberPtSchedule() { return "member/ptSchedule"; }

    @GetMapping("/ptBooking.me")
    public String memberptBookingForm() { return "member/ptBookingForm"; }

    @GetMapping("/booking.me")
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
                               @RequestParam(required = false) String email,
                               @RequestParam(required = false) String address,
                               @RequestParam String birthDate,
                               HttpSession session,
                               Model model) {

        try {
            Member member = new Member();
            member.setMemberType(1);
            member.setMemberId(id);
            member.setMemberPwd(bCryptPasswordEncoder.encode(password));
            member.setMemberName(name);
            member.setMemberPhone(phone);
            member.setMemberAddress(address);
            member.setMemberEmail(email);

            // 생년월일 변환 (YYYYMMDD -> Date)
            if (birthDate != null && birthDate.length() == 8) {
                String formattedDate = birthDate.substring(0, 4) + "-"
                        + birthDate.substring(4, 6) + "-"
                        + birthDate.substring(6, 8);
                member.setMemberBirth(Date.valueOf(formattedDate));
            } else {
                model.addAttribute("errorMsg", "생년월일 형식이 올바르지 않습니다.");
                return "common/error";
            }

            int result = memberService.addMember(member);

            if(result > 0) {
                session.setAttribute("alertMsg", "회원가입에 성공하였습니다.");
                return "redirect:/";
            } else {
                model.addAttribute("errorMsg", "회원가입에 실패하였습니다.");
                return "common/error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg", "회원가입 중 오류가 발생했습니다: " + e.getMessage());
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

        try {
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

            // 생년월일 변환 (YYYYMMDD -> Date)
            if (birthDate != null && birthDate.length() == 8) {
                String formattedDate = birthDate.substring(0, 4) + "-"
                        + birthDate.substring(4, 6) + "-"
                        + birthDate.substring(6, 8);
                member.setMemberBirth(Date.valueOf(formattedDate));
            } else {
                model.addAttribute("errorMsg", "생년월일 형식이 올바르지 않습니다.");
                return "common/error";
            }

            int result = memberService.addMember(member);

            if(result > 0) {
                session.setAttribute("alertMsg", "트레이너 회원가입에 성공하였습니다.");
                return "redirect:/";
            } else {
                model.addAttribute("errorMsg", "트레이너 회원가입에 실패하였습니다.");
                return "common/error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg", "트레이너 회원가입 중 오류가 발생했습니다: " + e.getMessage());
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

        try {
            // Member 객체 생성
            Member member = new Member();
            member.setMemberType(3); // 헬스장 운영자
            member.setMemberId(id);
            member.setMemberPwd(bCryptPasswordEncoder.encode(password));
            member.setMemberName(representative != null ? representative : gymName);
            member.setMemberPhone(phone);
            member.setMemberAddress(address);
            member.setMemberEmail(email);
            member.setMemberBirth(Date.valueOf("1900-01-01")); // 임시값

            // Gym 객체 생성
            Gym gym = new Gym();
            gym.setGymName(gymName != null ? gymName : "미등록 헬스장");
            gym.setGymOwner(representative != null ? representative : "미등록");
            gym.setGymPhone(phone);
            gym.setGymAddress(address != null ? address : "미등록");
            gym.setAttCacheNo(1); // 기본값

            // memberType=3일 때만 addGymOwner 사용 (GYM 테이블 INSERT)
            int result = memberService.addGymOwner(member, gym);

            if(result > 0) {
                session.setAttribute("alertMsg", "헬스장 운영자 회원가입에 성공하였습니다.");
                return "redirect:/";
            } else {
                model.addAttribute("errorMsg", "헬스장 운영자 회원가입에 실패하였습니다.");
                return "common/error";
            }
        } catch (IllegalArgumentException e) {
            // memberType 검증 실패 시
            model.addAttribute("errorMsg", e.getMessage());
            return "common/error";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMsg", "헬스장 운영자 회원가입 중 오류가 발생했습니다: " + e.getMessage());
            return "common/error";
        }
    }
    // 회원정보 수정
    @PostMapping("/updateMemberInfo.me")
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

        // 트레이너 정보 설정 (memberType이 2인 경우만 해당)
        if (loginMember.getMemberType() == 2) {
            updateMember.setTrainerCareer(trainerCareer);
            updateMember.setTrainerLicense(trainerLicense);
            updateMember.setTrainerAward(trainerAward);
        }

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

            // 회원 타입별 리다이렉트 처리
            if (loginMember.getMemberType() == 2) {
                // 트레이너는 대시보드로
                return "redirect:/dashboard.tr";
            } else if (loginMember.getMemberType() == 3) {
                // 헬스장 운영자는 대시보드로
                return "redirect:/dashboard.gym";
            } else {
                // 일반 회원 및 기타 회원은 마이페이지로
                return "redirect:/info.me";
            }
        } else {
            model.addAttribute("errorMsg", "회원정보 수정에 실패했습니다.");
            return "common/error";
        }
    }

    // 비밀번호 변경
    @PostMapping("/updatePassword.me")
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
            return "redirect:/info.me";
        }

        // 새 비밀번호 암호화
        String encodedNewPassword = bCryptPasswordEncoder.encode(newPassword);

        int result = memberService.updatePassword(loginMember.getMemberNo(), encodedNewPassword);

        if (result > 0) {
            session.setAttribute("alertMsg", "비밀번호가 변경되었습니다.");
            return "redirect:/info.me";
        } else {
            model.addAttribute("errorMsg", "비밀번호 변경에 실패했습니다.");
            return "common/error";
        }
    }

    // ====================================== 인바디 기록 ======================================================

    // 인바디 기록 등록
    @PostMapping("/insertInbody.me")
    public String insertInbody(@RequestParam double weight,
                               @RequestParam double muscle,
                               @RequestParam double bodyFat,
                               @RequestParam double bmi,
                               HttpSession session,
                               Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인이 필요합니다.");
            return "common/error";
        }

        InbodyRecord inbody = new InbodyRecord();
        inbody.setMemberNo(loginMember.getMemberNo());
        inbody.setWeight(weight);
        inbody.setSmm(muscle);
        inbody.setPbf(bodyFat);
        inbody.setBmi(bmi);

        int result = inbodyService.insertInbody(inbody);

        if (result > 0) {
            session.setAttribute("alertMsg", "인바디 기록이 등록되었습니다.");
            return "redirect:/info.me";
        } else {
            model.addAttribute("errorMsg", "인바디 기록 등록에 실패했습니다.");
            return "common/error";
        }
    }

    // 인바디 기록 목록 조회
    @GetMapping("/inbodyList.me")
    public String getInbodyList(HttpSession session, Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            model.addAttribute("errorMsg", "로그인이 필요합니다.");
            return "common/error";
        }

        List<InbodyRecord> inbodyList = inbodyService.getInbodyList(loginMember.getMemberNo());
        model.addAttribute("inbodyList", inbodyList);

        return "member/inbodyList";
    }

    // 최근 인바디 기록 조회 (Ajax용)
    @GetMapping("/latestInbody.me")
    @ResponseBody
    public InbodyRecord getLatestInbody(HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            return null;
        }

        return inbodyService.getLatestInbody(loginMember.getMemberNo());
    }



    // ====================================== 로그인 ======================================================
    @PostMapping("/login.me")
    public String login(@RequestParam String id,
                       @RequestParam String password,
                       HttpSession session) {
        
        Member loginMember = memberService.login(id, password);
        
        if (loginMember != null) {
            // 세션에 로그인 정보 저장
            session.setAttribute("loginMember", loginMember);
            
            // 멤버 타입 3(헬스장 운영자)이면 관리자 선택 페이지로 이동
            if (loginMember.getMemberType() == 3) {
                session.setAttribute("alertMsg", loginMember.getMemberName() + "님 환영합니다!");
                return "redirect:/adminSelect.gym";
            }
            
            session.setAttribute("alertMsg", loginMember.getMemberName() + "님 환영합니다!");
            return "redirect:/";
        } else {
            session.setAttribute("errorMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "redirect:/";
        }
    }

    // 로그아웃
    @GetMapping("/logout.me")
    public String logout(HttpSession session) {
        // 세션 완전 무효화
        session.invalidate();
        return "redirect:/?logout=success";
    }

}
