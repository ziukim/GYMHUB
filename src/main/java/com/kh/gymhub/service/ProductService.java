package com.kh.gymhub.service;

import com.kh.gymhub.model.vo.Product;

import java.util.List;

public interface ProductService {
    List<Product> getProductsByGymNo(int gymNo);
    List<Product> getProductsByGymNoAndType(int gymNo, String productType);
    int addProduct(Product product);
    int updateProduct(Product product);
    int deleteProduct(int productNo);
}

