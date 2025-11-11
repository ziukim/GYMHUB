package com.kh.gymhub.service;

import com.kh.gymhub.model.mapper.ProductMapper;
import com.kh.gymhub.model.vo.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    private final ProductMapper productMapper;

    @Autowired
    public ProductServiceImpl(ProductMapper productMapper) {
        this.productMapper = productMapper;
    }

    @Override
    public List<Product> getProductsByGymNo(int gymNo) {
        return productMapper.getProductsByGymNo(gymNo);
    }

    @Override
    public List<Product> getProductsByGymNoAndType(int gymNo, String productType) {
        return productMapper.getProductsByGymNoAndType(gymNo, productType);
    }

    @Override
    @Transactional
    public int addProduct(Product product) {
        return productMapper.addProduct(product);
    }

    @Override
    @Transactional
    public int updateProduct(Product product) {
        return productMapper.updateProduct(product);
    }

    @Override
    @Transactional
    public int deleteProduct(int productNo) {
        return productMapper.deleteProduct(productNo);
    }
}

