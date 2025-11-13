package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Stock;
import com.kh.gymhub.model.vo.StockManage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 재고 관리 Mapper 인터페이스
 */
@Mapper
public interface StockMapper {

    /**
     * 재고 물품 등록
     * @param stock 재고 정보
     * @return 등록된 행 수
     */
    int insertStock(Stock stock);

    /**
     * 재고 관리 정보 등록 (입출고)
     * @param stockManage 재고 관리 정보
     * @return 등록된 행 수
     */
    int insertStockManage(StockManage stockManage);

    /**
     * 특정 헬스장의 재고 목록 조회 (최근 목표재고수량 포함)
     * @param gymNo 헬스장 번호
     * @return 재고 목록
     */
    List<Stock> selectStockListByGymNo(@Param("gymNo") int gymNo);

    /**
     * 재고 상세 정보 조회
     * @param stockId 재고 물품 ID
     * @return 재고 정보
     */
    Stock selectStockById(@Param("stockId") int stockId);

    /**
     * 재고 정보 수정
     * @param stock 재고 정보
     * @return 수정된 행 수
     */
    int updateStock(Stock stock);

    /**
     * 재고 수량 업데이트
     * @param stockId 재고 물품 ID
     * @param stockCount 변경 수량 (양수: 증가, 음수: 감소)
     * @return 수정된 행 수
     */
    int updateStockCount(@Param("stockId") int stockId, @Param("stockCount") int stockCount);

    /**
     * 재고 관리 내역 삭제 (CASCADE)
     * @param stockId 재고 물품 ID
     * @return 삭제된 행 수
     */
    int deleteStockManageByStockId(@Param("stockId") int stockId);

    /**
     * 재고 삭제
     * @param stockId 재고 물품 ID
     * @return 삭제된 행 수
     */
    int deleteStock(@Param("stockId") int stockId);

    /**
     * SALES 테이블에서 해당 재고를 참조하는 레코드 수 조회
     * @param stockId 재고 물품 ID
     * @return 참조하는 레코드 수
     */
    int countSalesByStockId(@Param("stockId") int stockId);

    /**
     * 외래키 제약조건 비활성화
     * @param constraintName 제약조건 이름
     * @param tableName 테이블 이름
     */
    void disableForeignKeyConstraint(@Param("constraintName") String constraintName, @Param("tableName") String tableName);

    /**
     * 외래키 제약조건 활성화
     * @param constraintName 제약조건 이름
     * @param tableName 테이블 이름
     */
    void enableForeignKeyConstraint(@Param("constraintName") String constraintName, @Param("tableName") String tableName);

    /**
     * 특정 헬스장의 입출고 내역 조회 (입고/출고만)
     * @param gymNo 헬스장 번호
     * @return 입출고 내역 목록
     */
    List<StockManage> selectStockManageListByGymNo(@Param("gymNo") int gymNo);

    /**
     * 특정 재고의 최근 목표재고수량 조회
     * @param stockId 재고 물품 ID
     * @param gymNo 헬스장 번호
     * @return 목표재고수량
     */
    Integer selectTargetStockCount(@Param("stockId") int stockId, @Param("gymNo") int gymNo);

    /**
     * 목표재고수량 업데이트 (새로운 관리 내역 추가)
     * @param stockManage 재고 관리 정보
     * @return 등록된 행 수
     */
    int updateTargetStockCount(StockManage stockManage);
}

