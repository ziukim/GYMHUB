package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.Member;
import com.kh.gymhub.model.vo.Product;

import java.util.Date;
import java.util.List;

public interface PurchaseService {
    int registerMemberPurchase(Member member, int gymNo, List<Product> selectedProducts, 
                               Date startDate, Date endDate, String lockerRealNum);
}

