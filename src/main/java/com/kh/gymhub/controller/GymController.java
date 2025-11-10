package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.Member;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GymController {
    
    @GetMapping("/dashboard.gym")
    public String gymDashboard() {
        return "gym/gymDashBoard";
    }

    @GetMapping("/ptBoard.gym")
    public String ptBoard() {
        return "gym/gymPtBoard";
    }

    @GetMapping("/member.gym")
    public String memberManagement() {
        return "gym/gymMemberManagement";
    }

    @GetMapping("/sales.gym")
    public String salesBoard() {
        return "gym/gymSalesBoard";
    }

    @GetMapping("/facility.gym")
    public String facilitiesBoard() {
        return "gym/gymFacilitiesBoard";
    }

    @GetMapping("/facility/machine/enroll.gym")
    public String machineEnrollForm() {
        return "gym/gymMachineEnrollForm";
    }

    @GetMapping("/reservation.gym")
    public String reservationManagement() {
        return "gym/gymReservationManagement";
    }

    @GetMapping("/gym/info.gym")
    public String gymInfoManagement() {
        return "gym/gymInfoManagement";
    }

    @GetMapping("/trainer.gym")
    public String trainerManagement() {
        return "gym/gymTrainerManagement";
    }

    @GetMapping("/video.gym")
    public String videoManagement() {
        return "gym/gymVideoManagement";
    }

    @GetMapping("/product.gym")
    public String productManagement() {
        return "gym/gymProductManagement";
    }

    @GetMapping("/ticket.gym")
    public String ticketManagement() { return "gym/gymTicketManagement"; }

    // 관리자 선택 페이지
    @GetMapping("/admin/adminSelect")
    public String adminSelect(HttpSession session) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        // 로그인하지 않았거나 헬스장 운영자가 아닌 경우 메인 페이지로 리다이렉트
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        return "admin/adminSelect";
    }

    // 출석체크 페이지
    @GetMapping("/admin/attendanceCheck")
    public String attendance(HttpSession session) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        // 로그인하지 않았거나 헬스장 운영자가 아닌 경우 메인 페이지로 리다이렉트
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        return "admin/attendanceCheck";
    }

    // 관리자 메인 페이지
    @GetMapping("/admin/adminMain")
    public String adminMain() {
        return "admin/adminMain";
    }







}
