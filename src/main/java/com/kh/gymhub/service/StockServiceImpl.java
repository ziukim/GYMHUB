package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.StockMapper;
import com.kh.gymhub.model.vo.Stock;
import com.kh.gymhub.model.vo.StockManage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class StockServiceImpl implements StockService {

    private final StockMapper stockMapper;

    @Autowired
    public StockServiceImpl(StockMapper stockMapper) {
        this.stockMapper = stockMapper;
    }

    @Override
    @Transactional
    public int insertStock(Stock stock, int gymNo, int targetStockCount) {
        try {
            System.out.println("===== Service: insertStock 시작 =====");
            System.out.println("stock: " + stock);
            System.out.println("gymNo: " + gymNo);
            System.out.println("targetStockCount: " + targetStockCount);

            // 1. STOCK 테이블에 재고 물품 등록
            int result = stockMapper.insertStock(stock);
            System.out.println("insertStock result: " + result);
            System.out.println("생성된 stockId: " + stock.getStockId());

            // 2. STOCK_MANAGER 테이블에 목표재고수량 등록
            if (result > 0 && stock.getStockId() > 0) {
                StockManage stockManage = StockManage.builder()
                        .stockId(stock.getStockId())
                        .gymNo(gymNo)
                        .stockManageType("초기등록")
                        .stockManageCount(targetStockCount)
                        .build();

                System.out.println("stockManage: " + stockManage);

                result = stockMapper.insertStockManage(stockManage);
                System.out.println("insertStockManage result: " + result);
            } else {
                System.out.println("STOCK 등록 실패 또는 stockId 생성 안됨");
            }

            System.out.println("===== Service: insertStock 완료 =====");
            return result;
        } catch (Exception e) {
            System.out.println("===== Service 에러 =====");
            e.printStackTrace();
            throw new RuntimeException("재고 등록에 실패했습니다: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional
    public int processStockInOut(int stockId, int gymNo, String type, int count) {
        try {
            // 1. 재고 수량 업데이트
            int changeCount = type.equals("입고") ? count : -count;
            int result = stockMapper.updateStockCount(stockId, changeCount);

            // 2. STOCK_MANAGE 테이블에 입출고 내역 추가
            if (result > 0) {
                StockManage stockManage = StockManage.builder()
                        .stockId(stockId)
                        .gymNo(gymNo)
                        .stockManageType(type)
                        .stockManageCount(count)
                        .build();

                result = stockMapper.insertStockManage(stockManage);
            }

            return result;
        } catch (Exception e) {
            throw new RuntimeException("입출고 처리에 실패했습니다: " + e.getMessage(), e);
        }
    }

    @Override
    public List<Stock> selectStockListByGymNo(int gymNo) {
        return stockMapper.selectStockListByGymNo(gymNo);
    }

    @Override
    public Stock selectStockById(int stockId) {
        return stockMapper.selectStockById(stockId);
    }

    @Override
    @Transactional
    public int updateStock(Stock stock, int gymNo, int targetStockCount) {
        try {
            // 1. STOCK 테이블 업데이트 (물품명, 가격)
            int result = stockMapper.updateStock(stock);

            // 2. 목표재고수량 업데이트 (새로운 관리 내역 추가)
            if (result > 0) {
                StockManage stockManage = StockManage.builder()
                        .stockId(stock.getStockId())
                        .gymNo(gymNo)
                        .stockManageType("목표수정")
                        .stockManageCount(targetStockCount)
                        .build();

                result = stockMapper.updateTargetStockCount(stockManage);
            }

            return result;
        } catch (Exception e) {
            throw new RuntimeException("재고 수정에 실패했습니다: " + e.getMessage(), e);
        }
    }

    @Override
    @Transactional
    public int deleteStock(int stockId) {
        try {
            // 외래키 제약조건 일시적으로 비활성화 (입출고 내역과 매출 내역은 보존하기 위해)
            try {
                stockMapper.disableForeignKeyConstraint("FK_STOCK_MANAGER_STOCK", "STOCK_MANAGER");
            } catch (Exception e) {
                // 제약조건이 이미 비활성화되어 있거나 없는 경우 무시
                System.out.println("외래키 제약조건 비활성화 중 오류 (무시 가능): " + e.getMessage());
            }
            
            try {
                stockMapper.disableForeignKeyConstraint("FK_SALES_STOCK", "SALES");
            } catch (Exception e) {
                // 제약조건이 이미 비활성화되어 있거나 없는 경우 무시
                System.out.println("외래키 제약조건 비활성화 중 오류 (무시 가능): " + e.getMessage());
            }

            // STOCK 테이블의 데이터만 삭제 (입출고 내역과 매출 내역은 보존)
            int result = stockMapper.deleteStock(stockId);

            // 외래키 제약조건 다시 활성화
            try {
                stockMapper.enableForeignKeyConstraint("FK_STOCK_MANAGER_STOCK", "STOCK_MANAGER");
            } catch (Exception e) {
                // 제약조건 활성화 실패 시 로그만 남기고 계속 진행
                System.out.println("외래키 제약조건 활성화 중 오류: " + e.getMessage());
            }
            
            try {
                stockMapper.enableForeignKeyConstraint("FK_SALES_STOCK", "SALES");
            } catch (Exception e) {
                // 제약조건 활성화 실패 시 로그만 남기고 계속 진행
                System.out.println("외래키 제약조건 활성화 중 오류: " + e.getMessage());
            }

            return result;
        } catch (Exception e) {
            // 예외 발생 시 제약조건을 다시 활성화 시도
            try {
                stockMapper.enableForeignKeyConstraint("FK_STOCK_MANAGER_STOCK", "STOCK_MANAGER");
            } catch (Exception ex) {
                System.out.println("외래키 제약조건 활성화 중 오류: " + ex.getMessage());
            }
            try {
                stockMapper.enableForeignKeyConstraint("FK_SALES_STOCK", "SALES");
            } catch (Exception ex) {
                System.out.println("외래키 제약조건 활성화 중 오류: " + ex.getMessage());
            }
            throw new RuntimeException("재고 삭제에 실패했습니다: " + e.getMessage(), e);
        }
    }

    @Override
    public List<StockManage> selectStockManageListByGymNo(int gymNo) {
        return stockMapper.selectStockManageListByGymNo(gymNo);
    }
}

