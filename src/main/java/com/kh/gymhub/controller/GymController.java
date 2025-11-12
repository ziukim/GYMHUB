package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.Gym;
import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.model.vo.Product;
import com.kh.gymhub.model.vo.YoutubeUrl;
import com.kh.gymhub.service.MemberService;
import com.kh.gymhub.service.ProductService;
import com.kh.gymhub.service.YoutubeUrlService;
import jakarta.servlet.http.HttpSession;
import com.kh.gymhub.service.GymService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class GymController {

    private final ProductService productService;
    private final YoutubeUrlService youtubeUrlService;
    private final MemberService memberService;
    private final GymService gymService;

    @Autowired
    public GymController(ProductService productService, YoutubeUrlService youtubeUrlService, MemberService memberService,  GymService gymService) {
        this.gymService = gymService;
        this.productService = productService;
        this.youtubeUrlService = youtubeUrlService;
        this.memberService = memberService;
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
    public String memberManagement() {
        return "gym/gymMemberManagement";
    }

    @GetMapping("/sales.gym")
    public String salesBoard() {
        return "gym/gymSalesBoard";
    }


    @GetMapping("/reservation.gym")
    public String reservationManagement() {
        return "gym/gymReservationManagement";
    }

    @GetMapping("/info.gym")
    public String gymInfoManagement() {
        return "gym/gymInfoManagement";
    }

    @GetMapping("/trainer.gym")
    public String trainerManagement() {
        return "gym/gymTrainerManagement";
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

    @GetMapping("/stock.gym")
    public String stockManagement() {
        return "gym/gymStockManagement";
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

    // 헬스장 상세 정보 조회 (AJAX)
    @GetMapping("/gym/detail.ajax")
    @ResponseBody
    public Map<String, Object> getGymDetail(@RequestParam("gymNo") int gymNo) {
        Map<String, Object> result = new HashMap<>();

        try {
            Gym gym = gymService.getGymWithDetailByNo(gymNo);

            if (gym != null) {
                result.put("success", true);
                result.put("gym", gym);
            } else {
                result.put("success", false);
                result.put("message", "헬스장 정보를 찾을 수 없습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "데이터 조회 중 오류가 발생했습니다.");
        }

        return result;
    }

}