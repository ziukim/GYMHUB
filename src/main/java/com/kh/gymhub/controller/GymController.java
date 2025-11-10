package com.kh.gymhub.controller;

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
    public String adminSelect() {
        return "admin/adminSelect";
    }

    // 출석체크 페이지
    @GetMapping("/admin/attendanceCheck")
    public String attendance() {
        return "admin/attendanceCheck";
    }

    // 관리자 메인 페이지
    @GetMapping("/admin/adminMain")
    public String adminMain() {
        return "admin/adminMain";
    }


}
