package com.kh.gymhub.service;

public interface SalesService {
    // 회원권 매출 조회 (해당 달)
    int getMembershipSalesByGymNoAndMonth(int gymNo, int year, int month);
    
    // 재고(물품 판매) 매출 조회 (해당 달)
    int getStockSalesByGymNoAndMonth(int gymNo, int year, int month);
    
    // 총 매출 조회 (해당 달)
    int getTotalSalesByGymNoAndMonth(int gymNo, int year, int month);
}

