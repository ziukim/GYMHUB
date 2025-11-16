package com.kh.gymhub.controller;

import com.kh.gymhub.model.mapper.AttendanceMapper;
import com.kh.gymhub.model.mapper.LockerMapper;
import com.kh.gymhub.model.mapper.MemberMapper;
import com.kh.gymhub.model.mapper.MembershipMapper;
import com.kh.gymhub.model.mapper.PtPassMapper;
import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.GymDetail;
import com.kh.gymhub.model.vo.InquiryReserve;
import com.kh.gymhub.model.vo.Locker;
import com.kh.gymhub.model.vo.LockerPass;
import com.kh.gymhub.model.vo.MachineManage;
import com.kh.gymhub.model.vo.Membership;
import com.kh.gymhub.model.vo.PtPass;
import com.kh.gymhub.model.vo.PtReserve;
import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.model.vo.MemberWithMembership;
import com.kh.gymhub.model.vo.Product;
import com.kh.gymhub.model.vo.Stock;
import com.kh.gymhub.model.vo.YoutubeUrl;
import com.kh.gymhub.service.GymDetailService;
import com.kh.gymhub.service.GymService;
import com.kh.gymhub.service.InquiryService;
import com.kh.gymhub.service.LockerService;
import com.kh.gymhub.service.MachineService;
import com.kh.gymhub.service.MemberService;
import com.kh.gymhub.service.ProductService;
import com.kh.gymhub.service.PurchaseService;
import com.kh.gymhub.service.SalesService;
import com.kh.gymhub.service.StockService;
import com.kh.gymhub.service.YoutubeUrlService;
import com.kh.gymhub.service.PtReserveService;
import com.kh.gymhub.service.AttendanceService;
import com.kh.gymhub.model.vo.Attendance;
import com.kh.gymhub.model.mapper.PurchaseItemMapper;
import com.kh.gymhub.model.vo.PurchaseItem;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class GymController {
    
    private final ProductService productService;
    private final YoutubeUrlService youtubeUrlService;
    private final MemberService memberService;
    private final LockerService lockerService;
    private final PurchaseService purchaseService;
    private final MembershipMapper membershipMapper;
    private final SalesService salesService;
    private final MemberMapper memberMapper;
    private final GymService gymService;
    private final GymDetailService gymDetailService;
    private final MachineService machineService;
    private final AttendanceMapper attendanceMapper;
    private final StockService stockService;
    private final InquiryService inquiryService;
    private final PtPassMapper ptPassMapper;
    private final LockerMapper lockerMapper;
    private final PtReserveService ptReserveService;
    private final AttendanceService attendanceService;
    private final PurchaseItemMapper purchaseItemMapper;
    
    @Autowired
    public GymController(ProductService productService, YoutubeUrlService youtubeUrlService, MemberService memberService, LockerService lockerService, PurchaseService purchaseService, MembershipMapper membershipMapper, SalesService salesService, MemberMapper memberMapper, GymService gymService, GymDetailService gymDetailService, MachineService machineService, AttendanceMapper attendanceMapper, StockService stockService, InquiryService inquiryService, PtPassMapper ptPassMapper, LockerMapper lockerMapper, PtReserveService ptReserveService, AttendanceService attendanceService, PurchaseItemMapper purchaseItemMapper) {
        this.productService = productService;
        this.youtubeUrlService = youtubeUrlService;
        this.memberService = memberService;
        this.lockerService = lockerService;
        this.purchaseService = purchaseService;
        this.membershipMapper = membershipMapper;
        this.salesService = salesService;
        this.memberMapper = memberMapper;
        this.gymService = gymService;
        this.gymDetailService = gymDetailService;
        this.machineService = machineService;
        this.attendanceMapper = attendanceMapper;
        this.stockService = stockService;
        this.inquiryService = inquiryService;
        this.ptPassMapper = ptPassMapper;
        this.lockerMapper = lockerMapper;
        this.ptReserveService = ptReserveService;
        this.attendanceService = attendanceService;
        this.purchaseItemMapper = purchaseItemMapper;
    }
    
    // 메인 페이지 - 헬스장 목록 조회
    @GetMapping("/")
    public String index(Model model) {
        try {
            // 모든 헬스장 조회
            List<Gym> gyms = gymService.getAllGyms();
            
            // 각 헬스장에 대해 GymDetail 조회하여 합치기
            List<Map<String, Object>> gymList = new ArrayList<>();
            for (Gym gym : gyms) {
                Map<String, Object> gymMap = new HashMap<>();
                
                // Gym 기본 정보
                gymMap.put("gymNo", gym.getGymNo());
                gymMap.put("gymName", gym.getGymName());
                gymMap.put("gymOwner", gym.getGymOwner());
                gymMap.put("gymPhone", gym.getGymPhone());
                gymMap.put("gymAddress", gym.getGymAddress());
                gymMap.put("gymPhotoPath", gym.getGymPhotoPath());
                
                // GymDetail 정보 조회
                GymDetail gymDetail = gymDetailService.getGymDetailByGymNo(gym.getGymNo());
                if (gymDetail != null) {
                    gymMap.put("intro", gymDetail.getIntro());
                    gymMap.put("facilitiesInfo", gymDetail.getFacilitiesInfo());
                    gymMap.put("detailAddress", gymDetail.getDetailAddress());
                    gymMap.put("weekBusinessHour", gymDetail.getWeekBusinessHour());
                    gymMap.put("weekendBusinessHour", gymDetail.getWeekendBusinessHour());
                }
                
                // Product 정보도 조회 (가격 정보용)
                List<Product> products = productService.getProductsByGymNo(gym.getGymNo());
                gymMap.put("products", products);
                
                gymList.add(gymMap);
            }
            
            model.addAttribute("gymList", gymList);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("gymList", new ArrayList<>());
        }
        
        return "index";
    }

    @GetMapping("/dashboard.gym")
    public String gymDashboard(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/";
        }
        
        try {
            // 현재 날짜 기준으로 연도와 월 가져오기
            java.util.Calendar cal = java.util.Calendar.getInstance();
            int year = cal.get(java.util.Calendar.YEAR);
            int month = cal.get(java.util.Calendar.MONTH) + 1; // Calendar.MONTH는 0부터 시작
            
            // 총 매출 조회 (이번 달)
            int totalSales = salesService.getTotalSalesByGymNoAndMonth(gymNo, year, month);
            
            // 활성 회원 수 조회 (만료되지 않은 회원권)
            Integer activeMemberCount = membershipMapper.selectActiveMemberCountByGymNo(gymNo);
            int totalMembers = activeMemberCount != null ? activeMemberCount : 0;
            
            // 신규 회원 수 조회 (이번 달 등록)
            Integer newMemberCount = membershipMapper.selectNewMemberCountByGymNoAndMonth(gymNo, year, month);
            int newMembers = newMemberCount != null ? newMemberCount : 0;
            
            // 오늘 출석 수 조회 (입실만 있고 퇴실이 없는 회원 수)
            Integer todayAttendanceCount = attendanceMapper.selectTodayAttendanceCountByGymNo(gymNo);
            int todayAttendance = todayAttendanceCount != null ? todayAttendanceCount : 0;
            
            // 만료 예정 회원 수 조회 (7일 이내 만료)
            Integer expiringMemberCount = membershipMapper.selectExpiringMemberCountByGymNo(gymNo);
            int expiringMembers = expiringMemberCount != null ? expiringMemberCount : 0;
            
            // 최근 5개월 회원 수 통계 조회
            List<Map<String, Object>> monthlyStats = new ArrayList<>();
            for (int i = 4; i >= 0; i--) {
                // 현재 달에서 i개월 전 계산
                java.util.Calendar monthCal = java.util.Calendar.getInstance();
                monthCal.add(java.util.Calendar.MONTH, -i);
                int statYear = monthCal.get(java.util.Calendar.YEAR);
                int statMonth = monthCal.get(java.util.Calendar.MONTH) + 1;
                
                // 해당 월 말일 기준 활성 회원 수
                Integer monthEndCount = membershipMapper.selectActiveMemberCountByGymNoAndMonthEnd(gymNo, statYear, statMonth);
                int memberCount = monthEndCount != null ? monthEndCount : 0;
                
                // 해당 월에 등록한 회원 수
                Integer monthNewCount = membershipMapper.selectNewMemberCountByGymNoAndMonth(gymNo, statYear, statMonth);
                int newCount = monthNewCount != null ? monthNewCount : 0;
                
                // 해당 월에 만료된 회원 수
                Integer monthExpiredCount = membershipMapper.selectExpiredMemberCountByGymNoAndMonth(gymNo, statYear, statMonth);
                int expiredCount = monthExpiredCount != null ? monthExpiredCount : 0;
                
                Map<String, Object> monthStat = new HashMap<>();
                monthStat.put("year", statYear);
                monthStat.put("month", statMonth);
                monthStat.put("memberCount", memberCount);
                monthStat.put("newCount", newCount);
                monthStat.put("expiredCount", expiredCount);
                monthlyStats.add(monthStat);
            }
            
            // 락커 통계 조회
            List<LockerPass> lockerPassList = lockerService.selectLockerPassListByGymNo(gymNo);
            int totalLockers = lockerPassList != null ? lockerPassList.size() : 0;
            
            // 락커 상태별 통계 계산
            int usedCount = 0;      // 사용중 (7일 이상 남음)
            int expiringCount = 0;  // 만료예정 (7일 이내)
            int expiredCount = 0;   // 만료
            int brokenCount = 0;   // 고장
            int availableCount = 0; // 사용 가능
            
            java.util.Date now = new java.util.Date();
            
            if (lockerPassList != null) {
                for (int i = 0; i < lockerPassList.size(); i++) {
                    LockerPass locker = lockerPassList.get(i);
                    
                    // 고장 락커 체크
                    if (locker.getLockerStatus() != null && locker.getLockerStatus().equals("고장")) {
                        brokenCount++;
                        continue;
                    }
                    
                    // 회원이 있고 종료일이 있는 경우
                    if (locker.getMemberName() != null && !locker.getMemberName().trim().isEmpty() 
                            && locker.getLockerEnd() != null) {
                        // 만료일까지 남은 일수 계산
                        long daysUntilExpiry = (locker.getLockerEnd().getTime() - now.getTime()) / (1000 * 60 * 60 * 24);
                        
                        if (daysUntilExpiry < 0) {
                            // 만료된 락커
                            expiredCount++;
                        } else if (daysUntilExpiry <= 7) {
                            // 만료 예정 락커 (7일 이내)
                            expiringCount++;
                        } else {
                            // 사용중 락커 (7일 이상 남음)
                            usedCount++;
                        }
                    } else {
                        // 빈 락커 (회원이 없고 고장이 아닌 경우)
                        availableCount++;
                    }
                }
            }
            
            // 모델에 데이터 추가
            model.addAttribute("totalSales", totalSales);
            model.addAttribute("totalMembers", totalMembers);
            model.addAttribute("newMembers", newMembers);
            model.addAttribute("todayAttendance", todayAttendance);
            model.addAttribute("expiringMembers", expiringMembers);
            model.addAttribute("monthlyStats", monthlyStats);
            model.addAttribute("year", year);
            model.addAttribute("month", month);
            
            // 락커 통계 추가
            model.addAttribute("totalLockers", totalLockers);
            model.addAttribute("usedLockers", usedCount);
            model.addAttribute("expiringLockers", expiringCount);
            model.addAttribute("expiredLockers", expiredCount);
            model.addAttribute("brokenLockers", brokenCount);
            model.addAttribute("availableLockers", availableCount);
            
            // 재고 목록 조회
            List<Stock> stockList = stockService.selectStockListByGymNo(gymNo);
            model.addAttribute("stockList", stockList != null ? stockList : new ArrayList<>());
            
            // 예약 상담 목록 조회 (승인됨 상태이고 미래 날짜만)
            List<InquiryReserve> reservationList = inquiryService.getApprovedFutureReservationsByGymNo(gymNo);
            model.addAttribute("reservationList", reservationList != null ? reservationList : new ArrayList<>());
            
            // PT 신청관리 목록 조회
            List<PtReserve> pendingPtReserves = ptReserveService.getPendingPtReservesByGymNo(gymNo);
            List<PtReserve> approvedOrRejectedPtReserves = ptReserveService.getApprovedOrRejectedPtReservesByGymNo(gymNo);
            model.addAttribute("pendingPtReserves", pendingPtReserves != null ? pendingPtReserves : new ArrayList<>());
            model.addAttribute("approvedOrRejectedPtReserves", approvedOrRejectedPtReserves != null ? approvedOrRejectedPtReserves : new ArrayList<>());
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 기본값 설정
            model.addAttribute("totalSales", 0);
            model.addAttribute("totalMembers", 0);
            model.addAttribute("newMembers", 0);
            model.addAttribute("todayAttendance", 0);
            model.addAttribute("expiringMembers", 0);
            model.addAttribute("monthlyStats", new ArrayList<>());
            
            // 락커 통계 기본값
            model.addAttribute("totalLockers", 0);
            model.addAttribute("usedLockers", 0);
            model.addAttribute("expiringLockers", 0);
            model.addAttribute("expiredLockers", 0);
            model.addAttribute("brokenLockers", 0);
            model.addAttribute("availableLockers", 0);
            
            // 재고 목록 기본값
            model.addAttribute("stockList", new ArrayList<>());
            
            // 예약 상담 목록 기본값
            model.addAttribute("reservationList", new ArrayList<>());
            
            // PT 신청관리 목록 기본값
            model.addAttribute("pendingPtReserves", new ArrayList<>());
            model.addAttribute("approvedOrRejectedPtReserves", new ArrayList<>());
        }
        
        return "gym/gymDashBoard";
    }

    @GetMapping("/ptBoard.gym")
    public String ptBoard(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/";
        }
        
        try {
            // 대기중인 PT 예약 조회
            List<PtReserve> pendingPtReserves = ptReserveService.getPendingPtReservesByGymNo(gymNo);
            
            // 승인됨/거절됨 PT 예약 조회 (미래 날짜만)
            List<PtReserve> approvedOrRejectedPtReserves = ptReserveService.getApprovedOrRejectedPtReservesByGymNo(gymNo);
            
            // 모델에 데이터 추가
            model.addAttribute("pendingPtReserves", pendingPtReserves != null ? pendingPtReserves : new ArrayList<>());
            model.addAttribute("approvedOrRejectedPtReserves", approvedOrRejectedPtReserves != null ? approvedOrRejectedPtReserves : new ArrayList<>());
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 기본값 설정
            model.addAttribute("pendingPtReserves", new ArrayList<>());
            model.addAttribute("approvedOrRejectedPtReserves", new ArrayList<>());
        }
        
        return "gym/gymPtBoard";
    }

    @GetMapping("/member.gym")
    public String memberManagement(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/";
        }
        
        try {
            // 해당 헬스장의 회원 목록 조회
            List<MemberWithMembership> members = membershipMapper.selectMembersWithMembershipByGymNo(gymNo);
            model.addAttribute("members", members);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("members", new java.util.ArrayList<>());
        }
        
        return "gym/gymMemberManagement";
    }

    @GetMapping("/sales.gym")
    public String salesBoard(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/";
        }
        
        try {
            // 현재 날짜 기준으로 연도와 월 가져오기
            java.util.Calendar cal = java.util.Calendar.getInstance();
            int year = cal.get(java.util.Calendar.YEAR);
            int month = cal.get(java.util.Calendar.MONTH) + 1; // Calendar.MONTH는 0부터 시작
            
            // 매출 데이터 조회
            int membershipSales = salesService.getMembershipSalesByGymNoAndMonth(gymNo, year, month);
            int stockSales = salesService.getStockSalesByGymNoAndMonth(gymNo, year, month);
            int totalSales = salesService.getTotalSalesByGymNoAndMonth(gymNo, year, month);
            
            // 전체 회원 수 조회
            List<MemberWithMembership> members = membershipMapper.selectMembersWithMembershipByGymNo(gymNo);
            int totalMembers = members != null ? members.size() : 0;
            
            // 모델에 데이터 추가
            model.addAttribute("membershipSales", membershipSales);
            model.addAttribute("stockSales", stockSales);
            model.addAttribute("totalSales", totalSales);
            model.addAttribute("totalMembers", totalMembers);
            model.addAttribute("year", year);
            model.addAttribute("month", month);
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 발생 시 기본값 설정
            model.addAttribute("membershipSales", 0);
            model.addAttribute("stockSales", 0);
            model.addAttribute("totalSales", 0);
            model.addAttribute("totalMembers", 0);
        }
        
        return "gym/gymSalesBoard";
    }


    @GetMapping("/reservation.gym")
    public String reservationManagement(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/";
        }
        
        try {
            // '예약' 상태의 예약 목록 조회
            List<InquiryReserve> reservedInquiries = inquiryService.getReservedInquiriesByGymNo(gymNo);
            model.addAttribute("reservedInquiries", reservedInquiries != null ? reservedInquiries : new ArrayList<>());
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("reservedInquiries", new ArrayList<>());
        }
        
        return "gym/gymReservationManagement";
    }
    
    // 예약 상담 완료 처리 (AJAX)
    @PostMapping("/reservation/complete.ajax")
    @ResponseBody
    public java.util.Map<String, Object> completeReservation(@RequestBody java.util.Map<String, Object> requestData, HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            int inquiryNo = Integer.parseInt(requestData.get("inquiryNo").toString());
            
            // 예약 상태를 '완료'로 업데이트
            int updateResult = inquiryService.updateInquiryStatusToCompleted(inquiryNo);
            
            if (updateResult > 0) {
                result.put("success", true);
                result.put("message", "상담이 완료 처리되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "상담 완료 처리에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "상담 완료 처리 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    @GetMapping("/info.gym")
    public String gymInfoManagement(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");

        // 로그인하지 않았거나 헬스장 운영자가 아닌 경우 메인 페이지로 리다이렉트
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }

        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/";
        }

        // 헬스장 정보 조회 및 Model에 추가
        try {
            Gym gym = gymService.getGymByNo(gymNo);
            GymDetail gymDetail = gymDetailService.getGymDetailByGymNo(gymNo);
            
            System.out.println("=== Gym Info ===");
            System.out.println("Gym Photo Path: " + gym.getGymPhotoPath());
            
            model.addAttribute("gym", gym);
            model.addAttribute("gymDetail", gymDetail);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "gym/gymInfoManagement";
    }

    @GetMapping("/trainer.gym")
    public String trainerManagement(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/";
        }
        
        try {
            // 해당 헬스장의 트레이너 목록 조회 (memberType=2, gymNo=해당 헬스장)
            List<Member> trainers = memberMapper.selectTrainersByGymNo(gymNo);
            model.addAttribute("trainers", trainers != null ? trainers : new java.util.ArrayList<>());
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("trainers", new java.util.ArrayList<>());
        }
        
        return "gym/gymTrainerManagement";
    }
    
    @PostMapping("/trainer/register.gym")
    public String registerTrainer(@RequestParam("memberId") String memberId, HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/trainer.gym";
        }
        
        try {
            // 트레이너 조회 (memberType=2, gymNo=null)
            Member trainer = memberMapper.getTrainerByIdForRegistration(memberId);
            
            if (trainer == null) {
                session.setAttribute("errorMsg", "등록 가능한 트레이너를 찾을 수 없습니다. (이미 다른 헬스장에 등록되었거나 트레이너가 아닌 회원입니다.)");
                return "redirect:/trainer.gym";
            }
            
            // 트레이너의 gymNo 업데이트
            int updateResult = memberMapper.updateMemberGymNo(trainer.getMemberNo(), gymNo);
            
            if (updateResult > 0) {
                session.setAttribute("successMsg", "트레이너가 성공적으로 등록되었습니다.");
            } else {
                session.setAttribute("errorMsg", "트레이너 등록에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "트레이너 등록 중 오류가 발생했습니다.");
        }
        
        return "redirect:/trainer.gym";
    }
    
    @PostMapping("/trainer/delete.gym")
    public String deleteTrainer(@RequestParam("memberNo") int memberNo, HttpSession session) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/trainer.gym";
        }
        
        try {
            // 트레이너가 해당 헬스장 소속인지 확인
            List<Member> trainers = memberMapper.selectTrainersByGymNo(gymNo);
            Member trainer = null;
            for (Member t : trainers) {
                if (t.getMemberNo() == memberNo) {
                    trainer = t;
                    break;
                }
            }
            
            if (trainer != null) {
                // gymNo를 null로 업데이트 (삭제 대신 헬스장 연결 해제)
                int updateResult = memberMapper.updateMemberGymNo(memberNo, null);
                
                if (updateResult > 0) {
                    session.setAttribute("successMsg", "트레이너가 삭제되었습니다.");
                } else {
                    session.setAttribute("errorMsg", "트레이너 삭제에 실패했습니다.");
                }
            } else {
                session.setAttribute("errorMsg", "해당 트레이너를 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("errorMsg", "트레이너 삭제 중 오류가 발생했습니다.");
        }
        
        return "redirect:/trainer.gym";
    }
    
    // AJAX: 트레이너 아이디 조회 (memberType=2, gymNo=null)
    @GetMapping("/trainer/lookup.ajax")
    @ResponseBody
    public java.util.Map<String, Object> lookupTrainer(@RequestParam String memberId) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        try {
            if (memberId == null || memberId.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "아이디를 입력해주세요.");
                return result;
            }
            
            // 트레이너 조회 (memberType=2, gymNo=null)
            Member trainer = memberMapper.getTrainerByIdForRegistration(memberId.trim());
            
            if (trainer == null) {
                result.put("success", false);
                result.put("message", "등록 가능한 트레이너를 찾을 수 없습니다. (이미 다른 헬스장에 등록되었거나 트레이너가 아닌 회원입니다.)");
                return result;
            }
            
            result.put("success", true);
            result.put("trainer", trainer);
            result.put("message", "트레이너 정보를 조회했습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "트레이너 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    @GetMapping("/video.gym")
    public String videoManagement(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        // 로그인하지 않았거나 헬스장 운영자가 아닌 경우 메인 페이지로 리다이렉트
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/";
        }
        
        model.addAttribute("gymNo", gymNo);
        
        return "gym/gymVideoManagement";
    }

    // AJAX: 헬스장 영상 리스트 조회
    @GetMapping("/video/list.ajax")
    @ResponseBody
    public java.util.Map<String, Object> getVideoList(HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 모든 영상 조회
            List<YoutubeUrl> videos = youtubeUrlService.getYoutubeUrlsByGymNo(gymNo);
            
            result.put("success", true);
            result.put("videos", videos);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "데이터 조회 중 오류가 발생했습니다.");
        }
        
        return result;
    }

    // AJAX: 영상 추가
    @PostMapping("/video/add.ajax")
    @ResponseBody
    public java.util.Map<String, Object> addVideoAjax(@RequestBody java.util.Map<String, Object> requestData,
                                                       HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 요청 데이터 파싱
            String youtubeUrl = (String) requestData.get("youtubeUrl");
            String videoTitle = (String) requestData.get("videoTitle");
            String videoAuthor = (String) requestData.get("videoAuthor");
            
            if (youtubeUrl == null || youtubeUrl.trim().isEmpty() ||
                videoTitle == null || videoTitle.trim().isEmpty() ||
                videoAuthor == null || videoAuthor.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "모든 필드를 입력해주세요.");
                return result;
            }
            
            // 영상 생성
            YoutubeUrl video = new YoutubeUrl();
            video.setGymNo(gymNo);
            video.setYoutubeUrl(youtubeUrl.trim());
            video.setYoutubeUrlTitle(videoTitle.trim());
            video.setYoutubeUrlWriter(videoAuthor.trim());
            
            // DB에 추가
            int addResult = youtubeUrlService.addYoutubeUrl(video);
            
            if (addResult > 0) {
                // 추가된 영상 조회
                List<YoutubeUrl> allVideos = youtubeUrlService.getYoutubeUrlsByGymNo(gymNo);
                YoutubeUrl addedVideo = null;
                
                for (YoutubeUrl v : allVideos) {
                    if (v.getYoutubeUrl().equals(youtubeUrl.trim()) &&
                        v.getYoutubeUrlTitle().equals(videoTitle.trim()) &&
                        v.getYoutubeUrlWriter().equals(videoAuthor.trim())) {
                        addedVideo = v;
                        break;
                    }
                }
                
                if (addedVideo != null) {
                    result.put("success", true);
                    result.put("message", "영상이 업로드되었습니다.");
                    result.put("video", addedVideo);
                } else {
                    result.put("success", true);
                    result.put("message", "영상이 업로드되었습니다.");
                }
            } else {
                result.put("success", false);
                result.put("message", "영상 업로드에 실패했습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "영상 업로드 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // AJAX: 영상 삭제
    @PostMapping("/video/delete.ajax")
    @ResponseBody
    public java.util.Map<String, Object> deleteVideoAjax(@RequestBody java.util.Map<String, Object> requestData,
                                                           HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 요청 데이터 파싱
            Integer youtubeUrlNo = Integer.parseInt(requestData.get("youtubeUrlNo").toString());
            
            // 영상 조회하여 헬스장 번호 확인
            List<YoutubeUrl> videos = youtubeUrlService.getYoutubeUrlsByGymNo(gymNo);
            YoutubeUrl video = null;
            
            for (YoutubeUrl v : videos) {
                if (v.getYoutubeUrlNo() == youtubeUrlNo) {
                    video = v;
                    break;
                }
            }
            
            if (video == null) {
                result.put("success", false);
                result.put("message", "영상을 찾을 수 없습니다.");
                return result;
            }
            
            // DB에서 삭제
            int deleteResult = youtubeUrlService.deleteYoutubeUrl(youtubeUrlNo);
            
            if (deleteResult > 0) {
                result.put("success", true);
                result.put("message", "영상이 삭제되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "영상 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "영상 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    @GetMapping("/product.gym")
    public String productManagement(HttpSession session, Model model) {
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        // 로그인하지 않았거나 헬스장 운영자가 아닌 경우 메인 페이지로 리다이렉트
        if (loginMember == null || loginMember.getMemberType() != 3) {
            session.setAttribute("errorMsg", "헬스장 운영자만 접근할 수 있습니다.");
            return "redirect:/";
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            session.setAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "redirect:/";
        }
        
        model.addAttribute("gymNo", gymNo);
        
        return "gym/gymProductManagement";
    }

    // AJAX: 헬스장 상품 리스트 조회
    @GetMapping("/product/list.ajax")
    @ResponseBody
    public java.util.Map<String, Object> getProductList(HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 모든 상품 조회
            List<Product> allProducts = productService.getProductsByGymNo(gymNo);
            
            // 상품 타입별로 분류
            List<Product> membershipProducts = new java.util.ArrayList<>();
            List<Product> ptProducts = new java.util.ArrayList<>();
            List<Product> lockerProducts = new java.util.ArrayList<>();
            
            for (Product p : allProducts) {
                if ("회원권".equals(p.getProductType())) {
                    membershipProducts.add(p);
                } else if ("PT".equals(p.getProductType())) {
                    ptProducts.add(p);
                } else if ("락커".equals(p.getProductType())) {
                    lockerProducts.add(p);
                }
            }
            
            result.put("success", true);
            result.put("membership", membershipProducts);
            result.put("pt", ptProducts);
            result.put("locker", lockerProducts);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "데이터 조회 중 오류가 발생했습니다.");
        }
        
        return result;
    }

    // AJAX: 빈 락커 목록 조회
    @GetMapping("/locker/available.ajax")
    @ResponseBody
    public java.util.Map<String, Object> getAvailableLockers(HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 모든 락커 조회 (현재 유효한 기간의 락커만 조회됨)
            List<LockerPass> allLockers = lockerService.selectLockerPassListByGymNo(gymNo);
            
            // 빈 락커만 필터링
            // 1. memberName이 null이거나 빈 문자열인 경우 (락커권이 없는 경우)
            // 2. lockerPassStatus가 null인 경우 (락커권이 없는 경우)
            List<LockerPass> availableLockers = new java.util.ArrayList<>();
            for (LockerPass locker : allLockers) {
                if (locker.getMemberName() == null || locker.getMemberName().trim().isEmpty()) {
                    if (locker.getLockerPassStatus() == null || locker.getLockerPassStatus().trim().isEmpty()) {
                        availableLockers.add(locker);
                    }
                }
            }
            
            result.put("success", true);
            result.put("lockers", availableLockers);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "락커 목록 조회 중 오류가 발생했습니다.");
        }
        
        return result;
    }

    // AJAX: 회원 등록 (구매 등록)
    @PostMapping("/member/register.ajax")
    @ResponseBody
    public java.util.Map<String, Object> registerMember(@RequestBody java.util.Map<String, Object> requestData,
                                                         HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 요청 데이터 파싱
            String memberId = (String) requestData.get("memberId");
            java.util.List<Integer> productNos = (java.util.List<Integer>) requestData.get("productNos");
            String startDateStr = (String) requestData.get("startDate");
            String endDateStr = (String) requestData.get("endDate");
            String lockerRealNum = (String) requestData.get("lockerRealNum");
            
            if (memberId == null || memberId.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "회원 아이디가 필요합니다.");
                return result;
            }
            
            if (productNos == null || productNos.isEmpty()) {
                result.put("success", false);
                result.put("message", "상품을 선택해주세요.");
                return result;
            }
            
            // 회원 조회
            Member member = memberService.getMemberById(memberId);
            if (member == null) {
                result.put("success", false);
                result.put("message", "회원을 찾을 수 없습니다.");
                return result;
            }
            
            // 선택한 상품들 조회
            java.util.List<Product> selectedProducts = new java.util.ArrayList<>();
            java.util.List<Product> allProducts = productService.getProductsByGymNo(gymNo);
            for (Integer productNo : productNos) {
                for (Product product : allProducts) {
                    if (product.getProductNo() == productNo) {
                        selectedProducts.add(product);
                        break;
                    }
                }
            }
            
            if (selectedProducts.isEmpty()) {
                result.put("success", false);
                result.put("message", "선택한 상품을 찾을 수 없습니다.");
                return result;
            }
            
            // 날짜 파싱
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.util.Date startDate = sdf.parse(startDateStr);
            java.util.Date endDate = sdf.parse(endDateStr);
            
            // 회원 등록 (구매 등록)
            int purchaseNo = purchaseService.registerMemberPurchase(member, gymNo, selectedProducts, startDate, endDate, lockerRealNum);
            
            if (purchaseNo > 0) {
                result.put("success", true);
                result.put("message", "회원이 성공적으로 등록되었습니다.");
                result.put("purchaseNo", purchaseNo);
            } else {
                result.put("success", false);
                result.put("message", "회원 등록에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "회원 등록 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // AJAX: 상품 추가
    @PostMapping("/product/add.ajax")
    @ResponseBody
    public java.util.Map<String, Object> addProductAjax(@RequestBody java.util.Map<String, Object> requestData,
                                                        HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 요청 데이터 파싱
            String category = (String) requestData.get("category");
            String name = (String) requestData.get("name");
            Integer price = Integer.parseInt(requestData.get("price").toString());
            String duration = (String) requestData.get("duration");
            
            // category를 productType으로 변환
            String productType;
            if ("membership".equals(category)) {
                productType = "회원권";
            } else if ("pt".equals(category)) {
                productType = "PT";
            } else if ("locker".equals(category)) {
                productType = "락커";
            } else {
                result.put("success", false);
                result.put("message", "잘못된 상품 타입입니다.");
                return result;
            }
            
            // duration에서 일(day) 단위로 변환
            // 이용권/락커: "30일", "365일" 형식만 허용
            // PT: "10회", "20회" 형식만 허용
            int durationMonths = 0;
            try {
                duration = duration.trim();
                
                if ("pt".equals(category)) {
                    // PT는 회(횟수) 단위: "10회" 또는 "10" 형식
                    String countNumber = duration.replaceAll("[^0-9]", "");
                    if (!countNumber.isEmpty()) {
                        durationMonths = Integer.parseInt(countNumber);
                    }
                } else {
                    // 이용권/락커는 일 단위: "30일" 또는 "30" 형식
                    String dayNumber = duration.replaceAll("[^0-9]", "");
                    if (!dayNumber.isEmpty()) {
                        durationMonths = Integer.parseInt(dayNumber);
                    }
                }
            } catch (Exception e) {
                result.put("success", false);
                result.put("message", "유효기간 형식이 올바르지 않습니다. 일 단위로 입력해주세요. (예: 30일, 365일)");
                return result;
            }
            
            if (durationMonths <= 0) {
                result.put("success", false);
                result.put("message", "유효기간은 1 이상이어야 합니다.");
                return result;
            }
            
            // 상품 생성
            Product product = new Product();
            product.setGymNo(gymNo);
            product.setProductType(productType);
            product.setProductPrice(price);
            product.setDurationMonths(durationMonths);
            product.setProductStartDate(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            product.setProductStatus("Y");
            
            // DB에 추가
            int addResult = productService.addProduct(product);
            
            if (addResult > 0) {
                // 추가된 상품 조회 (productNo를 얻기 위해)
                List<Product> allProducts = productService.getProductsByGymNo(gymNo);
                Product addedProduct = null;
                int maxProductNo = 0;
                
                // 조건에 맞는 상품 중 가장 큰 productNo를 가진 상품 찾기
                for (Product p : allProducts) {
                    if (p.getProductType().equals(productType) 
                            && p.getProductPrice() == price 
                            && p.getDurationMonths() == durationMonths
                            && "Y".equals(p.getProductStatus())) {
                        if (p.getProductNo() > maxProductNo) {
                            maxProductNo = p.getProductNo();
                            addedProduct = p;
                        }
                    }
                }
                
                if (addedProduct != null) {
                    result.put("success", true);
                    result.put("message", "상품이 추가되었습니다.");
                    result.put("product", addedProduct);
                } else {
                    result.put("success", true);
                    result.put("message", "상품이 추가되었습니다.");
                }
            } else {
                result.put("success", false);
                result.put("message", "상품 추가에 실패했습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "상품 추가 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // AJAX: 상품 수정
    @PostMapping("/product/update.ajax")
    @ResponseBody
    public java.util.Map<String, Object> updateProductAjax(@RequestBody java.util.Map<String, Object> requestData,
                                                           HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 요청 데이터 파싱
            Integer productNo = Integer.parseInt(requestData.get("productNo").toString());
            String name = (String) requestData.get("name");
            Integer price = Integer.parseInt(requestData.get("price").toString());
            String duration = (String) requestData.get("duration");
            String category = (String) requestData.get("category");
            
            // 상품 조회하여 헬스장 번호 확인
            List<Product> products = productService.getProductsByGymNo(gymNo);
            Product product = null;
            
            for (Product p : products) {
                if (p.getProductNo() == productNo) {
                    product = p;
                    break;
                }
            }
            
            if (product == null) {
                result.put("success", false);
                result.put("message", "상품을 찾을 수 없습니다.");
                return result;
            }
            
            // category를 productType으로 변환
            String productType;
            if ("membership".equals(category)) {
                productType = "회원권";
            } else if ("pt".equals(category)) {
                productType = "PT";
            } else if ("locker".equals(category)) {
                productType = "락커";
            } else {
                productType = product.getProductType(); // 기존 값 유지
            }
            
            // duration에서 일(day) 단위로 변환
            int durationMonths = 0;
            try {
                duration = duration.trim();
                
                if ("pt".equals(category)) {
                    // PT는 회(횟수) 단위: "10회" 또는 "10" 형식
                    String countNumber = duration.replaceAll("[^0-9]", "");
                    if (!countNumber.isEmpty()) {
                        durationMonths = Integer.parseInt(countNumber);
                    }
                } else {
                    // 이용권/락커는 일 단위: "30일" 또는 "30" 형식
                    String dayNumber = duration.replaceAll("[^0-9]", "");
                    if (!dayNumber.isEmpty()) {
                        durationMonths = Integer.parseInt(dayNumber);
                    }
                }
            } catch (Exception e) {
                result.put("success", false);
                result.put("message", "유효기간 형식이 올바르지 않습니다. 일 단위로 입력해주세요. (예: 30일, 365일)");
                return result;
            }
            
            if (durationMonths <= 0) {
                result.put("success", false);
                result.put("message", "유효기간은 1 이상이어야 합니다.");
                return result;
            }
            
            // 상품 정보 업데이트
            product.setProductType(productType);
            product.setProductPrice(price);
            product.setDurationMonths(durationMonths);
            
            // DB에 수정
            int updateResult = productService.updateProduct(product);
            
            if (updateResult > 0) {
                // 수정된 상품 조회
                List<Product> updatedProducts = productService.getProductsByGymNo(gymNo);
                Product updatedProduct = null;
                
                for (Product p : updatedProducts) {
                    if (p.getProductNo() == productNo) {
                        updatedProduct = p;
                        break;
                    }
                }
                
                if (updatedProduct != null) {
                    result.put("success", true);
                    result.put("message", "상품이 수정되었습니다.");
                    result.put("product", updatedProduct);
                } else {
                    result.put("success", true);
                    result.put("message", "상품이 수정되었습니다.");
                }
            } else {
                result.put("success", false);
                result.put("message", "상품 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "상품 수정 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // AJAX: 상품 삭제
    @PostMapping("/product/delete.ajax")
    @ResponseBody
    public java.util.Map<String, Object> deleteProductAjax(@RequestBody java.util.Map<String, Object> requestData,
                                                            HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 요청 데이터 파싱
            Integer productNo = Integer.parseInt(requestData.get("productNo").toString());
            
            // 상품 조회하여 헬스장 번호 확인
            List<Product> products = productService.getProductsByGymNo(gymNo);
            Product product = null;
            
            for (Product p : products) {
                if (p.getProductNo() == productNo) {
                    product = p;
                    break;
                }
            }
            
            if (product == null) {
                result.put("success", false);
                result.put("message", "상품을 찾을 수 없습니다.");
                return result;
            }
            
            // DB에서 삭제
            int deleteResult = productService.deleteProduct(productNo);
            
            if (deleteResult > 0) {
                result.put("success", true);
                result.put("message", "상품이 삭제되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "상품 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "상품 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // 관리자 선택 페이지
    @GetMapping("/adminSelect.gym")
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
    @GetMapping("/attendanceCheck.gym")
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
    
    // 출석 체크 처리 (AJAX)
    @PostMapping("/attendance/check.ajax")
    @ResponseBody
    public Map<String, Object> checkAttendance(@RequestBody Map<String, Object> requestData, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 확인
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 전화번호 추출 (하이픈 제거)
            String phone = requestData.get("phone").toString().replace("-", "");
            
            if (phone == null || phone.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "전화번호를 입력해주세요.");
                return result;
            }
            
            // 전화번호로 회원 조회 (gym_no 매칭, 만료되지 않은 회원권 보유자만)
            Member member = attendanceService.getMemberByPhoneAndGymNo(phone, gymNo);
            boolean isTrainer = false;
            
            // 회원 조회 실패 시 트레이너 조회 시도
            if (member == null) {
                member = attendanceService.getTrainerByPhoneAndGymNo(phone, gymNo);
                if (member != null) {
                    isTrainer = true;
                }
            }
            
            if (member == null) {
                result.put("success", false);
                result.put("message", "등록된 회원이 아니거나 만료된 회원권입니다.");
                return result;
            }
            
            // 회원권 정보 조회 (트레이너인 경우 회원권 정보 없음)
            String membershipInfo = "";
            
            if (!isTrainer) {
                // 회원인 경우에만 회원권 정보 조회
                Membership membership = membershipMapper.selectMembershipByMemberNo(member.getMemberNo(), gymNo);
                
                if (membership != null) {
                    PurchaseItem purchaseItem = purchaseItemMapper.selectPurchaseItemByPurchaseNo(membership.getPurchaseNo());
                    if (purchaseItem != null) {
                        // 회원권 정보 문자열 생성 (예: "이용권 30일 + 락커 30일 + PT 10회")
                        java.util.List<String> productList = new java.util.ArrayList<>();
                        
                        if (purchaseItem.getMembershipPeriod() > 0) {
                            productList.add("이용권 " + purchaseItem.getMembershipPeriod() + "일");
                        }
                        if (purchaseItem.getLockerPeriod() != null && purchaseItem.getLockerPeriod() > 0) {
                            productList.add("락커 " + purchaseItem.getLockerPeriod() + "일");
                        }
                        if (purchaseItem.getPtCount() != null && purchaseItem.getPtCount() > 0) {
                            productList.add("PT " + purchaseItem.getPtCount() + "회");
                        }
                        
                        membershipInfo = String.join(" + ", productList);
                    }
                }
            }
            
            // 오늘 날짜의 입실 기록 조회
            Attendance todayCheckIn = attendanceService.getTodayCheckIn(gymNo, member.getMemberNo());
            
            if (todayCheckIn == null) {
                // 입실 기록이 없으면 입실 처리
                Attendance checkIn = new Attendance();
                checkIn.setGymNo(gymNo);
                checkIn.setMemberNo(member.getMemberNo());
                checkIn.setCheckInInfo("입실");
                checkIn.setAttendanceDate(new java.util.Date());
                
                int insertResult = attendanceService.insertAttendance(checkIn);
                
                if (insertResult > 0) {
                    result.put("success", true);
                    result.put("type", "입실");
                    result.put("message", "입실 처리되었습니다.");
                    result.put("memberName", member.getMemberName());
                    result.put("memberPhone", member.getMemberPhone());
                    result.put("membershipInfo", membershipInfo);
                } else {
                    result.put("success", false);
                    result.put("message", "입실 처리에 실패했습니다.");
                }
            } else {
                // 입실 기록이 있으면 퇴실 기록 INSERT
                // 오늘 날짜에 이미 퇴실 기록이 있는지 확인
                Attendance todayCheckOut = attendanceService.getTodayCheckOut(gymNo, member.getMemberNo());
                
                if (todayCheckOut != null) {
                    // 이미 퇴실 기록이 있음
                    result.put("success", false);
                    result.put("message", "이미 오늘 퇴실 처리되었습니다.");
                } else {
                    // 퇴실 기록 INSERT
                    Attendance checkOut = new Attendance();
                    checkOut.setGymNo(gymNo);
                    checkOut.setMemberNo(member.getMemberNo());
                    checkOut.setCheckInInfo("퇴실");
                    checkOut.setAttendanceDate(new java.util.Date());
                    
                    int insertResult = attendanceService.insertAttendance(checkOut);
                    
                    if (insertResult > 0) {
                        result.put("success", true);
                        result.put("type", "퇴실");
                        result.put("message", "퇴실 처리되었습니다.");
                        result.put("memberName", member.getMemberName());
                        result.put("memberPhone", member.getMemberPhone());
                        result.put("membershipInfo", membershipInfo);
                    } else {
                        result.put("success", false);
                        result.put("message", "퇴실 처리에 실패했습니다.");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "출석 체크 처리 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // 관리자 메인 페이지
    @GetMapping("/adminMain.gym")
    public String adminMain() {
        return "admin/adminMain";
    }

    // AJAX: 회원 아이디 조회 (헬스장 등록용 - gym_no가 null인 회원만)
    @GetMapping("/member/lookup.ajax")
    @ResponseBody
    public java.util.Map<String, Object> lookupMember(@RequestParam String memberId) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        try {
            if (memberId == null || memberId.trim().isEmpty()) {
                result.put("success", false);
                result.put("message", "아이디를 입력해주세요.");
                return result;
            }
            
            // gym_no가 null인 회원 조회
            Member member = memberService.getMemberByIdForGymRegistration(memberId.trim());
            
            if (member == null) {
                result.put("success", false);
                result.put("message", "등록 가능한 회원을 찾을 수 없습니다. (이미 다른 헬스장에 등록되었거나 존재하지 않는 회원입니다.)");
                return result;
            }
            
            // 회원 정보 반환
            result.put("success", true);
            result.put("member", member);
            result.put("message", "회원 정보를 조회했습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "회원 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // AJAX: 이용권 목록 조회 (회원 등록용)
    @GetMapping("/member/products.ajax")
    @ResponseBody
    public java.util.Map<String, Object> getProductsForMemberRegistration(HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 타입별로 상품 조회
            List<Product> membershipProducts = productService.getProductsByGymNoAndType(gymNo, "회원권");
            List<Product> lockerProducts = productService.getProductsByGymNoAndType(gymNo, "락커");
            List<Product> ptProducts = productService.getProductsByGymNoAndType(gymNo, "PT");
            
            result.put("success", true);
            result.put("membership", membershipProducts);
            result.put("locker", lockerProducts);
            result.put("pt", ptProducts);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "상품 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // AJAX: 회원 목록 조회 (Membership 테이블에 정보가 있는 회원만)
    @GetMapping("/member/list.ajax")
    @ResponseBody
    public java.util.Map<String, Object> getMemberList(HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 해당 헬스장의 회원 목록 조회
            List<MemberWithMembership> members = membershipMapper.selectMembersWithMembershipByGymNo(gymNo);
            
            result.put("success", true);
            result.put("members", members);
            result.put("count", members.size());
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "회원 목록 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // 헬스장 상세 정보 조회 (AJAX)
    @GetMapping("/gym/detail.ajax")
    @ResponseBody
    public Map<String, Object> getGymDetail(@RequestParam("gymNo") int gymNo) {
        Map<String, Object> result = new HashMap<>();

        try {
            Gym gym = gymService.getGymByNo(gymNo);
            GymDetail gymDetail = gymDetailService.getGymDetailByGymNo(gymNo);
            
            // Product 정보도 조회
            List<Product> products = productService.getProductsByGymNo(gymNo);

            if (gym != null) {
                result.put("success", true);
                result.put("gym", gym);
                result.put("gymDetail", gymDetail);
                result.put("products", products != null ? products : new ArrayList<>());
            } else {
                result.put("success", false);
                result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "데이터 조회 중 오류가 발생했습니다.");
        }

        return result;
    }

    @PostMapping("/uploadGymImage.gym")
    @ResponseBody
    public Map<String, Object> uploadGymImage(@RequestParam("gymImage") MultipartFile file,
                                              HttpSession session,
                                              HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }

        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }

        if (file.isEmpty()) {
            result.put("success", false);
            result.put("message", "파일이 선택되지 않았습니다.");
            return result;
        }

        try {
            // 파일 저장 경로 설정
            String uploadPath = session.getServletContext().getRealPath("/resources/uploadfiles/Gym");
            File uploadDir = new File(uploadPath);

            // 디렉토리가 없으면 생성
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 원본 파일명
            String originalFilename = file.getOriginalFilename();

            // 확장자 추출
            String extension = "";
            if (originalFilename != null && originalFilename.contains(".")) {
                extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            }

            // 고유한 파일명 생성 (gym_헬스장번호_타임스탬프.확장자)
            String savedFilename = "gym_" + gymNo + "_" + System.currentTimeMillis() + extension;

            // 파일 저장
            File destFile = new File(uploadDir, savedFilename);
            file.transferTo(destFile);

            // DB에 저장할 경로 (상대 경로)
            String dbPath = "/resources/uploadfiles/Gym/" + savedFilename;

            // DB 업데이트 (GYM 테이블의 GYM_PHOTO_PATH 업데이트)
            int updateResult = gymService.updateProfileImage(gymNo, dbPath);

            if (updateResult > 0) {
                result.put("success", true);
                result.put("message", "헬스장 이미지가 업데이트되었습니다.");
                result.put("imagePath", request.getContextPath() + dbPath);
            } else {
                result.put("success", false);
                result.put("message", "DB 업데이트에 실패했습니다.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "파일 업로드 중 오류가 발생했습니다: " + e.getMessage());
        }

        return result;
    }

    // 헬스장 기구 목록 조회 (AJAX)
    @GetMapping("/gym/machines.ajax")
    @ResponseBody
    public Map<String, Object> getGymMachines(@RequestParam("gymNo") int gymNo) {
        Map<String, Object> result = new HashMap<>();

        try {
            List<MachineManage> machines = machineService.selectMachineListByGymNo(gymNo);

            if (machines != null && !machines.isEmpty()) {
                result.put("success", true);
                result.put("machines", machines);
            } else {
                result.put("success", true);
                result.put("machines", new ArrayList<>());
                result.put("message", "등록된 기구가 없습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "기구 목록 조회 중 오류가 발생했습니다.");
        }

        return result;
    }

    @PostMapping("/gym/info/update")
    @ResponseBody
    public String updateGymInfo(@RequestParam String gymName,
                                @RequestParam String gymDescription,
                                @RequestParam String gymPhone,
                                @RequestParam String gymAddress,
                                @RequestParam String gymDetailAddress,
                                @RequestParam String weekdayStart,
                                @RequestParam String weekdayEnd,
                                @RequestParam String weekendStart,
                                @RequestParam String weekendEnd,
                                @RequestParam(required = false) String facilities,
                                HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null || loginMember.getMemberType() != 3) {
            return "fail";
        }

        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            return "fail";
        }

        try {
            // Gym 업데이트
            Gym gym = new Gym();
            gym.setGymNo(gymNo);
            gym.setGymName(gymName);
            gym.setGymPhone(gymPhone);
            gym.setGymAddress(gymAddress);
            int gymResult = gymService.updateGym(gym);

            // GymDetail 업데이트
            GymDetail gymDetail = gymDetailService.getGymDetailByGymNo(gymNo);
            if (gymDetail == null) {
                // GymDetail이 없으면 생성
                gymDetailService.addGymDetail(gymNo);
                gymDetail = gymDetailService.getGymDetailByGymNo(gymNo);
            }

            gymDetail.setIntro(gymDescription);
            gymDetail.setDetailAddress(gymDetailAddress);
            gymDetail.setFacilitiesInfo(facilities);
            gymDetail.setWeekBusinessHour(weekdayStart + " ~ " + weekdayEnd);
            gymDetail.setWeekendBusinessHour(weekendStart + " ~ " + weekendEnd);
            gymDetail.setGymNo(gymNo);

            int detailResult = gymDetailService.updateGymDetail(gymDetail);

            if (gymResult > 0 && detailResult > 0) {
                return "success";
            } else {
                return "fail";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }

    // 회원 상세 정보 조회 (AJAX)
    @GetMapping("/member/detail.ajax")
    @ResponseBody
    public java.util.Map<String, Object> getMemberDetail(@RequestParam("memberNo") int memberNo, HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 회원 기본 정보 조회
            Member member = memberMapper.getMemberByNo(memberNo);
            if (member == null) {
                result.put("success", false);
                result.put("message", "회원 정보를 찾을 수 없습니다.");
                return result;
            }
            
            // 회원권 정보 조회
            Membership membership = membershipMapper.selectMembershipByMemberNo(memberNo, gymNo);
            
            // PT 이용권 정보 조회
            PtPass ptPass = ptPassMapper.selectPtPassByMemberNo(memberNo, gymNo);
            
            // 락커 이용권 정보 조회
            LockerPass lockerPass = lockerMapper.selectLockerPassByMemberNo(memberNo, gymNo);
            
            // 결과 구성
            java.util.Map<String, Object> memberDetail = new java.util.HashMap<>();
            memberDetail.put("memberNo", member.getMemberNo());
            memberDetail.put("memberId", member.getMemberId());
            memberDetail.put("memberName", member.getMemberName());
            memberDetail.put("memberPhone", member.getMemberPhone());
            memberDetail.put("memberEmail", member.getMemberEmail());
            memberDetail.put("memberAddress", member.getMemberAddress());
            
            if (membership != null) {
                memberDetail.put("membershipNo", membership.getMembershipNo());
                memberDetail.put("endDate", membership.getEndDate());
            }
            
            if (ptPass != null) {
                memberDetail.put("ptPassNo", ptPass.getPtPassNo());
                memberDetail.put("ptEnd", ptPass.getPtEnd());
            }
            
            if (lockerPass != null) {
                memberDetail.put("lockerPassNo", lockerPass.getLockerPassNo());
                memberDetail.put("lockerEnd", lockerPass.getLockerEnd());
            }
            
            result.put("success", true);
            result.put("member", memberDetail);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "회원 정보 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // 이용권 연장 (AJAX)
    @PostMapping("/member/extend.ajax")
    @ResponseBody
    public java.util.Map<String, Object> extendMembership(@RequestBody java.util.Map<String, Object> requestData, HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 요청 데이터 파싱
            int memberNo = Integer.parseInt(requestData.get("memberNo").toString());
            @SuppressWarnings("unchecked")
            java.util.List<Integer> productNos = (java.util.List<Integer>) requestData.get("productNos");
            
            if (productNos == null || productNos.isEmpty()) {
                result.put("success", false);
                result.put("message", "연장할 이용권을 선택해주세요.");
                return result;
            }
            
            // 상품 정보 조회
            java.util.List<Product> allProducts = productService.getProductsByGymNo(gymNo);
            java.util.Map<Integer, Product> productMap = new java.util.HashMap<>();
            for (Product product : allProducts) {
                productMap.put(product.getProductNo(), product);
            }
            
            // 기존 이용권 정보 조회
            Membership membership = membershipMapper.selectMembershipByMemberNo(memberNo, gymNo);
            PtPass ptPass = ptPassMapper.selectPtPassByMemberNo(memberNo, gymNo);
            LockerPass lockerPass = lockerMapper.selectLockerPassByMemberNo(memberNo, gymNo);
            
            // 선택된 상품별로 연장 처리
            int maxDays = 0;
            int ptCount = 0;
            java.util.Date latestEndDate = null;
            
            for (Integer productNo : productNos) {
                Product product = productMap.get(productNo);
                if (product == null) continue;
                
                if ("회원권".equals(product.getProductType())) {
                    // 회원권 연장
                    int days = product.getDurationMonths();
                    maxDays = Math.max(maxDays, days);
                    
                    if (membership != null) {
                        java.util.Calendar cal = java.util.Calendar.getInstance();
                        cal.setTime(membership.getEndDate());
                        cal.add(java.util.Calendar.DAY_OF_MONTH, days);
                        java.util.Date newEndDate = cal.getTime();
                        
                        if (latestEndDate == null || newEndDate.after(latestEndDate)) {
                            latestEndDate = newEndDate;
                        }
                    }
                } else if ("락커".equals(product.getProductType())) {
                    // 락커 이용권 연장
                    int days = product.getDurationMonths();
                    
                    if (lockerPass != null) {
                        java.util.Calendar cal = java.util.Calendar.getInstance();
                        cal.setTime(lockerPass.getLockerEnd());
                        cal.add(java.util.Calendar.DAY_OF_MONTH, days);
                        java.util.Date newEndDate = cal.getTime();
                        
                        lockerMapper.updateLockerPassEndDate(lockerPass.getLockerPassNo(), newEndDate);
                    }
                } else if ("PT".equals(product.getProductType())) {
                    // PT 이용권 연장 (횟수 추가)
                    int count = product.getDurationMonths();
                    ptCount += count;
                    
                    if (ptPass != null) {
                        ptPassMapper.updatePtPassCount(ptPass.getPtPassNo(), count);
                    }
                }
            }
            
            // 회원권 만료일 업데이트
            if (membership != null && latestEndDate != null) {
                membershipMapper.updateMembershipEndDate(membership.getMembershipNo(), latestEndDate);
            }
            
            result.put("success", true);
            result.put("message", "이용권이 성공적으로 연장되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "이용권 연장 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // 회원 정보 업데이트 (이용권 연장 + 락커 재배정)
    @PostMapping("/member/update.ajax")
    @ResponseBody
    public java.util.Map<String, Object> updateMember(@RequestBody java.util.Map<String, Object> requestData, HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 요청 데이터 파싱
            int memberNo = Integer.parseInt(requestData.get("memberNo").toString());
            @SuppressWarnings("unchecked")
            java.util.List<Integer> productNos = (java.util.List<Integer>) requestData.get("productNos");
            String lockerRealNum = (String) requestData.get("lockerRealNum");
            String originalLockerRealNum = (String) requestData.get("originalLockerRealNum");
            
            // 기존 이용권 정보 조회
            Membership membership = membershipMapper.selectMembershipByMemberNo(memberNo, gymNo);
            PtPass ptPass = ptPassMapper.selectPtPassByMemberNo(memberNo, gymNo);
            LockerPass lockerPass = lockerMapper.selectLockerPassByMemberNo(memberNo, gymNo);
            
            // 1. 이용권 연장 처리
            if (productNos != null && !productNos.isEmpty()) {
                // 상품 정보 조회
                java.util.List<Product> allProducts = productService.getProductsByGymNo(gymNo);
                java.util.Map<Integer, Product> productMap = new java.util.HashMap<>();
                for (Product product : allProducts) {
                    productMap.put(product.getProductNo(), product);
                }
                
                // 선택된 상품별로 연장 처리
                int maxDays = 0;
                java.util.Date latestEndDate = null;
                
                for (Integer productNo : productNos) {
                    Product product = productMap.get(productNo);
                    if (product == null) continue;
                    
                    if ("회원권".equals(product.getProductType())) {
                        // 회원권 연장
                        int days = product.getDurationMonths();
                        maxDays = Math.max(maxDays, days);
                        
                        if (membership != null) {
                            java.util.Calendar cal = java.util.Calendar.getInstance();
                            cal.setTime(membership.getEndDate());
                            cal.add(java.util.Calendar.DAY_OF_MONTH, days);
                            java.util.Date newEndDate = cal.getTime();
                            
                            if (latestEndDate == null || newEndDate.after(latestEndDate)) {
                                latestEndDate = newEndDate;
                            }
                        }
                    } else if ("락커".equals(product.getProductType())) {
                        // 락커 이용권 연장
                        int days = product.getDurationMonths();
                        
                        if (lockerPass != null) {
                            java.util.Calendar cal = java.util.Calendar.getInstance();
                            cal.setTime(lockerPass.getLockerEnd());
                            cal.add(java.util.Calendar.DAY_OF_MONTH, days);
                            java.util.Date newEndDate = cal.getTime();
                            
                            lockerMapper.updateLockerPassEndDate(lockerPass.getLockerPassNo(), newEndDate);
                        }
                    } else if ("PT".equals(product.getProductType())) {
                        // PT 이용권 연장 (횟수 추가)
                        int count = product.getDurationMonths();
                        
                        if (ptPass != null) {
                            ptPassMapper.updatePtPassCount(ptPass.getPtPassNo(), count);
                        }
                    }
                }
                
                // 회원권 만료일 업데이트
                if (membership != null && latestEndDate != null) {
                    membershipMapper.updateMembershipEndDate(membership.getMembershipNo(), latestEndDate);
                }
            }
            
            // 2. 락커 재배정 처리
            if (lockerRealNum != null && !lockerRealNum.trim().isEmpty()) {
                // 락커 번호가 변경된 경우
                if (originalLockerRealNum == null || !lockerRealNum.equals(originalLockerRealNum)) {
                    // 새 락커 조회
                    Locker newLocker = lockerMapper.selectLockerByRealNumAndGymNo(lockerRealNum, gymNo);
                    
                    if (newLocker == null) {
                        result.put("success", false);
                        result.put("message", "존재하지 않는 락커 번호입니다.");
                        return result;
                    }
                    
                    // 기존 락커 pass가 있는 경우
                    if (lockerPass != null) {
                        // 기존 락커 상태를 "빈"으로 변경
                        Locker oldLocker = lockerMapper.selectLockerByNo(lockerPass.getLockerNo());
                        if (oldLocker != null) {
                            lockerMapper.updateLockerStatus(oldLocker.getLockerNo(), "빈");
                        }
                        
                        // 기존 락커 pass 상태를 "만료"로 변경
                        lockerMapper.updateLockerPassStatusToExpired(lockerPass.getLockerPassNo());
                        
                        // 새 락커 pass 생성 (기존 pass 정보를 기반으로)
                        LockerPass newLockerPass = LockerPass.builder()
                                .purchaseNo(lockerPass.getPurchaseNo())
                                .lockerNo(newLocker.getLockerNo())
                                .memberNo(memberNo)
                                .lockerPassStart(lockerPass.getLockerPassStart())
                                .lockerEnd(lockerPass.getLockerEnd())
                                .lockerPassStatus("정상")
                                .build();
                        
                        lockerMapper.insertLockerPass(newLockerPass);
                        
                        // 새 락커 상태를 "사용중"으로 변경
                        lockerMapper.updateLockerStatus(newLocker.getLockerNo(), "사용중");
                    } else {
                        // 기존 락커 pass가 없는 경우 (새로 배정)
                        // 새 락커 상태를 "사용중"으로 변경
                        lockerMapper.updateLockerStatus(newLocker.getLockerNo(), "사용중");
                    }
                }
            } else {
                // 락커가 제거된 경우 (빈 문자열 또는 null)
                if (lockerPass != null && originalLockerRealNum != null && !originalLockerRealNum.trim().isEmpty()) {
                    // 기존 락커 상태를 "빈"으로 변경
                    Locker oldLocker = lockerMapper.selectLockerByNo(lockerPass.getLockerNo());
                    if (oldLocker != null) {
                        lockerMapper.updateLockerStatus(oldLocker.getLockerNo(), "빈");
                    }
                    
                    // 기존 락커 pass 상태를 "만료"로 변경
                    lockerMapper.updateLockerPassStatusToExpired(lockerPass.getLockerPassNo());
                }
            }
            
            result.put("success", true);
            result.put("message", "회원 정보가 성공적으로 업데이트되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "회원 정보 업데이트 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // PT 예약 승인 (트레이너 배정)
    @PostMapping("/pt/approve.ajax")
    @ResponseBody
    public java.util.Map<String, Object> approvePtReserve(@RequestBody java.util.Map<String, Object> requestData, HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 요청 데이터 파싱
            int ptReserveNo = Integer.parseInt(requestData.get("ptReserveNo").toString());
            int ptTrainerNo = Integer.parseInt(requestData.get("ptTrainerNo").toString());
            
            // PT 예약 승인 및 트레이너 배정
            int updateResult = ptReserveService.approvePtReserve(ptReserveNo, ptTrainerNo);
            
            if (updateResult > 0) {
                result.put("success", true);
                result.put("message", "PT 예약이 승인되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "PT 예약 승인에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "PT 예약 승인 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // PT 예약 거절
    @PostMapping("/pt/reject.ajax")
    @ResponseBody
    public java.util.Map<String, Object> rejectPtReserve(@RequestBody java.util.Map<String, Object> requestData, HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 요청 데이터 파싱
            int ptReserveNo = Integer.parseInt(requestData.get("ptReserveNo").toString());
            
            // PT 예약 거절
            int updateResult = ptReserveService.rejectPtReserve(ptReserveNo);
            
            if (updateResult > 0) {
                result.put("success", true);
                result.put("message", "PT 예약이 거절되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "PT 예약 거절에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "PT 예약 거절 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // 트레이너 목록 조회 (AJAX)
    @GetMapping("/trainer/list.ajax")
    @ResponseBody
    public java.util.Map<String, Object> getTrainerList(HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            // 해당 헬스장의 트레이너 목록 조회
            List<Member> trainers = memberMapper.selectTrainersByGymNo(gymNo);
            
            result.put("success", true);
            result.put("trainers", trainers != null ? trainers : new ArrayList<>());
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "트레이너 목록 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    // 회원 삭제 (회원관리 페이지)
    @PostMapping("/member/delete.gym")
    @ResponseBody
    public java.util.Map<String, Object> deleteMember(@RequestBody java.util.Map<String, Object> requestData, HttpSession session) {
        java.util.Map<String, Object> result = new java.util.HashMap<>();
        
        // 세션에서 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        
        if (loginMember == null || loginMember.getMemberType() != 3) {
            result.put("success", false);
            result.put("message", "권한이 없습니다.");
            return result;
        }
        
        // 헬스장 번호 가져오기
        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            result.put("success", false);
            result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            return result;
        }
        
        try {
            int memberNo = Integer.parseInt(requestData.get("memberNo").toString());
            
            // 1. 해당 회원이 해당 헬스장 소속인지 확인
            Member member = memberMapper.getMemberByNo(memberNo);
            if (member == null || member.getGymNo() == null || !member.getGymNo().equals(gymNo)) {
                result.put("success", false);
                result.put("message", "해당 회원을 찾을 수 없습니다.");
                return result;
            }
            
            // 2. 회원권 만료 처리
            membershipMapper.expireMembershipByMemberNo(memberNo, gymNo);
            
            // 3. 회원의 GYM_NO를 NULL로 변경 (헬스장 연결 해제)
            int updateResult = memberMapper.updateMemberGymNo(memberNo, null);
            
            if (updateResult > 0) {
                result.put("success", true);
                result.put("message", "회원이 삭제되었습니다.");
            } else {
                result.put("success", false);
                result.put("message", "회원 삭제에 실패했습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("success", false);
            result.put("message", "회원 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

}
