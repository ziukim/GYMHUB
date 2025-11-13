package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.Stock;
import com.kh.gymhub.model.vo.StockManage;

import java.util.List;

/**
 * 재고 관리 Service 인터페이스
 */
public interface StockService {

    /**
     * 재고 등록 (물품 + 목표재고수량)
     * @param stock 재고 정보
     * @param gymNo 헬스장 번호
     * @param targetStockCount 목표재고수량
     * @return 성공 여부
     */
    int insertStock(Stock stock, int gymNo, int targetStockCount);

    /**
     * 입출고 처리
     * @param stockId 재고 물품 ID
     * @param gymNo 헬스장 번호
     * @param type 입고/출고
     * @param count 수량
     * @return 성공 여부
     */
    int processStockInOut(int stockId, int gymNo, String type, int count);

    /**
     * 특정 헬스장의 재고 목록 조회
     * @param gymNo 헬스장 번호
     * @return 재고 목록
     */
    List<Stock> selectStockListByGymNo(int gymNo);

    /**
     * 재고 상세 조회
     * @param stockId 재고 물품 ID
     * @return 재고 정보
     */
    Stock selectStockById(int stockId);

    /**
     * 재고 정보 수정 (물품명, 목표재고수량)
     * @param stock 재고 정보
     * @param gymNo 헬스장 번호
     * @param targetStockCount 목표재고수량
     * @return 성공 여부
     */
    int updateStock(Stock stock, int gymNo, int targetStockCount);

    /**
     * 재고 삭제
     * @param stockId 재고 물품 ID
     * @return 성공 여부
     */
    int deleteStock(int stockId);

    /**
     * 특정 헬스장의 입출고 내역 조회
     * @param gymNo 헬스장 번호
     * @return 입출고 내역 목록
     */
    List<StockManage> selectStockManageListByGymNo(int gymNo);
}

