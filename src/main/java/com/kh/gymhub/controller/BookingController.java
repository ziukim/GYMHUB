package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.GymDetail;
import com.kh.gymhub.model.vo.InquiryReserve;
import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.service.GymService;
import com.kh.gymhub.service.GymDetailService;
import com.kh.gymhub.service.InquiryService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class BookingController {

    private final InquiryService inquiryService;
    private final GymService gymService;
    private final GymDetailService gymDetailService;

    @Autowired
    public BookingController(InquiryService inquiryService, GymService gymService, GymDetailService gymDetailService) {
        this.inquiryService = inquiryService;
        this.gymService = gymService;
        this.gymDetailService = gymDetailService;
    }

    @GetMapping("/booking.me")
    public String bookingPage(@RequestParam Integer gymNo,
                              HttpSession session,
                              Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            session.setAttribute("errorMsg", "로그인이 필요합니다.");
            return "redirect:/";
        }

        if (gymNo == null || gymNo <= 0) {
            session.setAttribute("errorMsg", "헬스장을 선택해주세요.");
            return "redirect:/";
        }

        Gym gym = gymService.getGymByNo(gymNo);
        if (gym == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/";
        }

        GymDetail gymDetail = gymDetailService.getGymDetailByGymNo(gymNo);
        InquiryReserve existingReserve = inquiryService.getReserveByMemberAndGym(
                loginMember.getMemberNo(), gymNo);
        List<InquiryReserve> reservedTimes = inquiryService.getReservedTimesByGymNo(gymNo);

        List<String> reservedTimeStrings = new ArrayList<>();
        if (reservedTimes != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            for (InquiryReserve reserve : reservedTimes) {
                if (reserve.getVisitDatetime() != null) {
                    reservedTimeStrings.add(sdf.format(reserve.getVisitDatetime()));
                }
            }
        }

        model.addAttribute("gym", gym);
        model.addAttribute("gymDetail", gymDetail);
        model.addAttribute("loginMember", loginMember);
        model.addAttribute("existingReserve", existingReserve);
        model.addAttribute("reservedTimes", reservedTimeStrings);

        return "booking/booking";
    }

    @PostMapping("/booking/submit.me")
    public String submitBooking(@RequestParam Integer gymNo,
                                @RequestParam String visitDate,
                                @RequestParam String visitTime,
                                HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            session.setAttribute("errorMsg", "로그인이 필요합니다.");
            return "redirect:/";
        }

        if (gymNo == null || gymNo <= 0) {
            session.setAttribute("errorMsg", "헬스장 정보가 올바르지 않습니다.");
            return "redirect:/";
        }

        if (visitDate == null || visitDate.isEmpty() ||
                visitTime == null || visitTime.isEmpty()) {
            session.setAttribute("errorMsg", "날짜와 시간을 선택해주세요.");
            return "redirect:/booking.me?gymNo=" + gymNo;
        }

        InquiryReserve existing = inquiryService.getReserveByMemberAndGym(
                loginMember.getMemberNo(), gymNo);

        if (existing != null) {
            session.setAttribute("errorMsg", "이미 해당 헬스장에 예약이 존재합니다.");
            return "redirect:/booking.me?gymNo=" + gymNo;
        }

        Date visitDatetime = null;
        try {
            String startTime = visitTime.split(" - ")[0].trim();
            String datetimeString = visitDate + " " + startTime;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            visitDatetime = sdf.parse(datetimeString);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "날짜 형식이 올바르지 않습니다.");
            return "redirect:/booking.me?gymNo=" + gymNo;
        }

        InquiryReserve reserve = new InquiryReserve();
        reserve.setGymNo(gymNo);
        reserve.setMemberNo(loginMember.getMemberNo());
        reserve.setVisitDatetime(visitDatetime);
        reserve.setInquiryStatus("대기");
        reserve.setInquiryMemo(null);

        int result = inquiryService.insertReserve(reserve);

        if (result > 0) {
            session.setAttribute("successMsg", "예약이 완료되었습니다.");
            return "redirect:/";
        } else {
            session.setAttribute("errorMsg", "예약에 실패했습니다. 다시 시도해주세요.");
            return "redirect:/booking.me?gymNo=" + gymNo;
        }
    }

    // ✅ 예약 관리 페이지
    @GetMapping("/reservation.gym")
    public String gymReservationManagement(HttpSession session, Model model) {
        System.out.println("====================================");
        System.out.println("예약 관리 페이지 접근!");

        Member loginMember = (Member) session.getAttribute("loginMember");
        System.out.println("loginMember: " + loginMember);

        if (loginMember == null || loginMember.getMemberType() != 3) {
            System.out.println("권한 없음!");
            session.setAttribute("errorMsg", "헬스장 운영자만 접근 가능합니다.");
            return "redirect:/";
        }

        Integer gymNo = loginMember.getGymNo();
        System.out.println("gymNo: " + gymNo);

        if (gymNo == null || gymNo <= 0) {
            System.out.println("소속 헬스장 없음!");
            session.setAttribute("errorMsg", "소속된 헬스장이 없습니다.");
            return "redirect:/dashboard.gym";
        }

        List<InquiryReserve> reservationList = inquiryService.getReservationsByGymNo(gymNo);
        System.out.println("예약 목록: " + (reservationList != null ? reservationList.size() : 0) + "건");

        if (reservationList != null) {
            for (InquiryReserve r : reservationList) {
                System.out.println("  - " + r.getMemberName() + " / " + r.getVisitDatetime() + " / " + r.getInquiryStatus());
            }
        }

        model.addAttribute("reservationList", reservationList);
        System.out.println("====================================");

        return "gym/gymReservationManagement";
    }

    // ✅ 예약 상태 변경
    @PostMapping("/reservation/updateStatus.gym")
    @ResponseBody
    public Map<String, Object> updateReservationStatus(
            @RequestParam("inquiryNo") int inquiryNo,
            @RequestParam("status") String status,
            HttpSession session) {

        Map<String, Object> result = new HashMap<>();

        System.out.println("====================================");
        System.out.println("상태 변경 요청: inquiryNo=" + inquiryNo + ", status=" + status);

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("status", "error");
            result.put("message", "권한이 없습니다.");
            return result;
        }

        int updateResult = inquiryService.updateInquiryStatus(inquiryNo, status);
        System.out.println("업데이트 결과: " + updateResult);
        System.out.println("====================================");

        if (updateResult > 0) {
            result.put("status", "success");
            result.put("message", "상태가 변경되었습니다.");
        } else {
            result.put("status", "error");
            result.put("message", "상태 변경에 실패했습니다.");
        }

        return result;
    }
}