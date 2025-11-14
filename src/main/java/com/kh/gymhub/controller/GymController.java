package com.kh.gymhub.controller;

import com.kh.gymhub.model.mapper.MemberMapper;
import com.kh.gymhub.model.mapper.MembershipMapper;
import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.GymDetail;
import com.kh.gymhub.model.vo.LockerPass;
import com.kh.gymhub.model.vo.MachineManage;
import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.model.vo.MemberWithMembership;
import com.kh.gymhub.model.vo.Product;
import com.kh.gymhub.model.vo.YoutubeUrl;
import com.kh.gymhub.service.GymDetailService;
import com.kh.gymhub.service.GymService;
import com.kh.gymhub.service.LockerService;
import com.kh.gymhub.service.MachineService;
import com.kh.gymhub.service.MemberService;
import com.kh.gymhub.service.ProductService;
import com.kh.gymhub.service.PurchaseService;
import com.kh.gymhub.service.SalesService;
import com.kh.gymhub.service.YoutubeUrlService;
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
    
    @Autowired
    public GymController(ProductService productService, YoutubeUrlService youtubeUrlService, MemberService memberService, LockerService lockerService, PurchaseService purchaseService, MembershipMapper membershipMapper, SalesService salesService, MemberMapper memberMapper, GymService gymService, GymDetailService gymDetailService, MachineService machineService) {
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
    public String gymDashboard() {
        return "gym/gymDashBoard";
    }

    @GetMapping("/ptBoard.gym")
    public String ptBoard() {
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

}
