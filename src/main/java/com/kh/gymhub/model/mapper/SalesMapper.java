package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Sales;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;

@Mapper
public interface SalesMapper {
    int insertSales(Sales sales);
    
    // 회원권 매출 조회 (해당 달)
    Integer selectMembershipSalesByGymNoAndMonth(@Param("gymNo") int gymNo, @Param("year") int year, @Param("month") int month);
    
    // 재고(물품 판매) 매출 조회 (해당 달, 출고만)
    Integer selectStockSalesByGymNoAndMonth(@Param("gymNo") int gymNo, @Param("year") int year, @Param("month") int month);
}

