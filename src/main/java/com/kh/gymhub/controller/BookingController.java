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

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 방문예약 관련 요청을 처리하는 컨트롤러
 */
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

    /**
     * 방문예약 페이지 이동
     * URL: /booking.me?gymNo=1
     */
    @GetMapping("/booking.me")
    public String bookingPage(@RequestParam Integer gymNo,
                              HttpSession session,
                              Model model) {

        // 1. 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            session.setAttribute("errorMsg", "로그인이 필요합니다.");
            return "redirect:/";
        }

        // 2. gymNo 유효성 검사
        if (gymNo == null || gymNo <= 0) {
            session.setAttribute("errorMsg", "헬스장을 선택해주세요.");
            return "redirect:/";
        }

        // 3. 헬스장 정보 조회
        Gym gym = gymService.getGymByNo(gymNo);
        if (gym == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/";
        }

        // 4. 헬스장 상세 정보 조회
        GymDetail gymDetail = gymDetailService.getGymDetailByGymNo(gymNo);

        // 5. 기존 예약 확인 (같은 회원 + 같은 헬스장)
        InquiryReserve existingReserve = inquiryService.getReserveByMemberAndGym(
                loginMember.getMemberNo(), gymNo);

        // 6. 예약된 시간대 조회
        List<InquiryReserve> reservedTimes = inquiryService.getReservedTimesByGymNo(gymNo);

        // 7. 예약된 시간대를 문자열 리스트로 변환 (JavaScript에서 사용)
        List<String> reservedTimeStrings = new ArrayList<String>();
        if (reservedTimes != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            for (int i = 0; i < reservedTimes.size(); i++) {
                InquiryReserve reserve = reservedTimes.get(i);
                if (reserve.getVisitDatetime() != null) {
                    String timeString = sdf.format(reserve.getVisitDatetime());
                    reservedTimeStrings.add(timeString);
                }
            }
        }

        // 8. Model에 데이터 추가
        model.addAttribute("gym", gym);
        model.addAttribute("gymDetail", gymDetail);
        model.addAttribute("loginMember", loginMember);
        model.addAttribute("existingReserve", existingReserve);
        model.addAttribute("reservedTimes", reservedTimeStrings);

        // 9. booking.jsp로 이동
        return "booking/booking";
    }

    /**
     * 예약 제출 처리
     * URL: /booking/submit.me
     */
    @PostMapping("/booking/submit.me")
    public String submitBooking(@RequestParam Integer gymNo,
                                @RequestParam String visitDate,
                                @RequestParam String visitTime,
                                HttpSession session) {

        // 1. 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            session.setAttribute("errorMsg", "로그인이 필요합니다.");
            return "redirect:/";
        }

        // 2. 파라미터 유효성 검사
        if (gymNo == null || gymNo <= 0) {
            session.setAttribute("errorMsg", "헬스장 정보가 올바르지 않습니다.");
            return "redirect:/";
        }

        if (visitDate == null || visitDate.isEmpty() ||
                visitTime == null || visitTime.isEmpty()) {
            session.setAttribute("errorMsg", "날짜와 시간을 선택해주세요.");
            return "redirect:/booking.me?gymNo=" + gymNo;
        }

        // 3. 중복 예약 체크
        InquiryReserve existing = inquiryService.getReserveByMemberAndGym(
                loginMember.getMemberNo(), gymNo);

        if (existing != null) {
            session.setAttribute("errorMsg", "이미 해당 헬스장에 예약이 존재합니다.");
            return "redirect:/booking.me?gymNo=" + gymNo;
        }

        // 4. 날짜와 시간 합치기 (visitDate: 2025-11-20, visitTime: 10:00 - 11:00)
        Date visitDatetime = null;
        try {
            // 시간에서 시작 시간만 추출 (10:00 - 11:00 → 10:00)
            String startTime = visitTime.split(" - ")[0].trim();

            // 날짜 + 시간 조합
            String datetimeString = visitDate + " " + startTime;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            visitDatetime = sdf.parse(datetimeString);
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "날짜 형식이 올바르지 않습니다.");
            return "redirect:/booking.me?gymNo=" + gymNo;
        }

        // 5. 예약 정보 생성
        InquiryReserve reserve = new InquiryReserve();
        reserve.setGymNo(gymNo);
        reserve.setMemberNo(loginMember.getMemberNo());
        reserve.setVisitDatetime(visitDatetime);
        reserve.setInquiryStatus("대기");  // 상태: "대기"
        reserve.setInquiryMemo(null);      // 메모: NULL

        // 6. 예약 정보 저장
        int result = inquiryService.insertReserve(reserve);

        // 7. 결과 처리
        if (result > 0) {
            session.setAttribute("successMsg", "예약이 완료되었습니다.");
            return "redirect:/";  // index.jsp로 이동
        } else {
            session.setAttribute("errorMsg", "예약에 실패했습니다. 다시 시도해주세요.");
            return "redirect:/booking.me?gymNo=" + gymNo;
        }
    }
}
