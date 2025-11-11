package com.kh.gymhub.model.mapper;

import com.kh.gymhub.model.vo.Product;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ProductMapper {
    List<Product> getProductsByGymNo(@Param("gymNo") int gymNo);
    List<Product> getProductsByGymNoAndType(@Param("gymNo") int gymNo, @Param("productType") String productType);
    int addProduct(Product product);
    int updateProduct(Product product);
    int deleteProduct(@Param("productNo") int productNo);
}

