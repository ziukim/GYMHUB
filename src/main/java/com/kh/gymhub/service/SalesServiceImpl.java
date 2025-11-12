package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.SalesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SalesServiceImpl implements SalesService {
    
    private final SalesMapper salesMapper;
    
    @Autowired
    public SalesServiceImpl(SalesMapper salesMapper) {
        this.salesMapper = salesMapper;
    }
    
    @Override
    public int getMembershipSalesByGymNoAndMonth(int gymNo, int year, int month) {
        Integer result = salesMapper.selectMembershipSalesByGymNoAndMonth(gymNo, year, month);
        return result != null ? result : 0;
    }
    
    @Override
    public int getStockSalesByGymNoAndMonth(int gymNo, int year, int month) {
        Integer result = salesMapper.selectStockSalesByGymNoAndMonth(gymNo, year, month);
        return result != null ? result : 0;
    }
    
    @Override
    public int getTotalSalesByGymNoAndMonth(int gymNo, int year, int month) {
        int membershipSales = getMembershipSalesByGymNoAndMonth(gymNo, year, month);
        int stockSales = getStockSalesByGymNoAndMonth(gymNo, year, month);
        return membershipSales + stockSales;
    }
}

