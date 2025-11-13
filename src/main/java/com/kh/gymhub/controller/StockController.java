package com.kh.gymhub.controller;

import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.model.vo.Stock;
import com.kh.gymhub.model.vo.StockManage;
import com.kh.gymhub.service.StockService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class StockController {

    private final StockService stockService;

    @Autowired
    public StockController(StockService stockService) {
        this.stockService = stockService;
    }

    /**
     * 재고 관리 페이지 이동
     */
    @GetMapping("/stock.gym")
    public String stockList(HttpSession session, Model model) {
        System.out.println("===== stockList 시작 =====");

        Integer gymNo = (Integer) session.getAttribute("gymNo");

        if (gymNo == null) {
            Member loginMember = (Member) session.getAttribute("loginMember");
            if (loginMember != null && loginMember.getMemberType() == 3) {
                gymNo = loginMember.getGymNo();
                if (gymNo != null) {
                    session.setAttribute("gymNo", gymNo);
                }
            }
        }

        System.out.println("gymNo: " + gymNo);

        if (gymNo == null) {
            model.addAttribute("errorMsg", "헬스장 정보를 찾을 수 없습니다.");
            return "gym/gymStockManagement";  // 수정
        }

        try {
            // 1. 재고 목록 조회
            List<Stock> stockList = stockService.selectStockListByGymNo(gymNo);
            System.out.println("조회된 재고 목록 개수: " + stockList.size());

            for (Stock stock : stockList) {
                System.out.println("Stock: " + stock);
            }

            model.addAttribute("stockList", stockList);

            // 2. 입출고 내역 조회
            List<StockManage> stockManageList = stockService.selectStockManageListByGymNo(gymNo);
            System.out.println("조회된 입출고 내역 개수: " + stockManageList.size());
            model.addAttribute("stockManageList", stockManageList);

            System.out.println("===== stockList 완료 =====");
            return "gym/gymStockManagement";  // 수정

        } catch (Exception e) {
            System.out.println("===== 에러 발생 =====");
            e.printStackTrace();
            model.addAttribute("errorMsg", "재고 목록을 불러오는데 실패했습니다.");
            return "gym/gymStockManagement";  // 수정
        }
    }

    /**
     * 재고 등록
     */
    @PostMapping("/stockInsert.gym")
    @ResponseBody
    public String insertStock(@RequestParam("stockName") String stockName,
                              @RequestParam("targetStockCount") int targetStockCount,
                              @RequestParam("stockPrice") int stockPrice,
                              HttpSession session) {

        System.out.println("===== 재고 등록 시작 =====");

        Member loginMember = (Member) session.getAttribute("loginMember");
        System.out.println("loginMember: " + loginMember);

        if (loginMember == null) {
            System.out.println("로그인 정보 없음");
            return "fail_auth";
        }

        System.out.println("memberType: " + loginMember.getMemberType());
        if (loginMember.getMemberType() != 3) {
            System.out.println("권한 없음 (memberType != 3)");
            return "fail_auth";
        }

        Integer gymNo = loginMember.getGymNo();
        System.out.println("gymNo: " + gymNo);

        if (gymNo == null) {
            System.out.println("gymNo가 null입니다");
            return "fail_auth";
        }

        try {
            System.out.println("입력 데이터:");
            System.out.println("- stockName: " + stockName);
            System.out.println("- targetStockCount: " + targetStockCount);
            System.out.println("- stockPrice: " + stockPrice);
            System.out.println("- gymNo: " + gymNo);

            Stock stock = Stock.builder()
                    .stockName(stockName)
                    .stockCount(0) // 초기 재고는 0
                    .stockPrice(stockPrice)
                    .build();

            int result = stockService.insertStock(stock, gymNo, targetStockCount);

            System.out.println("result: " + result);
            System.out.println("===== 재고 등록 완료 =====");

            return result > 0 ? "success" : "fail";

        } catch (Exception e) {
            System.out.println("===== 에러 발생 =====");
            e.printStackTrace();
            return "error: " + e.getMessage();
        }
    }

    /**
     * 재고 상세 조회
     */
    @GetMapping("/stockDetail.gym")
    @ResponseBody
    public Stock getStockDetail(@RequestParam int stockId) {
        try {
            return stockService.selectStockById(stockId);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 재고 정보 수정 (물품명, 목표재고수량)
     */
    @PostMapping("/stockUpdate.gym")
    @ResponseBody
    public String updateStock(@RequestParam("stockId") int stockId,
                              @RequestParam("stockName") String stockName,
                              @RequestParam("targetStockCount") int targetStockCount,
                              @RequestParam("stockPrice") int stockPrice,
                              HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null || loginMember.getMemberType() != 3) {
            return "fail_auth";
        }

        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            return "fail_auth";
        }

        try {
            Stock stock = Stock.builder()
                    .stockId(stockId)
                    .stockName(stockName)
                    .stockPrice(stockPrice)
                    .build();

            int result = stockService.updateStock(stock, gymNo, targetStockCount);
            return result > 0 ? "success" : "fail";
        } catch (Exception e) {
            return "error";
        }
    }

    /**
     * 입출고 처리
     */
    @PostMapping("/stockInOut.gym")
    @ResponseBody
    public String processStockInOut(@RequestParam("stockId") int stockId,
                                    @RequestParam("type") String type,
                                    @RequestParam("count") int count,
                                    HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null || loginMember.getMemberType() != 3) {
            return "fail_auth";
        }

        Integer gymNo = loginMember.getGymNo();
        if (gymNo == null) {
            return "fail_auth";
        }

        try {
            int result = stockService.processStockInOut(stockId, gymNo, type, count);
            return result > 0 ? "success" : "fail";
        } catch (Exception e) {
            return "error";
        }
    }

    /**
     * 재고 삭제
     */
    @PostMapping("/stockDelete.gym")
    @ResponseBody
    public String deleteStock(@RequestParam int stockId) {
        System.out.println("===== 재고 삭제 시작 =====");
        System.out.println("stockId: " + stockId);

        try {
            int result = stockService.deleteStock(stockId);
            System.out.println("삭제 결과: " + result);
            return result > 0 ? "success" : "fail";
        } catch (Exception e) {
            System.out.println("===== 삭제 에러 =====");
            e.printStackTrace();
            return "error";
        }
    }
}

